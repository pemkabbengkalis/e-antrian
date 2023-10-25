

import { createServer } from 'http'; // Menggunakan 'http' daripada 'https'
import { WebSocketServer } from 'ws';
import mysql from 'mysql2';
import fs from 'fs';

const currentDate = new Date().toISOString().slice(0, 10);
const wss = new WebSocketServer({ noServer: true }); // Menggunakan noServer: true agar WebSocketServer tidak membuat server HTTP

const db = mysql.createPool({
  host: 'localhost',
  user: 'eantrianbengkali_antrian',
  password: '5oM!F^@J8V^-',
  database: 'eantrianbengkali_antrian',
});

const server = createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('WebSocket server is running');
});

server.on('upgrade', (request, socket, head) => {
  wss.handleUpgrade(request, socket, head, (ws) => {
    wss.emit('connection', ws, request);
  });
});

wss.on('connection', function connection(ws) {
  ws.on('message', function message(data) {
    try {
      const requestData = JSON.parse(data);
      const monitorId = requestData.id;

      fetchDataFromDatabase(ws, monitorId);
    } catch (error) {
      console.error('Error parsing client data: ' + error);
      // Handle error if the received data is not in the expected JSON format
    }
  });

  const interval = setInterval(() => {
    fetchDataFromDatabase(ws);
  }, 1000);

  ws.on('close', () => {
    clearInterval(interval);
  });
});

function fetchDataFromDatabase(ws, monitorId) {
  const query = `
  SELECT MAX(waktu_panggil) AS waktu_panggil 
  FROM antrian_panggil_detail
  LEFT JOIN antrian_detail USING(id_antrian_detail)
  LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
  LEFT JOIN antrian_panggil USING(id_antrian_panggil)
  WHERE id_setting_layar = 4
  `;

  db.query(query, [monitorId, currentDate], (error, results) => {
    if (error) {
      console.error('Error fetching data from the database: ' + error);
      return;
    }

    const data = results[0];

    const jsonData = JSON.stringify(data);

    getAntrianBelumDipanggil(ws, monitorId, results[0].waktu_panggil);
  });
}
function getAntrianBelumDipanggil(ws, monitorId, waktu) {
  const query = `
  SELECT * FROM antrian_panggil_detail
  LEFT JOIN antrian_detail USING(id_antrian_detail)
  LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
  LEFT JOIN antrian_kategori USING(id_antrian_kategori)
  LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
  LEFT JOIN antrian_panggil USING(id_antrian_panggil)
  WHERE id_setting_layar = 4
  `;

  db.query(query, [monitorId, waktu], (error, results) => {
    if (error) {
      console.error('Error fetching data from the database: ' + error);
      return;
    }

    const data = results[0];

    const response = {
      status: 'ok',
      data: data,
    };

    const jsonResponse = JSON.stringify(response);

    ws.send(jsonResponse);
  });
}


server.listen(8080, () => {
  console.log('WebSocket server is running on ws://e-antrian.bengkaliskab.go.id:8080');
});
