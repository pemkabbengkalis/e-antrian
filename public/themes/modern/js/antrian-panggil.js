$(document).ready(function(){
	var suara = '';
	
	$('.panggil-antrian').click(function(){
		
		$this = $(this);
		
		if ($this.hasClass('disable')) {
			return false;
		}
		
		$spinner = $('<i class="fas fa-circle-notch fa-spin me-2 mt-1" style="float:left"></i>');
		$spinner.prependTo($this);
		$this.attr('disabled', 'disabled');
		$this.addClass('disabled');
		$this.prop('disabled', true);
		
		$.ajax({
			url : base_url + 'antrian-panggil/ajax-panggil-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-detail'),
			success : function(data) {
				data = $.parseJSON(data);
				$this.prop('disabled', false);
				$spinner.remove();
				$('#total-antrian-dipanggil').html(data.message.jml_dipanggil);
				
				sisa = parseInt(data.message.jml_antrian) - parseInt(data.message.jml_dipanggil);
				$('#total-sisa-antrian').html(sisa);
				$this.parent().next().find('.panggil-ulang-antrian').removeClass('disabled');
				
				$this.parent().prev().prev().html(data.message.jml_dipanggil);
				
				// jml dipanggil
				$this.parent().prev().html(data.message.jml_dipanggil_by_loket);
				
				if (sisa == 0) {
					$('.panggil-antrian').attr('disabled', 'disabled');
					$('.panggil-antrian').addClass('disabled');
					$('.panggil-antrian').prop('disabled', true);
				} else {
					$this.removeAttr('disabled');
					$this.removeClass('disabled');
				}
				
				if (suara != '') {
					suara.pause();
				}
				console.log(data);
				list_option = data.message.nomor_dipanggil.reverse();
				console.log(list_option);
				options = '';
				list_option.map( i => {
					options += '<option value="' + i + '">' + i + '</option>'
				});
								
				$select = $this.parents('tr').eq(0).find('.nomor-antrian');
				$select.html(options);
				$select.addClass('select2');
				$select.show();
				$select.select2({'theme': 'bootstrap-5'});
				
				// Panggih hanya di layar monitor
				// panggil(data.message);
			}, error: function(xhr) {
				console.log(xhr);
				$this.removeAttr('disabled');
				$spinner.remove();
				$this.removeClass('disabled');
				$this.prop('disabled', false);
				Swal.fire({
					title: 'Error !!!',
					text: xhr.responseText,
					icon: 'error',
					showCloseButton: true,
					confirmButtonText: 'OK'
				})
			}				
		})
	});
	
	$('.panggil-ulang-antrian').click(function(){
		
		$this = $(this);
		if ($this.hasClass('disabled')) {
			return;
		}
		
		$spinner = $('<i class="fas fa-circle-notch fa-spin me-2 mt-1" style="float:left"></i>');
		$spinner.prependTo($this);
		$this.attr('disabled', 'disabled');
		$this.addClass('disabled');
		$this.prop('disabled', true);

		$.ajax({
			url : base_url + 'antrian-panggil/ajax-panggil-ulang-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-detail') + '&nomor_antrian=' + $this.parent().find('.nomor-antrian').val(),
			success : function(result) {
				data = $.parseJSON(result);
				
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$spinner.remove();
				$this.removeClass('disabled');
				
				if (data.status == 'ok') {
					if (suara != '') {
						suara.pause();
					}
				} else {
					Swal.fire({
						title: 'Error !!!',
						text: data.message,
						icon: 'error',
						showCloseButton: true,
						confirmButtonText: 'OK'
					})
				}
				
				// Panggih hanya di layar monitor
				// panggil(data);
			}, error: function(xhr) {
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$spinner.remove();
				$this.removeClass('disabled');
				console.log(xhr);
				Swal.fire({
					title: 'Error !!!',
					text: xhr.responseText,
					icon: 'error',
					showCloseButton: true,
					confirmButtonText: 'OK'
				})
			}				
		})
	});
	
	/* $('.custom-panggil-ulang-antrian').click(function(){
		
		$this = $(this);
		if ($this.hasClass('disabled')) {
			return;
		}
		
		$spinner = $('<i class="fas fa-circle-notch fa-spin me-2 mt-1" style="float:left"></i>');
		$spinner.prependTo($this);
		$this.attr('disabled', 'disabled');
		$this.addClass('disabled');
		$this.prop('disabled', true);

		$.ajax({
			url : base_url + 'antrian-panggil/ajax-panggil-ulang-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-kategori') + '&nomor_antrian=' + $('#option-nomor-antrian').val(),
			success : function(result) {
				data = $.parseJSON(result);
				
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$spinner.remove();
				$this.removeClass('disabled');
				
				if (data.status == 'ok') {
					if (suara != '') {
						suara.pause();
					}
				} else {
					Swal.fire({
						title: 'Error !!!',
						text: data.message,
						icon: 'error',
						showCloseButton: true,
						confirmButtonText: 'OK'
					})
				}
				// Panggil hanya di layar monitor
				// panggil(data);
			}, error: function(xhr) {
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$spinner.remove();
				$this.removeClass('disabled');
				console.log(xhr);
				Swal.fire({
					title: 'Error !!!',
					text: xhr.responseText,
					icon: 'error',
					showCloseButton: true,
					confirmButtonText: 'OK'
				})
			}				
		})
	}); */
	
	$('.select2').select2({'theme':'bootstrap-5'});
})