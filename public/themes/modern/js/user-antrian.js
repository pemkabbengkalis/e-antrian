/**
* Written by: Agus Prawoto Hadi
* Year		: 2022
* Website	: jagowebdev.com
*/

jQuery(document).ready(function () {
	
	if ($('#table-result').length) {
		column = $.parseJSON($('#dataTables-column').html());
		url = $('#dataTables-url').text();
		
		 var settings = {
			"processing": true,
			"serverSide": true,
			"scrollX": true,
			"ajax": {
				"url": url,
				"type": "POST",
				/* "dataSrc": function (json) {
					console.log(json)
				} */
			},
			"columns": column
		}
		
		$add_setting = $('#dataTables-setting');
		if ($add_setting.length > 0) {
			add_setting = $.parseJSON($('#dataTables-setting').html());
			for (k in add_setting) {
				settings[k] = add_setting[k];
			}
		}
		
		dataTables =  $('#table-result').DataTable( settings );
	}
	
	$bootbox = '';
	$('table').undelegate('click').delegate('.btn-assign-antrian', 'click', function(e) {
		$this = $(this);
		e.preventDefault();
		id = $(this).attr('data-id-user');
		$bootbox =  bootbox.dialog({
			title: 'Assign User ke Antrian',
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
						$spinner = $('<i class="fas fa-circle-notch fa-spin ms-2 fa-lg"></i>');
						$bootbox.find('.alert').remove();
						$button_submit.append($spinner);
						$button.prop('disabled', true);
						
						form = $bootbox.find('form')[0];
						$.ajax({
							type: 'POST',
							url: base_url + 'user-antrian/ajaxUpdateUserAntrian',
							data: $bootbox.find('form').serialize(),
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
									dataTables.draw();
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
		// $bootbox.find('.modal-dialog').css('max-width', '400px');
		var $button = $bootbox.find('button').prop('disabled', true);
		var $button_submit = $bootbox.find('button.submit');
		
		$.get(base_url + 'user-antrian/ajaxGetAssignAntian?id=' + id, function(html){
			$button.prop('disabled', false);
			$bootbox.find('.modal-body').empty().append(html);
		});
	})
	
	$('body').delegate('.check-all', 'click', function() {
		$bootbox.find('input[type="checkbox"]').prop('checked', true);
	});
	$('body').delegate('.uncheck-all', 'click', function() {
		$bootbox.find('input[type="checkbox"]').prop('checked', false);
	});
});