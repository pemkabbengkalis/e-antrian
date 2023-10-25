-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table aplikasi_antrian.antrian_detail
CREATE TABLE IF NOT EXISTS `antrian_detail` (
  `id_antrian_detail` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_antrian_kategori` int(10) unsigned DEFAULT NULL,
  `id_antrian_tujuan` int(10) unsigned DEFAULT NULL,
  `aktif` enum('Y','N') NOT NULL DEFAULT 'Y',
  `tgl_update` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_antrian_detail`),
  UNIQUE KEY `id_antrian_kategori_id_antrian_tujuan` (`id_antrian_kategori`,`id_antrian_tujuan`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.antrian_detail: ~12 rows (approximately)
INSERT INTO `antrian_detail` (`id_antrian_detail`, `id_antrian_kategori`, `id_antrian_tujuan`, `aktif`, `tgl_update`) VALUES
	(1, 1, 1, 'Y', '2022-07-09 19:56:32'),
	(2, 2, 12, 'Y', '2023-07-13 20:30:44'),
	(3, 2, 13, 'Y', '2022-07-24 15:08:21'),
	(4, 2, 14, 'Y', '2022-07-17 05:37:01'),
	(5, 2, 15, 'Y', '2022-07-24 15:09:33'),
	(6, 3, 17, 'Y', '2022-07-17 05:41:06'),
	(7, 3, 18, 'Y', '2022-07-17 05:41:00'),
	(8, 5, 3, 'Y', '2022-07-09 19:56:32'),
	(9, 4, 2, 'Y', '2022-07-09 19:56:32'),
	(10, 6, 4, 'Y', '2022-07-09 19:56:32'),
	(11, 7, 5, 'Y', '2022-07-09 19:56:32'),
	(20, 9, 7, 'Y', '2022-10-25 20:43:48');

-- Dumping structure for table aplikasi_antrian.antrian_kategori
CREATE TABLE IF NOT EXISTS `antrian_kategori` (
  `id_antrian_kategori` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_antrian_kategori` varchar(255) NOT NULL,
  `awalan` char(1) NOT NULL,
  `aktif` enum('Y','N') NOT NULL,
  `tgl_input` datetime DEFAULT NULL,
  `id_user_input` int(10) unsigned DEFAULT NULL,
  `tgl_update` datetime DEFAULT NULL,
  `id_user_update` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_antrian_kategori`) USING BTREE,
  UNIQUE KEY `nama_antrian_kategori` (`nama_antrian_kategori`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.antrian_kategori: ~8 rows (approximately)
INSERT INTO `antrian_kategori` (`id_antrian_kategori`, `nama_antrian_kategori`, `awalan`, `aktif`, `tgl_input`, `id_user_input`, `tgl_update`, `id_user_update`) VALUES
	(1, 'Poliklinik Gigi dan Mulut', 'A', 'Y', '2022-01-12 08:28:06', 1, '2023-07-14 17:26:41', 1),
	(2, 'Customer Service', 'A', 'Y', '2022-01-12 08:30:38', 1, '2023-07-13 20:27:42', 1),
	(3, 'Loket', 'B', 'Y', '2022-07-03 18:34:48', 1, '2022-07-24 14:46:28', 1),
	(4, 'Poliklinik Ibu dan Anak', 'B', 'Y', '2022-07-03 18:39:16', 1, '2022-07-17 06:42:31', 1),
	(5, 'Poliklinik Umum', 'C', 'Y', '2022-07-03 18:39:45', 1, '2022-07-17 06:42:35', 1),
	(6, 'Poliklinik Kebidanan', 'D', 'Y', '2022-07-03 18:39:55', 1, '2022-07-03 19:43:05', 1),
	(7, 'Poliklinik Mata', 'E', 'Y', '2022-07-03 19:43:20', 1, NULL, NULL),
	(9, 'Counter', 'A', 'Y', '2022-10-25 20:43:35', 1, NULL, NULL);

-- Dumping structure for table aplikasi_antrian.antrian_panggil
CREATE TABLE IF NOT EXISTS `antrian_panggil` (
  `id_antrian_panggil` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_antrian_kategori` int(10) unsigned NOT NULL,
  `jml_antrian` smallint(5) unsigned NOT NULL,
  `jml_dipanggil` smallint(5) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `time_ambil` time NOT NULL,
  `time_dipanggil` time NOT NULL,
  PRIMARY KEY (`id_antrian_panggil`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.antrian_panggil: ~19 rows (approximately)
INSERT INTO `antrian_panggil` (`id_antrian_panggil`, `id_antrian_kategori`, `jml_antrian`, `jml_dipanggil`, `tanggal`, `time_ambil`, `time_dipanggil`) VALUES
	(1, 2, 20, 20, '2022-07-16', '21:12:21', '21:37:26'),
	(2, 3, 14, 0, '2022-07-16', '21:08:29', '00:00:00'),
	(3, 2, 17, 7, '2022-07-17', '13:25:33', '13:03:58'),
	(4, 3, 13, 5, '2022-07-17', '13:22:55', '05:49:10'),
	(5, 5, 2, 2, '2022-07-17', '07:05:37', '07:20:15'),
	(6, 4, 9, 0, '2022-07-17', '14:00:50', '00:00:00'),
	(7, 6, 3, 0, '2022-07-17', '07:05:40', '00:00:00'),
	(8, 1, 10, 3, '2022-07-17', '14:07:02', '07:22:21'),
	(9, 7, 1, 0, '2022-07-17', '07:05:35', '00:00:00'),
	(10, 2, 15, 7, '2022-07-24', '11:51:09', '14:49:36'),
	(11, 3, 7, 5, '2022-07-24', '14:47:07', '14:47:25'),
	(12, 5, 1, 0, '2022-12-31', '05:56:08', '00:00:00'),
	(13, 3, 3, 0, '2022-12-31', '06:26:18', '00:00:00'),
	(14, 2, 7, 0, '2022-12-31', '07:06:58', '00:00:00'),
	(15, 3, 4, 0, '2023-07-14', '07:34:21', '00:00:00'),
	(16, 2, 13, 13, '2023-07-14', '18:31:48', '18:47:30'),
	(17, 4, 1, 0, '2023-07-14', '17:32:21', '00:00:00'),
	(18, 2, 0, 0, '2023-07-15', '04:55:57', '00:00:00'),
	(19, 3, 8, 5, '2023-07-15', '08:50:51', '08:56:44');

-- Dumping structure for table aplikasi_antrian.antrian_panggil_awalan
CREATE TABLE IF NOT EXISTS `antrian_panggil_awalan` (
  `nama_file` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='Pengaturan suara sebawai awalan pemanggilan antrian, seperti bunyi bell';

-- Dumping data for table aplikasi_antrian.antrian_panggil_awalan: ~0 rows (approximately)
INSERT INTO `antrian_panggil_awalan` (`nama_file`) VALUES
	('["bell_long.wav","nomor_antrian.wav"]');

-- Dumping structure for table aplikasi_antrian.antrian_panggil_detail
CREATE TABLE IF NOT EXISTS `antrian_panggil_detail` (
  `id_antrian_panggil_detail` int(11) NOT NULL AUTO_INCREMENT,
  `id_antrian_panggil` int(11) unsigned NOT NULL,
  `id_antrian_detail` int(11) unsigned NOT NULL,
  `awalan_panggil` char(1) NOT NULL,
  `nomor_panggil` smallint(5) unsigned NOT NULL,
  `waktu_panggil` time DEFAULT current_timestamp(),
  PRIMARY KEY (`id_antrian_panggil_detail`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.antrian_panggil_detail: ~67 rows (approximately)
INSERT INTO `antrian_panggil_detail` (`id_antrian_panggil_detail`, `id_antrian_panggil`, `id_antrian_detail`, `awalan_panggil`, `nomor_panggil`, `waktu_panggil`) VALUES
	(1, 1, 3, 'A', 1, '20:11:18'),
	(2, 1, 3, 'A', 2, '20:11:35'),
	(3, 1, 4, 'A', 3, '20:11:51'),
	(4, 1, 2, 'A', 4, '20:11:55'),
	(5, 1, 2, 'A', 5, '20:11:57'),
	(6, 1, 2, 'A', 6, '20:11:57'),
	(7, 1, 4, 'A', 7, '20:11:58'),
	(8, 1, 4, 'A', 8, '20:11:59'),
	(9, 1, 4, 'A', 9, '20:12:00'),
	(10, 1, 3, 'A', 10, '20:17:31'),
	(11, 1, 3, 'A', 11, '20:28:39'),
	(12, 1, 5, 'A', 12, '20:33:07'),
	(13, 1, 2, 'A', 13, '20:35:03'),
	(14, 1, 5, 'A', 14, '20:35:10'),
	(15, 1, 3, 'A', 15, '20:54:17'),
	(16, 1, 2, 'A', 16, '21:12:32'),
	(17, 1, 4, 'A', 17, '21:31:00'),
	(18, 1, 5, 'A', 18, '21:35:59'),
	(19, 1, 2, 'A', 19, '21:36:24'),
	(20, 1, 4, 'A', 20, '21:37:26'),
	(21, 3, 2, 'A', 1, '05:10:21'),
	(22, 3, 3, 'A', 2, '05:10:38'),
	(23, 3, 2, 'A', 3, '05:11:41'),
	(24, 4, 6, 'B', 1, '05:37:35'),
	(25, 4, 6, 'B', 2, '05:42:02'),
	(26, 4, 6, 'B', 3, '05:45:33'),
	(27, 4, 6, 'B', 4, '05:49:00'),
	(28, 4, 7, 'B', 5, '05:49:10'),
	(29, 8, 1, 'A', 1, '07:07:37'),
	(30, 3, 3, 'A', 4, '07:07:57'),
	(31, 5, 8, 'C', 1, '07:19:58'),
	(32, 5, 8, 'C', 2, '07:20:15'),
	(33, 8, 1, 'A', 2, '07:21:54'),
	(34, 8, 1, 'A', 3, '07:22:21'),
	(35, 3, 2, 'A', 5, '07:23:55'),
	(36, 3, 4, 'A', 6, '07:24:01'),
	(37, 3, 3, 'A', 7, '13:03:59'),
	(65, 11, 6, 'B', 1, '14:47:17'),
	(66, 11, 7, 'B', 2, '14:47:18'),
	(67, 11, 6, 'B', 3, '14:47:22'),
	(68, 11, 6, 'B', 4, '14:47:23'),
	(69, 11, 7, 'B', 5, '14:47:25'),
	(70, 10, 2, 'A', 1, '14:49:24'),
	(71, 10, 3, 'A', 2, '14:49:25'),
	(72, 10, 5, 'A', 3, '14:49:28'),
	(73, 10, 2, 'A', 4, '14:49:31'),
	(74, 10, 3, 'A', 5, '14:49:32'),
	(75, 10, 2, 'A', 6, '14:49:34'),
	(76, 10, 5, 'A', 7, '14:49:36'),
	(77, 16, 2, 'A', 1, '18:09:19'),
	(78, 16, 2, 'A', 2, '18:10:21'),
	(79, 16, 3, 'A', 3, '18:10:52'),
	(80, 16, 3, 'A', 4, '18:30:08'),
	(81, 16, 4, 'A', 5, '18:31:56'),
	(82, 16, 3, 'A', 6, '18:32:30'),
	(83, 16, 2, 'A', 7, '18:34:12'),
	(84, 16, 4, 'A', 8, '18:39:13'),
	(85, 16, 5, 'A', 9, '18:40:17'),
	(86, 16, 4, 'A', 10, '18:42:10'),
	(87, 16, 4, 'A', 11, '18:43:50'),
	(88, 16, 4, 'A', 12, '18:46:31'),
	(89, 16, 3, 'A', 13, '18:47:30'),
	(123, 19, 6, 'B', 1, '08:56:36'),
	(124, 19, 7, 'B', 2, '08:56:37'),
	(125, 19, 7, 'B', 3, '08:56:40'),
	(126, 19, 6, 'B', 4, '08:56:42'),
	(127, 19, 7, 'B', 5, '08:56:44');

-- Dumping structure for table aplikasi_antrian.antrian_panggil_ulang
CREATE TABLE IF NOT EXISTS `antrian_panggil_ulang` (
  `id_setting_layar` int(11) unsigned DEFAULT NULL,
  `id_antrian_panggil_detail` int(11) unsigned DEFAULT NULL,
  `tanggal_panggil_ulang` date DEFAULT curdate(),
  `waktu_panggil_ulang` time DEFAULT curtime()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.antrian_panggil_ulang: ~41 rows (approximately)
INSERT INTO `antrian_panggil_ulang` (`id_setting_layar`, `id_antrian_panggil_detail`, `tanggal_panggil_ulang`, `waktu_panggil_ulang`) VALUES
	(1, 30, '2022-07-17', '13:00:11'),
	(1, 30, '2022-07-17', '13:02:15'),
	(1, 35, '2022-07-17', '13:05:20'),
	(1, 35, '2022-07-17', '13:05:50'),
	(1, 36, '2022-07-17', '13:06:09'),
	(1, 49, '2022-07-24', '11:28:03'),
	(1, 60, '2022-07-24', '11:50:08'),
	(1, 61, '2022-07-24', '11:51:02'),
	(1, 64, '2022-07-24', '11:51:47'),
	(1, 83, '2023-07-14', '18:35:45'),
	(1, 83, '2023-07-14', '18:47:52'),
	(1, 83, '2023-07-14', '18:49:02'),
	(1, 83, '2023-07-14', '18:56:39'),
	(1, 83, '2023-07-14', '18:56:55'),
	(1, 83, '2023-07-14', '18:58:22'),
	(1, 83, '2023-07-14', '18:58:31'),
	(1, 83, '2023-07-14', '19:00:47'),
	(1, 83, '2023-07-14', '19:02:35'),
	(1, 83, '2023-07-14', '19:06:39'),
	(1, 83, '2023-07-14', '19:07:44'),
	(1, 83, '2023-07-14', '19:08:55'),
	(1, 83, '2023-07-14', '19:09:53'),
	(1, 83, '2023-07-14', '19:10:50'),
	(1, 83, '2023-07-14', '19:13:58'),
	(1, 83, '2023-07-14', '19:14:17'),
	(1, 83, '2023-07-14', '19:17:33'),
	(1, 100, '2023-07-15', '05:48:52'),
	(1, 103, '2023-07-15', '07:04:54'),
	(1, 103, '2023-07-15', '07:05:22'),
	(1, 103, '2023-07-15', '07:06:15'),
	(1, 103, '2023-07-15', '07:06:51'),
	(1, 104, '2023-07-15', '08:20:56'),
	(1, 104, '2023-07-15', '08:21:48'),
	(1, 104, '2023-07-15', '08:22:02'),
	(1, 101, '2023-07-15', '08:23:41'),
	(1, 104, '2023-07-15', '08:23:51'),
	(1, 102, '2023-07-15', '08:23:55'),
	(1, 124, '2023-07-15', '08:56:56'),
	(1, 124, '2023-07-15', '08:57:40'),
	(1, 123, '2023-07-15', '08:57:53'),
	(1, 125, '2023-07-15', '08:57:56');

-- Dumping structure for table aplikasi_antrian.antrian_tujuan
CREATE TABLE IF NOT EXISTS `antrian_tujuan` (
  `id_antrian_tujuan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_antrian_tujuan` varchar(255) NOT NULL,
  `nama_file` varchar(255) NOT NULL,
  PRIMARY KEY (`id_antrian_tujuan`) USING BTREE,
  UNIQUE KEY `nama_poliklinik` (`nama_antrian_tujuan`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table aplikasi_antrian.antrian_tujuan: ~21 rows (approximately)
INSERT INTO `antrian_tujuan` (`id_antrian_tujuan`, `nama_antrian_tujuan`, `nama_file`) VALUES
	(1, 'Poliklinik Gigi dan Mulut', '["poliklinik.wav","gigi_dan_mulut.wav"]'),
	(2, 'Poliklinik Ibu dan Anak', '["poliklinik.wav","ibu_dan_anak.wav"]'),
	(3, 'Poliklinik Umum', '["poliklinik.wav","umum.wav"]'),
	(4, 'Poliklinik Kebidanan', '["poliklinik.wav","kebidanan.wav"]'),
	(5, 'Poliklinik Mata', '["poliklinik.wav","mata.wav"]'),
	(6, 'Apotik', '["apotik.wav"]'),
	(7, 'Counter 1', '["counter.wav","satu.wav"]'),
	(8, 'Counter 2', '["counter.wav","dua.wav"]'),
	(9, 'Counter 3', '["counter.wav","tiga.wav"]'),
	(10, 'Counter 4', '["counter.wav","empat.wav"]'),
	(11, 'Counter 5', '["counter.wav","lima.wav"]'),
	(12, 'Customer Service 1', '["customer_service.wav","satu.wav"]'),
	(13, 'Customer Service 2', '["customer_service.wav","dua.wav"]'),
	(14, 'Customer Service 3', '["customer_service.wav","tiga.wav"]'),
	(15, 'Customer Service 4', '["customer_service.wav","empat.wav"]'),
	(16, 'Customer Service 5', '["customer_service.wav","lima.wav"]'),
	(17, 'Loket 1', '["loket.wav","satu.wav"]'),
	(18, 'Loket 2', '["loket.wav","dua.wav"]'),
	(19, 'Loket 3', '["loket.wav","tiga.wav"]'),
	(20, 'Loket 4', '["loket.wav","empat.wav"]'),
	(21, 'Loket 5', '["loket.wav","lima.wav"]');

-- Dumping structure for table aplikasi_antrian.identitas
CREATE TABLE IF NOT EXISTS `identitas` (
  `nama` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_hp` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `file_logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.identitas: ~0 rows (approximately)
INSERT INTO `identitas` (`nama`, `alamat`, `no_hp`, `email`, `website`, `file_logo`) VALUES
	('Jagowebdev Virtual Office', 'Perumahan Muria Indah Kudus', '08561363962', 'info@jagowebdev.com', 'https://jagowebdev.com', 'logo_layar_monitor.png');

-- Dumping structure for table aplikasi_antrian.menu
CREATE TABLE IF NOT EXISTS `menu` (
  `id_menu` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nama_menu` varchar(50) NOT NULL,
  `id_menu_kategori` int(10) unsigned DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  `id_module` smallint(5) unsigned DEFAULT NULL,
  `id_parent` smallint(5) unsigned DEFAULT NULL,
  `aktif` tinyint(1) NOT NULL DEFAULT 1,
  `new` tinyint(1) NOT NULL DEFAULT 0,
  `urut` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_menu`) USING BTREE,
  KEY `menu_module` (`id_module`) USING BTREE,
  KEY `menu_menu` (`id_parent`),
  CONSTRAINT `menu_menu` FOREIGN KEY (`id_parent`) REFERENCES `menu` (`id_menu`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `menu_module` FOREIGN KEY (`id_module`) REFERENCES `module` (`id_module`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=COMPACT COMMENT='Tabel menu aplikasi';

-- Dumping data for table aplikasi_antrian.menu: ~31 rows (approximately)
INSERT INTO `menu` (`id_menu`, `nama_menu`, `id_menu_kategori`, `class`, `url`, `id_module`, `id_parent`, `aktif`, `new`, `urut`) VALUES
	(1, 'User', 2, 'fas fa-users', 'builtin/user', 5, NULL, 1, 0, 6),
	(2, 'Assign Role', 1, 'fas fa-link', '#', NULL, 46, 1, 0, 6),
	(3, 'User Role', 1, 'fas fa-user-tag', 'builtin/user-role', 7, 2, 1, 0, 2),
	(4, 'Module', 1, 'fas fa-network-wired', 'builtin/module', 2, 46, 1, 0, 1),
	(6, 'Menu', 1, 'fas fa-clone', 'builtin/menu', 1, 46, 1, 0, 5),
	(7, 'Menu Role', 1, 'fas fa-folder-minus', 'builtin/menu-role', 8, 2, 1, 0, 3),
	(8, 'Setting', 1, 'fas fa-cogs', '#', NULL, 46, 1, 0, 7),
	(9, 'Role', 1, 'fas fa-briefcase', 'builtin/role', 4, 46, 1, 0, 4),
	(10, 'Setting Applikasi', 1, 'fas fa-cog', 'builtin/setting-app', 16, 8, 1, 0, 1),
	(11, 'Setting Layout', 1, 'fas fa-brush', 'builtin/setting-layout', 15, 8, 1, 0, 2),
	(12, 'Identitas', 2, 'fas fa-address-card', 'identitas', 21, NULL, 1, 0, 1),
	(13, 'Antrian', 2, 'fas fa-user-group', '#', NULL, NULL, 1, 0, 2),
	(14, 'Group Antrian', 2, 'fas fa-users-rectangle', 'antrian', 22, 13, 1, 0, 1),
	(15, 'Ambil Antrian', 2, 'fas fa-list-check', 'antrian-ambil', 26, 13, 1, 0, 2),
	(16, 'Panggil Antrian', 2, 'fas fa-volume-high', 'antrian-panggil', 27, 13, 1, 0, 3),
	(17, 'Reset Antrian', 2, 'fas fa-retweet', 'antrian-reset', 28, 13, 1, 0, 4),
	(18, 'Referensi Tujuan', 2, 'fas fa-door-closed', 'tujuan', 29, 13, 1, 0, 5),
	(19, 'Rekap Antrian', 2, 'fas fa-square-poll-vertical', 'antrian-rekap', 62, 13, 1, 0, 6),
	(20, 'Layar', 2, 'fas fa-tv', '#', NULL, NULL, 1, 0, 3),
	(21, 'Layar Ambil Antrian', 2, 'fas fa-desktop', 'layar/antrian', 30, 20, 1, 0, 1),
	(22, 'Layar Monitor', 2, 'fas fa-desktop', 'layar/show-layar-monitor', 30, 20, 1, 0, 2),
	(23, 'Setting Registrasi', 1, 'fas fa-user-plus', 'builtin/setting-registrasi', 34, 8, 1, 0, 3),
	(24, 'Setting Layar', 2, 'fas fa-gear', 'layar-monitor-setting', 31, 20, 1, 0, 3),
	(25, 'Setting Layout', 2, 'fas fa-palette', 'layar-monitor-setting-layout', 32, 20, 1, 0, 4),
	(26, 'Setting Printer', 2, 'fas fa-print', 'setting-printer', 36, NULL, 1, 0, 4),
	(27, 'Suara Awalan', 2, 'fas fa-volume-high', 'awalan-panggil', 37, NULL, 1, 0, 5),
	(38, 'Module Permission', 1, 'fas fa-shield-alt', 'builtin/permission', 51, 46, 1, 0, 3),
	(39, 'Role Permission', 1, 'far fa-user', 'builtin/role-permission', 52, 2, 1, 0, 1),
	(46, 'Aplikasi', 1, 'fas fa-gear', '#', NULL, NULL, 1, 0, 1),
	(47, 'Assign User', 2, 'fas fa-link', '#', NULL, NULL, 1, 0, 7),
	(48, 'User Antrian', 2, 'fas fa-user-gear', 'user-antrian', 64, 47, 1, 0, 1);

-- Dumping structure for table aplikasi_antrian.menu_kategori
CREATE TABLE IF NOT EXISTS `menu_kategori` (
  `id_menu_kategori` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_kategori` varchar(255) DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `aktif` enum('Y','N') DEFAULT NULL,
  `show_title` enum('Y','N') DEFAULT NULL,
  `urut` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_menu_kategori`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.menu_kategori: ~3 rows (approximately)
INSERT INTO `menu_kategori` (`id_menu_kategori`, `nama_kategori`, `deskripsi`, `aktif`, `show_title`, `urut`) VALUES
	(1, 'Master Aplikasi', 'Menu Pengaturan Aplikasi', 'Y', 'Y', 1),
	(2, 'Aplikasi Antrian', 'Menu Aplikasi Antrian', 'Y', 'Y', 2);

-- Dumping structure for table aplikasi_antrian.menu_role
CREATE TABLE IF NOT EXISTS `menu_role` (
  `id_menu` smallint(5) unsigned NOT NULL,
  `id_role` smallint(5) unsigned NOT NULL,
  KEY `module_role_module` (`id_menu`),
  KEY `module_role_role` (`id_role`),
  CONSTRAINT `menu_role_menu` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_role_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=COMPACT COMMENT='Tabel hak akses dari menu aplikasi';

-- Dumping data for table aplikasi_antrian.menu_role: ~40 rows (approximately)
INSERT INTO `menu_role` (`id_menu`, `id_role`) VALUES
	(8, 2),
	(11, 2),
	(2, 1),
	(3, 1),
	(4, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(13, 1),
	(14, 1),
	(17, 1),
	(18, 1),
	(20, 1),
	(23, 1),
	(25, 1),
	(26, 1),
	(38, 1),
	(39, 1),
	(12, 1),
	(27, 1),
	(19, 1),
	(24, 1),
	(13, 2),
	(16, 1),
	(16, 2),
	(46, 1),
	(20, 2),
	(21, 1),
	(21, 2),
	(22, 1),
	(22, 2),
	(15, 1),
	(15, 2),
	(1, 1),
	(1, 2),
	(47, 1),
	(48, 1);

-- Dumping structure for table aplikasi_antrian.module
CREATE TABLE IF NOT EXISTS `module` (
  `id_module` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nama_module` varchar(50) DEFAULT NULL,
  `judul_module` varchar(50) DEFAULT NULL,
  `id_module_status` tinyint(1) DEFAULT NULL,
  `login` enum('Y','N','R') NOT NULL DEFAULT 'Y',
  `deskripsi` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_module`),
  UNIQUE KEY `module_nama` (`nama_module`),
  KEY `module_module_status` (`id_module_status`),
  CONSTRAINT `module_module_status` FOREIGN KEY (`id_module_status`) REFERENCES `module_status` (`id_module_status`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC COMMENT='Tabel modul aplikasi';

-- Dumping data for table aplikasi_antrian.module: ~31 rows (approximately)
INSERT INTO `module` (`id_module`, `nama_module`, `judul_module`, `id_module_status`, `login`, `deskripsi`) VALUES
	(1, 'builtin/menu', 'Menu Manager', 1, 'Y', 'Administrasi Menu'),
	(2, 'builtin/module', 'Module Manager', 1, 'Y', 'Pengaturan Module'),
	(3, 'builtin/module-role', 'Assign Role ke Module', 1, 'Y', 'Assign Role ke Module'),
	(4, 'builtin/role', 'Role Manager', 1, 'Y', 'Pengaturan Role'),
	(5, 'builtin/user', 'User Manager', 1, 'Y', 'Pengaturan user'),
	(6, 'login', 'Login', 1, 'R', 'Login ke akun Anda'),
	(7, 'builtin/user-role', 'Assign Role ke User', 1, 'Y', 'Assign role ke user'),
	(8, 'builtin/menu-role', 'Menu - Role', 1, 'Y', 'Assign role ke menu'),
	(15, 'builtin/setting-layout', 'Setting Layout', 1, 'Y', 'Setting Layout Aplikasi'),
	(16, 'builtin/setting-app', 'Setting App', 1, 'Y', 'Pengaturan aplikasi seperti nama aplikasi, logo, d'),
	(21, 'identitas', 'Identitas Organisasi', 1, 'Y', 'Identitas Organisasi'),
	(22, 'antrian', 'Antrian', 1, 'Y', 'Antrian'),
	(25, 'home', 'Home', 1, 'Y', 'Home'),
	(26, 'antrian-ambil', 'Ambil Antrian', 1, 'Y', 'Ambil Antrian'),
	(27, 'antrian-panggil', 'Panggil Antrian', 1, 'Y', 'Panggil Antrian'),
	(28, 'antrian-reset', 'Reset Antrian', 1, 'Y', 'Reset Antrian'),
	(29, 'tujuan', 'Tujuan Antrian', 1, 'Y', 'Tujuan Antrian'),
	(30, 'layar', 'Layar Monitor', 1, 'Y', 'Layar Monitor'),
	(31, 'layar-monitor-setting', 'Setting Monitor Antrian', 1, 'Y', 'Setting Monitor Antrian'),
	(32, 'layar-monitor-setting-layout', 'Setting Layout Layar', 1, 'Y', 'Setting Layout Layar'),
	(33, 'register', 'Register Akun', 1, 'R', 'Register Akun'),
	(34, 'builtin/setting-registrasi', 'Setting Registrasi Akun', 1, 'Y', 'Setting Registrasi Akun'),
	(35, 'recovery', 'Reset Password', 1, 'R', 'Reset Password'),
	(36, 'setting-printer', 'Setting Printer', 1, 'Y', 'Setting Printer'),
	(37, 'awalan-panggil', 'Suara Awalan Panggil Antrian', 1, 'Y', 'Suara Awalan Panggil Antrian'),
	(44, 'wilayah', 'Wilayah', 1, 'Y', 'Wilayah'),
	(51, 'builtin/permission', 'Permission', 1, 'Y', 'Permission'),
	(52, 'builtin/role-permission', 'Role Permission', 1, 'Y', 'Role Permission'),
	(62, 'antrian-rekap', 'Rekap Antrian', 1, 'Y', 'Rekap Antrian'),
	(63, 'longpolling', 'Long Polling', 1, 'N', 'Long Polling'),
	(64, 'user-antrian', 'Assign User ke Antrian', 1, 'Y', 'Assign User ke Antrian');

-- Dumping structure for table aplikasi_antrian.module_permission
CREATE TABLE IF NOT EXISTS `module_permission` (
  `id_module_permission` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `id_module` smallint(5) unsigned NOT NULL DEFAULT 0,
  `nama_permission` varchar(50) NOT NULL,
  `judul_permission` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_module_permission`) USING BTREE,
  UNIQUE KEY `id_module_nama_permission` (`id_module`,`nama_permission`) USING BTREE,
  CONSTRAINT `module_permission_module` FOREIGN KEY (`id_module`) REFERENCES `module` (`id_module`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table aplikasi_antrian.module_permission: ~134 rows (approximately)
INSERT INTO `module_permission` (`id_module_permission`, `id_module`, `nama_permission`, `judul_permission`, `keterangan`) VALUES
	(1, 1, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(2, 2, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(3, 3, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(4, 4, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(5, 5, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(6, 6, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(7, 7, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(8, 8, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(10, 15, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(11, 16, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(12, 21, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(13, 22, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(14, 25, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(15, 26, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(16, 27, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(17, 28, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(18, 29, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(19, 30, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(20, 31, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(21, 32, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(22, 33, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(23, 34, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(24, 35, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(25, 36, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(33, 44, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(37, 51, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(38, 1, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(39, 2, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(40, 3, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(41, 4, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(42, 5, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(43, 6, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(44, 7, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(45, 8, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(47, 15, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(48, 16, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(49, 21, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(50, 22, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(51, 25, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(52, 26, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(53, 27, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(54, 28, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(55, 29, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(56, 30, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(57, 31, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(58, 32, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(59, 33, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(60, 34, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(61, 35, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(62, 36, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(70, 44, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(74, 51, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(75, 1, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(76, 2, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(77, 3, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(78, 4, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(79, 5, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(80, 6, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(81, 7, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(82, 8, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(84, 15, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(85, 16, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(86, 21, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(87, 22, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(88, 25, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(89, 26, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(90, 27, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(91, 28, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(92, 29, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(93, 30, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(94, 31, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(95, 32, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(96, 33, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(97, 34, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(98, 35, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(99, 36, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(107, 44, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(111, 51, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(112, 1, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(113, 2, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(114, 3, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(115, 4, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(116, 5, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(117, 6, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(118, 7, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(119, 8, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(121, 15, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(122, 16, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(123, 21, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(124, 22, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(125, 25, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(126, 26, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(127, 27, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(128, 28, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(129, 29, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(130, 30, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(131, 31, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(132, 32, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(133, 33, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(134, 34, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(135, 35, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(136, 36, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(144, 44, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(148, 51, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(149, 52, 'read_all', 'Read All Data', 'Hak akses untuk membaca data chartjs'),
	(150, 52, 'create', 'Create Data', 'Hak akses untuk menambah data'),
	(152, 52, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(153, 52, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(154, 37, 'create', 'Create Data', 'Hak akses untuk membuat data'),
	(155, 37, 'read_all', 'Read All Data', 'Hak akses untuk membaca semua data'),
	(156, 37, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(157, 37, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(182, 5, 'read_own', 'Read Own Data', 'Hak akses untuk membaca data miliknya sendiri'),
	(183, 5, 'update_own', 'Update Own Data', 'Hak akses untuk mengupdate data miliknya sendiri'),
	(184, 5, 'delete_own', 'Delete Own Data', 'Hak akses untuk menghapus data miliknya sendiri'),
	(185, 15, 'read_own', 'Read Own Data', 'Hak akses untuk membaca data miliknya sendiri'),
	(186, 15, 'update_own', 'Update Own Data', 'Hak akses untuk mengupdate data miliknya sendiri'),
	(187, 15, 'delete_own', 'Delete Own Data', 'Hak akses untuk menghapus data miliknya sendiri'),
	(192, 62, 'create', 'Create Data', 'Hak akses untuk membuat data'),
	(193, 62, 'read_all', 'Read All Data', 'Hak akses untuk membaca semua data'),
	(194, 62, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(195, 62, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(196, 63, 'create', 'Create Data', 'Hak akses untuk membuat data'),
	(197, 63, 'read_all', 'Read All Data', 'Hak akses untuk membaca semua data'),
	(198, 63, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(199, 63, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data'),
	(200, 64, 'create', 'Create Data', 'Hak akses untuk membuat data'),
	(201, 64, 'read_all', 'Read All Data', 'Hak akses untuk membaca semua data'),
	(202, 64, 'update_all', 'Update All Data', 'Hak akses untuk mengupdate semua data'),
	(203, 64, 'delete_all', 'Delete All Data', 'Hak akses untuk menghapus semua data');

-- Dumping structure for table aplikasi_antrian.module_status
CREATE TABLE IF NOT EXISTS `module_status` (
  `id_module_status` tinyint(1) NOT NULL AUTO_INCREMENT,
  `nama_status` varchar(50) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_module_status`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC COMMENT='Tabel status modul, seperti: aktif, non aktif, dalam perbaikan';

-- Dumping data for table aplikasi_antrian.module_status: ~3 rows (approximately)
INSERT INTO `module_status` (`id_module_status`, `nama_status`, `keterangan`) VALUES
	(1, 'Aktif', NULL),
	(2, 'Tidak Aktif', NULL),
	(3, 'Dalam Perbaikan', 'Hanya role developer yang dapat mengakses module dengan status ini');

-- Dumping structure for table aplikasi_antrian.role
CREATE TABLE IF NOT EXISTS `role` (
  `id_role` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nama_role` varchar(50) NOT NULL,
  `judul_role` varchar(50) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  `id_module` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_role`),
  UNIQUE KEY `role_nama` (`nama_role`),
  KEY `role_module` (`id_module`),
  CONSTRAINT `role_module` FOREIGN KEY (`id_module`) REFERENCES `module` (`id_module`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC COMMENT='Tabel yang berisi daftar role, role ini mengatur bagaimana user mengakses module, role ini nantinya diassign ke user';

-- Dumping data for table aplikasi_antrian.role: ~3 rows (approximately)
INSERT INTO `role` (`id_role`, `nama_role`, `judul_role`, `keterangan`, `id_module`) VALUES
	(1, 'admin', 'Administrator', 'Administrator', 5),
	(2, 'user', 'User', 'Pengguna umum', 5),
	(3, 'webdev', 'Web Developer', 'Pengembang aplikasi', 5);

-- Dumping structure for table aplikasi_antrian.role_module_permission
CREATE TABLE IF NOT EXISTS `role_module_permission` (
  `id_role` smallint(5) unsigned NOT NULL,
  `id_module_permission` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_role`,`id_module_permission`) USING BTREE,
  KEY `role_permission_permission` (`id_module_permission`) USING BTREE,
  CONSTRAINT `role_module_permission_module_permission` FOREIGN KEY (`id_module_permission`) REFERENCES `module_permission` (`id_module_permission`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_module_permission_role` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table aplikasi_antrian.role_module_permission: ~151 rows (approximately)
INSERT INTO `role_module_permission` (`id_role`, `id_module_permission`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 10),
	(1, 11),
	(1, 12),
	(1, 13),
	(1, 14),
	(1, 15),
	(1, 16),
	(1, 17),
	(1, 18),
	(1, 19),
	(1, 20),
	(1, 21),
	(1, 22),
	(1, 23),
	(1, 24),
	(1, 25),
	(1, 33),
	(1, 37),
	(1, 38),
	(1, 39),
	(1, 40),
	(1, 41),
	(1, 42),
	(1, 43),
	(1, 44),
	(1, 45),
	(1, 47),
	(1, 48),
	(1, 49),
	(1, 50),
	(1, 51),
	(1, 52),
	(1, 53),
	(1, 54),
	(1, 55),
	(1, 56),
	(1, 57),
	(1, 58),
	(1, 59),
	(1, 60),
	(1, 61),
	(1, 62),
	(1, 70),
	(1, 74),
	(1, 75),
	(1, 76),
	(1, 77),
	(1, 78),
	(1, 79),
	(1, 80),
	(1, 81),
	(1, 82),
	(1, 84),
	(1, 85),
	(1, 86),
	(1, 87),
	(1, 88),
	(1, 89),
	(1, 90),
	(1, 91),
	(1, 92),
	(1, 93),
	(1, 94),
	(1, 95),
	(1, 96),
	(1, 97),
	(1, 98),
	(1, 99),
	(1, 107),
	(1, 111),
	(1, 112),
	(1, 113),
	(1, 114),
	(1, 115),
	(1, 116),
	(1, 117),
	(1, 118),
	(1, 119),
	(1, 121),
	(1, 122),
	(1, 123),
	(1, 124),
	(1, 125),
	(1, 126),
	(1, 127),
	(1, 128),
	(1, 129),
	(1, 130),
	(1, 131),
	(1, 132),
	(1, 133),
	(1, 134),
	(1, 135),
	(1, 136),
	(1, 144),
	(1, 148),
	(1, 149),
	(1, 150),
	(1, 152),
	(1, 153),
	(1, 154),
	(1, 155),
	(1, 156),
	(1, 157),
	(1, 182),
	(1, 183),
	(1, 184),
	(1, 185),
	(1, 186),
	(1, 187),
	(1, 192),
	(1, 193),
	(1, 194),
	(1, 195),
	(1, 196),
	(1, 197),
	(1, 198),
	(1, 199),
	(1, 200),
	(1, 201),
	(1, 202),
	(1, 203),
	(2, 52),
	(2, 53),
	(2, 56),
	(2, 182),
	(2, 183),
	(2, 185),
	(2, 186),
	(2, 197),
	(3, 182);

-- Dumping structure for table aplikasi_antrian.setting
CREATE TABLE IF NOT EXISTS `setting` (
  `type` varchar(50) NOT NULL,
  `param` varchar(255) NOT NULL,
  `value` tinytext DEFAULT NULL,
  PRIMARY KEY (`type`,`param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table aplikasi_antrian.setting: ~23 rows (approximately)
INSERT INTO `setting` (`type`, `param`, `value`) VALUES
	('app', 'background_logo', 'transparent'),
	('app', 'btn_login', 'btn-danger'),
	('app', 'deskripsi_web', 'Template administrasi lengkap dengan fitur penting dalam pengembangan aplikasi seperti pengatuan web, layout, dll'),
	('app', 'favicon', 'favicon.png'),
	('app', 'footer_app', '&copy; {{YEAR}} &lt;a href=&quot;https://jagowebdev.com&quot; target=&quot;_blank&quot;&gt;www.Jagowebdev.com&lt;/a&gt;'),
	('app', 'footer_login', '&copy; {{YEAR}} &lt;a href=&quot;https://jagowebdev.com&quot; target=&quot;_blank&quot;&gt;Jagowebdev.com&lt;/a&gt;'),
	('app', 'judul_web', 'Admin Template Jagowebdev'),
	('app', 'logo_app', 'logo_aplikasi.png'),
	('app', 'logo_login', 'logo_login.png'),
	('app', 'logo_register', 'logo_register.png'),
	('layout', 'bootswatch_theme', 'cosmo'),
	('layout', 'color_scheme', 'blue'),
	('layout', 'font_family', 'poppins'),
	('layout', 'font_size', '14.5'),
	('layout', 'logo_background_color', 'dark'),
	('layout', 'sidebar_color', 'dark'),
	('register', 'default_page_id_module', '5'),
	('register', 'default_page_id_role', '2'),
	('register', 'default_page_type', 'id_module'),
	('register', 'default_page_url', '{{BASE_URL}}builtin/user/edit?id=1'),
	('register', 'enable', 'Y'),
	('register', 'id_role', '2'),
	('register', 'metode_aktivasi', 'email');

-- Dumping structure for table aplikasi_antrian.setting_layar
CREATE TABLE IF NOT EXISTS `setting_layar` (
  `id_setting_layar` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_setting` varchar(255) NOT NULL DEFAULT '',
  `id_setting_printer` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_setting_layar`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table aplikasi_antrian.setting_layar: ~3 rows (approximately)
INSERT INTO `setting_layar` (`id_setting_layar`, `nama_setting`, `id_setting_printer`) VALUES
	(1, 'Layar Pelayanan', 2),
	(2, 'Layar Poliklinik', 1),
	(3, 'Layar Counter', 1);

-- Dumping structure for table aplikasi_antrian.setting_layar_detail
CREATE TABLE IF NOT EXISTS `setting_layar_detail` (
  `id_setting_layar` int(11) unsigned NOT NULL,
  `id_antrian_kategori` int(11) unsigned NOT NULL,
  `urut` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table aplikasi_antrian.setting_layar_detail: ~8 rows (approximately)
INSERT INTO `setting_layar_detail` (`id_setting_layar`, `id_antrian_kategori`, `urut`) VALUES
	(2, 5, 1),
	(2, 4, 2),
	(2, 1, 3),
	(2, 6, 4),
	(2, 7, 5),
	(3, 9, 1),
	(1, 3, 1),
	(1, 2, 2);

-- Dumping structure for table aplikasi_antrian.setting_layar_layout
CREATE TABLE IF NOT EXISTS `setting_layar_layout` (
  `param` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.setting_layar_layout: ~8 rows (approximately)
INSERT INTO `setting_layar_layout` (`param`, `value`) VALUES
	('color_scheme', 'gradient'),
	('font_family', 'poppins'),
	('font_size', '100'),
	('jenis_video', 'youtube'),
	('link_video', 'https://www.youtube.com/watch?v=QuwguZgGejY'),
	('text_footer', 'JAM BUKA LAYANAN KAMI ADALAH PUKUL 07:00 s.d 21.00. TERIMA KASIH ATAS KUNJUNGAN ANDA . KAMI SENANTIASA MELAYANI SEPENUH HATI'),
	('text_footer_mode', 'statis'),
	('text_footer_speed', '25');

-- Dumping structure for table aplikasi_antrian.setting_printer
CREATE TABLE IF NOT EXISTS `setting_printer` (
  `id_setting_printer` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama_setting_printer` varchar(255) DEFAULT NULL,
  `alamat_server` varchar(255) DEFAULT NULL,
  `aktif` tinyint(4) DEFAULT NULL,
  `feed` tinyint(4) unsigned DEFAULT NULL,
  `font_type` enum('FONT_A','FONT_B','FONT_C') DEFAULT NULL,
  `font_size_width` tinyint(4) DEFAULT NULL,
  `font_size_height` tinyint(4) DEFAULT NULL,
  `autocut` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`id_setting_printer`),
  UNIQUE KEY `nama_setting_printer` (`nama_setting_printer`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.setting_printer: ~2 rows (approximately)
INSERT INTO `setting_printer` (`id_setting_printer`, `nama_setting_printer`, `alamat_server`, `aktif`, `feed`, `font_type`, `font_size_width`, `font_size_height`, `autocut`) VALUES
	(1, 'Printer Pengunjung', 'smb://LOCALHOST/POS58', 1, 2, 'FONT_A', 7, 7, 'Y'),
	(2, 'Printer Back Office', 'smb://LOCALHOST/POS57', 1, 2, 'FONT_A', 7, 7, 'N');

-- Dumping structure for table aplikasi_antrian.setting_user
CREATE TABLE IF NOT EXISTS `setting_user` (
  `id_user` int(11) unsigned NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT '',
  `param` varchar(255) NOT NULL,
  PRIMARY KEY (`id_user`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table aplikasi_antrian.setting_user: 2 rows
/*!40000 ALTER TABLE `setting_user` DISABLE KEYS */;
INSERT INTO `setting_user` (`id_user`, `type`, `param`) VALUES
	(3, 'layout', '{"color_scheme":"green","bootswatch_theme":"default","sidebar_color":"dark","logo_background_color":"dark","font_family":"poppins","font_size":"14.5"}'),
	(2, 'layout', '{"color_scheme":"blue-dark","bootswatch_theme":"cosmo","sidebar_color":"dark","logo_background_color":"dark","font_family":"poppins","font_size":"14.5"}');
/*!40000 ALTER TABLE `setting_user` ENABLE KEYS */;

-- Dumping structure for table aplikasi_antrian.user
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `verified` tinyint(4) NOT NULL,
  `status` enum('active','suspended','deleted') NOT NULL DEFAULT 'active',
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `avatar` varchar(255) DEFAULT NULL,
  `default_page_type` enum('url','id_module','id_role') DEFAULT NULL,
  `default_page_url` varchar(50) DEFAULT NULL,
  `default_page_id_module` smallint(5) unsigned DEFAULT NULL,
  `default_page_id_role` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `user_role` (`default_page_id_role`),
  KEY `user_module` (`default_page_id_module`),
  CONSTRAINT `user_module` FOREIGN KEY (`default_page_id_module`) REFERENCES `module` (`id_module`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `user_role` FOREIGN KEY (`default_page_id_role`) REFERENCES `role` (`id_role`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=COMPACT COMMENT='Tabel user untuk login';

-- Dumping data for table aplikasi_antrian.user: ~4 rows (approximately)
INSERT INTO `user` (`id_user`, `email`, `username`, `nama`, `password`, `verified`, `status`, `created`, `avatar`, `default_page_type`, `default_page_url`, `default_page_id_module`, `default_page_id_role`) VALUES
	(1, 'prawoto.hadi@gmail.com', 'admin', 'Agus', '$2y$10$hj7DaVh4qvazTpuucAdbJehhA5g1wbCzvvDBsI5CJ8UGT6xb0fQ8i', 1, 'active', '2018-09-20 16:04:35', 'default.png', 'id_module', '', 5, 1),
	(2, 'andi@gmail.com', 'andi', 'Andi', '$2y$10$ARSBhxrk52KPb2.v3pghjufwCehA.uwVHcwRVfm28OaytVDcat8b6', 1, 'active', '2019-10-01 09:15:03', '', 'id_module', '', 5, 2),
	(3, 'budi@gmail.com', 'budi', 'Budi', '$2y$10$strgoHv1YxR29OBOdyjsSuDMgVcuA2SjULVkawBa.h.UWSgvf7fdu', 1, 'active', '2023-03-11 13:32:38', 'Fransisco Brian.png', 'id_module', '', 5, 2),
	(4, 'sandi@gmail.com', 'sandi', 'Sandi', '$2y$10$lejUe3EFmdV7gICKf7yYXel2mD6f3yPZ2N07xdv/pbVPhZ6yyo3my', 1, 'active', '2023-07-15 20:47:45', NULL, 'id_module', '', 5, 2);

-- Dumping structure for table aplikasi_antrian.user_antrian_detail
CREATE TABLE IF NOT EXISTS `user_antrian_detail` (
  `id_user` int(10) unsigned NOT NULL,
  `id_antrian_detail` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_user`,`id_antrian_detail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.user_antrian_detail: ~37 rows (approximately)
INSERT INTO `user_antrian_detail` (`id_user`, `id_antrian_detail`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(1, 10),
	(1, 11),
	(1, 20),
	(2, 1),
	(2, 2),
	(2, 3),
	(2, 4),
	(2, 5),
	(2, 6),
	(2, 7),
	(2, 8),
	(2, 9),
	(2, 10),
	(2, 11),
	(2, 20),
	(3, 1),
	(3, 2),
	(3, 3),
	(3, 4),
	(3, 5),
	(3, 6),
	(3, 7),
	(3, 8),
	(3, 9),
	(3, 10),
	(3, 11),
	(3, 20),
	(4, 4);

-- Dumping structure for table aplikasi_antrian.user_login_activity
CREATE TABLE IF NOT EXISTS `user_login_activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) unsigned NOT NULL,
  `id_activity` tinyint(4) NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_login_activity_user` (`id_user`),
  CONSTRAINT `user_login_activity_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table aplikasi_antrian.user_login_activity: ~254 rows (approximately)
INSERT INTO `user_login_activity` (`id`, `id_user`, `id_activity`, `time`) VALUES
	(1, 1, 1, '2021-03-09 06:41:49'),
	(2, 1, 1, '2021-03-09 18:57:18'),
	(3, 1, 1, '2021-03-09 19:39:09'),
	(4, 1, 1, '2021-03-09 19:40:19'),
	(5, 1, 1, '2021-03-09 19:42:23'),
	(6, 1, 1, '2021-03-09 19:42:37'),
	(7, 1, 1, '2021-03-13 21:04:15'),
	(8, 1, 1, '2021-03-14 19:16:37'),
	(9, 1, 1, '2021-03-14 19:33:36'),
	(10, 1, 1, '2021-04-01 05:09:56'),
	(11, 1, 1, '2021-05-27 07:19:44'),
	(12, 1, 1, '2021-05-27 20:55:41'),
	(13, 1, 1, '2021-05-30 16:05:20'),
	(14, 1, 1, '2021-05-30 21:27:32'),
	(15, 1, 1, '2021-05-31 12:20:38'),
	(16, 1, 1, '2021-12-19 08:50:37'),
	(17, 1, 1, '2021-12-20 20:12:26'),
	(18, 1, 1, '2021-12-20 20:54:39'),
	(19, 1, 1, '2021-12-20 21:01:36'),
	(20, 1, 1, '2021-12-21 20:08:38'),
	(21, 1, 1, '2021-12-21 20:14:09'),
	(22, 1, 1, '2021-12-24 20:22:35'),
	(23, 1, 1, '2021-12-25 11:40:33'),
	(24, 1, 1, '2021-12-25 13:52:21'),
	(25, 1, 1, '2021-12-25 15:55:18'),
	(26, 1, 1, '2021-12-26 10:47:59'),
	(27, 1, 1, '2022-01-01 20:26:54'),
	(28, 1, 1, '2022-01-06 20:57:26'),
	(29, 1, 1, '2022-01-07 05:44:38'),
	(30, 1, 1, '2022-01-08 17:11:21'),
	(31, 1, 1, '2022-01-15 14:18:48'),
	(32, 1, 1, '2022-01-16 12:27:25'),
	(33, 1, 1, '2022-01-23 05:15:32'),
	(34, 1, 1, '2022-01-29 06:25:29'),
	(35, 1, 1, '2022-01-30 11:37:13'),
	(36, 1, 1, '2022-02-04 20:14:46'),
	(37, 1, 1, '2022-02-11 20:08:38'),
	(38, 1, 1, '2022-02-12 08:56:22'),
	(39, 1, 1, '2022-02-13 06:33:35'),
	(40, 1, 1, '2022-02-13 06:46:00'),
	(41, 1, 1, '2022-02-13 06:47:51'),
	(42, 1, 1, '2022-02-13 06:48:37'),
	(43, 1, 1, '2022-02-13 06:50:53'),
	(44, 1, 1, '2022-02-13 06:51:49'),
	(45, 1, 1, '2022-02-13 06:52:17'),
	(46, 1, 1, '2022-02-13 06:52:43'),
	(47, 1, 1, '2022-02-13 07:00:46'),
	(48, 1, 1, '2022-02-13 07:01:14'),
	(49, 1, 1, '2022-02-13 07:16:25'),
	(50, 1, 1, '2022-02-13 07:47:25'),
	(52, 1, 1, '2022-02-13 07:52:20'),
	(53, 1, 1, '2022-02-13 07:53:53'),
	(54, 1, 1, '2022-02-13 08:02:28'),
	(55, 1, 1, '2022-02-13 08:11:32'),
	(56, 1, 1, '2022-02-19 06:06:40'),
	(57, 1, 1, '2022-02-25 17:40:21'),
	(58, 1, 1, '2022-03-10 16:31:49'),
	(59, 1, 1, '2022-03-20 19:54:08'),
	(60, 1, 1, '2022-04-02 15:22:39'),
	(61, 1, 1, '2022-05-24 19:46:00'),
	(62, 1, 1, '2022-05-26 05:33:54'),
	(63, 1, 1, '2022-05-26 11:48:51'),
	(64, 1, 1, '2022-05-26 14:47:21'),
	(65, 1, 1, '2022-05-26 21:04:14'),
	(66, 1, 1, '2022-05-27 20:10:27'),
	(67, 1, 1, '2022-05-28 05:04:42'),
	(68, 1, 1, '2022-05-28 06:23:46'),
	(69, 1, 1, '2022-05-28 10:38:45'),
	(70, 1, 1, '2022-05-28 18:43:53'),
	(71, 1, 1, '2022-05-28 20:14:59'),
	(73, 1, 1, '2022-05-28 20:20:21'),
	(74, 1, 1, '2022-05-28 21:29:04'),
	(75, 1, 1, '2022-05-29 05:51:03'),
	(76, 1, 1, '2022-06-01 10:11:47'),
	(77, 1, 1, '2022-06-01 16:39:59'),
	(78, 1, 1, '2022-06-02 21:27:07'),
	(79, 1, 1, '2022-06-03 20:39:38'),
	(80, 1, 1, '2022-06-04 05:19:14'),
	(81, 1, 1, '2022-06-04 09:55:18'),
	(82, 1, 1, '2022-06-05 04:52:09'),
	(83, 1, 1, '2022-06-05 07:42:05'),
	(84, 1, 1, '2022-06-05 11:29:05'),
	(85, 1, 1, '2022-06-10 21:43:54'),
	(87, 1, 1, '2022-06-10 21:54:25'),
	(88, 1, 1, '2022-06-12 18:45:04'),
	(89, 1, 1, '2022-06-12 20:29:49'),
	(90, 1, 1, '2022-06-13 19:58:46'),
	(91, 1, 1, '2022-06-13 19:59:20'),
	(92, 1, 1, '2022-06-14 19:29:19'),
	(93, 1, 1, '2022-06-14 19:30:01'),
	(94, 1, 1, '2022-06-15 19:44:47'),
	(95, 1, 1, '2022-06-15 19:45:58'),
	(96, 1, 1, '2022-06-18 07:09:11'),
	(97, 1, 1, '2022-06-18 14:00:24'),
	(98, 1, 1, '2022-06-18 16:56:07'),
	(99, 1, 1, '2022-06-19 04:52:30'),
	(100, 1, 1, '2022-06-19 11:32:33'),
	(103, 1, 1, '2022-06-19 16:01:58'),
	(104, 1, 1, '2022-06-19 16:09:07'),
	(105, 1, 1, '2022-06-19 16:10:34'),
	(106, 1, 1, '2022-06-19 16:12:06'),
	(107, 1, 1, '2022-06-20 05:03:09'),
	(108, 1, 1, '2022-06-20 11:42:51'),
	(109, 1, 1, '2022-06-20 11:49:05'),
	(110, 1, 1, '2022-06-20 12:40:09'),
	(111, 1, 1, '2022-06-20 13:17:50'),
	(112, 1, 1, '2022-06-21 20:33:32'),
	(113, 1, 1, '2022-06-22 20:37:47'),
	(114, 1, 1, '2022-06-22 20:40:00'),
	(115, 1, 1, '2022-06-25 05:55:26'),
	(116, 1, 1, '2022-06-25 07:26:56'),
	(117, 1, 1, '2022-06-26 05:32:54'),
	(118, 1, 1, '2022-06-26 07:39:40'),
	(119, 1, 1, '2022-06-26 07:43:35'),
	(120, 1, 1, '2022-06-26 07:44:56'),
	(121, 1, 1, '2022-06-26 07:47:01'),
	(122, 1, 1, '2022-06-26 07:48:16'),
	(123, 1, 1, '2022-06-26 08:24:36'),
	(124, 1, 1, '2022-06-26 08:25:28'),
	(125, 1, 1, '2022-06-26 08:26:55'),
	(127, 1, 1, '2022-06-26 09:40:53'),
	(128, 1, 1, '2022-06-26 09:42:18'),
	(130, 1, 1, '2022-06-26 12:20:37'),
	(132, 1, 1, '2022-06-26 15:44:52'),
	(133, 1, 1, '2022-06-26 18:40:18'),
	(134, 1, 1, '2022-07-09 07:36:04'),
	(135, 1, 1, '2022-08-06 11:44:36'),
	(136, 1, 1, '2022-08-06 12:10:27'),
	(137, 1, 1, '2022-08-06 13:06:38'),
	(138, 1, 1, '2022-08-08 20:35:38'),
	(139, 1, 1, '2022-08-10 21:35:05'),
	(140, 1, 1, '2022-08-27 20:48:39'),
	(141, 1, 1, '2022-08-28 09:23:05'),
	(142, 1, 1, '2022-11-21 19:44:29'),
	(143, 1, 1, '2022-11-21 21:23:43'),
	(144, 1, 1, '2022-11-21 22:02:38'),
	(145, 1, 1, '2022-11-22 04:21:39'),
	(146, 1, 1, '2022-11-22 19:22:54'),
	(147, 1, 1, '2022-11-23 04:21:45'),
	(148, 1, 1, '2022-11-24 20:40:46'),
	(149, 1, 1, '2022-11-25 21:05:42'),
	(150, 1, 1, '2022-11-26 04:22:01'),
	(151, 1, 1, '2022-11-29 18:32:44'),
	(152, 1, 1, '2022-12-03 11:03:46'),
	(154, 1, 1, '2022-12-03 12:52:22'),
	(156, 1, 1, '2022-12-17 09:03:29'),
	(157, 1, 1, '2022-12-17 10:28:33'),
	(158, 1, 1, '2022-12-17 10:41:03'),
	(160, 1, 1, '2022-12-17 12:27:17'),
	(166, 1, 1, '2022-12-17 15:46:50'),
	(167, 1, 1, '2022-12-17 18:28:03'),
	(168, 1, 1, '2022-12-18 04:53:40'),
	(169, 1, 1, '2022-12-18 05:56:39'),
	(170, 1, 1, '2022-12-18 06:09:26'),
	(171, 1, 1, '2022-12-18 07:15:25'),
	(172, 1, 1, '2022-12-18 08:45:15'),
	(173, 1, 1, '2022-12-18 11:34:09'),
	(174, 1, 1, '2022-12-18 20:06:41'),
	(175, 1, 1, '2022-12-21 04:39:03'),
	(177, 1, 1, '2023-01-14 06:24:10'),
	(179, 1, 1, '2023-01-14 06:26:38'),
	(180, 1, 1, '2023-01-16 20:59:21'),
	(181, 1, 1, '2023-01-16 21:22:13'),
	(182, 1, 1, '2023-01-17 20:27:07'),
	(183, 1, 1, '2023-01-17 21:03:41'),
	(184, 1, 1, '2023-01-17 21:15:52'),
	(185, 1, 1, '2023-01-17 21:41:26'),
	(186, 1, 1, '2023-01-17 21:54:02'),
	(187, 1, 1, '2023-01-17 22:19:10'),
	(188, 1, 1, '2023-01-18 05:41:46'),
	(189, 1, 1, '2023-01-18 05:57:41'),
	(190, 1, 1, '2023-01-18 06:26:09'),
	(191, 1, 1, '2023-01-18 20:17:15'),
	(192, 1, 1, '2023-01-19 20:37:55'),
	(193, 1, 1, '2023-01-19 20:58:50'),
	(194, 1, 1, '2023-01-20 05:59:47'),
	(195, 1, 1, '2023-01-20 20:19:23'),
	(196, 1, 1, '2023-01-21 21:38:12'),
	(197, 1, 1, '2023-01-23 06:37:53'),
	(198, 1, 1, '2023-01-23 06:42:11'),
	(199, 1, 1, '2023-02-03 20:51:32'),
	(201, 1, 1, '2023-02-04 13:15:52'),
	(203, 1, 1, '2023-02-04 13:18:01'),
	(206, 1, 1, '2023-02-04 17:58:32'),
	(207, 1, 1, '2023-02-09 22:20:56'),
	(208, 1, 1, '2023-02-11 11:45:18'),
	(209, 1, 1, '2023-02-12 09:10:32'),
	(210, 1, 1, '2023-02-12 13:18:30'),
	(211, 1, 1, '2023-02-28 19:17:05'),
	(212, 1, 1, '2023-03-01 05:03:50'),
	(213, 1, 1, '2023-03-01 18:26:27'),
	(214, 1, 1, '2023-03-02 05:00:16'),
	(215, 1, 1, '2023-03-02 18:41:40'),
	(216, 1, 1, '2023-03-03 05:05:08'),
	(217, 1, 1, '2023-03-03 18:05:13'),
	(218, 1, 1, '2023-03-04 05:31:22'),
	(219, 1, 1, '2023-03-05 05:31:33'),
	(220, 1, 1, '2023-03-05 18:44:19'),
	(221, 1, 1, '2023-03-06 18:41:44'),
	(222, 1, 1, '2023-03-07 05:15:42'),
	(223, 1, 1, '2023-03-07 05:38:50'),
	(224, 1, 1, '2023-03-07 18:48:06'),
	(225, 1, 1, '2023-03-08 05:01:05'),
	(227, 1, 1, '2023-03-08 05:28:44'),
	(228, 1, 1, '2023-03-08 18:35:37'),
	(229, 1, 1, '2023-03-08 20:02:47'),
	(230, 1, 1, '2023-03-09 05:05:23'),
	(231, 1, 1, '2023-03-09 18:49:40'),
	(232, 1, 1, '2023-03-10 05:08:30'),
	(233, 1, 1, '2023-03-10 18:34:20'),
	(234, 1, 1, '2023-03-10 22:05:43'),
	(236, 1, 1, '2023-03-11 05:04:30'),
	(239, 1, 1, '2023-03-11 05:45:06'),
	(241, 1, 1, '2023-03-11 06:43:46'),
	(242, 1, 1, '2023-03-11 06:46:36'),
	(245, 1, 1, '2023-03-11 06:51:36'),
	(247, 1, 1, '2023-03-11 07:25:01'),
	(253, 1, 1, '2023-03-11 11:09:58'),
	(254, 3, 1, '2023-03-11 13:34:10'),
	(255, 1, 1, '2023-03-11 13:34:33'),
	(256, 3, 1, '2023-03-11 13:35:12'),
	(257, 1, 1, '2023-03-11 13:42:45'),
	(258, 3, 1, '2023-03-11 16:09:11'),
	(259, 1, 1, '2023-03-11 16:09:37'),
	(260, 3, 1, '2023-03-11 16:12:29'),
	(261, 1, 1, '2023-03-11 16:22:14'),
	(262, 1, 1, '2023-03-11 22:12:54'),
	(263, 1, 1, '2023-03-12 08:06:45'),
	(264, 1, 1, '2023-07-11 18:55:45'),
	(265, 1, 1, '2023-07-11 20:22:45'),
	(266, 1, 1, '2023-07-12 05:16:36'),
	(267, 1, 1, '2023-07-12 18:42:21'),
	(268, 1, 1, '2023-07-12 19:50:26'),
	(269, 1, 1, '2023-07-13 05:10:33'),
	(270, 1, 1, '2023-07-13 20:20:34'),
	(271, 1, 1, '2023-07-14 04:14:35'),
	(272, 1, 1, '2023-07-14 10:09:05'),
	(273, 1, 1, '2023-07-14 16:48:49'),
	(274, 3, 1, '2023-07-14 16:49:17'),
	(275, 1, 1, '2023-07-14 16:49:55'),
	(276, 2, 1, '2023-07-14 16:51:51'),
	(277, 1, 1, '2023-07-14 16:53:37'),
	(278, 2, 1, '2023-07-14 16:55:56'),
	(279, 1, 1, '2023-07-14 16:57:28'),
	(280, 1, 1, '2023-07-14 17:21:51'),
	(281, 1, 1, '2023-07-15 04:55:19'),
	(282, 1, 1, '2023-07-15 07:04:05'),
	(283, 1, 1, '2023-07-15 18:32:16'),
	(284, 1, 1, '2023-07-16 05:16:45'),
	(285, 4, 1, '2023-07-16 08:57:43'),
	(286, 1, 1, '2023-07-16 08:58:18'),
	(287, 3, 1, '2023-07-16 08:58:37'),
	(288, 1, 1, '2023-07-16 08:58:59'),
	(289, 2, 1, '2023-07-16 08:59:17'),
	(290, 4, 1, '2023-07-16 08:59:41'),
	(291, 1, 1, '2023-07-16 09:02:29'),
	(292, 2, 1, '2023-07-16 09:05:57'),
	(293, 1, 1, '2023-07-16 09:14:12'),
	(294, 2, 1, '2023-07-16 09:39:46'),
	(295, 2, 1, '2023-07-16 09:40:11');

-- Dumping structure for table aplikasi_antrian.user_login_activity_ref
CREATE TABLE IF NOT EXISTS `user_login_activity_ref` (
  `id_activity` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id_activity`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table aplikasi_antrian.user_login_activity_ref: ~0 rows (approximately)

-- Dumping structure for table aplikasi_antrian.user_role
CREATE TABLE IF NOT EXISTS `user_role` (
  `id_user` int(10) unsigned NOT NULL,
  `id_role` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_user`,`id_role`),
  KEY `module_role_module` (`id_user`),
  KEY `module_role_role` (`id_role`),
  CONSTRAINT `user_role_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=COMPACT COMMENT='Tabel yang berisi role yang dimili oleh masing masing user';

-- Dumping data for table aplikasi_antrian.user_role: ~4 rows (approximately)
INSERT INTO `user_role` (`id_user`, `id_role`) VALUES
	(1, 1),
	(2, 2),
	(3, 2),
	(4, 2);

-- Dumping structure for table aplikasi_antrian.user_token
CREATE TABLE IF NOT EXISTS `user_token` (
  `selector` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `action` enum('register','remember','recovery','activation') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_user` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `expires` datetime NOT NULL,
  PRIMARY KEY (`selector`),
  KEY `user_token_user` (`id_user`),
  CONSTRAINT `user_token_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table aplikasi_antrian.user_token: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
