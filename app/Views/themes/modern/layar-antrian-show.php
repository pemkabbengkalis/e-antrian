<!DOCTYPE HTML>
<html lang="en">
<head>
<title><?=$site_title?></title>
<meta name="descrition" content="<?=$site_title?>"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="<?=$config->baseURL . 'public/images/favicon.png?r='.time()?>" />
<link rel="stylesheet" type="text/css" href="<?=$config->baseURL . 'public/vendors/bootstrap/css/bootstrap.min.css?r='.time()?>"/>
<link rel="stylesheet" type="text/css" href="<?=$config->baseURL . 'public/vendors/fontawesome/css/all.css?r='.time()?>"/>
<link rel="stylesheet" type="text/css" href="<?=$config->baseURL . 'public/vendors/sweetalert2/sweetalert2.min.css?r=' . time()?>"/>
<link rel="stylesheet" type="text/css" href="<?=$config->baseURL . 'public/themes/modern/builtin/css/fonts/'.$setting['font_family'].'.css?r='.time()?>"/>
<link rel="stylesheet" type="text/css" href="<?=$config->baseURL . 'public/themes/modern/css/layar-show.css?r='.time()?>"/>
<link rel="stylesheet" type="text/css" href="<?=$config->baseURL . 'public/themes/modern/css/layar-monitor-show-'.$setting['color_scheme'].'.css?r='.time()?>"/>
<link rel="stylesheet" type="text/css" href="<?=$config->baseURL . 'public/themes/modern/css/layar-antrian-show.css?r='.time()?>"/>

<?php
if (@$styles) {
	foreach($styles as $file) {
		echo '<link rel="stylesheet" type="text/css" href="'.$file.'?r='.time().'"/>' . "\n";
	}
}
?>
<link rel="stylesheet" type="text/css" href="<?=$config->baseURL . 'public/themes/modern/css/layar-monitor-show-'.$setting['color_scheme'].'.css?r='.time()?>"/>
<style>

.bgmotif {
	height: 100%;
	background-image: url('<?=$config->baseURL . 'public/images/bgmotif.png' ?>');
}
/* Bootbox */
.bootbox-close-button {
	border: 0;
    background: none;
    font-size: 25px;
    color: #8c8d91;
}

.alert-dismissible .close {
    position: absolute;
    top: 0;
    right: 0;
    padding: .75rem 1.25rem;
    color: inherit;
}
button.close {
	background-color: transparent;
    border: 0;
    -webkit-appearance: none;
}

.close {
    float: right;
    font-size: 1.5rem;
    color: #000;
    text-shadow: 0 1px 0 #fff;
    opacity: .5;
}

.bootbox-body {
	color: #212529;
}
/*-- Bootbox */
</style>

<script type="text/javascript" src="<?=$config->baseURL . 'public/vendors/jquery/jquery.min.js?r='.time()?>"></script>
<script type="text/javascript" src="<?=$config->baseURL . 'public/vendors/bootstrap/js/bootstrap.min.js?r='.time()?>"></script>
<script type="text/javascript" src="<?=$config->baseURL . '/public/vendors/bootbox/bootbox.min.js'?>"></script>
<script type="text/javascript" src="<?=$config->baseURL . 'public/vendors/sweetalert2/sweetalert2.min.js?r=' . time()?>"></script>
<script type="text/javascript" src="<?=$config->baseURL . 'public/themes/modern/js/antrian.js?r='.time()?>"></script>
<script type="text/javascript">
	var base_url = "<?=base_url()?>/"
	bootbox.setDefaults({
		animate: false,
		centerVertical : true
	});
</script>
<?php
if (@$scripts) {
	foreach($scripts as $file) {
		if (is_array($file)) {
			if ($file['print']) {
				echo '<script type="text/javascript">' . $file['script'] . '</script>' . "\n";
			}
		} else {
			echo '<script type="text/javascript" src="'.$file.'?r='.time().'"></script>' . "\n";
		}
	}
}
// echo '<pre>'; print_r($urut); die;
?>
<script>
window.onload = function() {
    var el = document.documentElement,
        rfs = el.requestFullScreen
        || el.webkitRequestFullScreen
        || el.mozRequestFullScreen;
    rfs.call(el);
};
</script>
</head>
<body class="bgmotif">
	<div class="block-container">
		<header class="shadow-sm">
			<div class="header-left-container">
				<div class="logo">
					<img src="<?=base_url()?>/public/images/<?=$identitas['file_logo']?>">
				</div>
				<div class="detail">
					<div class="logo-text">
						<?=$identitas['nama']?>
					</div>
					<div class="alamat">
						<p><?=$identitas['alamat']?></p>
						<p>Telp: <?=$identitas['no_hp']?></p>
					</div>
				</div>
			</div>
			<div class="header-right-container">
				<div class="tanggal">
					<?=format_tanggal(date('Y-m-d'))?>
				</div>
				<div class="waktu">
					<span id="live_jam"><?=date('H:i:s')?></span>
				</div>
			</div>
		</header>
		<div class="content-container">
			<div class="ambil-antrian-container">
				<h1 class="title">Ambil Antrian</h1>
				<div class="button-container">
					
					<?php
					// echo '<pre>'; print_r($antrian_detail); die;
					// $list_background = ['#9e26fb', '#00cf85', '#ee4e57', '#308ded', '#ff9541'];
					$index = 0;
					foreach ($antrian_kategori as $val) {
						?>
						<div class="card card-list-kategori ambil-antrian" data-id-antrian-kategori="<?php echo $val['id_antrian_kategori'] ?> ">
							<div class="wrap-antrian">
						    <?php if(!empty($val['logo']))
								echo '<center><img class="img-antrian-logo" src="'.$config->baseURL . 'public/images/logo/' .$val['logo'].'" alt=""></center>';
							?>
							<div class="name-kategori"><?php echo $val['nama_antrian_kategori']; ?></div>
					        </div>
					    </div>
						<?php
						//echo '<button style="background:' . $list_background[$index] . '" class="btn ambil-antrian" data-id-antrian-kategori="' . $val['id_antrian_kategori'] . '"><span>' . $val['nama_antrian_kategori'] . '</span></button>';
						$index++;
						
						
					}
					?>
				</div>
			</div>
		</div>
		<footer>
			<div><?=$setting['text_footer']?></div>
		</footer>
	</div>
</body>
</html>