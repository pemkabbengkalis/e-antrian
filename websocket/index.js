import https from 'https'; // Menggunakan 'http' daripada 'https'
import { WebSocketServer } from 'ws';
import mysql from 'mysql2';
import { parse } from 'url';
import fs from 'fs';

var monitorId;
const currentDate = new Date().toISOString().split('T')[0];


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
  const { pathname, query } = parse(request.url, true);
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
    }
  });

  const interval = setInterval(() => {
    getLastAntrianUpdate(ws, monitorId);
  }, 1000);

  ws.on('close', () => {
    clearInterval(interval);
  });
});



/* Cek jika perubahan pada antrian misal nama tujuan, aktif dan non aktif */
function getLastAntrianUpdate(ws, monitorId) {
  const query = `
    SELECT 
      (SELECT tgl_update AS tgl_update_kategori FROM antrian_kategori 
      LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
      WHERE id_setting_layar = ${monitorId}
      ORDER BY tgl_update DESC LIMIT 1) AS tgl_update_kategori,
      (SELECT tgl_update AS tgl_update_tujuan FROM antrian_detail 
      LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
      WHERE id_setting_layar =  ${monitorId}
      ORDER BY tgl_update DESC LIMIT 1) AS tgl_update_tujuan
  `;

  db.query(query, (error, results) => {
    if (error) {
      console.error('Error fetching data from the database: ' + error);
    } else {
      const data = results[0];
      // ws.send(JSON.stringify(currentDate));
      const date = new Date(data['tgl_update_kategori']);
      const formattedDate = date.toISOString().slice(0, 10);
      getAllAntrianUpdate(ws, monitorId, formattedDate);
    }
  });
}

function getAllAntrianUpdate(ws, monitorId, waktu) {
  // Cek Kategori
  const cekkategoriSQL = `SELECT * 
    FROM antrian_kategori 
    LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
    WHERE id_setting_layar = ${monitorId}
    AND tgl_update > ${waktu}`;

  db.query(cekkategoriSQL, [monitorId, waktu], (error, results) => {
    if (error) {
      console.error('Error fetching data from the database: ' + error);
    } else {
      const kategori = results[0];
      const result = { kategori };

      if (kategori) {
        // Kategori Tujuan
        const kategoriTujuanSQL = `SELECT * FROM antrian_detail
          LEFT JOIN antrian_kategori USING(id_antrian_kategori)
          LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
          WHERE id_antrian_kategori = ${kategori.id_antrian_kategori}`;

        db.query(kategoriTujuanSQL, [kategori.id_antrian_kategori], (error, results) => {
          if (error) {
            console.error('Error fetching kategori tujuan: ' + error);
          } else {
            const kategori_tujuan = results;
            result.kategori.tujuan = kategori_tujuan;

            // Jumlah antrian masing-masing tujuan
            const jumlahAntrianSQL = `SELECT id_antrian_detail, id_antrian_kategori, COUNT(*) AS jml, MAX(nomor_panggil) AS nomor_panggil
              FROM antrian_panggil_detail
              LEFT JOIN antrian_panggil USING(id_antrian_panggil)
              LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
              WHERE id_setting_layar = ${monitorId} AND tanggal = ${currentDate}
              GROUP BY id_antrian_detail`;

            db.query(jumlahAntrianSQL, [monitorId, currentDate], (error, results) => {
              if (error) {
                console.error('Error fetching jumlah antrian: ' + error);
              } else {
                const tujuan_panggil = {};
                results.forEach((val) => {
                  tujuan_panggil[val.id_antrian_detail] = val;
                });
                result.kategori.tujuan_panggil = tujuan_panggil;
                if (kategori || kategori_tujuan) {
                const antrianAkhir = `SELECT * FROM antrian_panggil_detail
                      LEFT JOIN antrian_panggil USING(id_antrian_panggil)
                      LEFT JOIN antrian_detail USING(id_antrian_detail)
                      LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
                      LEFT JOIN antrian_kategori ON antrian_detail.id_antrian_kategori = antrian_kategori.id_antrian_kategori
                      WHERE tanggal =  ${currentDate} AND antrian_kategori.aktif = "Y" AND antrian_detail.aktif = "Y"
                      ORDER BY waktu_panggil DESC LIMIT 1`;

                db.query(antrianAkhir,[currentDate],(error, results) => {
                  if (error) {
                  }else{
                    const kategori_tujuan_akhir = results;
                    result.kategori.antrian_terakhir = kategori_tujuan_akhir;
                    const response = [
                      {'fungsi':'check_perubahan_antrian'},
                      { 'status': 'ok' },
                      { 'data': result }
                    ];
                    
                    ws.send(JSON.stringify(response));
                  }
                }
              );
                }
                
              }
            });
          }
        });
      } else {
        ws.send(JSON.stringify({ status: 'error', message: 'No data found' }));
      }
    }
  });
}

server.listen(8443, () => {
  console.log('WebSocket server is running');
});
