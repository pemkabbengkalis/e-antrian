let i = 0;
let current_ended = 0;
let audio_ended = true;
let audio_object = [];
let current_added = [];
const data_layar_antrian = [];
current_volume = '';



//WEBSOCKET
var websocketURL = 'wss://10.20.30.252:8443?id=' + $('#id-setting-layar').text();

function connectWebSocket() {
	var socket = new WebSocket(websocketURL);

	socket.addEventListener('open', function (event) {
		console.log('Koneksi WebSocket terbuka.', $('#id-setting-layar').text());
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
				case 'check_current_antrian':
					console.log("jalan kan fungsi check_current_antrian");
					if (receivedData[2] && receivedData[2].data) {
						var dataValue = receivedData[2].data;
						console.log("CURRENT 'data':", dataValue);

						// Di sini Anda dapat menggabungkan nilai 'fungsi' dan 'data' sesuai kebutuhan.
						// var combinedResult = {
						// 	fungsi: fungsiValue,
						// 	data: dataValue
						// };
						check_current_antrian(dataValue);
						// console.log("Combined Result:", combinedResult);
					}
					break

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



function check_current_antrian(data) {
	if (Array.isArray(data) && data.length > 0) {
		data_layar_antrian.push(data.data);
		addAudio(data.data);
		if (audio_ended) {
			if (player) {
				current_volume = player.volume;
				new_volume = 5 / 100 * current_volume;
				console.log(current_volume);
				console.log(new_volume.toFixed(2));
				player.volume = new_volume.toFixed(2);
			}
			playSound()
		}

	} else {

	}

}

function check_perubahan_antrian(data) {
	if (data) {
		const kategori = data.kategori;
		const tujuan = data.kategori.tujuan;
		const antrian_terakhir = data.kategori.antrian_terakhir;
	
		console.log("HASIL AKTIF :", antrian_terakhir);
	
		if (kategori) {
		  if (kategori.aktif == 'Y') {
			const $elm = $('div[data-id-kategori="' + kategori.id_antrian_kategori + '"');
			$elm.each(function (i, elm) {
			  $(elm).find('.antrian-awalan').html(kategori.awalan);
	
			  const id_antrian_detail = $(elm).attr('data-id-tujuan');
			  let nomor_antrian = 0;
			  if (id_antrian_detail in kategori.tujuan_panggil) {
				nomor_antrian = kategori.tujuan_panggil[id_antrian_detail].nomor_panggil;
			  }
	
			  $(elm).find('.nomor-antrian-dipanggil').html(nomor_antrian);
			});
		  } else if (kategori.aktif == 'N') {
			const $elm = $('div[data-id-kategori="' + kategori.id_antrian_kategori + '"');
			$elm.each(function (i, elm) {
			  $(elm).find('.antrian-awalan').html('');
			  $(elm).find('.nomor-antrian-dipanggil').html('---');
			});
		  }
		}
	
		if (tujuan) {
		  if (tujuan.tujuan_aktif == 'Y') {
			const $elm = $('div[data-id-tujuan="' + tujuan.id_antrian_detail + '"');
			$elm.find('.antrian-awalan').html(tujuan.awalan);
			let nomor_antrian = tujuan.tujuan_panggil ? tujuan.tujuan_panggil.nomor_panggil || 0:0;
			$elm.find('.nomor-antrian-dipanggil').html(nomor_antrian);
		  } else if (tujuan.tujuan_aktif == 'N') {
			const $elm = $('div[data-id-tujuan="' + tujuan.id_antrian_detail + '"');
			$elm.find('.antrian-awalan').html('');
			$elm.find('.nomor-antrian-dipanggil').html('---');
		  }
		}
	
		if (antrian_terakhir) {
		  $('.number-one').html(antrian_terakhir.awalan_panggil + antrian_terakhir.nomor_panggil);
		  $('.current-antrian-tujuan').html(antrian_terakhir.nama_antrian_tujuan);
		} else {
		  $('.number-one, .current-antrian-tujuan').html('---');
		}
	  }
  }
  



function playSound() {
	audio_ended = false

	if (current_added.indexOf(i) != -1) {
		console.log('change layar');
		data = data_layar_antrian[0];
		if (data) {
			console.log(data.awalan + data.jml_dipanggil);
			$('.current-antrian-number').find('.number-one').html(data.awalan + data.jml_dipanggil);
			$('.current-antrian-tujuan').html(data.nama_antrian_tujuan);
			$('#list-antrian-detail-nomor-' + data.id_antrian_detail).html(data.jml_dipanggil);
		}
		data_layar_antrian.splice(0, 1);
	}
	suara = audio_object[i];

	console.log(i + "-" + audio_object.length);
	if (suara !== undefined) {
		suara.addEventListener('ended', playSound);
		suara.play();
		/* if (i > 0) {
			delete(audio_object[i-1])
		} */
		i++;
	} else {
		if (player) {
			player.volume = current_volume;
		}
		audio_ended = true;
	}
}

function addAudio(data) {

	audio = [];
	current_added.push(audio_object.length)
	awalan_panggil = $('#awalan-panggil').html();

	if (awalan_panggil) {
		textJSON = JSON.parse(awalan_panggil);
		if (textJSON) {
			obj = JSON.parse(textJSON);
			obj.map(item => {
				audio.push(item.toLowerCase());
			});
		}
	}

	if (data.awalan != '') {
		audio.push(data.awalan.toLowerCase() + '.wav');
	}

	audio_angka = terbilang(data.jml_dipanggil);
	audio_angka = audio_angka.split(' ');
	for (k in audio_angka) {
		audio_angka[k] = audio_angka[k].toLowerCase() + '.wav';
	}

	audio = audio.concat(audio_angka);
	audio.push('silakan_menuju_ke.wav');
	nama_file = $.parseJSON(data.nama_file);

	for (k in nama_file) {
		if ($.trim(nama_file[k]) != '') {
			audio.push(nama_file[k].toLowerCase());
			console.log(audio);
		}
	}

	audio.map(file => {
		audio_object.push(new Audio(base_url + 'public/files/audio/' + file));
	})
}


function terbilang(bilangan) {
	bilangan = parseInt(bilangan);
	angka = [];
	angka[0] = '';
	angka[1] = 'satu';
	angka[2] = 'dua';
	angka[3] = 'tiga';
	angka[4] = 'empat';
	angka[5] = 'lima';
	angka[6] = 'enam';
	angka[7] = 'tujuh';
	angka[8] = 'delapan';
	angka[9] = 'sembilan';
	angka[10] = 'sepuluh';
	angka[11] = 'sebelas';

	result = '';
	if (bilangan < 12) {
		result = ' ' + angka[bilangan];
	} else if (bilangan < 20) {
		result = terbilang(bilangan - 10) + ' belas';
	} else if (bilangan < 100) {
		result = terbilang(bilangan / 10) + ' puluh ' + terbilang(bilangan % 10);
	} else if (bilangan < 200) {
		result = ' seratus ' + terbilang(bilangan - 100);
	} else if (bilangan < 1000) {
		result = terbilang(bilangan / 100) + ' ratus ' + terbilang(bilangan % 100);
	}

	/*
	else if ($nilai < 2000) {
		$temp = " seribu" . penyebut($nilai - 1000);
	} else if ($nilai < 1000000) {
		$temp = penyebut($nilai/1000) . " ribu" . penyebut($nilai % 1000);
	} else if ($nilai < 1000000000) {
		$temp = penyebut($nilai/1000000) . " juta" . penyebut($nilai % 1000000);
	} else if ($nilai < 1000000000000) {
		$temp = penyebut($nilai/1000000000) . " milyar" . penyebut(fmod($nilai,1000000000));
	} else if ($nilai < 1000000000000000) {
		$temp = penyebut($nilai/1000000000000) . " trilyun" . penyebut(fmod($nilai,1000000000000));
	}*/

	return $.trim(result);
}


