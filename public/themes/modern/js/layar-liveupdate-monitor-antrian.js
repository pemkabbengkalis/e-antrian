let i = 0;
let current_ended = 0;
let audio_ended = true;
let audio_object = [];
let current_added = [];
const data_layar_antrian = [];
current_volume = '';



//WEBSOCKET
var websocketURL = 'wss://10.20.30.252:8443?id='+ $('#id-setting-layar').text();

function connectWebSocket() {
	var socket = new WebSocket(websocketURL);

	socket.addEventListener('open', function (event) {
		console.log('Koneksi WebSocket terbuka.',$('#id-setting-layar').text());
        var id = $('#id-setting-layar').text();
        var message = {
            action: 'set_id',
            id: id
        };
        socket.send(JSON.stringify(message));
	});

	socket.addEventListener('message', function (event) {
		var receivedData = JSON.parse(event.data);

		if (receivedData[0] && receivedData[0].fungsi) {
			var fungsiValue = receivedData[0].fungsi;
			switch (fungsiValue) {
				case 'check_perubahan_antrian':
					console.log("jalan kan fungsi check_perubahan_antrian");
					if (receivedData[2] && receivedData[2].data) {
						var dataValue = receivedData[2].data;
						console.log("Value of 'data':", dataValue);
			
						// Di sini Anda dapat menggabungkan nilai 'fungsi' dan 'data' sesuai kebutuhan.
						// var combinedResult = {
						// 	fungsi: fungsiValue,
						// 	data: dataValue
						// };
						check_perubahan_antrian(dataValue);
						// console.log("Combined Result:", combinedResult);
					}
					break;

				default:
					break;
			}
		}
	});

	socket.addEventListener('close', function (event) {
		if (event.wasClean) {
			console.log('Koneksi WebSocket ditutup dengan bersih, kode: ' + event.code + ', alasan: ' + event.reason);
		} else {
			console.error('Koneksi WebSocket terputus. Mencoba menghubungkan ulang dalam 5 detik.');
			setTimeout(connectWebSocket, 5000); // Coba menghubungkan ulang dalam 5 detik.
		}
	});

	socket.addEventListener('error', function (event) {
		console.error('Terjadi kesalahan koneksi WebSocket:', event);
	});
}

connectWebSocket();


function check_perubahan_antrian(data) 
{
	
			kategori = data.kategori;
			tujuan = data.kategori.tujuan;
			antrian_terakhir = data.kategori.antrian_terakhir[0];

			console.log("HASIL AKTIF :",antrian_terakhir);

			if (kategori) {

				if (kategori.aktif == 'Y') {
					$elm = $('div[data-id-kategori="' + kategori.id_antrian_kategori + '"');
					$elm.each(function(i, elm) 
					{
						$(elm).find('.antrian-awalan').html(kategori.awalan);

						id_antrian_detail = $(elm).attr('data-id-tujuan');
						nomor_antrian = 0;
						if (id_antrian_detail in kategori.tujuan_panggil) {
							nomor_antrian = kategori.tujuan_panggil[id_antrian_detail].nomor_panggil;
						}

						$(elm).find('.nomor-antrian-dipanggil').html(nomor_antrian);
					})

				} else if (kategori.aktif == 'N') 
				{

					$elm = $('div[data-id-kategori="' + kategori.id_antrian_kategori + '"');
					$elm.each(function(i, elm) {
						$(elm).find('.antrian-awalan').html('');
						$(elm).find('.nomor-antrian-dipanggil').html('---');
					})							
				}
			}

			if (tujuan) {
				if (tujuan.tujuan_aktif == 'Y') 
				{
					$elm = $('div[data-id-tujuan="' + tujuan.id_antrian_detail + '"');
					$elm.find('.antrian-awalan').html(tujuan.awalan);
					nomor_antrian = tujuan.tujuan_panggil?.nomor_panggil || 0;
					$elm.find('.nomor-antrian-dipanggil').html(nomor_antrian);

				} else if (tujuan.tujuan_aktif == 'N') 
				{

					$elm = $('div[data-id-tujuan="' + tujuan.id_antrian_detail + '"');
					$elm.find('.antrian-awalan').html('');
					$elm.find('.nomor-antrian-dipanggil').html('---');							
				}

			}

			if (antrian_terakhir.length > 0) 
			{
				$('.number-one').html(antrian_terakhir.awalan_panggil + antrian_terakhir.nomor_panggil);
				$('.current-antrian-tujuan').html(antrian_terakhir.nama_antrian_tujuan);
			} else {
				//$('.number-one, .current-antrian-tujuan').html('---');
			}

			
		
	}