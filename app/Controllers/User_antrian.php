<?php
/**
*	App Name	: Antrian	
*	Developed by: Agus Prawoto Hadi
*	Website		: https://jagowebdev.com
*	Year		: 2022
*/

namespace App\Controllers;
use App\Models\UserAntrianModel;

class User_antrian extends \App\Controllers\BaseController
{
	public function __construct() {
		
		parent::__construct();
		
		$this->model = new UserAntrianModel;	
		$this->data['site_title'] = 'Assign User ke Antrian';

		$this->addJs ( $this->config->baseURL . 'public/themes/modern/js/user-antrian.js');
	}
	
	public function index()
	{
		$this->hasPermissionPrefix('read');
		$this->data['title'] = 'Assign User Ke Antrian';
		$this->view('user-antrian-result.php', $this->data);
	}
	
	public function ajaxGetAssignAntian() {
		$data = $this->model->getUserAntrian($_GET['id']);		
		$this->data['list_tujuan'] = $data;
		echo view('themes/modern/user-antrian-form.php', $this->data);
	}
	
	public function ajaxUpdateUserAntrian() 
	{
		$result = $this->model->saveUserAntrian();
		if ($result) {
			$message = ['status' => 'ok', 'message' => 'Data berhasil disimpan'];
		} else {
			$message = ['status' => 'error', 'message' => 'Data gagal disimpan'];
		}
		echo json_encode($message);
	}
	
	public function getDataDT() {
		
		$this->hasPermission('read_all');
		
		$num_users = $this->model->countAllData();
		$data = $this->model->getListData();
		
		$result['draw'] = $start = $this->request->getPost('draw') ?: 1;
		$result['recordsTotal'] = $num_users;
		$result['recordsFiltered'] = $data['total_filtered'];		
		
		helper('html');
		$no = 1;
			
		$result_data = [];
		foreach ($data['data'] as $val) 
		{
			// $result_data[$val['id_user']][$val['id_antrian_kategori']]['kategori'] = $val;
			$result_data[$val['id_user']]['tujuan'][$val['id_antrian_kategori']]['kategori'] = $val;
			$result_data[$val['id_user']]['tujuan'][$val['id_antrian_kategori']]['tujuan'][] = $val;
			$result_data[$val['id_user']]['nama'] = $val['nama'];
			$result_data[$val['id_user']]['id_user'] = $val['id_user'];
		}
		
		foreach ($result_data as &$val) 
		{
			$val['ignore_no'] = $no;
			$val['nama_antrian_tujuan'] = 'Antrian belum diassign';
			$val['ignore_action'] = btn_label(['attr' => ['class' => 'btn btn-success btn-xs btn-assign-antrian', 'data-id-user' => $val['id_user']], 'label' => 'Assign Antrian', 'icon' => 'fas fa-edit']);
			if ($val['tujuan']) {
				
				$list_item = '';
				foreach($val['tujuan'] as $id_antrian_kategori => $item) {
					if (!$id_antrian_kategori)
						continue;
					$list_item .= '<li><strong>' . $item['kategori']['nama_antrian_kategori'] . '</strong><ul>';
						foreach($item['tujuan'] as $tujuan) {
							$list_item .= '<li class="m-0">' . $tujuan['nama_antrian_tujuan'] . '</li>';
						}
					$list_item .= '</ul></li>';							
				}
				if ($list_item) {
					$val['nama_antrian_tujuan'] = '<ul class="list-circle">' . $list_item . '</ul>';
				}
				
			}
			$no++;
		}
	
		$result['data'] = array_values($result_data);
		echo json_encode($result); exit();
	}
}
