$(document).ready(function() {
	/* Cek apakah ada penambahan antrian atau yang dipanggil*/
	function check_current_ambil() 
	{
		$.ajax({
			type : 'post',
			url : base_url + '/longPolling/current_antrian_ambil',
			dataType : 'JSON',
			success : function(data) 
			{
				console.log(data);
				for (k in data.data) {
					$('tr[data-id-antrian-kategori="' + k + '"]').find('td').eq(3).html(data.data[k].jml_antrian);
				}
							
				check_current_ambil();
			}, error : function (xhr) {
				console.log(xhr);
				alert('Ajax Error !!!', xhr.responseText + '<br/><strong>Note</strong>: Detail error ada di console browser');
			}
		})
	}
	
	check_current_ambil();
})