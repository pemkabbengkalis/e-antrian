// import https from 'http'; // LOCAL'
import https from 'https'; // LIVE
import {
  WebSocketServer
} from 'ws';
import mysql from 'mysql2';
import {
  parse
} from 'url';
import fs from 'fs';


// const currentDate = new Date().toISOString().split('T')[0];
// function formatWaktu() {
//   const waktuSaatIni = new Date();
//   const jam = String(waktuSaatIni.getHours()).padStart(2, '0');
//   const menit = String(waktuSaatIni.getMinutes()).padStart(2, '0');
//   const detik = String(waktuSaatIni.getSeconds()).padStart(2, '0');

//   return `${jam}:${menit}:${detik}`;
// }
// function selisihDetik(waktu1, waktu2) {
//   const [jam1, menit1, detik1] = waktu1.split(':').map(Number);
//   const [jam2, menit2, detik2] = waktu2.split(':').map(Number);

//   const totalDetik1 = (jam1 * 3600) + (menit1 * 60) + detik1;
//   const totalDetik2 = (jam2 * 3600) + (menit2 * 60) + detik2;

//   return Math.abs(totalDetik1 - totalDetik2);
// }
const wss = new WebSocketServer({
  noServer: true
}); // Menggunakan noServer: true agar WebSocketServer tidak membuat server HTTP

//Env Server
const db = mysql.createPool({
  host: '10.20.30.252',
  user: 'loca_antrian',
  password: 'mpp@2023',
  database: 'loca_antrian',
});

//Env Local
// const db = mysql.createPool({
//   host: '127.0.0.1',
//   user: 'root',
//   password: '',
//   database: 'e-antrian',
// });

const clients = {}; 

//ONLINE KEY
const server = https.createServer({
  key: fs.readFileSync('/home/localhost/public_html/e-antrian/websocket/key.pem'),
  cert: fs.readFileSync('/home/localhost/public_html/e-antrian/websocket/cert.pem'),

});

//LOCAL KEY
// const server = https.createServer({
//   key: fs.readFileSync('server-key.pem'),
//   cert: fs.readFileSync('server-cert.pem'),
// });

server.on('upgrade', (request, socket, head) => {
  const {
    pathname,
    query
  } = parse(request.url, true);
  const monitorId = query.id;
  wss.handleUpgrade(request, socket, head, (ws) => {
    clients[monitorId] = ws;
    wss.emit('connection', ws, request, monitorId);
  });
});

wss.on('connection', function connection(ws, request, monitorId) {
  ws.on('message', function message(data) {
    try {
      getCurrentAntrian(ws, monitorId);
      getLastAntrianUpdate(ws, monitorId);
    } catch (error) {
      console.error('Error parsing client data: ' + error);
    }
  });

  const interval = setInterval(() => {
    getCurrentAntrian(ws, monitorId);
    getLastAntrianUpdate(ws, monitorId);
  }, 1000);

  ws.on('close', () => {
    clearInterval(interval);
    delete clients[monitorId]; // Hapus koneksi yang sudah ditutup
  });
});

/*current Antrian*/

function getCurrentAntrian(ws, monitorId) {
  const query = `SELECT MAX(waktu_panggil) AS waktu_panggil FROM antrian_panggil_detail
  LEFT JOIN antrian_detail USING(id_antrian_detail)
  LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
  LEFT JOIN antrian_panggil USING(id_antrian_panggil)
  WHERE id_setting_layar = ${monitorId} AND tanggal = "${currentDate}" `;
  //hasilnya : 03:59:43;
  db.query(query, (error, results) => {
    if (error) {
      console.error('Error fetching data from the database: ' + error);
    } else {
      const waktu_panggil = results[0];
      const wp = waktu_panggil['waktu_panggil'];
  console.log('waktu panggil terakhir', formatWaktu());

     
        const querAntrianBelumDipanggil = `SELECT * FROM antrian_panggil_detail LEFT JOIN antrian_detail USING(id_antrian_detail) LEFT JOIN antrian_tujuan USING(id_antrian_tujuan) LEFT JOIN antrian_kategori USING(id_antrian_kategori) LEFT JOIN setting_layar_detail USING(id_antrian_kategori) LEFT JOIN antrian_panggil USING(id_antrian_panggil) WHERE tanggal = "${currentDate}" AND waktu_panggil = "${wp}" AND id_setting_layar = "${monitorId}"`;
        db.query(querAntrianBelumDipanggil, (error, results) => {
          if (error) {
            console.error('Error fetching data from the database: ' + error);
          } else {
            console.log('Berhasil dapat antrian baru', wp.toString());
            const resulttime = [{
              'currentDate': currentDate
            },
            {
              'currentTime':waktu_panggil['waktu_panggil']
            }
          ]
            const response = [{
                'fungsi': 'check_current_antrian'
              },
              {
                'status': 'ok'
              },
              {
                'data': results
              },{
                'ID LAYAR':monitorId
              }
            ];
  
            ws.send(JSON.stringify(response));
          }
        });
        
     
     
        
    }
  });
}




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
      const data = results;
      getAllAntrianUpdate(ws, monitorId, data);
    }
  });
}

