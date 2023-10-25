<?php
echo '<p class="mb-2">Pilih printer untuk ambil antrian:</p><form method="post">';
foreach ($setting_printer as $val) {
	$checked = $setting_layar['id_setting_printer'] == $val['id_setting_printer'] ? ' checked="checked"' : '';
	echo '
	<div class="form-check mb-2">
		<input class="form-check-input" type="radio" name="id_setting_printer" id="setting-' . $val['id_setting_printer'] . '" value="' . $val['id_setting_printer'] . '" data-id-setting-printer="' . $val['id_setting_printer'] . '" data-id-setting-layar="' . $_GET['id'] . '" ' . $checked . '>
		<label class="form-check-label" for="setting-' . $val['id_setting_printer'] . '">
			' . $val['nama_setting_printer'] . '
		</label>
	</div>';
}
echo '</form><a href="' . base_url() . '/setting-printer" target="blank" title="Ubah Setting Printer">Ubah Setting Printer</a>';