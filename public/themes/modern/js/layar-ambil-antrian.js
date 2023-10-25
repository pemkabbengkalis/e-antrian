$(document).ready(function(){
	$('.ambil-antrian').click(function(){
		$this = $(this);
		$span = $this.find('span').css('position', 'relative');
		$loader = $('<i class="fas fa-circle-notch fa-spin fa-lg mt-2" style="position: absolute;bottom: -15px;left: calc(50% - 11px);"></i>');
		$loader.appendTo($span);
		$this.attr('disabled', 'disabled');
		$this.prop('disabled', true);
		
		$.ajax({
			url : base_url + 'antrian-ambil/ajax-ambil-antrian',
			type : 'post',
			data : 'id=' + $this.attr('data-id-antrian-kategori'),
			success : function(data) {
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$loader.remove();
				console.log(data);
			}, error: function(xhr) {
				$this.prop('disabled', false);
				$this.removeAttr('disabled');
				$loader.remove();
				bootbox.alert('<strong>Error</strong> ' + xhr.responseJSON.message);
			}				
		})
	});
	
	$('.btn-setting-printer').click(function() {
		$this = $(this);
		id = $this.attr('data-id-setting-layar');
		$bootbox =  bootbox.dialog({
			title: 'Pilih Printer',
			message: '<div class="text-center text-secondary"><div class="spinner-border"></div></div>',
			buttons: {
				cancel: {
					label: 'Cancel'
				},
				success: {
					label: 'Submit',
					className: 'btn-success submit',
					callback: function() 
					{
						$form = $bootbox.find('form');
						data = $form.serialize();
						if (!data) {
							bootbox.alert('<div class="alert alert-danger">Error: Printer belum dipilih</div>');
							return false;
						}
						
						$spinner = $('<i class="fas fa-circle-notch fa-spin ms-2 fa-lg"></i>');
						$bootbox.find('.alert').remove();
						$button_submit.append($spinner);
						$button.prop('disabled', true);
						
						form = $bootbox.find('form')[0];
						$.ajax({
							type: 'POST',
							url: base_url + 'layar/ajaxUpdateDataPilihPrinter',
							data: data + '&id_setting_layar=' + id,
							dataType: 'json',
							success: function (data) {
								
								$bootbox.modal('hide');
								if (data.status == 'ok') {
									const Toast = Swal.mixin({
										toast: true,
										position: 'top-end',
										showConfirmButton: false,
										timer: 2500,
										timerProgressBar: true,
										iconColor: 'white',
										customClass: {
											popup: 'bg-success text-light toast p-2'
										},
										didOpen: (toast) => {
											toast.addEventListener('mouseenter', Swal.stopTimer)
											toast.addEventListener('mouseleave', Swal.resumeTimer)
										}
									})
									Toast.fire({
										html: '<div class="toast-content"><i class="far fa-check-circle me-2"></i> Data berhasil disimpan</div>'
									})
									$this.parents('tr').find('.nama-printer').html(data.printer.nama_setting_printer);
								} else {
									$button.prop('disabled', false);
									$spinner.remove();
									show_alert('Error !!!', data.message, 'error');
								}
							},
							error: function (xhr) {
								$button.prop('disabled', false);
								$spinner.remove();
								show_alert('Error !!!', xhr.responseText, 'error');
								console.log(xhr.responseText);
							}
						})
						return false;
					}
				}
			}
		});
		$bootbox.find('.modal-dialog').css('max-width', '400px');
		var $button = $bootbox.find('button').prop('disabled', true);
		var $button_submit = $bootbox.find('button.submit');
		
		$.get(base_url + 'layar/ajaxGetFormPilihPrinter?id=' + id, function(html){
			$button.prop('disabled', false);
			$bootbox.find('.modal-body').empty().append(html);
		});
	})
})