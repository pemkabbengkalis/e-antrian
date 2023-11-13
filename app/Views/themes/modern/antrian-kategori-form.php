<div class="card">
	<div class="card-header">
		<h5 class="card-title"><?=$title?></h5>
	</div>
	<style>
        #preview {
            max-width: 100%;
            max-height: 200px;
            margin-top: 20px;
        }
    </style>
	<div class="card-body">
		<?php
		helper ('html');
		echo btn_link([
			'attr' => ['class' => 'btn btn-success btn-xs'],
			'url' => base_url() . '/antrian/add',
			'icon' => 'fa fa-plus',
			'label' => 'Tambah Kategori Antrian'
		]);
		
		echo btn_link([
			'attr' => ['class' => 'btn btn-light btn-xs'],
			'url' => $config->baseURL . '/antrian',
			'icon' => 'fa fa-arrow-circle-left',
			'label' => 'Daftar Kategori Antrian'
		]);
		?>
		<hr/>
		<?php
			if (!empty($message)) {
					show_message($message);
		} 
		helper('html');
		?>
		<form method="post" action="<?=current_url(true)?>" class="form-horizontal" enctype="multipart/form-data">
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Nama Kategori Antrian</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="nama_antrian_kategori" value="<?=set_value('nama_antrian_kategori', @$antrian_kategori['nama_antrian_kategori'])?>"/>
					<input type="hidden" name="nama_antrian_kategori_old" value="<?=set_value('nama_antrian_kategori_old', @$antrian_kategori['nama_antrian_kategori'])?>"/>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Abjad Awal Antrian</label>
				<div class="col-sm-5">
					<?php
					echo options(['name' => 'awalan'], ['' => 'Tidak', 'A' => 'A', 'B' => 'B', 'C' => 'C', 'D' => 'D', 'E' => 'E', 'F' => 'F', 'G' => 'G','H' => 'H','I' => 'I', 'J' => 'J'], set_value('awalan', @$antrian_kategori['awalan']) )
					?>
					<small>Misal: sistem nomor nya A1, A2, A3, dst... (diawali abjad A), berarti awalan nya adalah A</small>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Aktif</label>
				<div class="col-sm-5">
					<?php
					echo options(['name' => 'aktif'], ['Y' => 'Ya', 'N' => 'Tidak'], set_value('aktif', @$antrian_kategori['aktif']) )
					?>
				</div>
			</div>
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">Logo</label>
				<div class="col-sm-5">
				<div id="preview" data-src="<?php echo $antrian_kategori['logo']; ?>">
					<?php if (!empty($antrian_kategori['logo'])): ?>
						<img src="<?php echo $config->baseURL . 'public/images/logo/' . $antrian_kategori['logo']; ?>" style="max-width: 100%; max-height: 200px;">
					<?php endif; ?>
				</div>
				<input type="file" class="form-control" name="logo" id="imageInput" accept="image/*" onchange="previewImage(event)">
				</div>
			</div>
			<div class="row">
				<div class="col-sm-5">
					<button type="submit" name="submit" value="submit" class="btn btn-primary">Submit</button>
					<input type="hidden" name="id" value="<?=@$id_antrian_kategori?>"/>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
        function previewImage(event) {
            var input = event.target;
            var preview = document.getElementById('preview');

            // Pastikan ada gambar yang dipilih
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    // Tampilkan gambar yang dipilih dalam elemen img
                    var img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.maxWidth = '100%';
                    img.style.maxHeight = '200px';

                    // Bersihkan tampilan sebelumnya
                    preview.innerHTML = '';

                    // Tambahkan gambar ke dalam elemen div dengan id 'preview'
                    preview.appendChild(img);
                };

                // Baca data gambar sebagai URL
                reader.readAsDataURL(input.files[0]);
            } else {
                // Jika tidak ada gambar yang dipilih, hapus tampilan sebelumnya
				<?php
                if (!empty($antrian_kategori['logo'])) {
                    echo "var defaultImage = document.createElement('img');";
                    echo "defaultImage.src = '" . $config->baseURL . 'public/images/logo/' . $antrian_kategori['logo'] . "';";
                    echo "defaultImage.style.maxWidth = '100%';";
                    echo "defaultImage.style.maxHeight = '200px';";
                    echo "preview.innerHTML = '';";
                    echo "preview.appendChild(defaultImage);";
                } else {
                    echo "preview.innerHTML = '';";
                }
            ?>
                
            }
        }
    </script>