function getAllAntrianUpdate(ws, monitorId, waktu) {
  const result = {};
  // Cek Kategori
  const cekkategoriSQL = `SELECT * 
  FROM antrian_kategori 
  LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
  WHERE id_setting_layar = ?
  AND tgl_update >= ?`;

  db.query(cekkategoriSQL, [monitorId, waktu[0]['tgl_update_kategori']], (error, results) => {
    if (error) {
      console.error('Error fetching data from the database: ' + error);
    } else {
      const hasilkategori = results;
      result.kategori = hasilkategori;
      if (hasilkategori) {
        // Kategori Tujuan
        const kategoriTujuanSQL = `SELECT * FROM antrian_detail
        LEFT JOIN antrian_kategori USING(id_antrian_kategori)
        LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
        WHERE id_antrian_kategori = ?`;


        db.query(kategoriTujuanSQL, [hasilkategori.id_antrian_kategori], (error, results) => {
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
            WHERE id_setting_Layar = ? AND tanggal = ?
            GROUP BY id_antrian_detail`;


            db.query(jumlahAntrianSQL, [monitorId, currentDate], (error, results) => {
              if (error) {
                console.error('Error fetching jumlah antrian: ' + error);
              } else {
                const tujuan_panggil = [];
                results.forEach((val) => {
                  tujuan_panggil[val.id_antrian_detail] = val;
                });
                result.kategori.tujuan_panggil = tujuan_panggil;
                //Cek update Tujuan
                const antrianAktif = `SELECT *, antrian_detail.aktif AS tujuan_aktif
                FROM antrian_detail
                LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
                LEFT JOIN antrian_kategori USING(id_antrian_kategori)
                LEFT JOIN setting_layar_detail USING (id_antrian_kategori)
                WHERE id_setting_layar = ?
                AND antrian_detail.tgl_update > ? `;

                db.query(antrianAktif, [monitorId, waktu[0]['tgl_update_tujuan']], (error, results) => {
                  if (error) {
                    console.error('Error fetching jumlah antrian: ' + error);
                  } else {
                    const tujuan = results
                    result.tujuan = tujuan;
                    if (tujuan) {
                      // Jumlah antrian tujuan
                      const jumlAntrianTujuan = `SELECT id_antrian_detail, id_antrian_kategori, COUNT(*) AS jml, MAX(nomor_panggil) AS nomor_panggil
                      FROM antrian_panggil_detail
                      LEFT JOIN antrian_panggil USING(id_antrian_panggil)
                      WHERE id_antrian_detail = ? AND tanggal = ?
                      GROUP BY id_antrian_detail`;
                      db.query(jumlAntrianTujuan, [tujuan.id_antrian_detail, currentDate], (error, results) => {
                        if (error) {
                          console.error('Error fetching jumlah antrian: ' + error);
                        } else {
                          const tujuanpanggil = results;
                          result.tujuan.tujuan_panggil = tujuanpanggil;
                        }
                      });
                    }
                    if (result.kategori || result.tujuan) {
                      const antrianAkhir = `SELECT * FROM antrian_panggil_detail
                      LEFT JOIN antrian_panggil USING(id_antrian_panggil)
                      LEFT JOIN antrian_detail USING(id_antrian_detail)
                      LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
                      LEFT JOIN antrian_kategori ON antrian_detail.id_antrian_kategori = antrian_kategori.id_antrian_kategori
                      WHERE tanggal = ? AND antrian_kategori.aktif = "Y" AND antrian_detail.aktif = "Y"
                      ORDER BY waktu_panggil DESC LIMIT 1`;

                      db.query(antrianAkhir, [currentDate], (error, results) => {
                        if (error) {} else {
                          const kategori_tujuan_akhir = results;
                          result.kategori.antrian_terakhir = kategori_tujuan_akhir;

                        }
                      });
                    }

                    if (!result.kategori && !result.tujuan) {
                      return false;
                    }


                    const response = [{
                        'fungsi': 'check_perubahan_antrian'
                      },
                      {
                        'status': 'ok'
                      },
                      {
                        'data': result
                      },
                    ];

                    ws.send(JSON.stringify(response));
                  }
                });



              }
            });
          }
        });
      } else {
        ws.send(JSON.stringify({
          status: 'error',
          message: 'No data found'
        }));
      }
    }
  });
}

server.listen(8443, () => {
  console.log('WebSocket server is running');
});