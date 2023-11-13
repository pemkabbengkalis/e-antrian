<?php
/**
*	App Name	: Antrian	
*	Developed by: Agus Prawoto Hadi
*	Website		: https://jagowebdev.com
*	Year		: 2022
*/

namespace App\Models;

class AntrianModel extends \App\Models\BaseModel
{
	public function __construct() {
		parent::__construct();
	}
	
	/* public function getAllSettingLayar() {
		$sql = 'SELECT setting_layar.*, GROUP_CONCAT(nama_antrian_kategori) AS nama_kategori FROM setting_layar
				LEFT JOIN setting_layar_detail USING(id_setting_layar)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				GROUP BY id_setting_layar';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	} */
	
	/* public function getAntrianKategori() {
		$sql = 'SELECT setting_layar.*, GROUP_CONCAT(nama_antrian_kategori) AS nama_kategori FROM setting_layar
				LEFT JOIN setting_layar_detail USING(id_setting_layar)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				GROUP BY id_setting_layar';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	} */
	
	public function getUser() {
		$sql = 'SELECT * FROM user';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getUserAntrianByIdAntrianDetail($id) {
		$sql = 'SELECT * FROM user_antrian_detail WHERE id_antrian_detail = ?';
		$result = $this->db->query($sql, $id)->getResultArray();
		return $result;
	}
	
	public function getAllTujuan() {
		$sql = 'SELECT *, antrian_kategori.aktif AS kategori_aktif, antrian_detail.aktif AS tujuan_aktif, GROUP_CONCAT(user.nama SEPARATOR ", ") AS nama_user FROM 
				antrian_kategori 
				LEFT JOIN antrian_detail USING(id_antrian_kategori)
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
				LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
				LEFT JOIN setting_layar USING(id_setting_layar)
				LEFT JOIN user_antrian_detail USING(id_antrian_detail)
				LEFT JOIN user USING(id_user)
				GROUP BY id_antrian_detail';
				
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function deleteDataKategori() {
		$this->db->transStart();
		$this->db->table('antrian_kategori')->delete(['id_antrian_kategori' => $_POST['id']]);
		$this->db->table('antrian_detail')->delete(['id_antrian_kategori' => $_POST['id']]);
		$this->db->table('antrian_panggil')->delete(['id_antrian_kategori' => $_POST['id']]);
		$this->db->transComplete();
		
		if ($this->db->transStatus() === false) {
			return false;
		}
		return true;
	}
	
	public function deleteDataDetailAntrian() {
		$this->db->transStart();
		$this->db->table('antrian_detail')->delete(['id_antrian_detail' => $_POST['id']]);
		$this->db->table('user_antrian_detail')->delete(['id_antrian_detail' => $_POST['id']]);
		$this->db->transComplete();
		
		if ($this->db->transStatus() === false) {
			return false;
		}
		return true;
	}

	public function getAntrianKategori() {

		$sql = 'SELECT antrian_kategori.*, jml_tujuan, nama_setting, GROUP_CONCAT(nama_setting SEPARATOR ", ") AS nama_setting
				FROM antrian_kategori
				LEFT JOIN setting_layar_detail USING(id_antrian_kategori)
				LEFT JOIN setting_layar USING(id_setting_layar)
				LEFT JOIN (SELECT id_antrian_kategori, COUNT(id_antrian_detail) AS jml_tujuan 
							FROM antrian_detail GROUP BY id_antrian_kategori) AS tabel USING(id_antrian_kategori)
				GROUP BY id_antrian_kategori';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	/* public function getAllTujuan() {
		$sql = 'SELECT * FROM setting_layar
				LEFT JOIN setting_layar_detail USING(id_setting_layar)
				LEFT JOIN antrian_detail USING(id_antrian_kategori)
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	} */
	
	public function getAntrianKategoriById($id) {
		$sql = 'SELECT * FROM antrian_kategori WHERE id_antrian_kategori = ?';
		$result = $this->db->query($sql, trim($id))->getRowArray();
		return $result;
	}

	public function getAntrianDetailByIdKategori($id) {
		$sql = 'SELECT antrian_detail.*, awalan, nama_antrian_tujuan, GROUP_CONCAT(user.nama SEPARATOR ", ") AS nama_user FROM antrian_detail 
				LEFT JOIN antrian_kategori USING(id_antrian_kategori) 
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
				LEFT JOIN user_antrian_detail USING(id_antrian_detail)
				LEFT JOIN user USING(id_user)
				WHERE id_antrian_kategori = ?
				GROUP BY id_antrian_detail';
		$result = $this->db->query($sql, trim($id))->getResultArray();
		return $result;
	}
	
	public function getAntrianDetailById($id) {
		$sql = 'SELECT * FROM antrian_detail
				WHERE id_antrian_detail = ?';
		$result = $this->db->query($sql, trim($id))->getRowArray();
		return $result;
	}
	
	public function getAntrianTujuan() {
		$sql = 'SELECT * FROM antrian_tujuan';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getAntrianTujuanById($id) {
		$sql = 'SELECT * FROM antrian_tujuan WHERE id_antrian_tujuan = ?';
		$result = $this->db->query($sql, (int) $id)->getRowArray();
		return $result;
	}
	
	public function statusAntrianDetail() {
		$data_db['aktif'] = $_POST['aktif'];
		$data_db['tgl_update'] = date('Y-m-d H:i:s');
		$update = $this->db->table('antrian_detail')->update($data_db, ['id_antrian_detail' => $_POST['id_antrian_detail']]);
		return $update;
	}
	
	public function updateStatusKategori() {
		$data_db['aktif'] = $_POST['aktif'];
		$data_db['tgl_update'] = date('Y-m-d H:i:s');
		$update = $this->db->table('antrian_kategori')->update($data_db, ['id_antrian_kategori' => $_POST['id_antrian_kategori']]);
		return $update;
	}
	
	public function saveAntrianDetail() 
	{
		$data_db['aktif'] = $_POST['aktif'];
		$data_db['id_antrian_tujuan'] = $_POST['id_antrian_tujuan'];
		// $this->db->transStart();
		
		if ($_POST['id']) 
		{
			// print_r($data_db); die;
			$this->db->table('antrian_detail')->update($data_db, ['id_antrian_detail' => $_POST['id']]);
			$this->db->table('user_antrian_detail')->delete(['id_antrian_detail' => $_POST['id']]);
			$id_antrian_detail = $_POST['id'];
			
		} else {
			
			$data_db['id_antrian_kategori'] = $_POST['id_antrian_kategori'];
			$query = $this->db->table('antrian_detail')->insert($data_db);
			$result['id_antrian_detail'] = '';
			if ($query) {
				$id_antrian_detail = $result['id_antrian_detail'] = $this->db->insertID();
			}
		}
		
		$data_db_user = [];
		
		foreach ($_POST['id_user'] as $val) {
			$data_db_user[] = ['id_user' => $val, 'id_antrian_detail' => $id_antrian_detail];
		}
		// echo '<pre>'; print_r($data_db_user); die;
		if ($data_db_user) {
			$this->db->table('user_antrian_detail')->insertBatch($data_db_user);
		}
		
		$this->db->transComplete();
				
		if ($this->db->transStatus()) {
			$result['status'] = 'ok';
			$result['content'] = 'Data berhasil disimpan';
		} else {
			$result['status'] = 'error';
			$result['content'] = 'Data gagal disimpan';
		}
		
		return $result;
		
	}
	
	public function saveData() {

		$data_db['nama_antrian_kategori'] = $_POST['nama_antrian_kategori'];
		$data_db['awalan'] = $_POST['awalan'];
		
		if ($_POST['id']) 
		{
			$data_db['tgl_update'] = date('Y-m-d H:i:s');
			$data_db['id_user_update'] = $_SESSION['user']['id_user'];
			if(!empty($_FILES['logo'])){	
			$file = $this->request->getFile('logo');
			$path = ROOTPATH . 'public/images/logo/';
			$sql = 'SELECT * FROM antrian_kategori WHERE id_antrian_kategori = ?';
			$img_db = $this->db->query($sql, $_POST['id'])->getRowArray();
			$new_name = $img_db['logo'];	
			if ($file && $file->getName()) 
			{
				//old file
				if ($img_db['logo']) {
					if (file_exists($path . $img_db['logo'])) {
						$unlink = delete_file($path . $img_db['logo']);
						if (!$unlink) {
							$result = ['status' => 'error', 'message' => 'Gagal menghapus gambar lama'];
						}
					}
				}
							
				helper('upload_file');
				$new_name =  get_filename($file->getName(), $path);
				$file->move($path, $new_name);
				if (!$file->hasMoved()) {
					$result = ['status' => 'error', 'message' => 'Error saat memperoses gambar'];
					return $result;
				}
			}
			
			// Update avatar
			$data_db['logo'] = $new_name;
		}
			$query = $this->db->table('antrian_kategori')->update($data_db, ['id_antrian_kategori' => $_POST['id']]);

		}
		else {

			$data_db['tgl_input'] = date('Y-m-d H:i:s');
			$data_db['id_user_input'] = $_SESSION['user']['id_user'];
			$query = $this->db->table('antrian_kategori')->insert($data_db);
			$result['id_antrian_kategori'] = '';
			if ($query) {
				$result['id_antrian_kategori'] = $this->db->insertID();
			}
		}
		
		if ($query) {
			$result['message']['status'] = 'ok';
			$result['message']['content'] = 'Data berhasil disimpan';
		} else {
			$result['message']['status'] = 'error';
			$result['message']['content'] = 'Data gagal disimpan';
		}
		
		return $result;
	}
	
	public function checkDuplicateAntrianDetail($param, $id_antrian_kategori) 
	{
		$antrian_kategori = $this->getAntrianKategoriById($id_antrian_kategori);
		
		if (key_exists('id_antrian_tujuan', $param)){
			$check_tujuan = false;
			if (empty($param['id_antrian_tujuan_old'])) {
				$check_tujuan = true;
			} else {
				
				if ($param['id_antrian_tujuan'] != $param['id_antrian_tujuan_old']) {
					$check_tujuan = true;
				}
					
			}
			
			if ($check_tujuan) {
				$sql = 'SELECT COUNT(*) as jml 
						FROM antrian_detail 
						WHERE id_antrian_tujuan = "' . $param['id_antrian_tujuan'] . '" 
							AND id_antrian_kategori = ' . $id_antrian_kategori;
							
				$result = $this->db->query($sql)->getRowArray();
				if ($result['jml']) {
					$antrian_tujuan = $this->getAntrianTujuanById($param['id_antrian_tujuan']);
					return 'Tujuan ' . $antrian_tujuan['nama_antrian_tujuan'] . ' pada kategori antrian ' . $antrian_kategori['nama_antrian_kategori'] . ' sudah digunakan';
				}
			}
			
		}
		
		if (key_exists('awalan', $param)) {
			
			
			$check_tujuan = false;
			if (empty($param['awalan_old'])) {
				$check_tujuan = true;
			} else {
				
				if ($param['awalan'] != $param['awalan_old']) {
					$check_tujuan = true;
				}
					
			}
			
			if ($check_tujuan) {
				$sql = 'SELECT COUNT(*) as jml 
						FROM antrian_detail 
						WHERE awalan = "' . $param['awalan'] . '" 
							AND id_antrian_kategori = ' . $id_antrian_kategori;
							
				$result = $this->db->query($sql)->getRowArray();
				if ($result['jml'])
					return 'Awalan ' . $param['awalan'] . ' pada kategori antrian ' . $antrian_kategori['nama_antrian_kategori'] . ' sudah digunakan';
			}
		}

		return false;
	}
}
?>