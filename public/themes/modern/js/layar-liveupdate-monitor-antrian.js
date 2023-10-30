let audio_object = [];
let current_added = [];
const data_layar_antrian = [];
let audio_ended = true;
let current_volume = '';
let i = 0;

$(document).ready(function() {
    // Fungsi untuk polling data setiap 5 detik
    function pollData(url, callback) {
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'JSON',
            success: function(data) {
                data_layar_antrian.push(data.data);
                addAudio(data.data);
                if (audio_ended) {
                    if (player) {
                        current_volume = player.volume;
                        new_volume = (5 / 100) * current_volume;
                        console.log(current_volume);
                        console.log(new_volume.toFixed(2));
                        player.volume = new_volume.toFixed(2);
                    }
                    playSound();
                }
                if (typeof callback === 'function') {
                    callback();
                }
            },
            error: function(xhr) {
                console.log(xhr);
                alert('Ajax Error !!!', xhr.responseText + '<br/><strong>Note</strong>: Detail error ada di console browser');
                if (typeof callback === 'function') {
                    callback();
                }
            }
        });
    }

    function pollDataWithInterval(url, callback, interval) {
        pollData(url, function() {
            setTimeout(function() {
                pollDataWithInterval(url, callback, interval);
            }, interval);
        });
    }

    // Panggil fungsi polling dengan interval 5 detik
    pollDataWithInterval(base_url + '/longPolling/monitor_current_antrian?id=' + $('#id-setting-layar').text(), function() {
        // callback function jika diperlukan
    }, 60000);

    pollDataWithInterval(base_url + '/longPolling/monitor_panggil_ulang_antrian?id=' + $('#id-setting-layar').text(), function() {
        // callback function jika diperlukan
    }, 60000);

    pollDataWithInterval(base_url + '/longPolling/monitor_perubahan_antrian?id=' + $('#id-setting-layar').text(), function() {
        // callback function jika diperlukan
    }, 60000);

    function playSound() {
        audio_ended = false;
        if (current_added.indexOf(i) !== -1) {
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

        console.log(i + '-' + audio_object.length);
        if (suara !== undefined) {
            suara.addEventListener('ended', playSound);
            suara.play();
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
        current_added.push(audio_object.length);
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

        if (data.awalan !== '') {
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
            if ($.trim(nama_file[k]) !== '') {
                audio.push(nama_file[k].toLowerCase());
                console.log(audio);
            }
        }

        audio.map(file => {
            audio_object.push(new Audio(base_url + 'public/files/audio/' + file));
        });
    }

	function terbilang(bilangan) 
	{
		bilangan = parseInt(bilangan);
		angka = [];
		angka[0] = '';
		angka[1] = 'satu';
		angka[2] =  'dua';
		angka[3] =  'tiga';
		angka[4] =  'empat';
		angka[5] =  'lima';
		angka[6] =  'enam';
		angka[7] =  'tujuh';
		angka[8] =  'delapan';
		angka[9] =  'sembilan';
		angka[10] =  'sepuluh';
		angka[11] =  'sebelas';
		
		result = '';
		if (bilangan < 12) {
			result = ' ' + angka[bilangan];
		} else if (bilangan < 20) {
			result = terbilang(bilangan - 10) + ' belas';
		} else if (bilangan < 100) {
			result = terbilang(bilangan/10) + ' puluh ' + terbilang(bilangan % 10);
		} else if (bilangan < 200) {
			result = ' seratus ' + terbilang(bilangan - 100);
		} else if (bilangan < 1000) {
			result = terbilang(bilangan/100) + ' ratus ' + terbilang(bilangan % 100);
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
});
