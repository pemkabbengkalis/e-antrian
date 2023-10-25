<div class="card">
	<div class="card-header">
		<h5 class="card-title"><?=$title?></h5>
	</div>
	<div class="card-body">
		<?php
			if (!empty($message)) {
					show_message($message);
		}
		helper ('html');
		echo btn_link([
			'attr' => ['class' => 'btn btn-success btn-xs'],
			'url' => base_url() . '/setting-printer/add',
			'icon' => 'fa fa-plus',
			'label' => 'Tambah Data'
		]);
		
		echo btn_link([
			'attr' => ['class' => 'btn btn-light btn-xs'],
			'url' => $config->baseURL . '/setting-printer',
			'icon' => 'fa fa-arrow-circle-left',
			'label' => 'Daftar Setting Printer'
		]);
		?>
		<hr/>
		<form method="post" action="<?=current_url(true)?>" class="form-horizontal" enctype="multipart/form-data">
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Nama Setting</label>
				<div class="col-sm-5">
					<input class="form-control" type="text" name="nama_setting_printer" value="<?=set_value('nama_setting_printer', @$result['nama_setting_printer'])?>" required="required"/>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Alamat Server</label>
				<div class="col-sm-5">
					<textarea class="form-control" name="alamat_server"><?=set_value('alamat_server', @$result['alamat_server'])?></textarea>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Aktif</label>
				<div class="col-sm-5">
					<?php
					echo options(['name' => 'aktif'], ['1' => 'Ya', '0' => 'Tidak'], set_value('aktif', @$result['aktif']));
					?>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Feed</label>
				<div class="col-sm-5">
					<?=options(['name' => 'feed'], ['1' => '1', '2' => '2', '3' => '3', '4' => '4', '5' => '5'], set_value('feed', @$result['feed']));?>
					<small>Banyaknya scrool keatas setelah proses cetak selesai</small>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Jenis Font</label>
				<div class="col-sm-5">
					<?=options(['name' => 'font_type'], ['FONT_A' => 'Font A', 'FONT_B' => 'Font B', 'FONT_C' => 'Font C'], set_value('font_type', @$result['font_type']));?>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Ukuran Font</label>
				<div class="col-sm-5">
					<div class="input-group">
						<div class="input-group me-2" style="width:130px">
							<span class="input-group-text">Width</span>
							<?php
							$range = range(1,8);
							$list_option = [];
							foreach ($range as $val) {
								$list_option[$val] = $val;
							}
							echo options(['name' => 'font_size_width'], $list_option, set_value('font_size_width', @$result['font_size_width']));
							?>
						</div>
						<div class="input-group" style="width:130px">
							<span class="input-group-text">Height</span>
							<?php
							echo options(['name' => 'font_size_height'], $list_option, set_value('font_size_height', @$result['font_size_height']));
							?>
						</div>
					</div>
					<small>Ukuran huruf khusus bagian nomor antrian seperti A1, A2, A3, dst</small>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Autocut</label>
				<div class="col-sm-5">
					<?=options(['name' => 'autocut'], ['N' => 'Tidak', 'Y' => 'Ya'], set_value('autocut', @$result['autocut']));?>
					<small>Khusus printer thermal yang memiliki fitur auto cut</small>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-5">
					<button type="submit" name="submit" value="submit" class="btn btn-primary">Submit</button>
					<input type="hidden" name="id" value="<?=@$id?>"/>
				</div>
			</div>
		</form>
	</div>
</div>