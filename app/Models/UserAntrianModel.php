<?php
/**
*	App Name	: Antrian	
*	Developed by: Agus Prawoto Hadi
*	Website		: https://jagowebdev.com
*	Year		: 2022
*/

namespace App\Models;

class UserAntrianModel extends \App\Models\BaseModel
{
	public function __construct() {
		parent::__construct();
	}
	
	/* public function getUserAntrian() {
		$sql = 'SELECT * FROM user_antrian_detail
				LEFT JOIN antrian_detail USING(id_antrian_detail)
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan)
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				LEFT JOIN user USING(id_user)';
				
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	} */
	
	public function getListUser() {
		$sql = 'SELECT * FROM user';
		$result = $this->db->query($sql)->getResultArray();
		return $result;
	}
	
	public function getUserAntrian($id) {
		$sql = 'SELECT * FROM antrian_detail
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan) 
				LEFT JOIN antrian_kategori USING(id_antrian_kategori)
				LEFT JOIN (SELECT * FROM user_antrian_detail WHERE id_user = ?) AS tabel_user USING(id_antrian_detail)';
		$result = $this->db->query($sql, $id)->getResultArray();
		return $result;
	}
	
	public function saveUserAntrian() 
	{
		$this->db->transStart();
		$this->db->table('user_antrian_detail')->delete(['id_user' => $_POST['id_user']]);
		if (!empty($_POST['id_antrian_detail'])) {
			$data_db = [];
			foreach ($_POST['id_antrian_detail'] as $val) {
				$data_db[] = ['id_antrian_detail' => $val, 'id_user' => $_POST['id_user']];
			}
			$this->db->table('user_antrian_detail')->insertBatch($data_db);
		}
		$this->db->transComplete();
		if ($this->db->transStatus()) {
			return true;
		}
		
		return false;
	}
	
	public function getAllTujuan() {
		
	}
	
	public function countAllData() {
		$query = $this->db->query('SELECT COUNT(*) as jml FROM user')->getRow();
		return $query->jml;
	}
	
	public function getListData() 
	{
		
		// Get user
		$columns = $this->request->getPost('columns');
		$order_by = '';
		
		// Search
		$where = ' WHERE 1=1 ';
		$search_all = @$this->request->getPost('search')['value'];
		if ($search_all) {
			
			foreach ($columns as $val) {
				if (strpos($val['data'], 'ignore') !== false)
					continue;
				
				$where_col[] = $val['data'] . ' LIKE "%' . $search_all . '%"';
			}
			 $where .= ' AND (' . join(' OR ', $where_col) . ') ';
		}
		
		// Order
		$start = $this->request->getPost('start') ?: 0;
		$length = $this->request->getPost('length') ?: 10;
		
		$order_data = $this->request->getPost('order');
		$order = '';
		if (!empty($_POST['columns']) && strpos($_POST['columns'][$order_data[0]['column']]['data'], 'ignore') === false) {
			$order_by = $columns[$order_data[0]['column']]['data'] . ' ' . strtoupper($order_data[0]['dir']);
			$order = ' ORDER BY ' . $order_by . ' LIMIT ' . $start . ', ' . $length;
		}
		
		$sql = 'SELECT COUNT(*) AS jml FROM (
					SELECT id_user FROM user LEFT JOIN (
						SELECT user.id_user, antrian_detail.id_antrian_detail, nama_antrian_tujuan, antrian_kategori.id_antrian_kategori, nama_antrian_kategori FROM user_antrian_detail 
						LEFT JOIN antrian_detail USING(id_antrian_detail) 
						LEFT JOIN antrian_tujuan USING(id_antrian_tujuan) 
						LEFT JOIN antrian_kategori USING(id_antrian_kategori) 
						LEFT JOIN user USING(id_user)
					) AS tabel_user USING(id_user)
					' . $where . ' GROUP BY id_user) AS tabel';
						
		$query = $this->db->query($sql)->getRowArray();
		$total_filtered = $query['jml'];
		
		$sql = 'SELECT * FROM user LEFT JOIN (
				SELECT user.id_user, antrian_detail.id_antrian_detail, nama_antrian_tujuan, antrian_kategori.id_antrian_kategori, nama_antrian_kategori FROM user_antrian_detail 
				LEFT JOIN antrian_detail USING(id_antrian_detail) 
				LEFT JOIN antrian_tujuan USING(id_antrian_tujuan) 
				LEFT JOIN antrian_kategori USING(id_antrian_kategori) 
				LEFT JOIN user USING(id_user)
			) AS tabel_user USING(id_user)' . $where . $order;
			// echo $sql; die;
		$data = $this->db->query($sql)->getResultArray();
		
		return ['data' => $data, 'total_filtered' => $total_filtered];
		
	}
}
?>