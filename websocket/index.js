

import https from 'https';// Menggunakan 'http' daripada 'https'
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



const server = https.createServer({
  key: fs.readFileSync('/home/localhost/public_html/e-antrian/websocket/key.pem'),
  cert: fs.readFileSync('/home/localhost/public_html/e-antrian/websocket/cert.pem'),
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
    //const jsonResponse = JSON.stringify(data);
    //ws.send(jsonResponse);
    getAllAntrianUpdate(ws, monitorId, data);
  });
}
function getAllAntrianUpdate(ws, monitorId, waktu) {
  
  // Cek Kategori
  const cekkategoriSQL = `SELECT * 
      FROM antrian_kategori 
      LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
      WHERE id_setting_layar = ?
      AND tgl_update > ?`;

    db.query(cekkategoriSQL, [monitorId, waktu['tgl_update_kategori']], (error, results) => {
      if (error) {
        console.error('Error fetching data from the database: ' + error);
        res.statusCode = 500;
        res.end('Error fetching data from the database');
      } else {
        const kategori = results[0];
        const result = { kategori };

        if (kategori) {
          // Kategori Tujuan
          const kategoriTujuanSQL = `SELECT * FROM antrian_detail
            LEFT JOIN antrian_kategori USING(id_antrian_kategori)
            LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
            WHERE id_antrian_kategori = ?`;

          db.query(kategoriTujuanSQL, [kategori.id_antrian_kategori], (error, results) => {
            if (error) {
              console.error('Error fetching kategori tujuan: ' + error);
              res.statusCode = 500;
              res.end('Error fetching kategori tujuan');
            } else {
              const kategori_tujuan = results;
              result.kategori.tujuan = kategori_tujuan;

              // Jumlah antrian masing-masing tujuan
              const jumlahAntrianSQL = `SELECT id_antrian_detail, id_antrian_kategori, COUNT(*) AS jml, MAX(nomor_panggil) AS nomor_panggil
                FROM antrian_panggil_detail
                LEFT JOIN antrian_panggil USING(id_antrian_panggil)
                LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
                WHERE id_setting_layar = ? AND tanggal = ?
                GROUP BY id_antrian_detail`;

              db.query(jumlahAntrianSQL, [monitorId, new Date().toISOString().slice(0, 10)], (error, results) => {
                if (error) {
                  console.error('Error fetching jumlah antrian: ' + error);
                  res.statusCode = 500;
                  res.end('Error fetching jumlah antrian');
                } else {
                  const tujuan_panggil = {};
                  results.forEach((val) => {
                    tujuan_panggil[val.id_antrian_detail] = val;
                  });
                  result.kategori.tujuan_panggil = tujuan_panggil;

                  res.setHeader('Content-Type', 'application/json');
                  res.statusCode = 200;
                  res.end(JSON.stringify(result));
                  ws.send(res);
                }
              });
            }
          });
        } else {
          res.statusCode = 404;
          res.end('No data found');
        }
      }
    });
}


server.listen(8443, () => {
  console.log('WebSocket server is running');
});
