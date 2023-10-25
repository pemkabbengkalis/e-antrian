<div class="card">
	<div class="card-header">
		<h5 class="card-title"><?=$current_module['judul_module']?></h5>
	</div>
	
	<div class="card-body">
		
		<?php 
		if (!empty($message)) {
			show_alert($message);
		}
		helper('html');
		
		$jml_antrian = key_exists($kategori['id_antrian_kategori'], $antrian_urut) ? $antrian_urut[$kategori['id_antrian_kategori']]['jml_antrian'] : 0;
		$dipanggil = key_exists($kategori['id_antrian_kategori'], $antrian_urut) ? $antrian_urut[$kategori['id_antrian_kategori']]['jml_dipanggil'] : 0;
		$sisa = $jml_antrian - $dipanggil;
				
		?>
		<div class="mb-3">Nama Antrian</div>
		<table class="table display table-striped table-bordered table-hover" style="width:auto">
		<thead>
			<tr>
				<th>Kategori</th>
				<th>Jml. Antrian</th>
				<th>Awalan</th>
				<th>No. Terakhir</th>
				<th>Sisa</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><?=$kategori['nama_antrian_kategori']?></td>
				<td id="total-antrian"><?=$jml_antrian?></td>
				<td><?=$kategori['awalan']?></td>
				<td id="total-antrian-dipanggil"><?=$dipanggil?></td>
				<td id="total-sisa-antrian"><?=$sisa?></td>
		</tbody>
		</table>
		<div class="mb-3">Tujuan</div>
		<table class="table display table-striped table-bordered table-hover" style="width:auto">
			<thead>
				<tr>
					<th>No</th>
					<th>Tujuan</th>
					<th>No. Terakhir</th>
					<th>Jml. Panggil</th>
					<th>Panggil</th>
					<th>Panggil Ulang</th>
				</tr>
			</thead>
			<tbody>
				<?php
				$no = 1;
				$btn_panggil_disabled = $sisa == 0 ? ' disabled' : '';
				
				/* echo '<pre>'; 
				print_r($jml_dipanggil); die; */
				foreach ($antrian as $val) 
				{
					$jml = 0;
					if (key_exists($val['id_antrian_detail'], $jml_dipanggil)) {
						$jml = count($jml_dipanggil[$val['id_antrian_detail']]['nomor_dipanggil']);
					}
					
					$no_terakhir = 0;
					if (key_exists($val['id_antrian_detail'], $jml_dipanggil)) {
						$no_terakhir = max($jml_dipanggil[$val['id_antrian_detail']]['nomor_dipanggil']);
					}
				
					$btn_panggil_ulang_disabled = $jml == 0 ? ' disabled' : '';
					
					echo '<tr id="antrian-detail-' . $val['id_antrian_detail'] . '">
							<td>' . $no  . '</td>
							<td>' . $val['nama_antrian_tujuan'] . '</td>
							<td>' . $no_terakhir . '</td>
							<td>' . $jml . '</td>
							<td>' . btn_label([
													'attr' => ['class' => 'btn btn-secondary btn-xs panggil-antrian' . $btn_panggil_disabled
																, 'data-id-antrian-detail' => $val['id_antrian_detail']
																, 'data-url' => base_url() . '/antrian-panggil/ajax-panggil-antrian'
															],
													'url' => 'javascript:void(0)',
													'label' => 'Panggil'
												])
								. '</td>
							<td>
							<div class="input-group">';
							if ($jml > 0) {
								$list = $jml_dipanggil[$val['id_antrian_detail']]['nomor_dipanggil'];
								arsort($list);
								$option_no_antrian = [];
								foreach ($list as $no_dipanggil) {
									$option_no_antrian[$no_dipanggil] = $no_dipanggil;
								}
								
								echo options(['name' => 'option_no_antrian', 'class' => 'select2 nomor-antrian', 'style' => 'width:auto'], $option_no_antrian);
							} else {
								echo '<select name="option_no_antrian" class="form-select nomor-antrian" style="display:none; width:auto">
									</select>';
							}
							echo btn_label([
													'attr' => ['class' => 'btn btn-warning btn-xs panggil-ulang-antrian' . $btn_panggil_ulang_disabled
																, 'data-id-antrian-detail' => $val['id_antrian_detail']
																, 'data-url' => base_url() . '/antrian-panggil/ajax-panggil-ulang-antrian'
																, 'data-url-panggil-ulang' => base_url() . '/antrian/panggil-ulang-antrian'
															],
													'url' => 'javascript:void(0)',
													'label' => 'Panggil Ulang'
												])
								. '</div></td>
						</tr>';
						$no++;
				}
				?>
			</tbody>
		</table>
		<span id="id-antrian-kategori" style="display:none"><?=$kategori['id_antrian_kategori']?></span>
	</div>
</div>