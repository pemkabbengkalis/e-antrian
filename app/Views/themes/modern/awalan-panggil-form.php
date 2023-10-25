<div class="card">
	<div class="card-header">
		<h5 class="card-title"><?=$title?></h5>
	</div>
	<div class="card-body">
		<?php
			if (!empty($message)) {
					show_message($message);
		} 
		?>
		<form method="post" action="<?=current_url(true)?>" class="form-horizontal" enctype="multipart/form-data">
			<div class="row mb-3">
				<label class="col-sm-3 col-md-2 col-lg-3 col-xl-2 col-form-label">File Audio</label>
				<div class="col-sm-5">
					<div class="clearfix mb-2 audio-container">
					<?php
					if (!empty($result['nama_file'])) {
						$audio = json_decode($result['nama_file'], true);
						foreach ($audio as $file) {
							echo '
							<div class="me-3 mb-2">
								<div class="input-group">
									<button class="audio btn btn-outline-secondary" value="' . $file . '">' . $file . ' <i class="fas fa-volume-off"></i>
									
									</button>
									<button class="btn btn-danger delete-audio"><i class="fas fa-times"></i></button>
								</div>
								<input type="hidden" name="nama_file[]" value="' . $file . '"/>
							</div>';
						}
					}
					?>
					</div>
					<div>
					<button class="btn btn-success btn-xs add-audio"><i class="fa fa-plus pe-1"></i> Add Audio</a>
					</div>
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