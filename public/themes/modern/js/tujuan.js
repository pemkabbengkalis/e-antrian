$(document).ready(function(){
	
	let suara = '';
	$('body').delegate('.audio', 'click', function(e) {
		e.preventDefault();
		$this = $(this);
		if (suara)
			suara.pause();
		suara = new Audio(base_url + 'public/files/audio/' + $this.val());
		suara.play();
	});
	
	$(document).delegate('.delete-audio', 'click', function(e){
		e.preventDefault();
		$(this).parent().parent().remove();
	});
	
	$('.add-audio').click(function(e){
		e.preventDefault();
		$this = $(this);
		var $modal = jwdmodal({
			title: 'Pilih File Audio',
			url: base_url + '/tujuan/ajaxListAudio',
			width: '600px',
			action :function () 
			{
				$button = $('.audio-container').find('button.audio');
				list_audio_terpilih = '';
				$button.each(function(i, elm) {
					$('.jwd-modal-body').find('[data-pilih-file="' + $(elm).val() + '"]').prop('disabled', true).addClass('btn-light');
					list_audio_terpilih += '<span class="text-bg-success rounded border py-1 px-3 me-2 mb-1">' + $(elm).val() + '</span>';
				});
				
				$('.jwd-modal-body').prepend('<div class="list-audio-terpilih d-flex flex-wrap"><span class="me-2 mb-1"><strong>Terpilih</strong></span>' + list_audio_terpilih + '</div><hr/>');
			}
			
		});
		
		$(document)
		.undelegate('.pilih-audio', 'click')
		.delegate('.pilih-audio', 'click', function() {
			
			$(this).prop('disabled', true);
			$(this).addClass('btn-light');
			// Audio popup
			$tr = $(this).parents('tr').eq(0);
			$td = $tr.find('td');
			nama_file = $td.eq(1).html();
						
			// Tabel Audio
			$container = $('.audio-container');
			$row = 	'<div class="me-3 mb-2">' +
							'<div class="input-group">' + 
								'<button class="audio btn btn-outline-secondary" value="' + nama_file + '">' + nama_file + ' <i class="fas fa-volume-off"></i>' +
								'</button>' +
								'<button class="btn btn-danger delete-audio"><i class="fas fa-times"></i></button>' +
							'</div>' +
							'<input type="hidden" name="nama_file[]" value="' + nama_file + '">' + 
						'</div>';
					
			$container.append($row);
			$('.list-audio-terpilih').append('<span class="text-bg-success rounded border py-1 px-3 me-2 mb-1">' + nama_file + '</span>');
		});
	});
})