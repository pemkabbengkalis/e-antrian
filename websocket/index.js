

import { createServer } from 'https'; // Menggunakan 'http' daripada 'https'
import { WebSocketServer } from 'ws';
import mysql from 'mysql2';
import { parse } from 'url'; 
import fs from 'fs';
var monitorId;
const currentDate = new Date().toISOString().slice(0, 10);
const wss = new WebSocketServer({ noServer: true }); // Menggunakan noServer: true agar WebSocketServer tidak membuat server HTTP

const db = mysql.createPool({
  host: '10.20.30.252',
  user: 'loca_antrian',
  password: 'mpp@2023',
  database: 'loca_antrian',
});

const server = createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('WebSocket server is running');
});

server.on('upgrade', (request, socket, head) => {
  const { pathname, query } = parse(request.url, true); // Menggunakan 'parse' untuk mengurai URL
  // Dapatkan nilai "id" dari query string
  monitorId = query.id;
  wss.handleUpgrade(request, socket, head, (ws) => {
    wss.emit('connection', ws, request);
  });
});

wss.on('connection', function connection(ws) {
  ws.on('message', function message(data) {
    try {
      getLastAntrianUpdate(ws, monitorId);
    } catch (error) {
      console.error('Error parsing client data: ' + error);
      // Handle error if the received data is not in the expected JSON format
    }
  });

  const interval = setInterval(() => {
    getLastAntrianUpdate(ws,monitorId);
  }, 1000);

  ws.on('close', () => {
    clearInterval(interval);
  });
});

function getLastAntrianUpdate(ws, monitorId) {
  const query = `
  SELECT 
						( SELECT tgl_update AS tgl_update_kategori FROM antrian_kategori 
							LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
							WHERE id_setting_layar = ${monitorId}
							ORDER BY tgl_update DESC LIMIT 1 
						) AS tgl_update_kategori,
						( 
							SELECT tgl_update AS tgl_update_tujuan FROM antrian_detail 
							LLEFT JOIN setting_layar_detail USING (id_antrian_kategori)
							WHERE id_setting_layar =  ${monitorId}
							ORDER BY tgl_update DESC LIMIT 1 
						) AS tgl_update_tujuan
  `;

  db.query(query, [monitorId], (error, results) => {
    if (error) {
      console.error('Error fetching data from the database: ' + error);
      return;
    }
    const data = results[0];
    const jsonResponse = JSON.stringify(data);
    ws.send(jsonResponse);
    //getAllAntrianUpdate(ws, monitorId, data);
  });
}
function getAllAntrianUpdate(ws, monitorId, waktu) {
  
  // const query = `
  // SELECT * FROM antrian_panggil_detail
  // LEFT JOIN antrian_detail USING(id_antrian_detail)
  // LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
  // LEFT JOIN antrian_kategori USING(id_antrian_kategori)
  // LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
  // LEFT JOIN antrian_panggil USING(id_antrian_panggil)
  // WHERE id_setting_layar = 4
  // `;

  // db.query(query, [monitorId, waktu], (error, results) => {
  //   if (error) {
  //     console.error('Error fetching data from the database: ' + error);
  //     return;
  //   }

  //   const data = results[0];

  //   const response = {
  //     status: 'ok',
  //     data: data,
  //   };

  //   const jsonResponse = JSON.stringify(response);

  //   ws.send(jsonResponse);
  // });
}


server.listen(8443, () => {
  console.log('WebSocket server is running on ws://e-antrian.bengkaliskab.go.id:8080');
});
