<form method="post" action="">
	<?php
	foreach ($list_tujuan as $val) 
		{
			$result_data[$val['id_antrian_kategori']]['kategori'] = $val;
			$result_data[$val['id_antrian_kategori']]['tujuan'][] = $val;
			$result_data[$val['id_antrian_kategori']]['id_user'] = $val['id_user'];
		}
		
		$result = '';
		
		$list_item = '';
		// echo '<pre>'; print_r($result_data); die;
		foreach ($result_data as $val)
		{
			$list_item .= '<li><strong>' . $val['kategori']['nama_antrian_kategori'] . '</strong><ul>';
			foreach($val['tujuan'] as $item) 
			{
				$checked = $item['id_user'] ? 'checked="checked"' : '';
				$list_item .= '
					<li class="m-0"><div class="form-check">
						<input class="form-check-input" type="checkbox" name="id_antrian_detail[]" value="' . $item['id_antrian_detail'] . '" id="tujuan-' . $item['id_antrian_detail'] . '" ' . $checked . '>
						<label class="form-check-label" for="tujuan-' . $item['id_antrian_detail'] . '">' . $item['nama_antrian_tujuan'] . '</label>
					</div></li>';
					
				$list_item .= '</li>';							
			}
			$list_item .= '</ul>';
			
		}
		if ($list_item) {
			$result .= '<ul class="list-circle">' . $list_item . '</ul>
						<div class="d-flex mt-2"><a href="javascript:void(0)" title="Check All" class="check-all">Check All</a><span class="ms-2 me-2">|</span><a href="javascript:void(0)" class="uncheck-all" title="Check All">Uncheck All</a></div>';
			
		}
		
	echo $result;
	
	?>
	<input type="hidden" name="id_user" value="<?=$_GET['id']?>"/>
</form>