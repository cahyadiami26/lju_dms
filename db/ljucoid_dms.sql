-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 04, 2026 at 12:16 PM
-- Server version: 11.4.13-MariaDB-cll-lve-log
-- PHP Version: 8.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ljucoid_dms`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `action`, `description`, `document_id`, `created_at`) VALUES
(41, 7, 'login', 'User logged in', NULL, '2026-08-10 03:39:00'),
(42, 7, 'login', 'User logged in', NULL, '2026-08-10 04:54:52'),
(43, 7, 'login', 'User logged in', NULL, '2026-08-10 04:56:30'),
(44, 1, 'login', 'User logged in', NULL, '2026-08-11 02:59:18'),
(45, 1, 'login', 'User logged in', NULL, '2026-08-11 06:47:14'),
(46, 7, 'login', 'User logged in', NULL, '2026-08-11 06:48:12'),
(47, 1, 'login', 'User logged in', NULL, '2026-08-11 06:48:38'),
(48, 7, 'login', 'User logged in', NULL, '2026-08-11 06:50:19'),
(49, 7, 'upload', 'Upload dokumen: coba invoice', NULL, '2026-08-11 06:51:15'),
(50, 7, 'login', 'User logged in', NULL, '2026-08-11 06:59:18'),
(51, 7, 'sign', 'Menandatangani dokumen: coba invoice', NULL, '2026-08-11 07:20:25'),
(52, 7, 'delete', 'Hapus dokumen: coba invoice', NULL, '2026-08-11 07:21:23'),
(53, 1, 'login', 'User logged in', NULL, '2026-08-12 02:48:21'),
(54, 7, 'login', 'User logged in', NULL, '2026-08-12 02:52:39'),
(55, 7, 'login', 'User logged in', NULL, '2026-08-12 03:01:05'),
(56, 1, 'login', 'User logged in', NULL, '2026-08-12 03:39:51'),
(57, 7, 'login', 'User logged in', NULL, '2026-08-12 03:45:12'),
(58, 1, 'login', 'User logged in', NULL, '2026-08-12 03:45:33'),
(59, 7, 'login', 'User logged in', NULL, '2026-08-12 04:16:04'),
(60, 7, 'upload', 'Upload dokumen: coba invoice', NULL, '2026-08-12 04:16:43'),
(61, 7, 'sign', 'Menandatangani dokumen: coba invoice', NULL, '2026-08-12 04:19:35'),
(62, 7, 'delete', 'Hapus dokumen: coba invoice', NULL, '2026-08-12 04:21:28'),
(63, 7, 'upload', 'Upload dokumen: coba invoice', NULL, '2026-08-12 04:22:01'),
(64, 7, 'login', 'User logged in', NULL, '2026-08-12 04:32:56'),
(65, 7, 'sign', 'Menandatangani dokumen: coba invoice', NULL, '2026-08-12 05:01:21'),
(66, 7, 'login', 'User logged in', NULL, '2026-08-12 06:49:19'),
(67, 7, 'generate_mini_certificate', 'Membuat/mengunduh mini certificate dokumen LJU/2026/08/C65D5E', NULL, '2026-08-12 06:49:29'),
(68, 7, 'delete', 'Hapus dokumen: coba invoice', NULL, '2026-08-12 06:58:21'),
(69, 7, 'upload', 'Upload dokumen: Invoice 1', NULL, '2026-08-12 06:59:06'),
(70, 7, 'sign', 'Menandatangani dokumen: Invoice 1', NULL, '2026-08-12 06:59:23'),
(71, 7, 'generate_mini_certificate', 'Membuat/mengunduh mini certificate dokumen LJU/2026/08/B49815', NULL, '2026-08-12 06:59:53'),
(72, 7, 'login', 'User logged in', NULL, '2026-08-12 07:50:33'),
(73, 7, 'login', 'User logged in', NULL, '2026-08-22 08:51:32'),
(74, 7, 'upload', 'Upload dokumen: cb', NULL, '2026-08-22 08:58:29'),
(75, 7, 'add_signer', 'Tambah signer ke dokumen: cb', NULL, '2026-08-22 08:58:51'),
(76, 7, 'delete', 'Hapus dokumen: cb', NULL, '2026-08-22 09:00:27'),
(77, 1, 'login', 'User logged in', NULL, '2026-08-27 05:22:53'),
(78, 1, 'delete', 'Hapus dokumen: Invoice 1', NULL, '2026-08-27 05:23:07'),
(79, 7, 'login', 'User logged in', NULL, '2026-08-27 05:23:15'),
(80, 7, 'login', 'User logged in', NULL, '2026-08-31 02:31:57'),
(81, 7, 'upload', 'Upload dokumen: coba', NULL, '2026-08-31 02:37:08'),
(82, 7, 'delete', 'Hapus dokumen: coba', NULL, '2026-08-31 02:38:03'),
(83, 1, 'login', 'User logged in', NULL, '2026-08-31 02:39:57'),
(84, 7, 'login', 'User logged in', NULL, '2026-09-10 05:57:08'),
(85, 1, 'login', 'User logged in', NULL, '2026-09-10 05:57:38'),
(86, 7, 'login', 'User logged in', NULL, '2026-09-10 06:07:40'),
(87, 1, 'login', 'User logged in', NULL, '2026-09-10 06:10:05'),
(88, 1, 'login', 'User logged in', NULL, '2026-09-10 06:10:23'),
(89, 7, 'login', 'User logged in', NULL, '2026-09-10 06:20:44'),
(90, 1, 'login', 'User logged in', NULL, '2026-09-10 06:22:42'),
(91, 7, 'login', 'User logged in', NULL, '2026-09-10 07:24:22'),
(92, 7, 'login', 'User logged in', NULL, '2026-09-10 07:34:47'),
(93, 1, 'login', 'User logged in', NULL, '2026-09-10 07:37:54'),
(94, 1, 'login', 'User logged in', NULL, '2026-09-10 07:38:12'),
(95, 7, 'login', 'User logged in', NULL, '2026-09-10 07:38:23'),
(96, 1, 'login', 'User logged in', NULL, '2026-09-10 07:38:35'),
(97, 1, 'login', 'User logged in', NULL, '2026-09-10 07:47:21'),
(98, 1, 'login', 'User logged in', NULL, '2026-09-10 07:56:59'),
(99, 1, 'login', 'User logged in', NULL, '2026-09-10 08:00:41'),
(100, 1, 'login', 'User logged in', NULL, '2026-09-10 08:01:35'),
(101, 1, 'login', 'User logged in', NULL, '2026-09-10 08:04:56'),
(102, 7, 'login', 'User logged in', NULL, '2026-09-10 08:46:20'),
(103, 1, 'login', 'User logged in', NULL, '2026-09-11 01:14:48'),
(104, 1, 'login', 'User logged in', NULL, '2026-09-11 01:43:08'),
(105, 7, 'login', 'User logged in', NULL, '2026-09-11 02:01:10'),
(106, 1, 'login', 'User logged in', NULL, '2026-09-11 02:02:21'),
(107, 1, 'login', 'User logged in', NULL, '2026-09-11 02:57:03'),
(108, 7, 'login', 'User logged in', NULL, '2026-09-12 10:17:09'),
(109, 7, 'login', 'User logged in', NULL, '2026-09-12 12:05:56'),
(110, 7, 'login', 'User logged in', NULL, '2026-09-12 12:06:32'),
(111, 7, 'login', 'User logged in', NULL, '2026-09-12 12:06:46'),
(112, 7, 'login', 'User logged in', NULL, '2026-09-12 12:07:04'),
(113, 1, 'login', 'User logged in', NULL, '2026-09-14 02:57:36'),
(114, 1, 'login', 'User logged in', NULL, '2026-09-14 03:08:21'),
(115, 1, 'login', 'User logged in', NULL, '2026-09-14 03:27:07'),
(116, 1, 'login', 'User logged in', NULL, '2026-09-14 03:29:00'),
(117, 1, 'login', 'User logged in', NULL, '2026-09-14 03:31:17'),
(118, 8, 'login', 'User logged in', NULL, '2026-09-14 03:34:24'),
(119, 11, 'login', 'User logged in', NULL, '2026-09-14 03:42:47'),
(120, 1, 'login', 'User logged in', NULL, '2026-09-14 03:43:30'),
(121, 11, 'login', 'User logged in', NULL, '2026-09-14 03:46:55'),
(122, 8, 'login', 'User logged in', NULL, '2026-09-14 03:50:27'),
(123, 11, 'login', 'User logged in', NULL, '2026-09-14 03:50:48'),
(124, 1, 'login', 'User logged in', NULL, '2026-09-14 03:52:27'),
(125, 1, 'login', 'User logged in', NULL, '2026-09-14 03:53:07'),
(126, 8, 'login', 'User logged in', NULL, '2026-09-14 03:57:35'),
(127, 8, 'login', 'User logged in', NULL, '2026-09-14 04:02:57'),
(128, 1, 'login', 'User logged in', NULL, '2026-09-14 04:06:12'),
(129, 1, 'login', 'User logged in', NULL, '2026-09-14 04:08:03'),
(130, 8, 'login', 'User logged in', NULL, '2026-09-14 04:09:35'),
(131, 1, 'login', 'User logged in', NULL, '2026-09-14 04:10:01'),
(132, 1, 'login', 'User logged in', NULL, '2026-09-14 04:10:41'),
(133, 7, 'login', 'User logged in', NULL, '2026-09-14 04:12:35'),
(134, 11, 'login', 'User logged in', NULL, '2026-09-14 04:12:53'),
(135, 11, 'login', 'User logged in', NULL, '2026-09-14 04:14:21'),
(136, 11, 'login', 'User logged in', NULL, '2026-09-14 04:14:50'),
(137, 11, 'login', 'User logged in', NULL, '2026-09-14 04:15:01'),
(138, 1, 'login', 'User logged in', NULL, '2026-09-14 04:18:13'),
(139, 11, 'login', 'User logged in', NULL, '2026-09-14 04:20:23'),
(140, 8, 'login', 'User logged in', NULL, '2026-09-14 04:20:39'),
(141, 11, 'login', 'User logged in', NULL, '2026-09-14 04:21:35'),
(142, 1, 'login', 'User logged in', NULL, '2026-09-14 04:31:27'),
(143, 1, 'login', 'User logged in', NULL, '2026-09-14 04:40:23'),
(144, 8, 'login', 'User logged in', NULL, '2026-09-14 04:45:40'),
(145, 11, 'login', 'User logged in', NULL, '2026-09-14 04:46:14'),
(146, 8, 'login', 'User logged in', NULL, '2026-09-14 04:47:03'),
(147, 11, 'login', 'User logged in', NULL, '2026-09-14 04:55:51'),
(148, 11, 'login', 'User logged in', NULL, '2026-09-14 05:07:51'),
(149, 1, 'login', 'User logged in', NULL, '2026-09-14 05:34:58'),
(150, 8, 'login', 'User logged in', NULL, '2026-09-14 05:35:29'),
(151, 1, 'login', 'User logged in', NULL, '2026-09-14 05:35:48'),
(152, 11, 'login', 'User logged in', NULL, '2026-09-14 05:40:20'),
(153, 8, 'login', 'User logged in', NULL, '2026-09-14 05:42:31'),
(154, 1, 'login', 'User logged in', NULL, '2026-09-14 05:42:46'),
(155, 8, 'login', 'User logged in', NULL, '2026-09-14 05:43:19'),
(156, 1, 'login', 'User logged in', NULL, '2026-09-14 05:43:33'),
(157, 8, 'login', 'User logged in', NULL, '2026-09-14 05:43:58'),
(158, 11, 'login', 'User logged in', NULL, '2026-09-14 05:44:20'),
(159, 1, 'login', 'User logged in', NULL, '2026-09-14 05:44:34'),
(160, 8, 'login', 'User logged in', NULL, '2026-09-14 05:45:03'),
(161, 11, 'login', 'User logged in', NULL, '2026-09-14 05:53:00'),
(162, 11, 'login', 'User logged in', NULL, '2026-09-14 05:57:50'),
(163, 1, 'login', 'User logged in', NULL, '2026-09-14 05:58:21'),
(164, 11, 'login', 'User logged in', NULL, '2026-09-14 06:13:33'),
(165, 11, 'login', 'User logged in', NULL, '2026-09-14 06:13:44'),
(166, 11, 'login', 'User logged in', NULL, '2026-09-14 06:21:27'),
(167, 1, 'login', 'User logged in', NULL, '2026-09-14 06:28:18'),
(168, 11, 'login', 'User logged in', NULL, '2026-09-14 07:05:00'),
(169, 8, 'login', 'User logged in', NULL, '2026-09-14 07:08:45'),
(170, 11, 'login', 'User logged in', NULL, '2026-09-14 07:09:47'),
(171, 8, 'login', 'User logged in', NULL, '2026-09-14 07:12:09'),
(172, 11, 'login', 'User logged in', NULL, '2026-09-14 07:15:36'),
(173, 1, 'login', 'User logged in', NULL, '2026-09-14 09:47:06'),
(174, 8, 'login', 'User logged in', NULL, '2026-09-14 10:00:05'),
(175, 11, 'login', 'User logged in', NULL, '2026-09-14 10:00:33'),
(176, 1, 'login', 'User logged in', NULL, '2026-09-14 11:45:24'),
(177, 8, 'login', 'User logged in', NULL, '2026-09-15 02:37:44'),
(178, 8, 'login', 'User logged in', NULL, '2026-09-15 02:56:37'),
(179, 11, 'login', 'User logged in', NULL, '2026-09-15 03:09:10'),
(180, 8, 'login', 'User logged in', NULL, '2026-09-15 04:56:39'),
(181, 8, 'login', 'User logged in', NULL, '2026-09-15 04:57:35'),
(182, 11, 'login', 'User logged in', NULL, '2026-09-15 04:59:09'),
(183, 1, 'login', 'User logged in', NULL, '2026-09-15 05:30:35'),
(184, 8, 'login', 'User logged in', NULL, '2026-09-15 05:35:41'),
(185, 8, 'login', 'User logged in', NULL, '2026-09-15 06:04:55'),
(186, 8, 'upload', 'Upload dokumen: Uji Coba', NULL, '2026-09-15 06:20:29'),
(187, 8, 'login', 'User logged in', NULL, '2026-09-15 09:36:58'),
(188, 1, 'login', 'User logged in', NULL, '2026-09-15 10:07:34'),
(189, 1, 'login', 'User logged in', NULL, '2026-09-16 03:11:57'),
(190, 11, 'login', 'User logged in', NULL, '2026-09-16 03:12:22'),
(191, 1, 'login', 'User logged in', NULL, '2026-09-16 03:14:02'),
(192, 11, 'login', 'User logged in', NULL, '2026-09-16 03:23:42'),
(193, 1, 'login', 'User logged in', NULL, '2026-09-16 03:23:54'),
(194, 11, 'login', 'User logged in', NULL, '2026-09-16 03:25:42'),
(195, 11, 'login', 'User logged in', NULL, '2026-09-16 03:30:14'),
(196, 1, 'login', 'User logged in', NULL, '2026-09-16 03:30:52'),
(197, 11, 'login', 'User logged in', NULL, '2026-09-16 03:45:08'),
(198, 1, 'login', 'User logged in', NULL, '2026-09-16 07:46:23'),
(199, 8, 'login', 'User logged in', NULL, '2026-09-16 08:03:30'),
(200, 8, 'login', 'User logged in', NULL, '2026-09-16 08:08:21'),
(201, 11, 'login', 'User logged in', NULL, '2026-09-16 08:08:53'),
(202, 1, 'login', 'User logged in', NULL, '2026-09-16 11:37:31'),
(203, NULL, 'login', 'User logged in', NULL, '2026-09-16 11:38:07'),
(204, 1, 'login', 'User logged in', NULL, '2026-09-16 11:56:14'),
(205, 1, 'login', 'User logged in', NULL, '2026-09-16 11:56:36'),
(206, 11, 'login', 'User logged in', NULL, '2026-09-17 02:38:38'),
(207, 11, 'login', 'User logged in', NULL, '2026-09-17 03:11:25'),
(208, 11, 'login', 'User logged in', NULL, '2026-09-17 03:12:18'),
(209, 11, 'login', 'User logged in', NULL, '2026-09-17 03:13:50'),
(210, 1, 'login', 'User logged in', NULL, '2026-09-17 03:14:08'),
(211, 1, 'login', 'User logged in', NULL, '2026-09-17 03:18:56'),
(212, 8, 'login', 'User logged in', NULL, '2026-09-17 04:58:42'),
(213, 1, 'login', 'User logged in', NULL, '2026-09-17 04:59:10'),
(214, 11, 'login', 'User logged in', NULL, '2026-09-17 04:59:13'),
(215, 11, 'login', 'User logged in', NULL, '2026-09-17 07:41:02'),
(216, 11, 'login', 'User logged in', NULL, '2026-09-17 08:02:43'),
(217, 11, 'login', 'User logged in', NULL, '2026-09-17 08:05:09'),
(218, 11, 'login', 'User logged in', NULL, '2026-09-17 08:07:32'),
(219, 11, 'login', 'User logged in', NULL, '2026-09-17 08:07:56'),
(220, 11, 'login', 'User logged in', NULL, '2026-09-17 08:09:54'),
(221, 1, 'login', 'User logged in', NULL, '2026-09-17 08:12:27'),
(222, 8, 'login', 'User logged in', NULL, '2026-09-17 08:16:24'),
(223, 11, 'login', 'User logged in', NULL, '2026-09-17 08:16:47'),
(224, 8, 'login', 'User logged in', NULL, '2026-09-17 08:32:06'),
(225, 8, 'delete', 'Hapus dokumen: Uji Coba', NULL, '2026-09-17 08:32:50'),
(226, 8, 'login', 'User logged in', NULL, '2026-09-17 08:39:33'),
(227, 11, 'login', 'User logged in', NULL, '2026-09-17 08:39:51'),
(228, 8, 'login', 'User logged in', NULL, '2026-09-17 09:01:18'),
(229, 8, 'login', 'User logged in', NULL, '2026-09-17 09:01:28'),
(230, 1, 'login', 'User logged in', NULL, '2026-09-17 09:54:02'),
(231, 8, 'login', 'User logged in', NULL, '2026-09-17 09:57:39'),
(232, 11, 'login', 'User logged in', NULL, '2026-09-17 10:34:50'),
(233, 8, 'login', 'User logged in', NULL, '2026-09-17 11:11:10'),
(234, 8, 'login', 'User logged in', NULL, '2026-09-17 11:58:42'),
(235, 1, 'login', 'User logged in', NULL, '2026-09-17 12:08:05'),
(240, 1, 'create_nota_dinas', 'Membuat Nota Dinas #ND/001/09/2026', NULL, '2026-09-17 12:13:03'),
(241, 1, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/001/09/2026', NULL, '2026-09-17 12:39:46'),
(242, 1, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/001/09/2026', NULL, '2026-09-17 12:39:48'),
(243, 1, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/001/09/2026', NULL, '2026-09-17 12:39:51'),
(244, 1, 'create_nota_dinas', 'Membuat Nota Dinas #ND/002/09/2026', NULL, '2026-09-17 12:58:36'),
(245, 11, 'login', 'User logged in', NULL, '2026-09-18 01:59:54'),
(246, 11, 'login', 'User logged in', NULL, '2026-09-18 02:23:27'),
(247, 8, 'login', 'User logged in', NULL, '2026-09-18 05:10:40'),
(248, 11, 'login', 'User logged in', NULL, '2026-09-18 05:11:32'),
(249, 8, 'login', 'User logged in', NULL, '2026-09-18 05:11:56'),
(250, 8, 'process_nota_dinas', 'Memproses Nota Dinas #6', NULL, '2026-09-18 05:14:01'),
(251, 8, 'complete_nota_dinas', 'Menyelesaikan Nota Dinas #6', NULL, '2026-09-18 05:14:04'),
(252, 8, 'process_nota_dinas', 'Memproses Nota Dinas #3', NULL, '2026-09-18 05:14:24'),
(253, 8, 'complete_nota_dinas', 'Menyelesaikan Nota Dinas #3', NULL, '2026-09-18 05:14:25'),
(254, 8, 'process_nota_dinas', 'Memproses Nota Dinas #1', NULL, '2026-09-18 05:14:40'),
(255, 8, 'complete_nota_dinas', 'Menyelesaikan Nota Dinas #1', NULL, '2026-09-18 05:14:41'),
(256, 8, 'create_nota_dinas', 'Membuat Nota Dinas #011111', NULL, '2026-09-18 05:15:10'),
(257, 11, 'login', 'User logged in', NULL, '2026-09-18 05:16:11'),
(258, 8, 'create_nota_dinas', 'Membuat Nota Dinas #00888', NULL, '2026-09-18 05:20:44'),
(259, 8, 'upload', 'Upload dokumen baru untuk disposisi', NULL, '2026-09-18 05:22:27'),
(260, 8, 'create_disposition', 'Membuat disposisi dokumen #12', NULL, '2026-09-18 05:22:27'),
(261, 8, 'create_disposition', 'Membuat disposisi dokumen #12', NULL, '2026-09-18 05:27:02'),
(262, 8, 'upload', 'Upload dokumen: tess', NULL, '2026-09-18 05:29:29'),
(263, 8, 'generate_mini_certificate', 'Membuat/mengunduh mini certificate dokumen LJU/2026/09/A80016', NULL, '2026-09-18 05:30:01'),
(264, 11, 'login', 'User logged in', NULL, '2026-09-18 06:16:39'),
(265, 1, 'login', 'User logged in', NULL, '2026-09-18 06:32:27'),
(266, 8, 'login', 'User logged in', NULL, '2026-09-18 06:32:48'),
(267, 11, 'login', 'User logged in', NULL, '2026-09-18 06:58:52'),
(268, 11, 'login', 'User logged in', NULL, '2026-09-18 06:59:34'),
(269, 8, 'login', 'User logged in', NULL, '2026-09-18 07:04:19'),
(270, 11, 'login', 'User logged in', NULL, '2026-09-18 07:04:57'),
(271, 1, 'login', 'User logged in', NULL, '2026-09-18 08:12:24'),
(272, 7, 'login', 'User logged in', NULL, '2026-09-18 08:13:05'),
(273, 7, 'login', 'User logged in', NULL, '2026-09-18 11:37:54'),
(274, 7, 'accept_disposition', 'Disposisi #3: accept', NULL, '2026-09-18 11:38:38'),
(275, 1, 'login', 'User logged in', NULL, '2026-09-18 11:43:58'),
(276, 1, 'login', 'User logged in', NULL, '2026-09-18 11:45:00'),
(277, 8, 'login', 'User logged in', NULL, '2026-09-18 11:53:50'),
(278, 7, 'login', 'User logged in', NULL, '2026-09-18 22:07:52'),
(279, 8, 'login', 'User logged in', NULL, '2026-09-18 22:08:13'),
(280, 8, 'upload', 'Upload dokumen: coba2', NULL, '2026-09-18 22:09:16'),
(281, 8, 'create_disposition', 'Membuat disposisi dokumen #14', NULL, '2026-09-18 22:09:38'),
(282, 8, 'create_nota_dinas', 'Membuat Nota Dinas #ND/003/09/2026', NULL, '2026-09-18 22:11:23'),
(283, 7, 'accept_disposition', 'Disposisi #4: accept', NULL, '2026-09-18 22:12:55'),
(284, 8, 'upload', 'Upload dokumen: coba3', NULL, '2026-09-18 22:14:06'),
(285, 7, 'generate_mini_certificate', 'Membuat/mengunduh mini certificate dokumen LJU/2026/09/990825', NULL, '2026-09-18 22:14:50'),
(286, 8, 'delete', 'Hapus dokumen: coba3', NULL, '2026-09-18 22:22:54'),
(287, 8, 'delete', 'Hapus dokumen: coba2', NULL, '2026-09-18 22:22:59'),
(288, 8, 'upload', 'Upload dokumen: coba3', NULL, '2026-09-18 22:23:31'),
(289, 7, 'generate_mini_certificate', 'Membuat/mengunduh mini certificate dokumen LJU/2026/09/C70744', NULL, '2026-09-18 22:23:57'),
(290, 8, 'create_disposition', 'Membuat disposisi dokumen #16', NULL, '2026-09-18 22:25:15'),
(291, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/011/09/2026', NULL, '2026-09-18 22:59:34'),
(292, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/011/09/2026', NULL, '2026-09-18 22:59:36'),
(293, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/003/09/2026', NULL, '2026-09-18 22:59:37'),
(294, 7, 'login', 'User logged in', NULL, '2026-09-18 22:59:55'),
(295, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/011/09/2026', NULL, '2026-09-18 23:01:27'),
(296, 8, 'create_nota_dinas', 'Membuat Nota Dinas #ND/021/09/2026', NULL, '2026-09-18 23:01:44'),
(297, 8, 'create_nota_dinas', 'Membuat Nota Dinas #ND/031/09/2026', NULL, '2026-09-18 23:03:56'),
(298, 7, 'process_nota_dinas', 'Memproses Nota Dinas #13', NULL, '2026-09-18 23:26:19'),
(299, 8, 'login', 'User logged in', NULL, '2026-09-19 08:41:48'),
(300, 8, 'login', 'User logged in', NULL, '2026-09-20 04:15:32'),
(301, 8, 'login', 'User logged in', NULL, '2026-09-20 04:17:00'),
(302, 1, 'login', 'User logged in', NULL, '2026-09-20 07:05:58'),
(303, 1, 'return_disposition', 'Disposisi #2: return', NULL, '2026-09-20 07:12:28'),
(304, 1, 'login', 'User logged in', NULL, '2026-09-20 08:01:35'),
(305, 1, 'upload', 'Upload dokumen baru untuk disposisi', NULL, '2026-09-20 08:01:53'),
(306, 1, 'create_disposition', 'Membuat disposisi dokumen #17', NULL, '2026-09-20 08:01:53'),
(307, 7, 'login', 'User logged in', NULL, '2026-09-20 08:02:01'),
(308, 1, 'login', 'User logged in', NULL, '2026-09-20 09:45:24'),
(309, 14, 'login', 'User logged in', NULL, '2026-09-20 09:56:08'),
(310, 1, 'login', 'User logged in', NULL, '2026-09-20 09:56:27'),
(311, 1, 'upload', 'Upload dokumen baru untuk disposisi', NULL, '2026-09-20 09:56:44'),
(312, 1, 'create_disposition', 'Membuat disposisi dokumen #18 dengan tembusan arsip', NULL, '2026-09-20 09:56:45'),
(313, 14, 'login', 'User logged in', NULL, '2026-09-20 09:57:04'),
(314, 1, 'login', 'User logged in', NULL, '2026-09-20 10:28:06'),
(315, 1, 'login', 'User logged in', NULL, '2026-09-20 10:29:34'),
(316, 7, 'login', 'User logged in', NULL, '2026-09-20 10:40:10'),
(317, 7, 'login', 'User logged in', NULL, '2026-09-20 11:21:23'),
(318, 7, 'complete_disposition', 'Disposisi #7: complete', NULL, '2026-09-20 11:21:30'),
(319, 7, 'complete_disposition', 'Disposisi #5: complete', NULL, '2026-09-20 11:21:34'),
(320, 7, 'complete_nota_dinas', 'Menyelesaikan Nota Dinas #14', NULL, '2026-09-20 11:21:40'),
(321, 1, 'login', 'User logged in', NULL, '2026-09-20 11:22:00'),
(322, 1, 'delete_disposition', 'Menghapus Disposisi #9', NULL, '2026-09-20 11:22:09'),
(323, 1, 'delete_disposition', 'Menghapus Disposisi #8', NULL, '2026-09-20 11:22:11'),
(324, 1, 'delete_disposition', 'Menghapus Disposisi #7', NULL, '2026-09-20 11:22:12'),
(325, 1, 'delete_disposition', 'Menghapus Disposisi #6', NULL, '2026-09-20 11:22:13'),
(326, 1, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/002/09/2026', NULL, '2026-09-20 11:22:22'),
(327, 1, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/001/09/2026', NULL, '2026-09-20 11:22:24'),
(328, 1, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/001/09/2026', NULL, '2026-09-20 11:22:25'),
(329, 1, 'complete_nota_dinas', 'Menyelesaikan Nota Dinas #8', NULL, '2026-09-20 11:22:30'),
(330, 1, 'complete_nota_dinas', 'Menyelesaikan Nota Dinas #7', NULL, '2026-09-20 11:22:35'),
(331, 8, 'login', 'User logged in', NULL, '2026-09-20 11:23:01'),
(332, 8, 'delete_disposition', 'Menghapus Disposisi #5', NULL, '2026-09-20 11:23:09'),
(333, 8, 'delete_disposition', 'Menghapus Disposisi #3', NULL, '2026-09-20 11:23:11'),
(334, 8, 'delete_disposition', 'Menghapus Disposisi #2', NULL, '2026-09-20 11:23:12'),
(335, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/031/09/2026', NULL, '2026-09-20 11:23:15'),
(336, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/021/09/2026', NULL, '2026-09-20 11:23:16'),
(337, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #00888', NULL, '2026-09-20 11:23:17'),
(338, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #011111', NULL, '2026-09-20 11:23:19'),
(339, 8, 'delete', 'Hapus dokumen: coba3', NULL, '2026-09-20 11:23:23'),
(340, 8, 'delete', 'Hapus dokumen: tess', NULL, '2026-09-20 11:23:24'),
(341, 8, 'delete', 'Hapus dokumen: tes', NULL, '2026-09-20 11:23:25'),
(342, 7, 'login', 'User logged in', NULL, '2026-09-20 11:23:37'),
(343, 7, 'upload', 'Upload dokumen: Surat Penawaran', NULL, '2026-09-20 11:26:26'),
(344, 7, 'generate_mini_certificate', 'Membuat/mengunduh mini certificate dokumen LJU/2026/09/1602D0', NULL, '2026-09-20 11:28:48'),
(345, 7, 'upload', 'Upload dokumen baru untuk disposisi', NULL, '2026-09-20 11:29:51'),
(346, 7, 'create_disposition', 'Membuat disposisi dokumen #20', NULL, '2026-09-20 11:29:51'),
(347, 7, 'create_nota_dinas', 'Membuat Nota Dinas #ND/002/09/2026', NULL, '2026-09-20 11:31:07'),
(348, 8, 'login', 'User logged in', NULL, '2026-09-20 11:31:24'),
(349, 8, 'complete_disposition', 'Disposisi #10: complete', NULL, '2026-09-20 11:32:40'),
(350, 7, 'login', 'User logged in', NULL, '2026-09-20 11:37:59'),
(351, 7, 'delete_disposition', 'Menghapus Disposisi #10', NULL, '2026-09-20 11:38:05'),
(352, 7, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/002/09/2026', NULL, '2026-09-20 11:38:11'),
(353, 7, 'login', 'User logged in', NULL, '2026-09-21 02:02:20'),
(354, 7, 'create_nota_dinas', 'Membuat Nota Dinas #ND/002/09/2026', NULL, '2026-09-21 02:02:59'),
(355, 7, 'delete', 'Hapus dokumen: Disposisi Baru', NULL, '2026-09-21 02:04:49'),
(356, 7, 'delete', 'Hapus dokumen: Surat Penawaran', NULL, '2026-09-21 02:04:52'),
(357, 7, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/002/09/2026', NULL, '2026-09-21 02:05:03'),
(358, 11, 'login', 'User logged in', NULL, '2026-09-21 02:07:17'),
(359, 7, 'create_nota_dinas', 'Membuat Nota Dinas #ND/002/09/2026', NULL, '2026-09-21 02:18:29'),
(360, 7, 'create_disposition', 'Membuat disposisi dokumen #18', NULL, '2026-09-21 02:19:17'),
(361, 11, 'login', 'User logged in', NULL, '2026-09-21 02:46:46'),
(362, 11, 'login', 'User logged in', NULL, '2026-09-21 02:48:20'),
(363, 7, 'delete_disposition', 'Menghapus Disposisi #11', NULL, '2026-09-21 02:49:10'),
(364, 7, 'delete_nota_dinas', 'Menghapus Nota Dinas #ND/002/09/2026', NULL, '2026-09-21 02:49:17'),
(365, 8, 'login', 'User logged in', NULL, '2026-09-21 03:09:44'),
(366, 8, 'create_nota_dinas', 'Membuat Nota Dinas #011111', NULL, '2026-09-21 03:10:11'),
(367, 8, 'delete_nota_dinas', 'Menghapus Nota Dinas #011111', NULL, '2026-09-21 03:11:01'),
(368, 1, 'login', 'User logged in', NULL, '2026-09-21 03:34:25'),
(369, 15, 'login', 'User logged in', NULL, '2026-09-21 03:36:20'),
(370, 1, 'login', 'User logged in', NULL, '2026-09-21 03:39:06'),
(371, 16, 'login', 'User logged in', NULL, '2026-09-21 03:57:21'),
(372, 15, 'login', 'User logged in', NULL, '2026-09-21 03:57:35'),
(373, 1, 'login', 'User logged in', NULL, '2026-09-21 03:58:20'),
(374, 11, 'login', 'User logged in', NULL, '2026-09-21 04:02:31'),
(375, 7, 'login', 'User logged in', NULL, '2026-09-21 04:22:18'),
(376, 7, 'create_surat_keluar', 'Membuat Draft Surat Keluar #123/INF/LJU/09/2026', NULL, '2026-09-21 04:39:30'),
(377, 8, 'login', 'User logged in', NULL, '2026-09-21 04:40:23'),
(378, 7, 'login', 'User logged in', NULL, '2026-09-21 04:55:24'),
(379, 1, 'login', 'User logged in', NULL, '2026-09-21 04:55:36'),
(380, 7, 'login', 'User logged in', NULL, '2026-09-21 04:56:08'),
(381, 8, 'login', 'User logged in', NULL, '2026-09-21 05:23:33'),
(382, 8, 'sign_surat_keluar', 'Menandatangani Surat Keluar #123/INF/LJU/09/2026', NULL, '2026-09-21 05:23:58'),
(383, 8, 'upload', 'Upload dokumen: coba', NULL, '2026-09-21 05:38:23'),
(384, 8, 'generate_mini_certificate', 'Membuat/mengunduh mini certificate dokumen LJU/2026/09/5E7A8E', NULL, '2026-09-21 05:38:37'),
(385, 8, 'delete', 'Hapus dokumen: coba', NULL, '2026-09-21 05:38:53'),
(386, 8, 'login', 'User logged in', NULL, '2026-09-21 06:52:43'),
(387, 8, 'delete_surat_keluar', 'Menghapus Surat Keluar #123/INF/LJU/09/2026', NULL, '2026-09-21 07:16:53'),
(388, 11, 'login', 'User logged in', NULL, '2026-09-21 07:17:33'),
(389, 1, 'login', 'User logged in', NULL, '2026-09-21 07:21:45'),
(390, 11, 'login', 'User logged in', NULL, '2026-09-21 07:21:46'),
(391, 11, 'login', 'User logged in', NULL, '2026-09-21 07:21:54'),
(392, 11, 'login', 'User logged in', NULL, '2026-09-21 07:22:03'),
(393, 11, 'login', 'User logged in', NULL, '2026-09-21 07:22:25'),
(394, 11, 'login', 'User logged in', NULL, '2026-09-21 07:22:40'),
(395, 8, 'login', 'User logged in', NULL, '2026-09-22 02:06:35'),
(396, 11, 'login', 'User logged in', NULL, '2026-09-22 02:34:44'),
(397, 17, 'login', 'User logged in', NULL, '2026-09-22 03:06:59'),
(398, 17, 'login', 'User logged in', NULL, '2026-09-22 03:07:55'),
(399, 11, 'login', 'User logged in', NULL, '2026-09-22 03:15:20'),
(400, 8, 'login', 'User logged in', NULL, '2026-09-22 03:27:57'),
(401, 17, 'login', 'User logged in', NULL, '2026-09-22 03:30:14'),
(402, 18, 'login', 'User logged in', NULL, '2026-09-22 03:31:30'),
(403, 22, 'login', 'User logged in', NULL, '2026-09-22 03:31:46'),
(404, 20, 'login', 'User logged in', NULL, '2026-09-22 03:32:26'),
(405, 11, 'login', 'User logged in', NULL, '2026-09-22 03:32:38'),
(406, 24, 'login', 'User logged in', NULL, '2026-09-22 03:32:49'),
(407, 21, 'login', 'User logged in', NULL, '2026-09-22 03:33:17'),
(408, 22, 'login', 'User logged in', NULL, '2026-09-22 03:34:26'),
(409, 23, 'login', 'User logged in', NULL, '2026-09-22 03:36:50'),
(410, 8, 'login', 'User logged in', NULL, '2026-09-22 03:38:20'),
(411, 21, 'login', 'User logged in', NULL, '2026-09-22 03:39:43'),
(412, 11, 'login', 'User logged in', NULL, '2026-09-22 03:41:51'),
(413, 21, 'login', 'User logged in', NULL, '2026-09-22 03:47:58'),
(414, 31, 'login', 'User logged in', NULL, '2026-09-22 03:50:23'),
(415, 8, 'login', 'User logged in', NULL, '2026-09-22 03:52:54'),
(416, 8, 'upload', 'Upload dokumen: coba surat masuk', NULL, '2026-09-22 03:55:52'),
(417, 16, 'login', 'User logged in', NULL, '2026-09-22 03:56:19'),
(418, 22, 'login', 'User logged in', NULL, '2026-09-22 03:56:35'),
(419, 8, 'login', 'User logged in', NULL, '2026-09-22 03:56:43'),
(420, 7, 'login', 'User logged in', NULL, '2026-09-22 03:59:10'),
(421, 7, 'create_disposition', 'Membuat disposisi dokumen #22', NULL, '2026-09-22 04:00:05'),
(422, 8, 'login', 'User logged in', NULL, '2026-09-22 04:01:10'),
(423, 8, 'complete_disposition', 'Disposisi #12: complete', NULL, '2026-09-22 04:04:21'),
(424, 8, 'create_nota_dinas', 'Membuat Nota Dinas #123/nd/lju/2026', NULL, '2026-09-22 04:13:39'),
(425, 8, 'login', 'User logged in', NULL, '2026-09-22 06:08:16'),
(426, 8, 'create_disposition', 'Membuat disposisi dokumen #22', NULL, '2026-09-22 06:10:34'),
(427, 7, 'login', 'User logged in', NULL, '2026-09-22 06:10:47'),
(428, 26, 'login', 'User logged in', NULL, '2026-09-22 06:15:17'),
(429, 7, 'complete_disposition', 'Disposisi #13: complete', NULL, '2026-09-22 06:16:15'),
(430, 7, 'complete_nota_dinas', 'Menyelesaikan Nota Dinas #19', NULL, '2026-09-22 06:16:32'),
(431, 8, 'login', 'User logged in', NULL, '2026-09-22 06:16:56'),
(432, 23, 'login', 'User logged in', NULL, '2026-09-22 06:17:14'),
(433, 22, 'login', 'User logged in', NULL, '2026-09-22 06:17:44'),
(434, 7, 'login', 'User logged in', NULL, '2026-09-22 06:40:58'),
(435, 7, 'create_surat_keluar', 'Membuat Draft Surat Keluar #001/nfoko/lju/2006', NULL, '2026-09-22 06:41:48'),
(436, 8, 'login', 'User logged in', NULL, '2026-09-22 06:42:03'),
(437, 8, 'sign_surat_keluar', 'Menandatangani Surat Keluar #001/nfoko/lju/2006', NULL, '2026-09-22 06:42:34'),
(438, 1, 'login', 'User logged in', NULL, '2026-09-22 07:03:56'),
(439, 8, 'login', 'User logged in', NULL, '2026-09-22 07:41:40'),
(440, 8, 'login', 'User logged in', NULL, '2026-09-22 07:43:34'),
(441, 8, 'create_nota_dinas', 'Membuat Nota Dinas #000111', NULL, '2026-09-22 08:16:04'),
(442, 8, 'login', 'User logged in', NULL, '2026-09-22 08:17:00'),
(443, 8, 'create_disposition', 'Membuat disposisi dokumen #22 dengan tembusan arsip', NULL, '2026-09-22 08:36:11'),
(444, 14, 'login', 'User logged in', NULL, '2026-09-22 08:36:52'),
(445, 8, 'login', 'User logged in', NULL, '2026-09-22 08:40:02'),
(446, 19, 'login', 'User logged in', NULL, '2026-09-22 08:41:21'),
(447, 8, 'login', 'User logged in', NULL, '2026-09-22 09:27:54'),
(448, 11, 'login', 'User logged in', NULL, '2026-09-22 13:05:00'),
(449, 26, 'login', 'User logged in', NULL, '2026-09-23 01:21:01'),
(450, 22, 'login', 'User logged in', NULL, '2026-09-23 01:27:25'),
(451, 24, 'login', 'User logged in', NULL, '2026-09-23 01:30:34'),
(452, 22, 'upload', 'Upload dokumen: Surat Permohonan Koordinasi dan Pendampingan untuk Kades Sumber Jaya, Jati Agung', 23, '2026-09-23 01:33:09'),
(453, 22, 'upload', 'Upload dokumen: Surat Permohonan Koordinasi dan Pendampingan untuk Polsek Jati Agung', 24, '2026-09-23 01:35:31'),
(454, 24, 'login', 'User logged in', NULL, '2026-09-23 01:55:00'),
(455, 26, 'login', 'User logged in', NULL, '2026-09-23 02:08:30'),
(456, 8, 'login', 'User logged in', NULL, '2026-09-23 02:10:21'),
(457, 23, 'login', 'User logged in', NULL, '2026-09-23 02:14:42'),
(458, 28, 'login', 'User logged in', NULL, '2026-09-23 02:19:02'),
(459, 24, 'login', 'User logged in', NULL, '2026-09-23 02:19:15'),
(460, 15, 'login', 'User logged in', NULL, '2026-09-23 02:19:45'),
(461, 16, 'login', 'User logged in', NULL, '2026-09-23 02:20:10'),
(462, 17, 'login', 'User logged in', NULL, '2026-09-23 02:20:40'),
(463, 18, 'login', 'User logged in', NULL, '2026-09-23 02:20:58'),
(464, 19, 'login', 'User logged in', NULL, '2026-09-23 02:21:14'),
(465, 20, 'login', 'User logged in', NULL, '2026-09-23 02:21:30'),
(466, 21, 'login', 'User logged in', NULL, '2026-09-23 02:21:50'),
(467, 25, 'login', 'User logged in', NULL, '2026-09-23 02:22:07'),
(468, 26, 'login', 'User logged in', NULL, '2026-09-23 02:22:22'),
(469, 11, 'login', 'User logged in', NULL, '2026-09-23 02:22:51'),
(470, 14, 'login', 'User logged in', NULL, '2026-09-23 02:23:11'),
(471, 29, 'login', 'User logged in', NULL, '2026-09-23 02:23:26'),
(472, 30, 'login', 'User logged in', NULL, '2026-09-23 02:23:37'),
(473, 31, 'login', 'User logged in', NULL, '2026-09-23 02:23:52'),
(474, 32, 'login', 'User logged in', NULL, '2026-09-23 02:24:06'),
(475, 1, 'login', 'User logged in', NULL, '2026-09-23 02:27:04'),
(476, 33, 'login', 'User logged in', NULL, '2026-09-23 02:31:01'),
(477, 33, 'login', 'User logged in', NULL, '2026-09-23 02:32:28'),
(478, 16, 'login', 'User logged in', NULL, '2026-09-23 02:51:01'),
(479, 16, 'login', 'User logged in', NULL, '2026-09-23 02:51:43'),
(480, 16, 'login', 'User logged in', NULL, '2026-09-23 02:55:35'),
(481, 7, 'login', 'User logged in', NULL, '2026-09-23 03:24:20'),
(482, 7, 'login', 'User logged in', NULL, '2026-09-23 03:25:01'),
(483, 7, 'login', 'User logged in', NULL, '2026-09-23 03:29:37'),
(484, 7, 'upload', 'Upload dokumen: coba surat masuk', NULL, '2026-09-23 03:51:56'),
(485, 7, 'create_disposition', 'Membuat disposisi dokumen #25', NULL, '2026-09-23 04:03:33'),
(486, 7, 'delete', 'Hapus dokumen: coba surat masuk', NULL, '2026-09-23 04:11:17'),
(487, 7, 'upload', 'Upload dokumen: coba surat masuk', NULL, '2026-09-23 04:12:08'),
(488, 7, 'create_disposition', 'Membuat disposisi dokumen #26', NULL, '2026-09-23 04:21:42'),
(489, 8, 'login', 'User logged in', NULL, '2026-09-23 05:27:20'),
(490, 8, 'return_disposition', 'Disposisi #17: return', NULL, '2026-09-23 05:28:02'),
(491, 11, 'login', 'User logged in', NULL, '2026-09-23 05:29:02'),
(492, 8, 'login', 'User logged in', NULL, '2026-09-23 05:31:55'),
(493, 23, 'login', 'User logged in', NULL, '2026-09-23 05:32:40'),
(494, 23, 'login', 'User logged in', NULL, '2026-09-23 05:39:27'),
(495, 21, 'login', 'User logged in', NULL, '2026-09-23 05:41:56'),
(496, 21, 'login', 'User logged in', NULL, '2026-09-23 05:43:14'),
(497, 7, 'login', 'User logged in', NULL, '2026-09-23 06:19:35'),
(498, 7, 'create_surat_keluar', 'Membuat Draft Surat Keluar #coba/2026', NULL, '2026-09-23 06:20:32'),
(499, 8, 'login', 'User logged in', NULL, '2026-09-23 06:39:44'),
(500, 8, 'login', 'User logged in', NULL, '2026-09-23 06:41:09'),
(501, 14, 'login', 'User logged in', NULL, '2026-09-23 06:52:55'),
(502, 32, 'login', 'User logged in', NULL, '2026-09-23 06:56:45'),
(503, 1, 'login', 'User logged in', NULL, '2026-09-23 07:09:28'),
(504, NULL, 'login', 'User logged in', NULL, '2026-09-23 07:10:18'),
(505, 34, 'login', 'User logged in', NULL, '2026-09-23 07:10:34'),
(506, 1, 'login', 'User logged in', NULL, '2026-09-23 07:10:41'),
(507, 34, 'login', 'User logged in', NULL, '2026-09-23 07:11:01'),
(508, 34, 'login', 'User logged in', NULL, '2026-09-23 07:11:35'),
(509, 14, 'login', 'User logged in', NULL, '2026-09-23 07:43:02'),
(510, 14, 'login', 'User logged in', NULL, '2026-09-23 07:45:31'),
(511, 14, 'accept_disposition', 'Disposisi #15: accept', NULL, '2026-09-23 07:49:54'),
(512, 32, 'login', 'User logged in', NULL, '2026-09-23 07:51:44'),
(513, 14, 'login', 'User logged in', NULL, '2026-09-23 08:08:09'),
(514, 1, 'login', 'User logged in', NULL, '2026-09-23 08:19:22'),
(515, 1, 'create_disposition', 'Membuat disposisi dokumen #26', NULL, '2026-09-23 08:19:36'),
(516, 1, 'login', 'User logged in', NULL, '2026-09-23 12:37:04'),
(517, 1, 'login', 'User logged in', NULL, '2026-09-23 12:39:20'),
(518, 32, 'login', 'User logged in', NULL, '2026-09-24 02:48:57'),
(519, 23, 'login', 'User logged in', NULL, '2026-09-24 05:43:13'),
(520, 7, 'login', 'User logged in', NULL, '2026-09-25 03:36:34'),
(521, 1, 'login', 'User logged in', NULL, '2026-09-25 08:55:26'),
(522, 1, 'login', 'User logged in', NULL, '2026-09-25 09:02:34'),
(523, 1, 'login', 'User logged in', NULL, '2026-09-25 09:10:13'),
(524, 1, 'login', 'User logged in', NULL, '2026-09-25 09:12:59'),
(525, 7, 'login', 'User logged in', NULL, '2026-09-25 09:13:19'),
(526, 1, 'create_surat_tugas', 'Membuat Draft Surat Tugas #006/LJU-DU/ST/X/2026', NULL, '2026-09-26 10:36:54'),
(527, 1, 'update_surat_tugas', 'Mengubah Surat Tugas #006/LJU-DU/ST/X/2026', NULL, '2026-09-26 10:58:50'),
(528, 15, 'sign_surat_tugas', 'Menandatangani Surat Tugas #006/LJU-DU/ST/X/2026 secara Manual (Basah)', NULL, '2026-09-26 11:32:13'),
(529, 1, 'create_surat_keluar', 'Membuat Draft Surat Keluar #123/INF/LJU/IX/2026', NULL, '2026-09-27 04:01:40'),
(530, 7, 'sign_surat_keluar', 'Menandatangani Surat Keluar #123/INF/LJU/IX/2026 secara Manual (Basah)', NULL, '2026-09-27 04:05:13'),
(531, 7, 'delete_surat_keluar', 'Menghapus Surat Keluar #123/INF/LJU/IX/2026', NULL, '2026-09-27 04:06:32'),
(532, 7, 'sign_surat_keluar', 'Menandatangani Surat Keluar #coba/2026 secara Manual (Basah)', NULL, '2026-09-27 04:11:15'),
(533, 1, 'create_surat_keluar', 'Membuat Draft Surat Keluar #006/LJU-DU/ST/X/2026', NULL, '2026-09-27 05:20:36'),
(534, 7, 'create_surat_keluar', 'Membuat Draft Surat Keluar #006/LJU-DU/ST/X/2026', NULL, '2026-09-27 05:26:53'),
(535, 7, 'create_surat_keluar', 'Membuat Draft Surat Keluar #006/LJU-DU/ST/X/2026', NULL, '2026-09-27 05:31:31'),
(536, 7, 'update_surat_keluar', 'Mengubah Surat Keluar #006/LJU-DU/ST/X/2026', NULL, '2026-09-27 05:34:20'),
(537, 7, 'update_surat_keluar', 'Mengubah Surat Keluar #006/LJU-DU/ST/X/2026', NULL, '2026-09-27 05:42:01'),
(538, 7, 'update_surat_keluar', 'Mengubah Surat Keluar #006/LJU-DU/ST/X/2026', NULL, '2026-09-27 05:43:12'),
(539, 7, 'sign_surat_keluar', 'Menandatangani Surat Keluar #006/LJU-DU/ST/X/2026 menggunakan metode: draw', NULL, '2026-09-27 05:52:15'),
(540, 7, 'create_surat_keluar', 'Membuat Draft Surat Keluar #123/INF/LJU/IX/2026', NULL, '2026-09-27 05:52:52'),
(541, 7, 'sign_surat_keluar', 'Menandatangani Surat Keluar #123/INF/LJU/IX/2026 menggunakan metode: saved', NULL, '2026-09-27 05:53:56'),
(542, 7, 'create_surat_keluar', 'Membuat Draft Surat Keluar #53/INF/LJU/IX/2026', NULL, '2026-09-27 05:54:17'),
(543, 7, 'sign_surat_keluar', 'Menandatangani Surat Keluar #53/INF/LJU/IX/2026 secara Manual (Tanpa Tanda Tangan Digital)', NULL, '2026-09-27 05:54:21'),
(544, 1, 'sign_surat_keluar', 'Menandatangani Surat Keluar #006/LJU-DU/ST/X/2026 menggunakan metode: draw', NULL, '2026-09-27 06:04:24'),
(545, 1, 'create_surat_tugas', 'Membuat Draft Surat Tugas #016/LJU-DU/ST/X/2026', NULL, '2026-09-27 06:44:55'),
(546, 1, 'update_surat_tugas', 'Memperbarui Draft Surat Tugas #016/LJU-DU/ST/X/2026', NULL, '2026-09-27 06:59:07'),
(547, 16, 'sign_surat_tugas', 'Menandatangani Surat Tugas #016/LJU-DU/ST/X/2026 secara Manual (Basah)', NULL, '2026-09-27 07:23:56'),
(548, 7, 'create_surat_tugas', 'Membuat Draft Surat Tugas #106/LJU-DU/ST/X/2026', NULL, '2026-09-27 07:33:41'),
(549, 16, 'sign_surat_tugas', 'Menandatangani Surat Tugas #106/LJU-DU/ST/X/2026 secara Manual (Basah)', NULL, '2026-09-27 07:34:03'),
(550, 1, 'create_surat_tugas', 'Membuat Draft Surat Tugas #123/INF/LJU/IX/2026', NULL, '2026-09-27 09:44:08'),
(551, 16, 'sign_surat_tugas', 'Menandatangani Surat Tugas #123/INF/LJU/IX/2026 secara Manual (Basah)', NULL, '2026-09-27 09:44:33'),
(552, 1, 'delete_surat_tugas', 'Menghapus Surat Tugas #123/INF/LJU/IX/2026', NULL, '2026-09-27 09:55:14'),
(553, 1, 'delete_surat_tugas', 'Menghapus Surat Tugas #016/LJU-DU/ST/X/2026', NULL, '2026-09-27 09:55:16'),
(554, 7, 'delete_surat_tugas', 'Menghapus Surat Tugas #106/LJU-DU/ST/X/2026', NULL, '2026-09-27 09:55:48'),
(555, 7, 'complete_nota_dinas', 'Menyelesaikan Nota Dinas #20', NULL, '2026-09-27 09:56:51'),
(556, 7, 'delete_disposition', 'Menghapus Disposisi #17', NULL, '2026-09-27 09:57:01'),
(557, 7, 'delete_disposition', 'Menghapus Disposisi #12', NULL, '2026-09-27 09:57:03'),
(558, 1, 'delete_disposition', 'Menghapus Disposisi #19', NULL, '2026-09-27 09:57:25'),
(559, 1, 'delete', 'Hapus dokumen: coba surat masuk', NULL, '2026-09-27 11:33:22'),
(560, 1, 'delete', 'Hapus dokumen: coba surat masuk', NULL, '2026-09-27 11:33:28'),
(561, 1, 'delete', 'Hapus dokumen: Disposisi Baru', NULL, '2026-09-27 11:33:38'),
(562, 1, 'delete', 'Hapus dokumen: Disposisi Baru', NULL, '2026-09-27 11:33:40'),
(563, 7, 'create_surat_tugas', 'Membuat Draft Surat Tugas #123/INF/LJU/IX/2026', NULL, '2026-09-28 02:19:10'),
(564, 7, 'delete_surat_tugas', 'Menghapus Surat Tugas #123/INF/LJU/IX/2026', NULL, '2026-09-28 02:20:09'),
(565, 7, 'create_surat_tugas', 'Membuat Draft Surat Tugas #123/INF/LJU/IX/2026', NULL, '2026-09-28 02:21:53'),
(566, 7, 'sign_surat_tugas', 'Menandatangani Surat Tugas #123/INF/LJU/IX/2026 secara Digital', NULL, '2026-09-28 02:22:09'),
(567, 7, 'delete_surat_tugas', 'Menghapus Surat Tugas #123/INF/LJU/IX/2026', NULL, '2026-09-28 02:41:12'),
(568, 7, 'create_surat_tugas', 'Membuat Draft Surat Tugas #123/INF/LJU/IX/2026', NULL, '2026-09-28 02:41:28'),
(569, 7, 'sign_surat_tugas', 'Menandatangani Surat Tugas #123/INF/LJU/IX/2026 secara Digital', NULL, '2026-09-28 02:41:48'),
(570, 7, 'delete_surat_tugas', 'Menghapus Surat Tugas #123/INF/LJU/IX/2026', NULL, '2026-09-28 02:42:29');

-- --------------------------------------------------------

--
-- Table structure for table `audit_trail`
--

CREATE TABLE `audit_trail` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `action` enum('login','logout','view','download','upload','edit','delete','permission_change','version_upload','search','loan_out','loan_return','location_change') NOT NULL,
  `module` varchar(50) DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `document_title` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_trail`
--

INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `action`, `module`, `document_id`, `document_title`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, 'admin', 'upload', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Uploaded document: Laporan_Progress_Bidang_Usaha_Infokom_PT_Lampung_Jasa_Utama_Jan_Agustus_2026-edited.docx (docx)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:36:58'),
(2, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:40:41'),
(3, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:57:01'),
(4, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:57:28'),
(5, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:57:49'),
(6, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:58:50'),
(7, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:59:01'),
(8, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:59:05'),
(9, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:59:12'),
(10, 1, 'admin', 'permission_change', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Permission added for user:7', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:59:26'),
(11, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 05:59:26'),
(12, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:03:01'),
(13, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:03:02'),
(14, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:03:55'),
(15, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:07:11'),
(16, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:07:12'),
(17, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:07:12'),
(18, 1, 'admin', 'permission_change', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Permission added for division:Infokom', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:07:22'),
(19, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:07:22'),
(20, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:07:32'),
(21, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:09:57'),
(22, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:19:30'),
(23, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:22:34'),
(24, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 06:57:27'),
(25, 1, 'admin', 'edit', 'users', 1, 'Administrator', 'Memperbarui profil mandiri & mengganti avatar', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 07:15:57'),
(26, 1, 'admin', 'edit', 'users', 1, 'Administrator', 'Memperbarui profil mandiri & mengganti avatar', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 07:22:19'),
(27, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 07:24:15'),
(28, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 07:34:40'),
(29, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 07:37:46'),
(30, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 07:38:06'),
(31, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 07:47:13'),
(32, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 08:00:31'),
(33, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 08:04:48'),
(34, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-10 08:46:12'),
(35, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 01:14:51'),
(36, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 01:43:00'),
(37, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 01:43:15'),
(38, 1, 'admin', 'permission_change', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Permission added for division:', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 01:43:32'),
(39, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 01:43:32'),
(40, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 01:43:40'),
(41, 1, 'admin', 'permission_change', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Removed permission ID: 1', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 01:43:40'),
(42, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 01:43:52'),
(43, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:00:58'),
(44, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:01:03'),
(45, 7, 'ami', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:01:50'),
(46, 7, 'ami', 'edit', 'users', 7, 'Ami Tri Cahyadi', 'Memperbarui profil', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:02:04'),
(47, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:02:12'),
(48, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:13:45'),
(49, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:14:01'),
(50, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:14:57'),
(51, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:15:44'),
(52, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:36:07'),
(53, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:48:05'),
(54, 1, 'admin', 'edit', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Document info updated', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:48:27'),
(55, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:53:37'),
(56, 1, 'admin', 'edit', 'documents_arsip', 1, 'laporan kerja infokom agustus 2026', 'Informasi dokumen diperbarui', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:53:54'),
(57, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:53:54'),
(58, 1, 'admin', 'view', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:54:02'),
(59, 1, 'admin', 'delete', 'documents', 1, 'laporan kerja infokom agustus 2026', 'Document deleted: 0001/LK/EDAMS/IX/2026', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:54:45'),
(60, 1, 'admin', 'edit', 'users', 1, 'Administrator', 'Memperbarui profil', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:56:49'),
(61, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:56:55'),
(62, 1, 'admin', 'upload', 'documents', 2, 'akta', 'Uploaded document: Jadwal Pelajaran.pdf (pdf)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:59:22'),
(63, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 02:59:22'),
(64, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 03:00:47'),
(65, 1, 'admin', 'edit', 'documents_arsip', 2, 'akta', 'Informasi dokumen diperbarui', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 03:02:24'),
(66, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 03:02:24'),
(67, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 03:05:56'),
(68, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 03:20:55'),
(69, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 03:21:12'),
(70, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 04:51:19'),
(71, 1, 'admin', 'location_change', 'locations', 2, 'akta', 'Ditempatkan di lokasi ID: 5', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 04:51:50'),
(72, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 04:52:10'),
(73, 1, 'admin', 'loan_out', 'loans', 2, 'akta', 'Dipinjam oleh: Dodi Subarkah | Keperluan: untuk liat-liat | Hingga: 2026-09-15', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 04:52:48'),
(74, 1, 'admin', 'loan_return', 'loans', 2, 'akta', 'Dikembalikan oleh: Dodi Subarkah | Status: returned | Catatan: aman', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 04:56:05'),
(75, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:39:38'),
(76, 1, 'admin', 'upload', 'documents', 3, 'coba', 'Uploaded document: Diagram - local.jpg (jpg)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:41:00'),
(77, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:41:00'),
(78, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:41:26'),
(79, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:41:38'),
(80, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:48:39'),
(81, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:50:13'),
(82, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:50:17'),
(83, 1, 'admin', 'location_change', 'documents', 3, NULL, 'Lokasi fisik ditetapkan (location_id: 3)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:50:45'),
(84, 1, 'admin', 'location_change', 'documents', 3, 'coba', 'Lokasi fisik ditetapkan (location_id: 3)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:51:44'),
(85, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:51:50'),
(86, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:52:30'),
(87, 1, 'admin', 'location_change', 'documents', 3, 'coba', 'Lokasi fisik ditetapkan (location_id: 3)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:52:37'),
(88, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:56:03'),
(89, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:56:09'),
(90, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:56:23'),
(91, 1, 'admin', 'location_change', 'documents', 3, 'coba', 'Lokasi fisik ditetapkan (location_id: 3)', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:56:28'),
(92, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 06:56:28'),
(93, 1, 'admin', 'search', 'documents', NULL, NULL, 'Search keyword: X', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:00:42'),
(94, 1, 'admin', 'search', 'documents', NULL, NULL, 'Search keyword: Pak X', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:00:55'),
(95, 1, 'admin', 'search', 'documents', NULL, NULL, 'Search keyword: Pak', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:01:00'),
(96, 1, 'admin', 'search', 'documents', NULL, NULL, 'Search keyword: akta', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:01:31'),
(97, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:01:44'),
(98, 1, 'admin', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: X', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:12:57'),
(99, 1, 'admin', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: Pak X', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:13:13'),
(100, 1, 'admin', 'edit', 'documents_arsip', 3, 'coba', 'Informasi dokumen diperbarui', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:13:30'),
(101, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:13:30'),
(102, 1, 'admin', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: Pak X', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:13:38'),
(103, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:16:56'),
(104, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-11 07:19:18'),
(105, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-12 12:07:50'),
(106, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 02:57:57'),
(107, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:08:27'),
(108, 1, 'admin', 'view', 'documents', 2, 'akta', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:36:47'),
(109, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:36:51'),
(110, 1, 'admin', 'permission_change', 'documents', 3, 'coba', 'Permission added for user:8', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:37:00'),
(111, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:37:00'),
(112, 8, 'dodi', 'view', 'documents', 3, 'coba', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:37:20'),
(113, 1, 'admin', 'view', 'documents', 3, 'coba', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:37:45'),
(114, 8, 'dodi', 'view', 'documents', 3, 'coba', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:38:12'),
(115, 8, 'dodi', 'view', 'documents', 3, 'coba', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:38:19'),
(116, 1, 'admin', 'delete', 'documents', 3, 'coba', 'Document deleted: 0001/SM/JKN/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:38:45'),
(117, 1, 'admin', 'delete', 'documents', 2, 'akta', 'Document deleted: 0001/LGL/LGL/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:38:49'),
(118, 1, 'admin', 'upload', 'documents', 4, 'Laporan kerja', 'Uploaded document: Laporan_Kas_Vios_2026-09.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:39:32'),
(119, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:39:32'),
(120, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:39:40'),
(121, 1, 'admin', 'permission_change', 'documents', 4, 'Laporan kerja', 'Permission added for division:Infokom', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:40:02'),
(122, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:40:02'),
(123, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:40:16'),
(124, 1, 'admin', 'permission_change', 'documents', 4, 'Laporan kerja', 'Permission added for user:8', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:40:27'),
(125, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:40:28'),
(126, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:40:40'),
(127, 1, 'admin', 'permission_change', 'documents', 4, 'Laporan kerja', 'Removed permission ID: 5', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:40:40'),
(128, 8, 'dodi', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:40:41'),
(129, 8, 'dodi', 'download', 'documents', 4, 'Laporan kerja', 'Downloaded v1.0: Laporan_Kas_Vios_2026-09.pdf', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:40:48'),
(130, 8, 'dodi', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:41:56'),
(131, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:42:19'),
(132, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:43:14'),
(133, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:44:35'),
(134, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:50:11'),
(135, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:50:31'),
(136, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 03:52:50'),
(137, 11, 'venta', 'edit', 'users', 11, 'Venta', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:53:45'),
(138, 8, 'dodi', 'edit', 'users', 8, 'Dodi Subarkah', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:58:36'),
(139, 8, 'dodi', 'edit', 'users', 8, 'Dodi Subarkah', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 03:59:48'),
(140, 8, 'dodi', 'edit', 'users', 8, 'Dodi Subarkah', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:00:14'),
(141, 8, 'dodi', 'edit', 'users', 8, 'Dodi Subarkah', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:01:00'),
(142, 8, 'dodi', 'edit', 'users', 8, 'Dodi Subarkah', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:01:18'),
(143, 8, 'dodi', 'edit', 'users', 8, 'Dodi Subarkah', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:01:45'),
(144, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:02:00'),
(145, 8, 'dodi', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:02:17'),
(146, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:07:47'),
(147, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:08:29'),
(148, 8, 'dodi', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:09:55'),
(149, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:10:02'),
(150, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:12:27'),
(151, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:12:40'),
(152, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:14:40'),
(153, 11, 'venta', 'edit', 'users', 11, 'Venta', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-14 04:15:13'),
(154, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:18:06'),
(155, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:20:11'),
(156, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:21:23'),
(157, 11, 'venta', 'edit', 'users', 11, 'Venta', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:23:48'),
(158, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:31:19'),
(159, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:31:34'),
(160, 1, 'admin', 'permission_change', 'documents', 4, 'Laporan kerja', 'Permission added for division:', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:31:46'),
(161, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:31:46'),
(162, 1, 'admin', 'permission_change', 'documents', 4, 'Laporan kerja', 'Permission added for user:11', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:32:11'),
(163, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:32:12'),
(164, 11, 'venta', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:32:24'),
(165, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:37:56'),
(166, 11, 'venta', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:41:20'),
(167, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:45:37'),
(168, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:46:01'),
(169, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:47:00'),
(170, 8, 'dodi', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:49:49'),
(171, 1, 'admin', 'edit', 'documents_arsip', 4, 'Laporan kerja', 'Informasi dokumen diperbarui', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:50:35'),
(172, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:50:35'),
(173, 8, 'dodi', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:50:42'),
(174, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 04:50:43'),
(175, 1, 'admin', 'upload', 'documents', 5, 'coba2', 'Uploaded document: Laporan_Kas_Vios_2026-09.xls (xls)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:51:37'),
(176, 1, 'admin', 'view', 'documents', 5, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:51:37'),
(177, 1, 'admin', 'delete', 'documents', 5, 'coba2', 'Document deleted: 0003/LK/KES/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:54:46'),
(178, 1, 'admin', 'upload', 'documents', 6, 'coba2', 'Uploaded document: Laporan_Kas_Vios_2026-09.xls (xls)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:55:11'),
(179, 1, 'admin', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:55:11'),
(180, 1, 'admin', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:55:23'),
(181, 1, 'admin', 'permission_change', 'documents', 6, 'coba2', 'Permission added for division:Legal', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:55:43'),
(182, 1, 'admin', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:55:43'),
(183, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:55:45'),
(184, 11, 'venta', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 04:55:59'),
(185, 11, 'venta', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 05:08:07'),
(186, 11, 'venta', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: coba', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:08:34'),
(187, 11, 'venta', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 05:14:06'),
(188, 11, 'venta', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 05:14:20'),
(189, 11, 'venta', 'download', 'documents', 6, 'coba2', 'Downloaded v1.0: Laporan_Kas_Vios_2026-09.xls', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 05:14:35'),
(190, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:34:50'),
(191, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:35:21'),
(192, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:35:41'),
(193, 1, 'admin', 'upload', 'documents', 7, 'jadwal kapal dalom september', 'Uploaded document: jadwal_september_2026.jpeg (jpeg)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:39:58'),
(194, 1, 'admin', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:39:58'),
(195, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:40:12'),
(196, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:42:16'),
(197, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:42:38'),
(198, 1, 'admin', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:42:52'),
(199, 1, 'admin', 'permission_change', 'documents', 6, 'coba2', 'Permission added for division:Infokom', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:09'),
(200, 1, 'admin', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:09'),
(201, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:12'),
(202, 8, 'dodi', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:24'),
(203, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:30'),
(204, 1, 'admin', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:37'),
(205, 1, 'admin', 'permission_change', 'documents', 7, 'jadwal kapal dalom september', 'Permission added for division:', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:46'),
(206, 1, 'admin', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:46'),
(207, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:43:48'),
(208, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:44:12'),
(209, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:44:26'),
(210, 1, 'admin', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:44:37'),
(211, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:44:57'),
(212, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:57:42'),
(213, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:58:16'),
(214, 1, 'admin', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:58:25'),
(215, 1, 'admin', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 05:59:53'),
(216, 1, 'admin', 'edit', 'documents_arsip', 7, 'jadwal kapal dalom september', 'Informasi dokumen diperbarui', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 06:02:48'),
(217, 1, 'admin', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 06:02:48');
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `action`, `module`, `document_id`, `document_title`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(218, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 06:07:37'),
(219, 1, 'admin', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 06:12:26'),
(220, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 06:13:27'),
(221, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 06:19:30'),
(222, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 07:01:22'),
(223, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-14 07:08:16'),
(224, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-14 07:09:19'),
(225, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-14 07:11:28'),
(226, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 07:24:03'),
(227, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '114.10.103.142', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-14 09:48:11'),
(228, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-14 10:00:18'),
(229, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-14 11:46:07'),
(230, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-15 02:56:52'),
(231, 11, 'venta', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-15 03:40:49'),
(232, 11, 'venta', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-15 03:40:54'),
(233, 11, 'venta', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-15 03:41:12'),
(234, 11, 'venta', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-15 03:41:26'),
(235, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-15 04:56:35'),
(236, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', '2026-09-15 04:58:52'),
(237, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '156.230.191.187', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-15 05:41:43'),
(238, 1, 'admin', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '156.230.191.178', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-15 10:07:39'),
(239, 1, 'admin', 'edit', 'users', 12, 'aaa', 'Membuat user baru: aa', '156.230.191.178', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-15 10:21:29'),
(240, 1, 'admin', 'edit', 'users', 12, 'aaa', 'Memperbarui user: aa', '156.230.191.178', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-15 10:21:45'),
(241, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:12:13'),
(242, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:13:30'),
(243, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:23:34'),
(244, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:23:47'),
(245, 1, 'admin', 'edit', 'users', 11, 'Venta', 'Memperbarui user: venta', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:25:26'),
(246, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:25:35'),
(247, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:25:57'),
(248, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:30:48'),
(249, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 03:39:57'),
(250, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 08:08:40'),
(251, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-16 08:09:39'),
(252, 1, 'admin', 'edit', 'users', 13, 'aa', 'Membuat user baru: aaa', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:37:58'),
(253, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:38:00'),
(254, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:40:13'),
(255, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:41:24'),
(256, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:41:26'),
(257, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:42:46'),
(258, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:43:25'),
(259, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:43:49'),
(260, 13, 'aaa', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:45:14'),
(261, 13, 'aaa', 'view', 'documents', 6, 'coba2', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:46:01'),
(262, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:46:06'),
(263, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:46:44'),
(264, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:51:09'),
(265, 13, 'aaa', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:54:27'),
(266, 13, 'aaa', 'view', 'documents', 4, 'Laporan kerja', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:55:29'),
(267, 13, 'aaa', 'view', 'documents', 7, 'jadwal kapal dalom september', 'Viewed document', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:55:34'),
(268, 13, 'aaa', 'logout', 'auth', NULL, NULL, 'Logout', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:56:03'),
(269, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.47.134.46', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36 Edg/153.0.0.0', '2026-09-16 11:56:25'),
(270, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 03:14:01'),
(271, 1, 'admin', 'delete', 'documents', 4, 'Laporan kerja', 'Document deleted: 0002/LK/INF/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 03:14:12'),
(272, 1, 'admin', 'delete', 'documents', 6, 'coba2', 'Document deleted: 0004/LK/KES/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 03:14:20'),
(273, 1, 'admin', 'delete', 'documents', 7, 'jadwal kapal dalom september', 'Document deleted: 0002/SM/PGK/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 03:14:23'),
(274, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 03:14:28'),
(275, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 04:58:59'),
(276, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-17 08:05:31'),
(277, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 08:12:11'),
(278, 1, 'admin', 'edit', 'users', 14, 'Innaya', 'Membuat user baru: innaya', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 08:13:17'),
(279, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 08:16:15'),
(280, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 08:16:35'),
(281, 11, 'venta', 'upload', 'documents', 8, 'coba', 'Uploaded document: TEMPLATE LAPORAN MAGANG.docx (docx)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 08:20:42'),
(282, 11, 'venta', 'view', 'documents', 8, 'coba', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 08:20:42'),
(283, 11, 'venta', 'delete', 'documents', 8, 'coba', 'Document deleted: 0002/LGL/LGL/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 08:20:53'),
(284, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 08:32:03'),
(285, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 08:39:37'),
(286, 11, 'venta', 'upload', 'documents', 9, 'akta', 'Uploaded document: Zaskya Jauza Chalisya _23220560.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 08:56:17'),
(287, 11, 'venta', 'view', 'documents', 9, 'akta', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 08:56:17'),
(288, 11, 'venta', 'delete', 'documents', 9, 'akta', 'Document deleted: 0003/LGL/LGL/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 08:56:31'),
(289, 11, 'venta', 'upload', 'documents', 10, 'Akta Notaris 2023', 'Uploaded document: Akta Notaris 2023.12.06 No. 11_compressed.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 09:00:13'),
(290, 11, 'venta', 'view', 'documents', 10, 'Akta Notaris 2023', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 09:00:13'),
(291, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-17 09:01:16'),
(292, 11, 'venta', 'delete', 'documents', 10, 'Akta Notaris 2023', 'Document deleted: 0004/LGL/LGL/ARSIP/IX/2026', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:10:02'),
(293, 11, 'venta', 'upload', 'documents', 11, 'Akta Notaris', 'Uploaded document: Akta Notaris 2023.12.06 No. 11.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:10:41'),
(294, 11, 'venta', 'view', 'documents', 11, 'Akta Notaris', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:10:41'),
(295, 11, 'venta', 'upload', 'documents', 12, 'Akta Notaris 2022.10.19 No. 14', 'Uploaded document: Akta Notaris 2022.10.19 No. 14.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:14:59'),
(296, 11, 'venta', 'view', 'documents', 12, 'Akta Notaris 2022.10.19 No. 14', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:14:59'),
(297, 11, 'venta', 'edit', 'documents_arsip', 11, 'Akta Notaris 2023.12.06 No.11', 'Informasi dokumen diperbarui', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:16:28'),
(298, 11, 'venta', 'view', 'documents', 11, 'Akta Notaris 2023.12.06 No.11', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:16:28'),
(299, 11, 'venta', 'upload', 'documents', 13, 'Akta Notaris 2022.08.23 No. 18', 'Uploaded document: Akta Notaris 2022.08.23 No. 18.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:27:06'),
(300, 11, 'venta', 'view', 'documents', 13, 'Akta Notaris 2022.08.23 No. 18', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:27:06'),
(301, 11, 'venta', 'upload', 'documents', 14, 'Akta Notaris 2021.07.27 No.51', 'Uploaded document: Akta Notaris 2021.07.27 No. 51.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:36:14'),
(302, 11, 'venta', 'view', 'documents', 14, 'Akta Notaris 2021.07.27 No.51', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:36:14'),
(303, 11, 'venta', 'upload', 'documents', 15, 'Akta Notaris 2021.02.19 No.39', 'Uploaded document: Akta Notaris 2021.02.19 No. 39.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:39:27'),
(304, 11, 'venta', 'view', 'documents', 15, 'Akta Notaris 2021.02.19 No.39', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:39:27'),
(305, 11, 'venta', 'upload', 'documents', 16, 'Akta Notaris 2020.12.30 No. 5', 'Uploaded document: Akta Notaris 2020.12.30 No. 54.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:54:27'),
(306, 11, 'venta', 'view', 'documents', 16, 'Akta Notaris 2020.12.30 No. 5', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:54:28'),
(307, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.47.134.11', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-17 09:54:29'),
(308, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-17 09:54:29'),
(309, 11, 'venta', 'edit', 'documents_arsip', 16, 'Akta Notaris 2020.12.30 No. 54', 'Informasi dokumen diperbarui', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:56:13'),
(310, 11, 'venta', 'view', 'documents', 16, 'Akta Notaris 2020.12.30 No. 54', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 09:56:13'),
(311, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-17 09:57:23'),
(312, 11, 'venta', 'upload', 'documents', 17, 'Akta Notaris 2020.11.03 No.01', 'Uploaded document: Akta Notaris 2020.11.03 No. 01.pdf (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 10:00:10'),
(313, 11, 'venta', 'view', 'documents', 17, 'Akta Notaris 2020.11.03 No.01', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-17 10:00:10'),
(314, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-17 10:34:37'),
(315, 11, 'venta', 'upload', 'documents', 18, 'Akta Notaris 2020.09.21 No.65', 'Uploaded document: Akta Notaris 2020.09.21 No. 65.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 02:38:49'),
(316, 11, 'venta', 'view', 'documents', 18, 'Akta Notaris 2020.09.21 No.65', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 02:38:49'),
(317, 11, 'venta', 'upload', 'documents', 19, 'Akta Notaris 2020.09.02 No.03', 'Uploaded document: Akta Notaris 2020.09.02 No. 03.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 02:44:12'),
(318, 11, 'venta', 'view', 'documents', 19, 'Akta Notaris 2020.09.02 No.03', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 02:44:12'),
(319, 11, 'venta', 'upload', 'documents', 20, 'Akta Notaris 2020.07.09 No.23', 'Uploaded document: Akta Notaris 2020.07.09 No. 23.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 02:54:00'),
(320, 11, 'venta', 'view', 'documents', 20, 'Akta Notaris 2020.07.09 No.23', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 02:54:00'),
(321, 11, 'venta', 'upload', 'documents', 21, 'Akta Notaris 2020.02.17 No.58', 'Uploaded document: Akta Notaris 2020.02.17 No. 58.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 03:01:52'),
(322, 11, 'venta', 'view', 'documents', 21, 'Akta Notaris 2020.02.17 No.58', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 03:01:52'),
(323, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-18 03:19:15'),
(324, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:25:16'),
(325, 11, 'venta', 'upload', 'documents', 22, 'Akta Notaris 2019.07.17 No.79', 'Uploaded document: Akta Notaris 2019.07.17 No. 79.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:36:35'),
(326, 11, 'venta', 'view', 'documents', 22, 'Akta Notaris 2019.07.17 No.79', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:36:35'),
(327, 11, 'venta', 'upload', 'documents', 23, 'Akta Notaris 2019.04.04 No.02', 'Uploaded document: Akta Notaris 2019.04.04 No. 02.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:44:20'),
(328, 11, 'venta', 'view', 'documents', 23, 'Akta Notaris 2019.04.04 No.02', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:44:20'),
(329, 11, 'venta', 'upload', 'documents', 24, 'Akta Notaris 2019.01.15 No.30', 'Uploaded document: Akta Notaris 2019.01.15 No. 30.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:45:40'),
(330, 11, 'venta', 'view', 'documents', 24, 'Akta Notaris 2019.01.15 No.30', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:45:41'),
(331, 11, 'venta', 'upload', 'documents', 25, 'Akta Notaris 2018.10.18 No.148', 'Uploaded document: Akta Notaris 2018.10.18 No. 148.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:51:18'),
(332, 11, 'venta', 'view', 'documents', 25, 'Akta Notaris 2018.10.18 No.148', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:51:18'),
(333, 11, 'venta', 'upload', 'documents', 26, 'Akta Notaris 2018.10.18 No.147', 'Uploaded document: Akta Notaris 2018.10.18 No. 147.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:53:09'),
(334, 11, 'venta', 'view', 'documents', 26, 'Akta Notaris 2018.10.18 No.147', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:53:10'),
(335, 11, 'venta', 'upload', 'documents', 27, 'Akta Notaris 2018.06.30 No.116', 'Uploaded document: Akta Notaris 2018.06.30 No. 116.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:54:17'),
(336, 11, 'venta', 'view', 'documents', 27, 'Akta Notaris 2018.06.30 No.116', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 04:54:17'),
(337, 11, 'venta', 'upload', 'documents', 28, 'Akta Notaris 2018.03.12. No.60', 'Uploaded document: Akta Notaris 2018.03.12 No. 60.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:02:45'),
(338, 11, 'venta', 'view', 'documents', 28, 'Akta Notaris 2018.03.12. No.60', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:02:45'),
(339, 11, 'venta', 'upload', 'documents', 29, 'Akta Notaris 2017.12.15 No.128', 'Uploaded document: Akta Notaris 2017.12.15 No. 128.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:06:40'),
(340, 11, 'venta', 'view', 'documents', 29, 'Akta Notaris 2017.12.15 No.128', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:06:40'),
(341, 11, 'venta', 'upload', 'documents', 30, 'Akta Notaris 2017.10.10 N0.22', 'Uploaded document: Akta Notaris 2017.10.10 No. 22.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:08:24'),
(342, 11, 'venta', 'view', 'documents', 30, 'Akta Notaris 2017.10.10 N0.22', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:08:24'),
(343, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-18 05:11:16'),
(344, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-18 05:11:53'),
(345, 11, 'venta', 'upload', 'documents', 31, 'Akta Notaris 2017.06.22 No.161', 'Uploaded document: Akta Notaris 2017.06.22 No. 161.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:18:33'),
(346, 11, 'venta', 'view', 'documents', 31, 'Akta Notaris 2017.06.22 No.161', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:18:33'),
(347, 11, 'venta', 'upload', 'documents', 32, 'Akta Notaris 2017.06.21 No.159', 'Uploaded document: Akta Notaris 2017.06.21 No. 159.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:20:18'),
(348, 11, 'venta', 'view', 'documents', 32, 'Akta Notaris 2017.06.21 No.159', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:20:18'),
(349, 11, 'venta', 'edit', 'documents_arsip', 30, 'Akta Notaris 2017.10.10 N0.22', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:20:40'),
(350, 11, 'venta', 'view', 'documents', 30, 'Akta Notaris 2017.10.10 N0.22', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:20:40'),
(351, 11, 'venta', 'edit', 'documents_arsip', 29, 'Akta Notaris 2017.12.15 No.128', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:21:10'),
(352, 11, 'venta', 'view', 'documents', 29, 'Akta Notaris 2017.12.15 No.128', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:21:10'),
(353, 11, 'venta', 'edit', 'documents_arsip', 30, 'Akta Notaris 2017.10.10 N0.22', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:21:25'),
(354, 11, 'venta', 'view', 'documents', 30, 'Akta Notaris 2017.10.10 N0.22', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:21:25'),
(355, 11, 'venta', 'upload', 'documents', 33, 'Akta Notaris 2017.01.20 No.122', 'Uploaded document: Akta Notaris 2017.01.20 No. 122.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:41:19'),
(356, 11, 'venta', 'view', 'documents', 33, 'Akta Notaris 2017.01.20 No.122', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 05:41:19'),
(357, 11, 'venta', 'upload', 'documents', 34, 'Akta Notaris 2016.12.23. No.288', 'Uploaded document: Akta Notaris 2016.12.23 No. 288.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:02:17'),
(358, 11, 'venta', 'view', 'documents', 34, 'Akta Notaris 2016.12.23. No.288', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:02:18'),
(359, 11, 'venta', 'upload', 'documents', 35, 'Akta Notaris 2016.06.02 No.13', 'Uploaded document: Akta Notaris 2016.06.02 No. 13.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:03:40'),
(360, 11, 'venta', 'view', 'documents', 35, 'Akta Notaris 2016.06.02 No.13', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:03:41'),
(361, 11, 'venta', 'upload', 'documents', 36, 'Akta Notaris 2016.04.11 No.14', 'Uploaded document: Akta Notaris 2016.04.11 No. 14.Pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:05:27'),
(362, 11, 'venta', 'view', 'documents', 36, 'Akta Notaris 2016.04.11 No.14', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:05:27'),
(363, 11, 'venta', 'edit', 'documents_arsip', 30, 'Akta Notaris 2017.10.10 N0.22', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:06:07'),
(364, 11, 'venta', 'view', 'documents', 30, 'Akta Notaris 2017.10.10 N0.22', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:06:07'),
(365, 11, 'venta', 'edit', 'documents_arsip', 29, 'Akta Notaris 2017.12.15 No.128', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:06:22'),
(366, 11, 'venta', 'view', 'documents', 29, 'Akta Notaris 2017.12.15 No.128', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:06:22'),
(367, 11, 'venta', 'edit', 'documents_arsip', 28, 'Akta Notaris 2018.03.12. No.60', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:06:38'),
(368, 11, 'venta', 'view', 'documents', 28, 'Akta Notaris 2018.03.12. No.60', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:06:38'),
(369, 11, 'venta', 'edit', 'documents_arsip', 27, 'Akta Notaris 2018.06.30 No.116', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:06:52'),
(370, 11, 'venta', 'view', 'documents', 27, 'Akta Notaris 2018.06.30 No.116', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:06:52'),
(371, 11, 'venta', 'edit', 'documents_arsip', 26, 'Akta Notaris 2018.10.18 No.147', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:07:26'),
(372, 11, 'venta', 'view', 'documents', 26, 'Akta Notaris 2018.10.18 No.147', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:07:27'),
(373, 11, 'venta', 'edit', 'documents_arsip', 25, 'Akta Notaris 2018.10.18 No.148', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:07:42'),
(374, 11, 'venta', 'view', 'documents', 25, 'Akta Notaris 2018.10.18 No.148', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:07:42'),
(375, 11, 'venta', 'edit', 'documents_arsip', 24, 'Akta Notaris 2019.01.15 No.30', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:08:03'),
(376, 11, 'venta', 'view', 'documents', 24, 'Akta Notaris 2019.01.15 No.30', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:08:03'),
(377, 11, 'venta', 'edit', 'documents_arsip', 23, 'Akta Notaris 2019.04.04 No.02', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:08:17'),
(378, 11, 'venta', 'view', 'documents', 23, 'Akta Notaris 2019.04.04 No.02', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:08:17'),
(379, 11, 'venta', 'edit', 'documents_arsip', 22, 'Akta Notaris 2019.07.17 No.79', 'Informasi dokumen diperbarui', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:08:42'),
(380, 11, 'venta', 'view', 'documents', 22, 'Akta Notaris 2019.07.17 No.79', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:08:42'),
(381, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-18 06:10:36'),
(382, 11, 'venta', 'view', 'documents', 36, 'Akta Notaris 2016.04.11 No.14', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-18 06:18:07'),
(383, 11, 'venta', 'upload', 'documents', 37, 'Akta Notaris 2015.08.06 No.03', 'Uploaded document: Akta Notaris 2015.08.06 No. 03.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:19:17'),
(384, 11, 'venta', 'view', 'documents', 37, 'Akta Notaris 2015.08.06 No.03', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:19:17'),
(385, 11, 'venta', 'upload', 'documents', 38, 'Akta Notaris 2016.04.11 No.15', 'Uploaded document: Akta Notaris 2016.04.11 No. 15.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:21:11'),
(386, 11, 'venta', 'view', 'documents', 38, 'Akta Notaris 2016.04.11 No.15', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:21:11'),
(387, 11, 'venta', 'upload', 'documents', 39, 'Akta Notaris 2015.04.06 No.09', 'Uploaded document: Akta Notaris 2015.04.06 No. 09.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:27:05'),
(388, 11, 'venta', 'view', 'documents', 39, 'Akta Notaris 2015.04.06 No.09', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:27:05'),
(389, 11, 'venta', 'upload', 'documents', 40, 'Akta Notaris 2014.03.13 No.84', 'Uploaded document: Akta Notaris 2014.03.13 No. 84.Pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:29:25'),
(390, 11, 'venta', 'view', 'documents', 40, 'Akta Notaris 2014.03.13 No.84', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:29:25'),
(391, 11, 'venta', 'upload', 'documents', 41, 'Akta Notaris 2013.07.16. No.264', 'Uploaded document: Akta Notaris 2013.07.16 No. 264.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:31:08'),
(392, 11, 'venta', 'view', 'documents', 41, 'Akta Notaris 2013.07.16. No.264', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:31:08'),
(393, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-18 06:32:44'),
(394, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '114.10.103.214', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-18 06:34:20'),
(395, 11, 'venta', 'upload', 'documents', 42, 'Akta Notaris 2012.07.30 No.05', 'Uploaded document: Akta Notaris 2012.07.30 No. 05.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:36:40'),
(396, 11, 'venta', 'view', 'documents', 42, 'Akta Notaris 2012.07.30 No.05', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:36:40'),
(397, 11, 'venta', 'upload', 'documents', 43, 'Akta Notaris 2012.06.05 No.01', 'Uploaded document: Akta Notaris 2012.06.05 No. 01.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:38:00'),
(398, 11, 'venta', 'view', 'documents', 43, 'Akta Notaris 2012.06.05 No.01', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:38:00'),
(399, 11, 'venta', 'upload', 'documents', 44, 'Akta Notaris 2011.20.11 No.02', 'Uploaded document: Akta Notaris 2011.10.11 No. 02.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:40:07'),
(400, 11, 'venta', 'view', 'documents', 44, 'Akta Notaris 2011.20.11 No.02', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:40:07'),
(401, 11, 'venta', 'upload', 'documents', 45, 'Akta Notaris 2011.04.15 No.06', 'Uploaded document: Akta Notaris 2011.04.15 No. 06.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:41:18'),
(402, 11, 'venta', 'view', 'documents', 45, 'Akta Notaris 2011.04.15 No.06', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:41:18'),
(403, 11, 'venta', 'upload', 'documents', 46, 'Akta Notaris 2010.11.18 No.02', 'Uploaded document: Akta Notaris 2010.11.18 No. 02.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:46:04'),
(404, 11, 'venta', 'view', 'documents', 46, 'Akta Notaris 2010.11.18 No.02', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:46:04'),
(405, 11, 'venta', 'upload', 'documents', 47, 'Akta Notaris 2010.09.01 No.01', 'Uploaded document: Akta Notaris 2010.09.01 No. 01.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:47:41'),
(406, 11, 'venta', 'view', 'documents', 47, 'Akta Notaris 2010.09.01 No.01', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:47:41'),
(407, 11, 'venta', 'upload', 'documents', 48, 'Akta RUSLB 2024.08.29 No.03', 'Uploaded document: Salinan Akta RUPSLB 2024.08.29 No.03.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:52:27'),
(408, 11, 'venta', 'view', 'documents', 48, 'Akta RUSLB 2024.08.29 No.03', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:52:27'),
(409, 11, 'venta', 'upload', 'documents', 49, 'Akta RUPSLB PT LAMPUNG JASA UTAMA (Perseroda) 07-10-2025', 'Uploaded document: Akta RUPSLB PT. LAMPUNG JASA UTAMA (Perseroda) 07-10-2025.pdf (pdf)', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:54:08'),
(410, 11, 'venta', 'view', 'documents', 49, 'Akta RUPSLB PT LAMPUNG JASA UTAMA (Perseroda) 07-10-2025', 'Viewed document', '182.10.35.248', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-18 06:54:08'),
(411, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-18 07:04:45'),
(412, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-18 07:05:40'),
(413, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-18 07:43:37'),
(414, 11, 'venta', 'view', 'documents', 49, 'Akta RUPSLB PT LAMPUNG JASA UTAMA (Perseroda) 07-10-2025', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-18 07:43:57');
INSERT INTO `audit_trail` (`id`, `user_id`, `user_name`, `action`, `module`, `document_id`, `document_title`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(415, 11, 'venta', 'view', 'documents', 49, 'Akta RUPSLB PT LAMPUNG JASA UTAMA (Perseroda) 07-10-2025', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-18 07:43:58'),
(416, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '203.83.40.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-18 08:12:58'),
(417, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '203.83.40.13', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-18 08:13:23'),
(418, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '103.47.134.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 08:17:05'),
(419, 14, 'innaya', 'upload', 'documents', 50, 'Disposisi Baru', 'Uploaded document:  (docx)', '103.47.134.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 10:04:13'),
(420, 14, 'innaya', 'view', 'documents', 50, 'Disposisi Baru', 'Viewed document', '103.47.134.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 10:04:13'),
(421, 14, 'innaya', 'delete', 'documents', 50, 'Disposisi Baru', 'Document deleted: 0003/SM/KES/ARSIP/IX/2026', '103.47.134.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 10:04:25'),
(422, 14, 'innaya', 'logout', 'auth', NULL, NULL, 'Logout', '103.47.134.8', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-20 10:16:48'),
(423, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.1 Safari/605.1.15', '2026-09-21 02:45:56'),
(424, 11, 'venta', 'upload', 'documents', 51, 'MOU ANTARA PT. LAMPU.NG JASA UTAMA |Perseroda) DAN PT. DAMAI LAUTAN NUSANTARA', 'Uploaded document:  (pdf)', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:01:02'),
(425, 11, 'venta', 'view', 'documents', 51, 'MOU ANTARA PT. LAMPU.NG JASA UTAMA |Perseroda) DAN PT. DAMAI LAUTAN NUSANTARA', 'Viewed document', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:01:02'),
(426, 11, 'venta', 'upload', 'documents', 52, 'NIB PT Lampung Jasa Utama (Perseroda)', 'Uploaded document:  (pdf)', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:11:08'),
(427, 11, 'venta', 'view', 'documents', 52, 'NIB PT Lampung Jasa Utama (Perseroda)', 'Viewed document', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:11:08'),
(428, 11, 'venta', 'upload', 'documents', 53, 'SBU KONTRUKSI GEDUNG HUNIAN PT LAMPUNG JASA UTAMA (PERSERODA)', 'Uploaded document:  (pdf)', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:19:16'),
(429, 11, 'venta', 'view', 'documents', 53, 'SBU KONTRUKSI GEDUNG HUNIAN PT LAMPUNG JASA UTAMA (PERSERODA)', 'Viewed document', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:19:17'),
(430, 11, 'venta', 'upload', 'documents', 54, 'SBU KONTRUKSI BANGUNAN SIPIL JALAN PT LAMPUNG JASA UTAMA (PERSERODA)', 'Uploaded document:  (pdf)', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:21:18'),
(431, 11, 'venta', 'view', 'documents', 54, 'SBU KONTRUKSI BANGUNAN SIPIL JALAN PT LAMPUNG JASA UTAMA (PERSERODA)', 'Viewed document', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:21:18'),
(432, 11, 'venta', 'upload', 'documents', 55, 'SBU KONTRUKSI JARINGAN IRIGASI DAN DRAINASE PT LAMPUNG JASA UTAMA (PERSERODA)', 'Uploaded document:  (pdf)', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:23:14'),
(433, 11, 'venta', 'view', 'documents', 55, 'SBU KONTRUKSI JARINGAN IRIGASI DAN DRAINASE PT LAMPUNG JASA UTAMA (PERSERODA)', 'Viewed document', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:23:14'),
(434, 11, 'venta', 'upload', 'documents', 56, 'SBU KONTRUKSI GEDUNG PERKANTORAN PT LAMPUNG JASA UTAMA (PERSERODA)', 'Uploaded document:  (pdf)', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:24:33'),
(435, 11, 'venta', 'view', 'documents', 56, 'SBU KONTRUKSI GEDUNG PERKANTORAN PT LAMPUNG JASA UTAMA (PERSERODA)', 'Viewed document', '114.79.7.211', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 03:24:33'),
(436, 1, 'admin', 'edit', 'users', 15, 'OKTAVIANUS YULIA, S.T.', 'Memperbarui user: oki', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 03:48:33'),
(437, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 03:57:11'),
(438, 16, 'amri', 'view', 'documents', 56, 'SBU KONTRUKSI GEDUNG PERKANTORAN PT LAMPUNG JASA UTAMA (PERSERODA)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 03:57:26'),
(439, 16, 'amri', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 03:57:31'),
(440, 15, 'oki', 'view', 'documents', 56, 'SBU KONTRUKSI GEDUNG PERKANTORAN PT LAMPUNG JASA UTAMA (PERSERODA)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 03:58:00'),
(441, 15, 'oki', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 03:58:14'),
(442, 1, 'admin', 'edit', 'users', 32, 'Dede Maysaroh', 'Memperbarui user: dede', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 04:18:24'),
(443, 1, 'admin', 'edit', 'users', 30, 'Afrilia Damayanti', 'Memperbarui user: afril', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 04:18:44'),
(444, 1, 'admin', 'edit', 'users', 19, 'Edi Wahyudi', 'Memperbarui user: yudi', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 04:19:10'),
(445, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-21 07:17:05'),
(446, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-21 07:17:27'),
(447, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:20:01'),
(448, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-21 07:21:57'),
(449, 1, 'admin', 'edit', 'users', 11, 'Ventania Agustina', 'Memperbarui user: venta', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 07:22:12'),
(450, 1, 'admin', 'edit', 'users', 14, 'Innaya Rizki', 'Memperbarui user: innaya', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 07:22:24'),
(451, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-21 07:22:32'),
(452, 11, 'venta', 'upload', 'documents', 57, 'PERJANJIAN ANTARA PT PELABUHAN TANJUNG PRIOK CABANG PANJANG DENGAN PT LAMPUNG JASA UTAMA', 'Uploaded document:  (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:35:53'),
(453, 11, 'venta', 'view', 'documents', 57, 'PERJANJIAN ANTARA PT PELABUHAN TANJUNG PRIOK CABANG PANJANG DENGAN PT LAMPUNG JASA UTAMA', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:35:53'),
(454, 11, 'venta', 'upload', 'documents', 58, 'PERJANJIAN ANTARA PT PELABUHAN TANJUNG PRIOK CABANG PANJANG DENGAN PT LAMPUNG JASA UTAMA', 'Uploaded document:  (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:39:07'),
(455, 11, 'venta', 'view', 'documents', 58, 'PERJANJIAN ANTARA PT PELABUHAN TANJUNG PRIOK CABANG PANJANG DENGAN PT LAMPUNG JASA UTAMA', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:39:07'),
(456, 11, 'venta', 'upload', 'documents', 59, 'PERTANJIAN KERJASAMA ANTARA FT. LAMPUNG JASA UTAMA (Perseroda) DENGAN FT. DALOM LINTAS BERJAYA', 'Uploaded document:  (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:42:32'),
(457, 11, 'venta', 'view', 'documents', 59, 'PERTANJIAN KERJASAMA ANTARA FT. LAMPUNG JASA UTAMA (Perseroda) DENGAN FT. DALOM LINTAS BERJAYA', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:42:32'),
(458, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-21 07:42:52'),
(459, 11, 'venta', 'view', 'documents', 51, 'MOU ANTARA PT. LAMPU.NG JASA UTAMA |Perseroda) DAN PT. DAMAI LAUTAN NUSANTARA', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:44:47'),
(460, 11, 'venta', 'view', 'documents', 52, 'NIB PT Lampung Jasa Utama (Perseroda)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:45:36'),
(461, 11, 'venta', 'view', 'documents', 59, 'PERTANJIAN KERJASAMA ANTARA FT. LAMPUNG JASA UTAMA (Perseroda) DENGAN FT. DALOM LINTAS BERJAYA', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:46:14'),
(462, 11, 'venta', 'view', 'documents', 57, 'PERJANJIAN ANTARA PT PELABUHAN TANJUNG PRIOK CABANG PANJANG DENGAN PT LAMPUNG JASA UTAMA', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:48:18'),
(463, 11, 'venta', 'upload', 'documents', 60, 'MOU ANTARA PT. LAMPU.NG JASA UTAMA |Perseroda) DAN PT. DAMAI LAUTAN NUSANTARA', 'Uploaded document:  (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:57:38'),
(464, 11, 'venta', 'view', 'documents', 60, 'MOU ANTARA PT. LAMPU.NG JASA UTAMA |Perseroda) DAN PT. DAMAI LAUTAN NUSANTARA', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 07:57:38'),
(465, 11, 'venta', 'upload', 'documents', 61, 'MOU ANTARA PT LAMPUNG JASA UTAMA (PERSERODA) DENGAN HIMPUNAN PENGEMBANGAN PERMUKIMAN DAN PERUMAHAN RAKYAT', 'Uploaded document:  (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:00:23'),
(466, 11, 'venta', 'view', 'documents', 61, 'MOU ANTARA PT LAMPUNG JASA UTAMA (PERSERODA) DENGAN HIMPUNAN PENGEMBANGAN PERMUKIMAN DAN PERUMAHAN RAKYAT', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:00:23'),
(467, 11, 'venta', 'upload', 'documents', 62, 'MOU ANTARA PT JATENG PETRO ENERGl (Perseroda) DENGAN PT LAMPUNG JASA UTAIVIA (Perseroda)', 'Uploaded document:  (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:03:54'),
(468, 11, 'venta', 'view', 'documents', 62, 'MOU ANTARA PT JATENG PETRO ENERGl (Perseroda) DENGAN PT LAMPUNG JASA UTAIVIA (Perseroda)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:03:54'),
(469, 11, 'venta', 'upload', 'documents', 63, 'KONTRAK PENGADAAN PEKERJAAN MANAGE SERVICE ANTARA PT TELEMATIKA MULTIMEDIA SOLuSI DENGAN PT LAMPUNG JASA UTAMA (PESERODA)', 'Uploaded document:  (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:08:41'),
(470, 11, 'venta', 'view', 'documents', 63, 'KONTRAK PENGADAAN PEKERJAAN MANAGE SERVICE ANTARA PT TELEMATIKA MULTIMEDIA SOLuSI DENGAN PT LAMPUNG JASA UTAMA (PESERODA)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:08:41'),
(471, 11, 'venta', 'view', 'documents', 61, 'MOU ANTARA PT LAMPUNG JASA UTAMA (PERSERODA) DENGAN HIMPUNAN PENGEMBANGAN PERMUKIMAN DAN PERUMAHAN RAKYAT', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:24:18'),
(472, 11, 'venta', 'view', 'documents', 61, 'MOU ANTARA PT LAMPUNG JASA UTAMA (PERSERODA) DENGAN HIMPUNAN PENGEMBANGAN PERMUKIMAN DAN PERUMAHAN RAKYAT', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:24:34'),
(473, 11, 'venta', 'view', 'documents', 60, 'MOU ANTARA PT. LAMPU.NG JASA UTAMA |Perseroda) DAN PT. DAMAI LAUTAN NUSANTARA', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:24:46'),
(474, 11, 'venta', 'edit', 'users', 11, 'Ventania Gusti Amelza Agung', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-21 08:25:21'),
(475, 11, 'venta', 'upload', 'documents', 64, 'MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA)', 'Uploaded document:  (pdf)', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:42:29'),
(476, 11, 'venta', 'view', 'documents', 64, 'MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-21 08:42:29'),
(477, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:21:03'),
(478, 8, 'dodi', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: akta', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:31:23'),
(479, 8, 'dodi', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: akta', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:31:55'),
(480, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:32:25'),
(481, 11, 'venta', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: akta', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:33:02'),
(482, 11, 'venta', 'view', 'documents', 64, 'MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:34:37'),
(483, 11, 'venta', 'view', 'documents', 64, 'MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:36:34'),
(484, 11, 'venta', 'view', 'documents', 64, 'MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:37:02'),
(485, 11, 'venta', 'loan_out', 'loans', 64, 'MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA)', 'Dipinjam oleh: Dodi Subarkah | Keperluan: foto copy | Hingga: 2026-09-30', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:41:22'),
(486, 11, 'venta', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:41:27'),
(487, 11, 'venta', 'view', 'documents', 64, 'MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA)', 'Viewed document', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 03:42:21'),
(488, 22, 'kanjengmum', 'edit', 'users', 22, 'Iqbal Damara', 'Memperbarui profil', '182.3.104.149', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 06:19:45'),
(489, 22, 'kanjengmum', 'edit', 'users', 22, 'Iqbal Damara', 'Memperbarui profil', '182.3.104.149', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 06:19:56'),
(490, 14, 'innaya', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-22 08:39:58'),
(491, 22, 'kanjengmum', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 01:18:52'),
(492, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 02:50:54'),
(493, 16, 'amri', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 02:51:36'),
(494, 16, 'amri', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 02:55:27'),
(495, 16, 'amri', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: akta', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 03:20:00'),
(496, 16, 'amri', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: akta', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 03:23:57'),
(497, 16, 'amri', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: cendikia', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 03:24:07'),
(498, 16, 'amri', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 03:24:16'),
(499, 7, 'ami', 'search', 'documents_arsip', NULL, NULL, 'Search keyword: cendikia', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 03:24:29'),
(500, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 03:24:50'),
(501, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 03:28:38'),
(502, 8, 'dodi', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 05:28:49'),
(503, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-23 05:55:56'),
(504, 11, 'venta', 'edit', 'users', 11, 'Ventania Gusti Amelza Agung', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-23 05:58:52'),
(505, 11, 'venta', 'login', 'auth', NULL, NULL, 'Login berhasil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-23 06:54:35'),
(506, 11, 'venta', 'edit', 'users', 11, 'Ventania Gusti Amelza Agung', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.5 Safari/605.1.15', '2026-09-23 07:02:12'),
(507, 14, 'innaya', 'edit', 'users', 14, 'Innaya Rizky', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 08:10:39'),
(508, 1, 'admin', 'logout', 'auth', NULL, NULL, 'Logout', '103.47.134.50', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-23 12:45:42'),
(509, 23, 'jaya', 'logout', 'auth', NULL, NULL, 'Logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-24 06:19:17'),
(510, 7, 'ami', 'logout', 'auth', NULL, NULL, 'Logout', '114.10.103.151', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-25 04:09:38'),
(511, 29, 'adrian', 'edit', 'users', 29, 'M Adrian Gumelar', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-10-01 05:16:33'),
(512, 29, 'adrian', 'edit', 'users', 29, 'M Adrian Gumelar', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-10-01 05:16:45'),
(513, 16, 'amri', 'edit', 'users', 16, 'AMRI ZAMANI', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', '2026-10-01 08:26:12'),
(514, 16, 'amri', 'edit', 'users', 16, 'AMRI ZAMANI', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', '2026-10-01 08:27:50'),
(515, 16, 'amri', 'edit', 'users', 16, 'AMRI ZAMANI', 'Memperbarui profil', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', '2026-10-01 08:32:38');

-- --------------------------------------------------------

--
-- Table structure for table `category_metadata_fields`
--

CREATE TABLE `category_metadata_fields` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `field_label` varchar(100) NOT NULL,
  `field_type` enum('text','date','number','textarea','select') DEFAULT 'text',
  `field_options` text DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT 0,
  `sort_order` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category_metadata_fields`
--

INSERT INTO `category_metadata_fields` (`id`, `category_id`, `field_name`, `field_label`, `field_type`, `field_options`, `is_required`, `sort_order`, `created_at`) VALUES
(1, 1, 'nomor_kontrak', 'Nomor Kontrak', 'text', NULL, 1, 1, '2026-09-10 05:34:55'),
(2, 1, 'tanggal_mulai', 'Tanggal Mulai', 'date', NULL, 1, 2, '2026-09-10 05:34:55'),
(6, 2, 'nomor_surat', 'Nomor Surat', 'text', NULL, 1, 1, '2026-09-10 05:34:55'),
(7, 2, 'tanggal_surat', 'Tanggal Surat', 'date', NULL, 1, 2, '2026-09-10 05:34:55'),
(8, 2, 'pengirim', 'Pengirim', 'text', NULL, 1, 3, '2026-09-10 05:34:55'),
(9, 2, 'perihal', 'Perihal', 'text', NULL, 1, 4, '2026-09-10 05:34:55'),
(10, 3, 'nomor_surat', 'Nomor Surat', 'text', NULL, 1, 1, '2026-09-10 05:34:55'),
(11, 3, 'tanggal_surat', 'Tanggal Surat', 'date', NULL, 1, 2, '2026-09-10 05:34:55'),
(12, 3, 'tujuan', 'Tujuan', 'text', NULL, 1, 3, '2026-09-10 05:34:55'),
(13, 3, 'perihal', 'Perihal', 'text', NULL, 1, 4, '2026-09-10 05:34:55'),
(14, 4, 'nomor_dokumen', 'Nomor Dokumen', 'text', NULL, 1, 1, '2026-09-10 05:34:55'),
(15, 4, 'tanggal_terbit', 'Tanggal Terbit', 'date', NULL, 1, 2, '2026-09-10 05:34:55'),
(17, 4, 'penerbit', 'Penerbit/Instansi', 'text', NULL, 1, 4, '2026-09-10 05:34:55'),
(18, 5, 'nomor_mou', 'Nomor MOU', 'text', NULL, 1, 1, '2026-09-10 05:34:55'),
(19, 5, 'tanggal_mulai', 'Tanggal Mulai', 'date', NULL, 1, 2, '2026-09-10 05:34:55'),
(21, 5, 'pihak_terlibat', 'Pihak yang Terlibat', 'textarea', NULL, 1, 4, '2026-09-10 05:34:55'),
(23, 2, 'tujuan', 'Tujuan', 'text', NULL, 1, 0, '2026-09-10 06:44:16'),
(25, 1, 'tanggal', 'Tanggal', 'text', NULL, 0, 0, '2026-09-18 06:28:30'),
(26, 7, 'tanggal_kontrak', 'Tanggal Kontrak', 'date', NULL, 0, 0, '2026-09-18 06:29:42'),
(27, 11, 'nomor_surat', 'Nomor Surat', 'number', NULL, 1, 0, '2026-09-21 07:30:22'),
(28, 11, 'tanggal_mulai', 'Tanggal Mulai', 'date', NULL, 1, 0, '2026-09-21 07:31:16');

-- --------------------------------------------------------

--
-- Table structure for table `dispositions`
--

CREATE TABLE `dispositions` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `status` enum('pending','accepted','rejected','forwarded','returned','completed') DEFAULT 'pending',
  `priority` enum('biasa','segera','sangat_segera') DEFAULT 'biasa',
  `nature` enum('biasa','rahasia','sangat_rahasia') DEFAULT 'biasa',
  `notes` text DEFAULT NULL,
  `action_notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `disposition_history`
--

CREATE TABLE `disposition_history` (
  `id` int(11) NOT NULL,
  `disposition_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` enum('created','accepted','rejected','forwarded','returned','completed') NOT NULL,
  `notes` text DEFAULT NULL,
  `to_user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `document_number` varchar(50) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT 0,
  `category` varchar(100) DEFAULT NULL,
  `tags` varchar(500) DEFAULT NULL,
  `status` enum('draft','pending_signature','signed','dispositioned','completed','rejected') DEFAULT 'draft',
  `document_type` enum('surat_masuk','surat_internal','surat_keluar') DEFAULT 'surat_masuk',
  `priority` enum('biasa','segera','sangat_segera') DEFAULT 'biasa',
  `nature` enum('biasa','rahasia','sangat_rahasia') DEFAULT 'biasa',
  `sender` varchar(255) DEFAULT NULL,
  `mail_number` varchar(100) DEFAULT NULL,
  `mail_date` date DEFAULT NULL,
  `verification_token` varchar(64) DEFAULT NULL,
  `verification_hash` varchar(64) DEFAULT NULL,
  `signed_pdf_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `user_id`, `recipient_id`, `document_number`, `title`, `description`, `file_path`, `file_type`, `file_size`, `category`, `tags`, `status`, `document_type`, `priority`, `nature`, `sender`, `mail_number`, `mail_date`, `verification_token`, `verification_hash`, `signed_pdf_path`, `created_at`, `updated_at`) VALUES
(23, 22, 14, 'LJU/2026/09/944A59', 'Surat Permohonan Koordinasi dan Pendampingan untuk Kades Sumber Jaya, Jati Agung', '', 'uploads/documents/LJU/2026/09/DOC_6ab32c551a2c60.47515661.pdf', 'pdf', 1240387, '', '', 'draft', 'surat_keluar', 'biasa', 'biasa', 'PT Lampung Jasa Utama', '186/LJU-DU/E/IX/2026', '2026-09-14', NULL, NULL, NULL, '2026-09-23 01:33:09', '2026-09-23 01:33:09'),
(24, 22, 14, 'LJU/2026/09/2EE2FE', 'Surat Permohonan Koordinasi dan Pendampingan untuk Polsek Jati Agung', '', 'uploads/documents/LJU/2026/09/DOC_6ab32ce3c0ce97.03503040.pdf', 'pdf', 1167348, '', '', 'draft', 'surat_keluar', 'biasa', 'biasa', '', '187/LJU-DU/E/IX/2026', '2026-09-14', NULL, NULL, NULL, '2026-09-23 01:35:31', '2026-09-23 01:35:31');

-- --------------------------------------------------------

--
-- Table structure for table `documents_arsip`
--

CREATE TABLE `documents_arsip` (
  `id` int(11) NOT NULL,
  `archive_number` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `folder_id` int(11) DEFAULT NULL,
  `current_version` int(11) DEFAULT 1,
  `status` enum('active','inactive','expired','archived') DEFAULT 'active',
  `expiry_date` date DEFAULT NULL,
  `expiry_alert_days` int(11) DEFAULT 30,
  `expiry_notified` tinyint(1) DEFAULT 0,
  `uploaded_by` int(11) NOT NULL,
  `division` enum('Keuangan','Pengadaan','Keamanan','Infokom','SDM','Direksi','IT','Legal','Kesekretariatan','JaKon','Pengangkutan & Pergudangan','Perdagangan','Energi & Migas') DEFAULT NULL,
  `department` enum('Keuangan & Umum','Bisnis','Sekretariat','Pengawas Internal') DEFAULT NULL,
  `is_confidential` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `documents_arsip`
--

INSERT INTO `documents_arsip` (`id`, `archive_number`, `title`, `description`, `category_id`, `folder_id`, `current_version`, `status`, `expiry_date`, `expiry_alert_days`, `expiry_notified`, `uploaded_by`, `division`, `department`, `is_confidential`, `created_at`, `updated_at`) VALUES
(11, '0005/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2023.12.06 No.11', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-17 09:10:41', '2026-09-17 09:16:28'),
(12, '0006/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2022.10.19 No. 14', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-17 09:14:59', '2026-09-17 09:14:59'),
(13, '0007/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2022.08.23 No. 18', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-17 09:27:06', '2026-09-17 09:27:06'),
(14, '0008/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2021.07.27 No.51', '', 4, 16, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-17 09:36:14', '2026-09-17 09:36:14'),
(15, '0009/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2021.02.19 No.39', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-17 09:39:27', '2026-09-17 09:39:27'),
(16, '0010/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2020.12.30 No. 54', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-17 09:54:27', '2026-09-17 09:56:13'),
(17, '0011/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2020.11.03 No.01', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-17 10:00:10', '2026-09-17 10:00:10'),
(18, '0012/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2020.09.21 No.65', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 02:38:49', '2026-09-18 02:38:49'),
(19, '0013/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2020.09.02 No.03', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 02:44:12', '2026-09-18 02:44:12'),
(20, '0014/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2020.07.09 No.23', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 02:54:00', '2026-09-18 02:54:00'),
(21, '0015/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2020.02.17 No.58', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 03:01:52', '2026-09-18 03:01:52'),
(22, '0016/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2019.07.17 No.79', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 04:36:35', '2026-09-18 06:08:42'),
(23, '0017/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2019.04.04 No.02', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 04:44:20', '2026-09-18 06:08:17'),
(24, '0018/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2019.01.15 No.30', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 04:45:40', '2026-09-18 06:08:03'),
(25, '0019/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2018.10.18 No.148', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 04:51:17', '2026-09-18 06:07:42'),
(26, '0020/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2018.10.18 No.147', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 04:53:09', '2026-09-18 06:07:26'),
(27, '0021/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2018.06.30 No.116', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 04:54:17', '2026-09-18 06:06:52'),
(28, '0022/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2018.03.12. No.60', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 05:02:45', '2026-09-18 06:06:38'),
(29, '0023/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2017.12.15 No.128', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 05:06:39', '2026-09-18 06:06:22'),
(30, '0024/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2017.10.10 N0.22', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 05:08:24', '2026-09-18 06:06:07'),
(31, '0025/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2017.06.22 No.161', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 05:18:33', '2026-09-18 05:18:33'),
(32, '0026/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2017.06.21 No.159', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 05:20:18', '2026-09-18 05:20:18'),
(33, '0027/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2017.01.20 No.122', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 05:41:18', '2026-09-18 05:41:18'),
(34, '0028/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2016.12.23. No.288', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:02:17', '2026-09-18 06:02:17'),
(35, '0029/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2016.06.02 No.13', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:03:40', '2026-09-18 06:03:40'),
(36, '0030/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2016.04.11 No.14', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:05:27', '2026-09-18 06:05:27'),
(37, '0031/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2015.08.06 No.03', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:19:17', '2026-09-18 06:19:17'),
(38, '0032/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2016.04.11 No.15', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:21:11', '2026-09-18 06:21:11'),
(39, '0033/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2015.04.06 No.09', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:27:04', '2026-09-18 06:27:04'),
(40, '0034/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2014.03.13 No.84', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:29:25', '2026-09-18 06:29:25'),
(41, '0035/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2013.07.16. No.264', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:31:08', '2026-09-18 06:31:08'),
(42, '0036/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2012.07.30 No.05', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:36:40', '2026-09-18 06:36:40'),
(43, '0037/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2012.06.05 No.01', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:38:00', '2026-09-18 06:38:00'),
(44, '0038/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2011.20.11 No.02', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:40:07', '2026-09-18 06:40:07'),
(45, '0039/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2011.04.15 No.06', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:41:18', '2026-09-18 06:41:18'),
(46, '0040/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2010.11.18 No.02', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:46:04', '2026-09-18 06:46:04'),
(47, '0041/LGL/LGL/ARSIP/IX/2026', 'Akta Notaris 2010.09.01 No.01', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:47:41', '2026-09-18 06:47:41'),
(48, '0042/LGL/LGL/ARSIP/IX/2026', 'Akta RUSLB 2024.08.29 No.03', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:52:27', '2026-09-18 06:52:27'),
(49, '0043/LGL/LGL/ARSIP/IX/2026', 'Akta RUPSLB PT LAMPUNG JASA UTAMA (Perseroda) 07-10-2025', '', 4, 4, 1, 'active', NULL, 30, 0, 11, 'Legal', 'Sekretariat', 0, '2026-09-18 06:54:08', '2026-09-18 06:54:08'),
(51, '0001/MOU/LGL/ARSIP/IX/2026', 'MOU ANTARA PT. LAMPU.NG JASA UTAMA |Perseroda) DAN PT. DAMAI LAUTAN NUSANTARA', 'KERJASAMA BAGI HASIL PEHDAPATAN (REVENUE SHARING)\r\nPENGOPERASIAN KAPAL FERRY RORO DI DERMAGA\r\nEKSEKUTIF I LINTASAN BAKAUHENI - MERAK', 5, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 03:01:02', '2026-09-21 03:01:02'),
(52, '0044/LGL/LGL/ARSIP/IX/2026', 'NIB PT Lampung Jasa Utama (Perseroda)', '', 4, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 03:11:08', '2026-09-21 03:11:08'),
(53, '0045/LGL/LGL/ARSIP/IX/2026', 'SBU KONTRUKSI GEDUNG HUNIAN PT LAMPUNG JASA UTAMA (PERSERODA)', '', 4, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 03:19:16', '2026-09-21 03:19:16'),
(54, '0046/LGL/LGL/ARSIP/IX/2026', 'SBU KONTRUKSI BANGUNAN SIPIL JALAN PT LAMPUNG JASA UTAMA (PERSERODA)', '', 4, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 03:21:18', '2026-09-21 03:21:18'),
(55, '0047/LGL/LGL/ARSIP/IX/2026', 'SBU KONTRUKSI JARINGAN IRIGASI DAN DRAINASE PT LAMPUNG JASA UTAMA (PERSERODA)', '', 4, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 03:23:14', '2026-09-21 03:23:14'),
(56, '0048/LGL/LGL/ARSIP/IX/2026', 'SBU KONTRUKSI GEDUNG PERKANTORAN PT LAMPUNG JASA UTAMA (PERSERODA)', '', 4, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 03:24:33', '2026-09-21 03:24:33'),
(57, '0001/PKS//LGL/IX/2026', 'PERJANJIAN ANTARA PT PELABUHAN TANJUNG PRIOK CABANG PANJANG DENGAN PT LAMPUNG JASA UTAMA', 'TENTANG KERJASAMA PELAYANAN JEMBATAN TIMBANG\r\nDI TERMINAL MULTIPURPOSE PELABUHAN PANJANG', 11, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 07:35:53', '2026-09-21 07:35:53'),
(58, '0002/PKS//LGL/IX/2026', 'PERJANJIAN ANTARA PT PELABUHAN TANJUNG PRIOK CABANG PANJANG DENGAN PT LAMPUNG JASA UTAMA', 'TENTANG KERJASAMA PELAYANAN JEMBATAN TIMBANG\r\nDI TERMINAL CURAH KERING PELABUHAN PANJANG', 11, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 07:39:07', '2026-09-21 07:39:07'),
(59, '0003/PKS//LGL/IX/2026', 'PERTANJIAN KERJASAMA ANTARA FT. LAMPUNG JASA UTAMA (Perseroda) DENGAN FT. DALOM LINTAS BERJAYA', 'TENTANG KERIASAMA OPERASIONAL KAPAL FERRY RORO DI\r\nDERMAGA EKSEKUTIF LINTASAN BAKAUHENI - MERAK', 11, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 07:42:32', '2026-09-21 07:42:32'),
(60, '0002/MOU/LGL/ARSIP/IX/2026', 'MOU ANTARA PT. LAMPU.NG JASA UTAMA |Perseroda) DAN PT. DAMAI LAUTAN NUSANTARA', 'TENTANG KERJASAMA BAGI HASIL PEHDAPATAN (REVENUE SHARING)\r\nPENGOPERASIAN KAPAL FERRY RORO DI DERMAGA\r\nEKSEKUTIF I LINTASAN BAKAUHENI - MERAK', 5, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 07:57:38', '2026-09-21 07:57:38'),
(61, '0003/MOU/LGL/ARSIP/IX/2026', 'MOU ANTARA PT LAMPUNG JASA UTAMA (PERSERODA) DENGAN HIMPUNAN PENGEMBANGAN PERMUKIMAN DAN PERUMAHAN RAKYAT', 'TENTANG KERJASAMA BIDANG PERMUKIMAN DAN PERUMAHA', 5, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 08:00:23', '2026-09-21 08:00:23'),
(62, '0004/MOU/LGL/ARSIP/IX/2026', 'MOU ANTARA PT JATENG PETRO ENERGl (Perseroda) DENGAN PT LAMPUNG JASA UTAIVIA (Perseroda)', 'TENTANG RENCANA KERJASAMA PEMANFAATAN GAS BUMI DAN\r\nPENGEMBANGAN ENERGI BARU DAN TERBARUKAN', 5, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 08:03:54', '2026-09-21 08:03:54'),
(63, '0004/PKS//LGL/IX/2026', 'KONTRAK PENGADAAN PEKERJAAN MANAGE SERVICE ANTARA PT TELEMATIKA MULTIMEDIA SOLuSI DENGAN PT LAMPUNG JASA UTAMA (PESERODA)', 'KONTRAK PENGADAAN PEKERJAAN MANAGE SERVICE', 11, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 08:08:41', '2026-09-21 08:08:41'),
(64, '0005/MOU/LGL/ARSIP/IX/2026', 'MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA)', 'TENTANG KERJA SAMA BIDANG TEKNOLOGI INFORMASI DAN KOMUNIKASI', 5, NULL, 1, 'active', NULL, 30, 0, 11, 'Legal', NULL, 0, '2026-09-21 08:42:29', '2026-09-21 08:42:29');

-- --------------------------------------------------------

--
-- Table structure for table `document_categories`
--

CREATE TABLE `document_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `numbering_format` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_categories`
--

INSERT INTO `document_categories` (`id`, `name`, `code`, `description`, `numbering_format`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Kontrak', 'KTR', 'Dokumen kontrak kerja sama', '{COUNTER}/{CODE}/{DIVISION}/ARSIP/{ROMAN_MONTH}/{YEAR}', 0, '2026-09-10 05:34:55', '2026-09-21 04:06:16'),
(2, 'Surat Masuk', 'SM', 'Surat masuk dari pihak eksternal', '{COUNTER}/{CODE}/{DIVISION}/ARSIP/{ROMAN_MONTH}/{YEAR}', 1, '2026-09-10 05:34:55', '2026-09-10 06:39:53'),
(3, 'Surat Keluar', 'SK', 'Surat keluar perusahaan', '{COUNTER}/{CODE}/{DIVISION}/ARSIP/{ROMAN_MONTH}/{YEAR}', 1, '2026-09-10 05:34:55', '2026-09-10 06:39:53'),
(4, 'Legalitas', 'LGL', 'Dokumen legalitas perusahaan', '{COUNTER}/{CODE}/{DIVISION}/ARSIP/{ROMAN_MONTH}/{YEAR}', 1, '2026-09-10 05:34:55', '2026-09-10 06:39:53'),
(5, 'MOU', 'MOU', 'Memorandum of Understanding', '{COUNTER}/{CODE}/{DIVISION}/ARSIP/{ROMAN_MONTH}/{YEAR}', 1, '2026-09-10 05:34:55', '2026-09-10 06:39:53'),
(6, 'Laporan Kerja', 'LK', '', '{COUNTER}/{CODE}/{DIVISION}/ARSIP/{ROMAN_MONTH}/{YEAR}', 1, '2026-09-10 05:36:08', '2026-09-10 06:39:53'),
(7, 'Perjanjian Kerahasiaan', 'NDA', '', '{COUNTER}/{CODE}/{DEPARTMENT}/{DIVISION}/{ROMAN_MONTH}/{YEAR}', 1, '2026-09-18 06:28:55', '2026-09-18 06:28:55'),
(11, 'Perjanjian Kerjasama', 'PKS', '', '{COUNTER}/{CODE}/{DEPARTMENT}/{DIVISION}/{ROMAN_MONTH}/{YEAR}', 1, '2026-09-21 07:27:45', '2026-09-21 07:27:45');

-- --------------------------------------------------------

--
-- Table structure for table `document_loans`
--

CREATE TABLE `document_loans` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `borrower_id` int(11) NOT NULL COMMENT 'User yang meminjam',
  `purpose` text NOT NULL COMMENT 'Keperluan peminjaman',
  `loan_date` date NOT NULL COMMENT 'Tanggal pinjam',
  `expected_return_date` date NOT NULL COMMENT 'Tanggal kembali yang dijanjikan',
  `actual_return_date` date DEFAULT NULL COMMENT 'Tanggal aktual pengembalian',
  `status` enum('borrowed','returned','overdue','lost') DEFAULT 'borrowed',
  `return_notes` text DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL COMMENT 'User Sekretariat yang menyetujui',
  `returned_to` int(11) DEFAULT NULL COMMENT 'User yang menerima pengembalian',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_loans`
--

INSERT INTO `document_loans` (`id`, `document_id`, `borrower_id`, `purpose`, `loan_date`, `expected_return_date`, `actual_return_date`, `status`, `return_notes`, `approved_by`, `returned_to`, `created_at`, `updated_at`) VALUES
(2, 64, 8, 'foto copy', '2026-09-22', '2026-09-30', NULL, 'borrowed', NULL, 11, NULL, '2026-09-22 03:41:22', '2026-09-22 03:41:22');

-- --------------------------------------------------------

--
-- Table structure for table `document_locations`
--

CREATE TABLE `document_locations` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `placed_by` int(11) DEFAULT NULL,
  `placed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_metadata`
--

CREATE TABLE `document_metadata` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `field_value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_metadata`
--

INSERT INTO `document_metadata` (`id`, `document_id`, `field_id`, `field_value`) VALUES
(40, 12, 14, '14'),
(41, 12, 15, '2022-10-19'),
(42, 12, 17, 'NOTARIS Nedi Heryandi, S.H'),
(43, 11, 14, '11'),
(44, 11, 15, '2023-12-06'),
(45, 11, 17, 'NOTARIS & PPAT Fahrul Rozi, S.H'),
(46, 13, 14, '18'),
(47, 13, 15, '2022-08-23'),
(48, 13, 17, 'NOTARIS Triadi Kurniawan, S.H., M.Kn'),
(49, 14, 14, '51'),
(50, 14, 15, '2021-07-27'),
(51, 14, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(52, 15, 14, '39'),
(53, 15, 15, '2021-02-19'),
(54, 15, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(58, 16, 14, '54'),
(59, 16, 15, '2020-12-30'),
(60, 16, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(61, 17, 14, '01'),
(62, 17, 15, '2020-11-03'),
(63, 17, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(64, 18, 14, '65'),
(65, 18, 15, '2020-09-21'),
(66, 18, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(67, 19, 14, '03'),
(68, 19, 15, '2020-09-02'),
(69, 19, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(70, 20, 14, '23'),
(71, 20, 15, '2020-07-09'),
(72, 20, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(73, 21, 14, '58'),
(74, 21, 15, '2020-02-17'),
(75, 21, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(103, 31, 14, '161'),
(104, 31, 15, '2017-06-22'),
(105, 31, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(106, 32, 14, '159'),
(107, 32, 15, '2017-06-21'),
(108, 32, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(118, 33, 14, '122'),
(119, 33, 15, '2017-01-20'),
(120, 33, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(121, 34, 14, '288'),
(122, 34, 15, '2016-12-23'),
(123, 34, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(124, 35, 14, '13'),
(125, 35, 15, '2016-06-02'),
(126, 35, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(127, 36, 14, '14'),
(128, 36, 15, '2016-04-11'),
(129, 36, 17, 'NOTARIS Nedi Heryandi, S.H'),
(130, 30, 14, '22'),
(131, 30, 15, '2017-10-10'),
(132, 30, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(133, 29, 14, '128'),
(134, 29, 15, '2017-12-15'),
(135, 29, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(136, 28, 14, '60'),
(137, 28, 15, '2018-03-12'),
(138, 28, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(139, 27, 14, '116'),
(140, 27, 15, '2018-06-30'),
(141, 27, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(142, 26, 14, '147'),
(143, 26, 15, '2018-10-18'),
(144, 26, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(145, 25, 14, '148'),
(146, 25, 15, '2018-10-18'),
(147, 25, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(148, 24, 14, '30'),
(149, 24, 15, '2019-01-15'),
(150, 24, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(151, 23, 14, '02'),
(152, 23, 15, '2019-04-04'),
(153, 23, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(154, 22, 14, '79'),
(155, 22, 15, '2019-07-17'),
(156, 22, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(157, 37, 14, '03'),
(158, 37, 15, '2015-08-06'),
(159, 37, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(160, 38, 14, '15'),
(161, 38, 15, '2016-04-11'),
(162, 38, 17, 'NOTARIS Nedi Heryandi, S.H'),
(163, 39, 14, '09'),
(164, 39, 15, '2015-04-06'),
(165, 39, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(166, 40, 14, '84'),
(167, 40, 15, '2014-03-13'),
(168, 40, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(169, 41, 14, '264'),
(170, 41, 15, '2013-07-16'),
(171, 41, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(172, 42, 14, '05'),
(173, 42, 15, '2012-07-30'),
(174, 42, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(175, 43, 14, '01'),
(176, 43, 15, '2012-06-05'),
(177, 43, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(178, 44, 14, '02'),
(179, 44, 15, '2011-10-11'),
(180, 44, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(181, 45, 14, '06'),
(182, 45, 15, '2011-04-15'),
(183, 45, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(184, 46, 14, '02'),
(185, 46, 15, '2010-11-18'),
(186, 46, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(187, 47, 14, '01'),
(188, 47, 15, '2010-09-01'),
(189, 47, 17, 'NOTARIS & PPAT Siti Agustina Sari, S.H,.M.Kn'),
(190, 48, 14, '03'),
(191, 48, 15, '2024-08-29'),
(192, 48, 17, 'NOTARIS Muhammad Novandi, S.H.,M.Kn'),
(193, 49, 14, '07'),
(194, 49, 15, '2025-10-07'),
(195, 49, 17, 'NOTARIS Muhammad Novandi, S.H.,M.Kn'),
(196, 51, 18, '001/I^JU-DLN/MOU/X/2025  '),
(197, 51, 19, '2025-10-15'),
(199, 51, 21, 'PT Damai Lautan Nusantara'),
(200, 52, 14, '1236000440759'),
(201, 52, 15, '2026-07-01'),
(202, 52, 17, 'Kementrian Investasi dan Hilirisasi / BKPM (Lembaga OSS)'),
(203, 53, 14, '202606111328147826954'),
(204, 53, 15, '2026-06-15'),
(205, 53, 17, 'GAPEKNAS'),
(206, 54, 14, ' 202606111356135053565'),
(207, 54, 15, '2026-06-15'),
(208, 54, 17, 'GAPEKNAS'),
(209, 55, 14, '202606111400104862297'),
(210, 55, 15, '2026-06-15'),
(211, 55, 17, 'GAPEKNAS'),
(212, 56, 14, '202606111354070681328'),
(213, 56, 15, '2026-06-15'),
(214, 56, 17, 'GAPEKNAS'),
(215, 57, 27, '019'),
(216, 57, 28, '2024-04-30'),
(217, 58, 27, '020'),
(218, 58, 28, '2024-08-01'),
(219, 59, 27, '001'),
(220, 59, 28, '2025-10-17'),
(221, 60, 18, '01/I^JU-DLN/MOU/X/2025 '),
(222, 60, 19, '2025-10-15'),
(223, 60, 21, 'FT. DAMAI LAUTAN NUSAHTA'),
(224, 61, 18, ' 001/LJU-HPP/MOU/I/2025'),
(225, 61, 19, '2025-01-01'),
(226, 61, 21, 'HIMPUNAN PENGEMBANGAN PERMUKIMAN DAN PERUMAHAN RAKYAT'),
(227, 62, 18, ': 001 /LJU.PEN/lvIOU/I/2026'),
(228, 62, 19, '2026-01-06'),
(229, 62, 21, 'PT JATENG PETRO ENERGl (Perseroda)'),
(230, 63, 27, '001'),
(231, 63, 28, '2026-01-01'),
(232, 64, 18, '003/LJU-CGS/MoU/VII/2024'),
(233, 64, 19, '2024-07-30'),
(234, 64, 21, 'PT CENDIKIA GLOBAL SOLUSI');

-- --------------------------------------------------------

--
-- Table structure for table `document_permissions`
--

CREATE TABLE `document_permissions` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `division` enum('Keuangan','Pengadaan','Keamanan','Infokom','SDM','Direksi','IT','Legal','Kesekretariatan','JaKon','Pengangkutan & Pergudangan','Perdagangan','Energi & Migas') DEFAULT NULL,
  `department` enum('Keuangan & Umum','Bisnis','Sekretariat','Pengawas Internal') DEFAULT NULL,
  `can_read` tinyint(1) DEFAULT 1,
  `can_download` tinyint(1) DEFAULT 0,
  `can_edit` tinyint(1) DEFAULT 0,
  `can_delete` tinyint(1) DEFAULT 0,
  `granted_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_tags`
--

CREATE TABLE `document_tags` (
  `document_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_tags`
--

INSERT INTO `document_tags` (`document_id`, `tag_id`) VALUES
(51, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(12, 5),
(13, 5),
(14, 5),
(15, 5),
(16, 5),
(17, 5),
(18, 5),
(19, 5),
(20, 5),
(21, 5),
(22, 5),
(23, 5),
(24, 5),
(25, 5),
(26, 5),
(27, 5),
(28, 5),
(29, 5),
(30, 5),
(31, 5),
(32, 5),
(33, 5),
(34, 5),
(35, 5),
(36, 5),
(37, 5),
(38, 5),
(39, 5),
(40, 5),
(41, 5),
(42, 5),
(43, 5),
(44, 5),
(45, 5),
(46, 5),
(47, 5),
(48, 5),
(49, 5),
(52, 5),
(53, 5),
(54, 5),
(55, 5),
(56, 5);

-- --------------------------------------------------------

--
-- Table structure for table `document_versions`
--

CREATE TABLE `document_versions` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `version_number` varchar(10) NOT NULL DEFAULT '1.0',
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) DEFAULT 0,
  `file_type` varchar(50) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `change_notes` text DEFAULT NULL,
  `uploaded_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_versions`
--

INSERT INTO `document_versions` (`id`, `document_id`, `version_number`, `file_name`, `file_path`, `file_size`, `file_type`, `mime_type`, `change_notes`, `uploaded_by`, `created_at`) VALUES
(11, 11, '1.0', 'Akta Notaris 2023.12.06 No. 11.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/11/v1.0_1789636241_Akta_Notaris_2023.12.06_No._11.pdf', 4658994, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-17 09:10:41'),
(12, 12, '1.0', 'Akta Notaris 2022.10.19 No. 14.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/12/v1.0_1789636499_Akta_Notaris_2022.10.19_No._14.pdf', 3557828, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-17 09:14:59'),
(13, 13, '1.0', 'Akta Notaris 2022.08.23 No. 18.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/13/v1.0_1789637226_Akta_Notaris_2022.08.23_No._18.pdf', 18753539, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-17 09:27:06'),
(14, 14, '1.0', 'Akta Notaris 2021.07.27 No. 51.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/14/v1.0_1789637774_Akta_Notaris_2021.07.27_No._51.pdf', 5783011, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-17 09:36:14'),
(15, 15, '1.0', 'Akta Notaris 2021.02.19 No. 39.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/15/v1.0_1789637967_Akta_Notaris_2021.02.19_No._39.pdf', 4629004, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-17 09:39:27'),
(16, 16, '1.0', 'Akta Notaris 2020.12.30 No. 54.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/16/v1.0_1789638867_Akta_Notaris_2020.12.30_No._54.pdf', 900739, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-17 09:54:27'),
(17, 17, '1.0', 'Akta Notaris 2020.11.03 No. 01.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/17/v1.0_1789639210_Akta_Notaris_2020.11.03_No._01.pdf', 4754302, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-17 10:00:10'),
(18, 18, '1.0', 'Akta Notaris 2020.09.21 No. 65.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/18/v1.0_1789699129_Akta_Notaris_2020.09.21_No._65.pdf', 17369925, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 02:38:49'),
(19, 19, '1.0', 'Akta Notaris 2020.09.02 No. 03.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/19/v1.0_1789699452_Akta_Notaris_2020.09.02_No._03.pdf', 26709494, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 02:44:12'),
(20, 20, '1.0', 'Akta Notaris 2020.07.09 No. 23.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/20/v1.0_1789700040_Akta_Notaris_2020.07.09_No._23.pdf', 1263622, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 02:54:00'),
(21, 21, '1.0', 'Akta Notaris 2020.02.17 No. 58.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/21/v1.0_1789700512_Akta_Notaris_2020.02.17_No._58.pdf', 975884, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 03:01:52'),
(22, 22, '1.0', 'Akta Notaris 2019.07.17 No. 79.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/22/v1.0_1789706195_Akta_Notaris_2019.07.17_No._79.pdf', 1274798, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 04:36:35'),
(23, 23, '1.0', 'Akta Notaris 2019.04.04 No. 02.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/23/v1.0_1789706660_Akta_Notaris_2019.04.04_No._02.pdf', 868796, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 04:44:20'),
(24, 24, '1.0', 'Akta Notaris 2019.01.15 No. 30.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/24/v1.0_1789706740_Akta_Notaris_2019.01.15_No._30.pdf', 888744, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 04:45:40'),
(25, 25, '1.0', 'Akta Notaris 2018.10.18 No. 148.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/25/v1.0_1789707078_Akta_Notaris_2018.10.18_No._148.pdf', 3932785, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 04:51:18'),
(26, 26, '1.0', 'Akta Notaris 2018.10.18 No. 147.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/26/v1.0_1789707189_Akta_Notaris_2018.10.18_No._147.pdf', 900717, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 04:53:09'),
(27, 27, '1.0', 'Akta Notaris 2018.06.30 No. 116.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/27/v1.0_1789707257_Akta_Notaris_2018.06.30_No._116.pdf', 2446819, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 04:54:17'),
(28, 28, '1.0', 'Akta Notaris 2018.03.12 No. 60.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/28/v1.0_1789707765_Akta_Notaris_2018.03.12_No._60.pdf', 4228579, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 05:02:45'),
(29, 29, '1.0', 'Akta Notaris 2017.12.15 No. 128.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/29/v1.0_1789708000_Akta_Notaris_2017.12.15_No._128.pdf', 11732521, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 05:06:40'),
(30, 30, '1.0', 'Akta Notaris 2017.10.10 No. 22.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/30/v1.0_1789708104_Akta_Notaris_2017.10.10_No._22.pdf', 11114511, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 05:08:24'),
(31, 31, '1.0', 'Akta Notaris 2017.06.22 No. 161.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/31/v1.0_1789708713_Akta_Notaris_2017.06.22_No._161.pdf', 5849492, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 05:18:33'),
(32, 32, '1.0', 'Akta Notaris 2017.06.21 No. 159.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/32/v1.0_1789708818_Akta_Notaris_2017.06.21_No._159.pdf', 6311142, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 05:20:18'),
(33, 33, '1.0', 'Akta Notaris 2017.01.20 No. 122.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/33/v1.0_1789710079_Akta_Notaris_2017.01.20_No._122.pdf', 1915597, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 05:41:19'),
(34, 34, '1.0', 'Akta Notaris 2016.12.23 No. 288.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/34/v1.0_1789711337_Akta_Notaris_2016.12.23_No._288.pdf', 2210741, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:02:17'),
(35, 35, '1.0', 'Akta Notaris 2016.06.02 No. 13.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/35/v1.0_1789711420_Akta_Notaris_2016.06.02_No._13.pdf', 2557162, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:03:40'),
(36, 36, '1.0', 'Akta Notaris 2016.04.11 No. 14.Pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/36/v1.0_1789711527_Akta_Notaris_2016.04.11_No._14.Pdf', 1924448, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:05:27'),
(37, 37, '1.0', 'Akta Notaris 2015.08.06 No. 03.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/37/v1.0_1789712357_Akta_Notaris_2015.08.06_No._03.pdf', 1253441, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:19:17'),
(38, 38, '1.0', 'Akta Notaris 2016.04.11 No. 15.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/38/v1.0_1789712471_Akta_Notaris_2016.04.11_No._15.pdf', 11776667, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:21:11'),
(39, 39, '1.0', 'Akta Notaris 2015.04.06 No. 09.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/39/v1.0_1789712825_Akta_Notaris_2015.04.06_No._09.pdf', 3975322, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:27:05'),
(40, 40, '1.0', 'Akta Notaris 2014.03.13 No. 84.Pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/40/v1.0_1789712965_Akta_Notaris_2014.03.13_No._84.Pdf', 1048550, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:29:25'),
(41, 41, '1.0', 'Akta Notaris 2013.07.16 No. 264.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/41/v1.0_1789713068_Akta_Notaris_2013.07.16_No._264.pdf', 4182800, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:31:08'),
(42, 42, '1.0', 'Akta Notaris 2012.07.30 No. 05.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/42/v1.0_1789713400_Akta_Notaris_2012.07.30_No._05.pdf', 1253968, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:36:40'),
(43, 43, '1.0', 'Akta Notaris 2012.06.05 No. 01.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/43/v1.0_1789713480_Akta_Notaris_2012.06.05_No._01.pdf', 1888931, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:38:00'),
(44, 44, '1.0', 'Akta Notaris 2011.10.11 No. 02.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/44/v1.0_1789713607_Akta_Notaris_2011.10.11_No._02.pdf', 1405329, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:40:07'),
(45, 45, '1.0', 'Akta Notaris 2011.04.15 No. 06.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/45/v1.0_1789713678_Akta_Notaris_2011.04.15_No._06.pdf', 5202132, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:41:18'),
(46, 46, '1.0', 'Akta Notaris 2010.11.18 No. 02.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/46/v1.0_1789713964_Akta_Notaris_2010.11.18_No._02.pdf', 1260789, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:46:04'),
(47, 47, '1.0', 'Akta Notaris 2010.09.01 No. 01.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/47/v1.0_1789714061_Akta_Notaris_2010.09.01_No._01.pdf', 3540225, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:47:41'),
(48, 48, '1.0', 'Salinan Akta RUPSLB 2024.08.29 No.03.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/48/v1.0_1789714347_Salinan_Akta_RUPSLB_2024.08.29_No.03.pdf', 15679873, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:52:27'),
(49, 49, '1.0', 'Akta RUPSLB PT. LAMPUNG JASA UTAMA (Perseroda) 07-10-2025.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/49/v1.0_1789714448_Akta_RUPSLB_PT._LAMPUNG_JASA_UTAMA__Perseroda__07-10-2025.pdf', 4768332, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-18 06:54:08'),
(51, 51, '1.0', '001_LJU-DLN_MOU_X_2025.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/51/v1.0_1789959662_001_LJU-DLN_MOU_X_2025.pdf', 3356669, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 03:01:02'),
(52, 52, '1.0', 'Nomor Induk Berusaha PT Lampung Jasa Utama.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/52/v1.0_1789960268_Nomor_Induk_Berusaha_PT_Lampung_Jasa_Utama.pdf', 1090868, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 03:11:08'),
(53, 53, '1.0', 'SBU PT LAMPUNG JASA UTAMA_BG001.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/53/v1.0_1789960756_SBU_PT_LAMPUNG_JASA_UTAMA_BG001.pdf', 529420, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 03:19:16'),
(54, 54, '1.0', 'SBU PT LAMPUNG JASA UTAMA_BS001.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/54/v1.0_1789960878_SBU_PT_LAMPUNG_JASA_UTAMA_BS001.pdf', 529415, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 03:21:18'),
(55, 55, '1.0', 'SBU PT LAMPUNG JASA UTAMA_BS004.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/55/v1.0_1789960994_SBU_PT_LAMPUNG_JASA_UTAMA_BS004.pdf', 529690, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 03:23:14'),
(56, 56, '1.0', 'SBU PT LAMPUNG JASA UTAMA_BG002.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/56/v1.0_1789961073_SBU_PT_LAMPUNG_JASA_UTAMA_BG002.pdf', 529426, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 03:24:33'),
(57, 57, '1.0', '019_LJU-PTP_PKS_VIII_2024.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/57/v1.0_1789976153_019_LJU-PTP_PKS_VIII_2024.pdf', 5641510, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 07:35:53'),
(58, 58, '1.0', 'TCK 020_LJU-PTP_PKS_VIII_2024.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/58/v1.0_1789976347_TCK_020_LJU-PTP_PKS_VIII_2024.pdf', 4258945, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 07:39:07'),
(59, 59, '1.0', '001_LJU-DLB_PKS_X_2025.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/59/v1.0_1789976552_001_LJU-DLB_PKS_X_2025.pdf', 3256703, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 07:42:32'),
(60, 60, '1.0', '001_LJU-DLN_MOU_X_2025.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/60/v1.0_1789977458_001_LJU-DLN_MOU_X_2025.pdf', 3356669, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 07:57:38'),
(61, 61, '1.0', '001_LJU-HPP_MOU_I_2025.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/61/v1.0_1789977623_001_LJU-HPP_MOU_I_2025.pdf', 2220057, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 08:00:23'),
(62, 62, '1.0', '001_LJU-JPEN_MOU_I_2026.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/62/v1.0_1789977834_001_LJU-JPEN_MOU_I_2026.pdf', 2666052, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 08:03:54'),
(63, 63, '1.0', '001_LJU-TMS_MS_I_2026.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/63/v1.0_1789978121_001_LJU-TMS_MS_I_2026.pdf', 2600783, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 08:08:41'),
(64, 64, '1.0', '003_LJU-CGS_MoU_VII_2024 dan 025_CGS-LGL_PKS_VII_2024.pdf', '/home/ljucoid/dms.lju.co.id/arsip/config/../uploads/documents/64/v1.0_1789980149_003_LJU-CGS_MoU_VII_2024_dan_025_CGS-LGL_PKS_VII_2024.pdf', 2348657, 'pdf', 'application/pdf', 'Initial upload', 11, '2026-09-21 08:42:29');

-- --------------------------------------------------------

--
-- Table structure for table `folders`
--

CREATE TABLE `folders` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `division` enum('Keuangan','Pengadaan','Keamanan','Infokom','SDM','Direksi','IT','Legal','Kesekretariatan','JaKon','Pengangkutan & Pergudangan','Perdagangan','Energi & Migas') DEFAULT NULL,
  `department` enum('Keuangan & Umum','Bisnis','Sekretariat','Pengawas Internal') DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `folders`
--

INSERT INTO `folders` (`id`, `name`, `parent_id`, `division`, `department`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Direksi', NULL, 'Direksi', NULL, NULL, '2026-09-10 05:34:55', '2026-09-10 05:34:55'),
(2, 'Keuangan', 13, 'Keuangan', NULL, NULL, '2026-09-10 05:34:55', '2026-09-11 02:04:55'),
(3, 'SDM', 13, 'SDM', NULL, NULL, '2026-09-10 05:34:55', '2026-09-11 02:05:47'),
(4, 'Legal', 14, 'Legal', NULL, NULL, '2026-09-10 05:34:55', '2026-09-11 02:05:01'),
(5, 'IT', NULL, 'IT', NULL, NULL, '2026-09-10 05:34:55', '2026-09-10 05:34:55'),
(7, 'Pengadaan', 14, 'Pengadaan', NULL, NULL, '2026-09-10 05:34:55', '2026-09-11 02:05:11'),
(8, 'Kesekretariatan', 14, '', NULL, NULL, '2026-09-10 05:34:55', '2026-09-11 02:05:22'),
(10, 'Keamanan', NULL, 'Keamanan', NULL, NULL, '2026-09-10 05:34:55', '2026-09-10 05:34:55'),
(11, 'Infokom', 12, 'Infokom', NULL, NULL, '2026-09-10 05:34:55', '2026-09-11 02:06:01'),
(12, 'Bisnis', NULL, NULL, 'Bisnis', NULL, '2026-09-11 02:04:06', '2026-09-11 02:07:31'),
(13, 'Keuangan & Umum', NULL, NULL, 'Keuangan & Umum', NULL, '2026-09-11 02:04:13', '2026-09-11 02:07:36'),
(14, 'Sekretariat', NULL, NULL, 'Sekretariat', NULL, '2026-09-11 02:04:19', '2026-09-11 02:07:39'),
(15, 'Pengawas Internal', NULL, NULL, 'Pengawas Internal', NULL, '2026-09-11 02:04:29', '2026-09-11 02:07:44'),
(16, 'Jasa Konstruksi', 12, 'JaKon', NULL, NULL, '2026-09-11 02:06:26', '2026-09-11 02:06:26'),
(17, 'Pengangkutan & Pergudangan', 12, 'Pengangkutan & Pergudangan', NULL, NULL, '2026-09-11 02:06:40', '2026-09-11 02:06:40'),
(18, 'Perdagangan', 12, 'Perdagangan', NULL, NULL, '2026-09-11 02:06:52', '2026-09-11 02:06:52'),
(19, 'Energi & Migas', 12, 'Energi & Migas', NULL, NULL, '2026-09-11 02:07:03', '2026-09-11 02:07:03');

-- --------------------------------------------------------

--
-- Table structure for table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `activity` varchar(50) NOT NULL COMMENT 'login_success, logout, login_failed',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_logs`
--

INSERT INTO `login_logs` (`id`, `user_id`, `activity`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 7, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-25 12:54:31'),
(2, 7, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-25 13:02:02'),
(3, 7, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-25 13:29:16'),
(4, 1, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-25 13:36:54'),
(5, 1, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-25 13:39:07'),
(6, 16, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-25 13:40:42'),
(7, 7, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-25 13:59:58'),
(8, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-25 17:02:26'),
(9, 16, 'logout', '103.59.45.210', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-26 03:04:34'),
(10, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:17:03'),
(11, 16, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:21:34'),
(12, 29, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:22:45'),
(13, 16, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:30:46'),
(14, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:33:34'),
(15, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:44:22'),
(16, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:59:15'),
(17, 16, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:59:26'),
(18, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 04:59:37'),
(19, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 06:12:01'),
(20, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 11:31:22'),
(21, 15, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-26 11:37:29'),
(22, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 04:04:17'),
(23, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 05:20:48'),
(24, 7, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 06:03:17'),
(25, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 07:23:02'),
(26, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 07:33:11'),
(27, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 09:55:23'),
(28, 16, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 09:55:31'),
(29, 7, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 09:57:15'),
(30, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 11:34:25'),
(31, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 11:34:51'),
(32, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 11:56:56'),
(33, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 11:59:17'),
(34, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 12:06:19'),
(35, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 12:07:00'),
(36, 18, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-27 12:09:37'),
(37, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 02:10:45'),
(38, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 03:20:39'),
(39, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 03:29:43'),
(40, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 03:30:07'),
(41, 7, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 03:30:18'),
(42, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 03:33:11'),
(43, 14, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-09-28 04:49:08'),
(44, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:36:15'),
(45, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:37:55'),
(46, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:41:33'),
(47, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:45:28'),
(48, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:45:36'),
(49, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:48:38'),
(50, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:51:59'),
(51, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:52:11'),
(52, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:52:41'),
(53, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:54:35'),
(54, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:54:40'),
(55, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:58:41'),
(56, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:58:47'),
(57, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:59:31'),
(58, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 06:59:36'),
(59, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:03:12'),
(60, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:03:14'),
(61, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:23:30'),
(62, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:23:43'),
(63, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:26:03'),
(64, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:29:13'),
(65, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:29:44'),
(66, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:30:45'),
(67, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:32:52'),
(68, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-28 07:33:29'),
(69, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-28 10:01:30'),
(70, 7, 'login_failed', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-09-29 02:47:57'),
(71, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-09-29 02:48:02'),
(72, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-09-29 02:54:15'),
(73, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-09-29 03:17:59'),
(74, 7, 'login_success', '103.47.134.50', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-29 13:21:30'),
(75, 7, 'logout', '103.47.134.50', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-29 13:21:47'),
(76, 1, 'login_success', '103.47.134.50', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-29 13:21:59'),
(77, 1, 'logout', '103.47.134.50', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-29 13:24:48'),
(78, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-09-29 22:09:59'),
(79, 1, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-09-29 22:18:58'),
(80, 7, 'login_success', '156.230.191.132', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-29 23:08:34'),
(81, 7, 'logout', '156.230.191.132', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-29 23:09:07'),
(82, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 02:27:49'),
(83, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 02:30:43'),
(84, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 02:30:55'),
(85, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 02:55:15'),
(86, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 02:55:18'),
(87, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 03:16:24'),
(88, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 03:25:07'),
(89, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 03:25:09'),
(90, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 03:38:59'),
(91, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-09-30 03:39:03'),
(92, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 04:13:33'),
(93, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 06:03:21'),
(94, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 06:32:44'),
(95, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 08:29:37'),
(96, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 08:29:49'),
(97, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 08:29:56'),
(98, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 08:30:18'),
(99, 24, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-30 08:30:27'),
(100, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-30 08:31:11'),
(101, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-30 08:31:41'),
(102, 16, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-30 08:31:52'),
(103, 16, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-30 08:32:38'),
(104, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-30 08:32:41'),
(105, 7, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-30 08:57:01'),
(106, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-30 08:57:07'),
(107, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-30 08:57:26'),
(108, 16, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Mobile Safari/537.36', '2026-09-30 08:57:46'),
(109, 21, 'login_success', '114.10.102.134', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-09-30 09:00:33'),
(110, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 09:03:44'),
(111, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-09-30 09:04:22'),
(112, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-30 09:09:37'),
(113, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-09-30 13:32:36'),
(114, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 02:22:35'),
(115, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 02:22:43'),
(116, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 02:23:09'),
(117, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 02:30:18'),
(118, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 05:14:23'),
(119, 29, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-10-01 05:15:08'),
(120, 29, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-10-01 05:16:54'),
(121, 29, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-10-01 05:17:04'),
(122, 29, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/153.0.0.0 Safari/537.36', '2026-10-01 05:17:12'),
(123, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 05:29:05'),
(124, 23, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-01 06:10:32'),
(125, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-01 06:13:27'),
(126, 28, 'login_success', '103.38.110.54', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.7.5 Mobile/15E148 Safari/604.1', '2026-10-01 06:35:26'),
(127, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 06:48:24'),
(128, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 07:59:35'),
(129, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 08:02:57'),
(130, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 08:02:59'),
(131, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 08:05:15'),
(132, 16, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', '2026-10-01 08:20:54'),
(133, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-01 08:26:03'),
(134, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 08:40:14'),
(135, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 08:59:43'),
(136, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 09:00:16'),
(137, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 09:01:02'),
(138, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 09:02:25'),
(139, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 09:04:41'),
(140, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 09:08:43'),
(141, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 09:34:42'),
(142, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-01 09:37:11'),
(143, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-01 09:37:51'),
(144, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 09:44:19'),
(145, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-01 09:47:31'),
(146, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-01 09:50:55'),
(147, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 10:00:16'),
(148, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-01 10:15:59'),
(149, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-01 10:20:20'),
(150, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 10:21:33'),
(151, 21, 'login_failed', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 10:21:59'),
(152, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 10:22:13'),
(153, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-01 10:25:04'),
(154, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 10:46:54'),
(155, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 10:46:57'),
(156, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 10:47:15'),
(157, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 11:19:48'),
(158, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 11:20:58'),
(159, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 11:21:08'),
(160, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 11:25:43'),
(161, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 11:48:24'),
(162, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:05:28'),
(163, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:05:31'),
(164, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:07:28'),
(165, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:07:30'),
(166, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:55:01'),
(167, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:55:03'),
(168, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:56:34'),
(169, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:56:43'),
(170, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:58:02'),
(171, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:58:05'),
(172, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:58:37'),
(173, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 12:58:42'),
(174, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:01:45'),
(175, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:01:48'),
(176, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:13:46'),
(177, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:13:49'),
(178, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:20:58'),
(179, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:21:01'),
(180, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:29:31'),
(181, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:29:33'),
(182, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:30:54'),
(183, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:31:39'),
(184, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 13:32:01'),
(185, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 22:24:32'),
(186, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 22:38:59'),
(187, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 22:39:01'),
(188, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 22:45:33'),
(189, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-01 22:45:37'),
(190, 7, 'login_success', '114.10.101.96', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-02 00:40:07'),
(191, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 01:47:44'),
(192, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 01:48:38'),
(193, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 02:18:14'),
(194, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 02:19:51'),
(195, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 02:40:38'),
(196, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 04:17:14'),
(197, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 04:18:34'),
(198, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 04:24:47'),
(199, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-02 04:24:56'),
(200, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 04:27:31'),
(201, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 04:27:52'),
(202, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 04:28:51'),
(203, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 04:32:23'),
(204, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 04:32:49'),
(205, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 05:30:28'),
(206, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 05:37:11'),
(207, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 05:41:09'),
(208, 16, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15', '2026-10-02 05:55:10'),
(209, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 06:30:57'),
(210, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 06:44:02'),
(211, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 06:44:47'),
(212, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 06:45:17'),
(213, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 07:52:18'),
(214, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 07:52:39'),
(215, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 07:54:30'),
(216, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 07:54:53'),
(217, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 07:55:24'),
(218, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 08:00:02'),
(219, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 09:11:00'),
(220, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 09:24:38'),
(221, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 09:26:24'),
(222, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 10:53:43'),
(223, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 11:05:23'),
(224, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-02 11:55:18'),
(225, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 12:49:21'),
(226, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 12:50:37'),
(227, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 13:02:57'),
(228, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 13:20:30'),
(229, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 13:23:16'),
(230, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 13:31:54'),
(231, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:02:35'),
(232, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:04:48'),
(233, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:05:14'),
(234, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:17:32'),
(235, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:18:27'),
(236, 36, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:18:31'),
(237, 36, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:19:35'),
(238, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:26:48'),
(239, 36, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-02 22:27:27'),
(240, 1, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 00:19:49'),
(241, 7, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:22:50'),
(242, 7, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:23:32'),
(243, 1, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:24:36'),
(244, 1, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:27:30'),
(245, 35, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:27:33'),
(246, 35, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:37:29'),
(247, 35, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:40:18'),
(248, 35, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:40:37'),
(249, 1, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 05:40:42'),
(250, 1, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 06:19:13'),
(251, 7, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 06:19:16'),
(252, 7, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 06:21:38'),
(253, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 06:25:12'),
(254, 7, 'logout', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 06:27:27'),
(255, 7, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 06:29:18'),
(256, 7, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 06:33:31'),
(257, 1, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 06:33:34'),
(258, 1, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 06:35:35'),
(259, 35, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 06:35:38'),
(260, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 06:53:05'),
(261, 7, 'logout', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 06:54:21'),
(262, 35, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 07:06:27'),
(263, 1, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 07:06:30'),
(264, 1, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 07:37:30'),
(265, 7, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 07:40:53'),
(266, 7, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 07:44:46'),
(267, 35, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 08:01:23'),
(268, 35, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 08:42:26'),
(269, 1, 'login_success', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 08:42:30'),
(270, 1, 'logout', '103.126.174.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 08:43:13'),
(271, 8, 'login_success', '114.10.103.180', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 10:06:53'),
(272, 8, 'logout', '114.10.103.180', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:08:17'),
(273, 7, 'login_success', '114.10.103.180', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:08:26'),
(274, 7, 'logout', '114.10.103.180', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:10:39'),
(275, 1, 'login_success', '114.10.103.180', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:11:04'),
(276, 1, 'logout', '114.10.103.180', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:14:15'),
(277, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:34:17'),
(278, 1, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:34:44'),
(279, 8, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:34:50'),
(280, 8, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:47:28'),
(281, 36, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:47:35'),
(282, 36, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:49:52');
INSERT INTO `login_logs` (`id`, `user_id`, `activity`, `ip_address`, `user_agent`, `created_at`) VALUES
(283, 16, 'login_failed', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:49:58'),
(284, 15, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:50:03'),
(285, 15, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:50:22'),
(286, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:50:24'),
(287, 1, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 10:57:35'),
(288, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 11:00:49'),
(289, 7, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 11:01:19'),
(290, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 11:01:33'),
(291, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 12:46:30'),
(292, 7, 'logout', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 12:49:04'),
(293, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 13:20:04'),
(294, 7, 'logout', '103.47.134.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-03 13:20:15'),
(295, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:12:23'),
(296, 7, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:14:49'),
(297, 8, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:14:57'),
(298, 8, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:16:21'),
(299, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:16:23'),
(300, 7, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:17:12'),
(301, 35, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:17:14'),
(302, 35, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:25:41'),
(303, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:25:43'),
(304, 7, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:26:00'),
(305, 35, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:26:26'),
(306, 35, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:26:56'),
(307, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:27:01'),
(308, 7, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:28:45'),
(309, 35, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:28:48'),
(310, 35, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:54:23'),
(311, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 22:54:25'),
(312, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 23:00:16'),
(313, 35, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 23:00:21'),
(314, 35, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 23:01:20'),
(315, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 23:01:23'),
(316, 7, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 23:18:24'),
(317, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 23:18:26'),
(318, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-03 23:23:46'),
(319, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 04:28:12'),
(320, 7, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 05:39:54'),
(321, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 05:39:57'),
(322, 1, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 05:40:21'),
(323, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 05:44:07'),
(324, 7, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 05:53:16'),
(325, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 10:22:03'),
(326, 8, 'login_success', '182.3.102.218', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-04 10:26:03'),
(327, 35, 'logout', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 10:34:17'),
(328, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 10:34:24'),
(329, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 11:36:18'),
(330, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-04 11:36:27'),
(331, 7, 'login_success', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-04 23:02:10'),
(332, 7, 'logout', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-04 23:02:56'),
(333, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 03:06:16'),
(334, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 03:06:43'),
(335, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 03:06:55'),
(336, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:08:39'),
(337, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:34:11'),
(338, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:34:31'),
(339, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:34:54'),
(340, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:35:00'),
(341, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:35:13'),
(342, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:35:45'),
(343, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:35:56'),
(344, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:36:02'),
(345, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:36:16'),
(346, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:41:26'),
(347, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:41:33'),
(348, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:42:29'),
(349, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:43:22'),
(350, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 03:43:31'),
(351, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:03:57'),
(352, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:05:50'),
(353, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:05:57'),
(354, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:06:04'),
(355, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:06:23'),
(356, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 04:06:53'),
(357, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:15:22'),
(358, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:15:39'),
(359, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:15:44'),
(360, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:15:50'),
(361, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:16:56'),
(362, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:18:20'),
(363, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:22:53'),
(364, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:44:35'),
(365, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:44:38'),
(366, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:44:53'),
(367, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:45:00'),
(368, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:45:30'),
(369, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 04:50:20'),
(370, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 04:59:07'),
(371, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:00:14'),
(372, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:00:17'),
(373, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:01:27'),
(374, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:01:31'),
(375, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:01:46'),
(376, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:01:59'),
(377, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:02:14'),
(378, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:02:17'),
(379, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:02:43'),
(380, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:02:45'),
(381, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:03:14'),
(382, 8, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:03:19'),
(383, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:03:24'),
(384, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:09:56'),
(385, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:09:58'),
(386, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:11:29'),
(387, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:11:39'),
(388, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:11:56'),
(389, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:11:59'),
(390, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:12:35'),
(391, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:12:37'),
(392, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:16:30'),
(393, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:16:32'),
(394, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:17:59'),
(395, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 05:18:03'),
(396, 7, 'login_success', '114.10.101.35', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 05:40:55'),
(397, 7, 'logout', '114.10.101.35', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 05:41:44'),
(398, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 06:35:54'),
(399, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 06:36:22'),
(400, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 06:36:29'),
(401, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 06:36:58'),
(402, 36, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 06:37:05'),
(403, 36, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:08:51'),
(404, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:09:53'),
(405, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:10:58'),
(406, 36, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:11:03'),
(407, 36, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:18:35'),
(408, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:18:37'),
(409, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:19:08'),
(410, 36, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:19:16'),
(411, 36, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:46:40'),
(412, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:46:43'),
(413, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:49:29'),
(414, 36, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:49:34'),
(415, 36, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:49:56'),
(416, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:49:58'),
(417, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:50:29'),
(418, 36, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:50:33'),
(419, 36, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:52:41'),
(420, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:52:43'),
(421, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:56:27'),
(422, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 07:56:37'),
(423, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 08:00:46'),
(424, 36, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 08:00:51'),
(425, 36, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 08:01:45'),
(426, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 08:01:48'),
(427, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 08:05:16'),
(428, 36, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-05 08:05:20'),
(429, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 10:15:41'),
(430, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 10:16:05'),
(431, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 10:20:00'),
(432, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-05 10:21:15'),
(433, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 10:48:14'),
(434, 35, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 10:53:29'),
(435, 36, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 10:53:38'),
(436, 36, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 10:56:52'),
(437, 7, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 10:56:57'),
(438, 7, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 10:57:18'),
(439, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 10:57:25'),
(440, 36, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 10:59:10'),
(441, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 11:31:21'),
(442, 36, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 11:31:59'),
(443, 7, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 22:12:22'),
(444, 36, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-05 22:13:18'),
(445, 1, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 00:40:14'),
(446, 36, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 00:44:47'),
(447, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 00:52:02'),
(448, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 00:52:10'),
(449, 37, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 00:59:26'),
(450, 1, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 00:59:32'),
(451, 8, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 05:56:59'),
(452, 36, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 05:58:29'),
(453, 36, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:02:16'),
(454, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:02:25'),
(455, 37, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:04:33'),
(456, 1, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:04:44'),
(457, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:06:25'),
(458, 38, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:06:34'),
(459, 38, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:07:04'),
(460, 1, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:13:06'),
(461, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:16:35'),
(462, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:16:46'),
(463, 37, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:17:02'),
(464, 38, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:17:12'),
(465, 38, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:19:37'),
(466, 36, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:19:45'),
(467, 36, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:20:46'),
(468, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:20:53'),
(469, 37, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:21:09'),
(470, 38, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:30:09'),
(471, 8, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:31:15'),
(472, 18, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:31:21'),
(473, 18, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:33:40'),
(474, 8, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:33:53'),
(475, 38, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:41:52'),
(476, 36, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:41:59'),
(477, 36, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:44:03'),
(478, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:44:09'),
(479, 37, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:44:21'),
(480, 37, 'login_failed', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:47:16'),
(481, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:47:20'),
(482, 37, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:47:33'),
(483, 38, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:47:43'),
(484, 38, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:48:05'),
(485, 18, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:48:10'),
(486, 18, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:55:18'),
(487, 1, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:55:25'),
(488, 1, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:55:59'),
(489, 18, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:56:05'),
(490, 18, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:58:44'),
(491, 36, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 06:58:57'),
(492, 36, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:00:11'),
(493, 8, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:00:38'),
(494, 18, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:00:44'),
(495, 36, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:02:15'),
(496, 18, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:03:21'),
(497, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:03:29'),
(498, 37, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:05:22'),
(499, 35, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:05:29'),
(500, 35, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:06:00'),
(501, 18, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:06:51'),
(502, 18, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:09:01'),
(503, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:09:07'),
(504, 36, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:41:29'),
(505, 37, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:41:36'),
(506, 7, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:46:27'),
(507, 7, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:47:43'),
(508, 8, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:47:50'),
(509, 8, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 07:48:17'),
(510, 8, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 08:18:25'),
(511, 7, 'login_failed', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 09:58:26'),
(512, 7, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 09:58:30'),
(513, 7, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 10:05:04'),
(514, 36, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 10:44:31'),
(515, 36, 'logout', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 10:57:29'),
(516, 37, 'login_success', '156.230.191.173', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36 Edg/154.0.0.0', '2026-10-06 10:57:37'),
(517, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-07 03:15:01'),
(518, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-07 03:23:55'),
(519, 18, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-07 03:24:12'),
(520, 18, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-07 03:24:53'),
(521, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-07 03:24:55'),
(522, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-07 04:01:33'),
(523, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 04:08:58'),
(524, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 05:34:25'),
(525, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 06:07:31'),
(526, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-07 06:21:04'),
(527, 23, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-07 08:20:28'),
(528, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-07 08:23:23'),
(529, 8, 'login_success', '182.3.101.51', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-07 12:12:45'),
(530, 21, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-08 07:37:50'),
(531, 21, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-08 07:38:20'),
(532, 7, 'login_success', '114.10.101.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-08 12:18:22'),
(533, 7, 'logout', '114.10.101.125', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-08 12:20:18'),
(534, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-09 03:08:28'),
(535, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-09 08:52:33'),
(536, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-09 08:54:49'),
(537, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 01:55:07'),
(538, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 02:45:29'),
(539, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 02:51:41'),
(540, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 03:07:45'),
(541, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-11 03:15:38'),
(542, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 03:28:25'),
(543, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 03:28:27'),
(544, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 04:15:13'),
(545, 7, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 04:41:33'),
(546, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 04:43:19'),
(547, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 05:49:52'),
(548, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 22:55:27'),
(549, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 22:55:36'),
(550, 35, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 23:07:41'),
(551, 7, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-11 23:09:27'),
(552, 32, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '2026-10-12 02:43:11'),
(553, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-12 03:20:30'),
(554, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-12 03:38:23'),
(555, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-12 06:51:50');
INSERT INTO `login_logs` (`id`, `user_id`, `activity`, `ip_address`, `user_agent`, `created_at`) VALUES
(556, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-13 06:38:49'),
(557, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-13 06:51:53'),
(558, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-13 06:51:55'),
(559, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36', '2026-10-13 06:59:12'),
(560, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-13 07:14:13'),
(561, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-13 07:14:15'),
(562, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-13 07:17:02'),
(563, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-13 07:17:04'),
(564, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-13 07:17:37'),
(565, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 01:00:00'),
(566, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:15:29'),
(567, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:34:49'),
(568, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:34:51'),
(569, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:35:29'),
(570, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:35:36'),
(571, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:37:49'),
(572, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:37:51'),
(573, 11, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.6.1 Safari/605.1.15', '2026-10-14 02:40:34'),
(574, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:40:55'),
(575, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 02:40:57'),
(576, 11, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 03:17:31'),
(577, 11, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 03:17:38'),
(578, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 07:12:51'),
(579, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 07:25:26'),
(580, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 07:25:31'),
(581, 11, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 07:27:11'),
(582, 11, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 07:27:27'),
(583, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 08:06:19'),
(584, 11, 'login_success', '114.79.1.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-14 08:35:05'),
(585, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-15 07:48:07'),
(586, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-15 07:51:00'),
(587, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 07:21:52'),
(588, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 07:31:56'),
(589, 35, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 07:31:58'),
(590, 35, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 07:37:39'),
(591, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 07:37:41'),
(592, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 07:53:10'),
(593, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 07:53:13'),
(594, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 09:05:34'),
(595, 35, 'login_success', '203.83.40.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 12:04:47'),
(596, 35, 'logout', '203.83.40.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-16 12:37:54'),
(597, 1, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 06:54:52'),
(598, 1, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 06:55:08'),
(599, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 06:55:10'),
(600, 35, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 07:02:06'),
(601, 1, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 07:02:09'),
(602, 7, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 07:16:12'),
(603, 1, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 09:13:55'),
(604, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 09:14:00'),
(605, 35, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 09:59:30'),
(606, 1, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 09:59:33'),
(607, 1, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 11:26:00'),
(608, 1, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-17 11:47:21'),
(609, 1, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-18 03:57:00'),
(610, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 02:28:30'),
(611, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 03:39:42'),
(612, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 04:31:18'),
(613, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 04:38:23'),
(614, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 04:39:05'),
(615, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 07:13:57'),
(616, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 07:17:00'),
(617, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 11:22:30'),
(618, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:07:42'),
(619, 35, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:09:37'),
(620, 36, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:09:45'),
(621, 36, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:09:54'),
(622, 36, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:10:31'),
(623, 1, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:10:33'),
(624, 1, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:11:19'),
(625, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:11:21'),
(626, 35, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:12:50'),
(627, 36, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:12:59'),
(628, 36, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:13:41'),
(629, 36, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:16:08'),
(630, 36, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:23:45'),
(631, 37, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:23:49'),
(632, 37, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-19 23:24:08'),
(633, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 03:07:59'),
(634, 37, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 03:24:41'),
(635, 37, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 03:32:37'),
(636, 36, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 03:32:41'),
(637, 35, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 03:33:58'),
(638, 7, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 03:34:01'),
(639, 7, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 03:36:01'),
(640, 1, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 03:36:04'),
(641, 1, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:04:01'),
(642, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:04:04'),
(643, 35, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:05:45'),
(644, 7, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:05:48'),
(645, 7, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:07:24'),
(646, 35, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:07:26'),
(647, 35, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:19:11'),
(648, 7, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:19:13'),
(649, 7, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 04:48:01'),
(650, 1, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 05:59:31'),
(651, 1, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 06:20:18'),
(652, 7, 'login_success', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 06:20:20'),
(653, 7, 'logout', '103.47.134.62', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 06:20:50'),
(654, 1, 'login_success', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 08:01:19'),
(655, 1, 'login_success', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 10:46:04'),
(656, 1, 'login_success', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 10:58:23'),
(657, 1, 'logout', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 10:58:29'),
(658, 24, 'login_success', '103.59.45.210', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-20 11:37:06'),
(659, 1, 'login_success', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 11:52:51'),
(660, 7, 'login_success', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 12:42:11'),
(661, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 22:45:24'),
(662, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 22:46:00'),
(663, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 22:47:22'),
(664, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 22:48:09'),
(665, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 22:53:30'),
(666, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 23:11:06'),
(667, 1, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 23:12:20'),
(668, 7, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 23:22:39'),
(669, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 23:23:06'),
(670, 35, 'login_success', '103.47.134.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-20 23:23:06'),
(671, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-21 02:06:42'),
(672, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-21 02:09:42'),
(673, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 02:55:21'),
(674, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 05:29:30'),
(675, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 06:16:09'),
(676, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 06:16:34'),
(677, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 06:16:36'),
(678, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 06:20:05'),
(679, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 06:20:07'),
(680, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 06:54:45'),
(681, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 06:54:47'),
(682, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 08:19:56'),
(683, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 08:19:58'),
(684, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 08:20:16'),
(685, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 08:20:18'),
(686, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 08:26:33'),
(687, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 08:26:37'),
(688, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 08:26:58'),
(689, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-21 08:27:00'),
(690, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 01:31:02'),
(691, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 01:34:05'),
(692, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:01:28'),
(693, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:10:16'),
(694, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:10:18'),
(695, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:10:43'),
(696, 35, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:10:46'),
(697, 35, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:10:52'),
(698, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 04:10:55'),
(699, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 05:26:51'),
(700, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 05:26:54'),
(701, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 05:27:46'),
(702, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 05:27:49'),
(703, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 05:28:15'),
(704, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 05:28:17'),
(705, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 05:30:33'),
(706, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-22 06:38:49'),
(707, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-22 06:42:03'),
(708, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 06:42:47'),
(709, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:06:24'),
(710, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:06:49'),
(711, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:15:06'),
(712, 18, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:15:45'),
(713, 21, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:21:49'),
(714, 21, 'login_success', '114.10.102.164', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/399.2.845414227 Mobile/15E148 Safari/604.1', '2026-10-22 07:23:19'),
(715, 22, 'login_success', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:51:40'),
(716, 18, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:58:44'),
(717, 18, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 07:58:53'),
(718, 21, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 08:36:50'),
(719, 18, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 08:41:45'),
(720, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-22 09:01:09'),
(721, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '2026-10-22 09:05:00'),
(722, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-22 09:10:04'),
(723, 22, 'login_success', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 10:04:02'),
(724, 1, 'login_success', '156.230.191.132', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-22 11:17:10'),
(725, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-22 23:15:24'),
(726, 22, 'login_success', '203.83.40.44', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 01:10:04'),
(727, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 01:41:56'),
(728, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 02:41:07'),
(729, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 02:41:10'),
(730, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 02:42:38'),
(731, 8, 'login_success', '182.3.104.208', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-23 03:21:50'),
(732, 28, 'login_success', '114.125.253.19', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.7.5 Mobile/15E148 Safari/604.1', '2026-10-23 03:24:42'),
(733, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 03:44:30'),
(734, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 03:47:07'),
(735, 31, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 03:52:21'),
(736, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:00:05'),
(737, 31, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:01:48'),
(738, 31, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:05:26'),
(739, 31, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:05:36'),
(740, 31, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:23:48'),
(741, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:23:50'),
(742, 31, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:24:49'),
(743, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:24:53'),
(744, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:25:01'),
(745, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:25:06'),
(746, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:25:17'),
(747, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:25:28'),
(748, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:25:32'),
(749, 31, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:25:37'),
(750, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:25:38'),
(751, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:25:57'),
(752, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:26:16'),
(753, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:26:22'),
(754, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:27:04'),
(755, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:27:11'),
(756, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:27:20'),
(757, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:27:29'),
(758, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:27:37'),
(759, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:27:47'),
(760, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:27:53'),
(761, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:28:02'),
(762, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:28:09'),
(763, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:28:20'),
(764, 31, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:28:39'),
(765, 31, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:29:55'),
(766, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:29:56'),
(767, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:31:16'),
(768, 31, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:31:27'),
(769, 31, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:39:20'),
(770, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:39:21'),
(771, 8, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:41:21'),
(772, 31, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:41:30'),
(773, 31, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:48:57'),
(774, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 04:48:58'),
(775, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 05:28:02'),
(776, 18, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 05:30:41'),
(777, 31, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 05:37:21'),
(778, 18, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 05:42:46'),
(779, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 06:05:27'),
(780, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 06:51:18'),
(781, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 07:15:14'),
(782, 7, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-23 07:15:19'),
(783, 1, 'login_failed', '103.47.134.23', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-23 08:32:25'),
(784, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-23 08:32:37'),
(785, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-23 08:33:36'),
(786, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-23 09:36:21'),
(787, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-23 10:16:52'),
(788, 8, 'login_success', '182.3.104.196', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-23 10:21:11'),
(789, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-23 10:28:31'),
(790, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-23 10:29:18'),
(791, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-23 10:48:04'),
(792, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-23 10:48:36'),
(793, 1, 'login_success', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-24 01:54:16'),
(794, 1, 'logout', '203.83.40.4', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-24 02:48:03'),
(795, 1, 'login_success', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-25 07:42:49'),
(796, 1, 'logout', '103.47.134.23', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-25 07:43:09'),
(797, 7, 'login_success', '103.47.134.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-25 23:21:18'),
(798, 7, 'logout', '103.47.134.55', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-25 23:22:07'),
(799, 22, 'login_success', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-26 01:39:27'),
(800, 24, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-26 01:40:14'),
(801, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 02:56:53'),
(802, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 03:02:51'),
(803, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 03:25:49'),
(804, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 04:20:29'),
(805, 1, 'login_failed', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-26 04:52:07'),
(806, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-26 04:52:17'),
(807, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 06:40:35'),
(808, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 06:55:58'),
(809, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:38:43'),
(810, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:38:51'),
(811, 7, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:38:53'),
(812, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:38:57'),
(813, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:38:59'),
(814, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:39:13'),
(815, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:55:30'),
(816, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:55:37'),
(817, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:57:08'),
(818, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:57:11'),
(819, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:58:40'),
(820, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:58:44'),
(821, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:59:43'),
(822, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 07:59:45'),
(823, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 08:05:37'),
(824, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 08:05:46'),
(825, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 08:07:35'),
(826, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 08:09:18'),
(827, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-26 08:09:20'),
(828, 22, 'login_success', '182.3.104.17', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-26 23:51:36'),
(829, 22, 'login_success', '182.3.104.17', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-27 00:59:30'),
(830, 11, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/27.0.1 Safari/605.1.15', '2026-10-27 03:36:27'),
(831, 21, 'login_success', '114.10.102.178', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1', '2026-10-27 04:18:12'),
(832, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36', '2026-10-27 04:45:01'),
(833, 1, 'login_success', '103.47.134.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '2026-10-27 10:08:16'),
(834, 1, 'logout', '103.47.134.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '2026-10-27 10:12:43'),
(835, 7, 'login_success', '103.47.134.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '2026-10-27 10:12:52');
INSERT INTO `login_logs` (`id`, `user_id`, `activity`, `ip_address`, `user_agent`, `created_at`) VALUES
(836, 7, 'login_success', '103.47.134.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-27 10:14:31'),
(837, 7, 'logout', '103.47.134.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '2026-10-27 10:28:26'),
(838, 1, 'login_success', '103.47.134.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '2026-10-27 10:28:37'),
(839, 7, 'logout', '103.47.134.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-27 10:30:37'),
(840, 1, 'logout', '103.47.134.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '2026-10-27 10:53:22'),
(841, 35, 'login_success', '103.47.134.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '2026-10-27 10:53:33'),
(842, 35, 'logout', '103.47.134.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36 Edg/156.0.0.0', '2026-10-27 10:59:30'),
(843, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Mobile Safari/537.36', '2026-10-28 01:41:50'),
(844, 22, 'login_success', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 00:20:37'),
(845, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 01:53:04'),
(846, 7, 'login_google_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:02:11'),
(847, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:02:35'),
(848, 7, 'login_google_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:05:50'),
(849, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:06:16'),
(850, 7, 'login_google_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:06:59'),
(851, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:07:05'),
(852, 7, 'login_google_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:07:31'),
(853, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:07:45'),
(854, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-10-29 03:14:14'),
(855, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:14:59'),
(856, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-10-29 03:42:43'),
(857, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:45:26'),
(858, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 03:45:38'),
(859, 7, 'login_google_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 04:26:44'),
(860, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 04:27:02'),
(861, 7, 'login_google_success', '114.10.101.212', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-10-29 06:48:34'),
(862, 7, 'logout', '114.10.101.212', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-10-29 06:48:52'),
(863, 8, 'login_google_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-10-29 09:37:38'),
(864, 7, 'login_google_success', '203.83.40.41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 12:43:28'),
(865, 7, 'logout', '203.83.40.41', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-10-29 12:43:41'),
(866, 7, 'login_success', '103.47.134.45', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-01 05:17:35'),
(867, 22, 'login_success', '182.3.104.133', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-02 00:11:48'),
(868, 22, 'login_success', '182.3.104.133', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 00:24:01'),
(869, 19, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:02:18'),
(870, 22, 'login_success', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:29:33'),
(871, 8, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36', '2026-11-03 09:30:06'),
(872, 22, 'login_success', '103.38.110.54', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:35:00'),
(873, 7, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:49:32'),
(874, 7, 'logout', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:49:38'),
(875, 7, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:49:41'),
(876, 7, 'logout', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:49:46'),
(877, 7, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:50:33'),
(878, 7, 'logout', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:50:42'),
(879, 7, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:53:12'),
(880, 7, 'logout', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:54:23'),
(881, 7, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:56:44'),
(882, 7, 'logout', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 09:56:59'),
(883, 24, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-03 10:16:24'),
(884, 7, 'login_google_success', '103.47.134.2', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-03 10:54:44'),
(885, 7, 'logout', '103.47.134.2', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-03 10:57:12'),
(886, 7, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 10:58:50'),
(887, 19, 'login_failed', '114.10.102.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', '2026-11-03 11:13:54'),
(888, 19, 'login_failed', '114.10.102.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', '2026-11-03 11:14:06'),
(889, 19, 'login_success', '114.10.102.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Mobile Safari/537.36', '2026-11-03 11:14:15'),
(890, 22, 'login_success', '182.3.104.104', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 11:37:51'),
(891, 7, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 11:54:30'),
(892, 33, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-03 11:56:56'),
(893, 24, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-03 12:00:45'),
(894, 1, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 12:53:22'),
(895, 1, 'logout', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 12:56:31'),
(896, 7, 'login_success', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 12:56:34'),
(897, 7, 'logout', '103.47.134.2', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-03 12:56:39'),
(898, 22, 'login_success', '182.3.104.112', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-04 00:45:45'),
(899, 24, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-04 01:06:28'),
(900, 7, 'login_google_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-04 02:17:34'),
(901, 7, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-04 02:17:49'),
(902, 1, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-04 02:18:01'),
(903, 1, 'logout', '103.38.110.54', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Mobile Safari/537.36', '2026-11-04 02:19:15'),
(904, 19, 'login_success', '103.38.110.54', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', '2026-11-04 04:07:41');

-- --------------------------------------------------------

--
-- Table structure for table `nota_dinas`
--

CREATE TABLE `nota_dinas` (
  `id` int(11) NOT NULL,
  `nomor_nota_dinas` varchar(100) NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `perihal` varchar(255) NOT NULL,
  `status` enum('created','sent','processed','complete') NOT NULL DEFAULT 'created',
  `created_at` datetime DEFAULT current_timestamp(),
  `completed_at` datetime DEFAULT NULL,
  `signature_type` varchar(20) DEFAULT NULL,
  `signature_data` longtext DEFAULT NULL,
  `signed_at` datetime DEFAULT NULL,
  `verification_token` varchar(64) DEFAULT NULL,
  `pdf_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nota_dinas`
--

INSERT INTO `nota_dinas` (`id`, `nomor_nota_dinas`, `from_user_id`, `to_user_id`, `tanggal`, `perihal`, `status`, `created_at`, `completed_at`, `signature_type`, `signature_data`, `signed_at`, `verification_token`, `pdf_path`) VALUES
(19, '123/nd/lju/2026', 8, 7, '2026-09-22', '<p>Tolong periksa internet ruang bisnis.</p>', 'complete', '2026-09-22 11:13:39', '2026-09-22 13:16:32', 'draw', 'data:image/png;base64,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', '2026-09-22 11:13:39', '84b6e65b25e0b942f44ef4214a772d84', NULL);
INSERT INTO `nota_dinas` (`id`, `nomor_nota_dinas`, `from_user_id`, `to_user_id`, `tanggal`, `perihal`, `status`, `created_at`, `completed_at`, `signature_type`, `signature_data`, `signed_at`, `verification_token`, `pdf_path`) VALUES
(20, '000111', 8, 7, '2026-09-22', '<p>tesss</p>', 'complete', '2026-09-22 15:16:04', '2026-09-27 16:56:51', 'saved', 'data:image/png;base64,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', '2026-09-22 15:16:04', 'fa70fd7218de41150ee4dd86476b2804', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `type` enum('expiry_warning','expiry_expired','new_document','permission_granted','version_update') NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `document_id`, `type`, `title`, `message`, `is_read`, `created_at`) VALUES
(1, 7, 1, 'permission_granted', 'Akses Dokumen Diberikan', 'Anda diberikan akses ke dokumen: laporan kerja infokom agustus 2026', 1, '2026-09-10 05:59:26'),
(2, 8, 2, 'permission_granted', 'Peminjaman Dokumen', 'Anda telah meminjam dokumen: 0001/LGL/LGL/ARSIP/IX/2026 - akta. Harap dikembalikan sebelum 2026-09-15.', 1, '2026-09-11 04:52:48'),
(3, 8, 3, 'permission_granted', 'Akses Dokumen Diberikan', 'Anda diberikan akses ke dokumen: coba', 1, '2026-09-14 03:37:00'),
(4, 8, 4, 'permission_granted', 'Akses Dokumen Diberikan', 'Anda diberikan akses ke dokumen: Laporan kerja', 1, '2026-09-14 03:40:27'),
(5, 11, 4, 'permission_granted', 'Akses Dokumen Diberikan', 'Anda diberikan akses ke dokumen: Laporan kerja', 1, '2026-09-14 04:32:11'),
(6, 1, 7, 'expiry_warning', 'Peringatan Masa Berlaku', 'Dokumen \"jadwal kapal dalom september\" (Surat Masuk) akan berakhir dalam 16 hari (30/09/2026)', 1, '2026-09-14 06:02:50'),
(7, 8, 64, 'permission_granted', 'Peminjaman Dokumen', 'Anda telah meminjam dokumen: 0005/MOU/LGL/ARSIP/IX/2026 - MOU ANTARA PT CENDIKIA GLOBAL SOLUSI DENGAN PT LAMPUNG JASA UTАМА (РERSERODA). Harap dikembalikan sebelum 2026-09-30.', 1, '2026-09-22 03:41:22');

-- --------------------------------------------------------

--
-- Table structure for table `numbering_counters`
--

CREATE TABLE `numbering_counters` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `counter` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `numbering_counters`
--

INSERT INTO `numbering_counters` (`id`, `category_id`, `year`, `month`, `counter`) VALUES
(1, 6, 2026, 9, 4),
(4, 4, 2026, 9, 48),
(5, 2, 2026, 9, 3),
(53, 5, 2026, 9, 5),
(59, 11, 2026, 9, 4);

-- --------------------------------------------------------

--
-- Table structure for table `physical_locations`
--

CREATE TABLE `physical_locations` (
  `id` int(11) NOT NULL,
  `room` varchar(100) NOT NULL COMMENT 'Nama/Nomor Ruang',
  `cabinet` varchar(50) NOT NULL COMMENT 'Nomor Rak/Kabinet',
  `box` varchar(50) NOT NULL COMMENT 'Nomor Box/Folder',
  `description` text DEFAULT NULL,
  `capacity` int(11) DEFAULT 100,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `physical_locations`
--

INSERT INTO `physical_locations` (`id`, `room`, `cabinet`, `box`, `description`, `capacity`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Ruang Arsip Utama', 'RAK-01', 'BOX-01', 'Arsip Kontrak & Legalitas', 100, 1, NULL, '2026-09-11 04:44:55', '2026-09-11 04:44:55'),
(2, 'Ruang Arsip Utama', 'RAK-01', 'BOX-02', 'Arsip Kontrak & Legalitas', 100, 1, NULL, '2026-09-11 04:44:55', '2026-09-11 04:44:55'),
(3, 'Ruang Arsip Utama', 'RAK-02', 'BOX-01', 'Arsip Surat Masuk', 100, 1, NULL, '2026-09-11 04:44:55', '2026-09-11 04:44:55'),
(4, 'Ruang Arsip Utama', 'RAK-02', 'BOX-02', 'Arsip Surat Keluar', 100, 1, NULL, '2026-09-11 04:44:55', '2026-09-11 04:44:55'),
(5, 'Ruang Arsip Sekretariat', 'KAB-A', 'F-001', 'Arsip MOU & Perjanjian', 100, 1, NULL, '2026-09-11 04:44:55', '2026-09-11 04:44:55');

-- --------------------------------------------------------

--
-- Table structure for table `signatures`
--

CREATE TABLE `signatures` (
  `id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `signer_name` varchar(100) DEFAULT NULL,
  `signer_position` varchar(100) DEFAULT NULL,
  `signature_type` enum('draw','type','upload') DEFAULT 'draw',
  `signature_data` longtext DEFAULT NULL,
  `signed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `hash` varchar(64) DEFAULT NULL,
  `status` enum('pending','signed','rejected') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `surat_keluar`
--

CREATE TABLE `surat_keluar` (
  `id` int(11) NOT NULL,
  `nomor_surat` varchar(100) NOT NULL,
  `tanggal_surat` date NOT NULL,
  `dikirim_oleh` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `penerima_surat` varchar(255) NOT NULL,
  `perihal` varchar(255) NOT NULL,
  `lampiran_surat` varchar(100) DEFAULT '-',
  `isi_surat` text NOT NULL,
  `status` enum('draft','published') DEFAULT 'draft',
  `penandatangan` int(11) DEFAULT NULL,
  `jenis_tandatangan` varchar(50) DEFAULT NULL,
  `signature_path` varchar(255) DEFAULT NULL,
  `signed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `surat_keluar`
--

INSERT INTO `surat_keluar` (`id`, `nomor_surat`, `tanggal_surat`, `dikirim_oleh`, `created_by`, `penerima_surat`, `perihal`, `lampiran_surat`, `isi_surat`, `status`, `penandatangan`, `jenis_tandatangan`, `signature_path`, `signed_at`, `created_at`, `updated_at`, `modified_at`) VALUES
(1, '006/LJU-DU/ST/X/2026', '2026-09-27', 7, 7, 'SMSNet', 'coba', '-', '<p>sdasdasdsdwwdwdwd</p>', 'published', 7, 'draw', 'https://dms.lju.co.id/uploads/signatures/sig_sk_1_1790488335.png', '2026-09-27 12:52:15', '2026-09-27 12:26:53', '2026-09-27 12:52:15', '2026-09-27 05:52:15'),
(2, '006/LJU-DU/ST/X/2026', '2026-09-27', 1, 7, 'SMSNet', 'coba3', '-', '<p>coba b3 b4 b5</p>', 'published', 1, 'draw', 'https://dms.lju.co.id/uploads/signatures/sig_sk_2_1790489064.png', '2026-09-27 13:04:24', '2026-09-27 12:31:31', '2026-09-27 13:04:24', '2026-09-27 06:04:24'),
(3, '123/INF/LJU/IX/2026', '2026-09-27', 7, 7, 'Lampungsai', 'coba 65', '-', '<p>ggttgtgt</p>', 'published', 7, 'saved', 'https://dms.lju.co.id/uploads/signatures/sig_sk_3_1790488436.png', '2026-09-27 12:53:56', '2026-09-27 12:52:52', '2026-09-27 12:53:56', '2026-09-27 05:53:56'),
(4, '53/INF/LJU/IX/2026', '2026-09-27', 7, 7, 'Lampungsai', 'kkooo', '-', '<p>kokokok</p>', 'published', 7, 'manual', NULL, '2026-09-27 12:54:21', '2026-09-27 12:54:17', '2026-09-27 12:54:21', '2026-09-27 05:54:21');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(7) DEFAULT '#007bff',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `color`, `created_at`) VALUES
(1, 'Penting', '#dc3545', '2026-09-10 05:34:55'),
(2, 'Urgent', '#fd7e14', '2026-09-10 05:34:55'),
(3, 'Rahasia', '#6f42c1', '2026-09-10 05:34:55'),
(4, 'Umum', '#28a745', '2026-09-10 05:34:55'),
(5, 'Arsip Permanen', '#17a2b8', '2026-09-10 05:34:55'),
(6, 'Perlu Tindak Lanjut', '#ffc107', '2026-09-10 05:34:55');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_surat_tugas`
--

CREATE TABLE `tbl_surat_tugas` (
  `id` int(11) NOT NULL,
  `nomor_surat` varchar(100) NOT NULL,
  `tanggal_surat` date NOT NULL,
  `teks_pembuka` text DEFAULT NULL,
  `berita_penugasan` text DEFAULT NULL,
  `penandatangan_id` int(11) NOT NULL,
  `status_surat` enum('draft','published') DEFAULT 'draft',
  `jenis_tandatangan` enum('draw','type','upload','saved','manual_wet') DEFAULT 'saved',
  `signature_data` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `modified_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `signed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_surat_tugas_personil`
--

CREATE TABLE `tbl_surat_tugas_personil` (
  `id` int(11) NOT NULL,
  `surat_tugas_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nik` varchar(50) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `position` enum('Direktur Utama','Direktur Operasional','Kepala Bidang','Kepala Divisi','Manager','Sekretaris','Staff','System Administrator','Corporate Secretary','Sekretaris Direksi','Sekretaris Komisaris') DEFAULT NULL,
  `division` enum('Keuangan','Pengadaan','Keamanan','Infokom','SDM','Direksi','IT','Legal','Kesekretariatan','Jasa Konstruksi','Pengangkutan & Pergudangan','Perdagangan','Energi & Migas','Direksi') DEFAULT NULL,
  `department` enum('Direksi','Keuangan & Umum','Bisnis','Sekretariat','Pengawas Internal') DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user','op_arsip') DEFAULT 'user',
  `avatar` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `rfid` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `webmail_user` varchar(200) NOT NULL,
  `webmail_pass` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nik`, `name`, `email`, `position`, `division`, `department`, `username`, `password`, `role`, `avatar`, `photo`, `signature`, `rfid`, `is_active`, `created_at`, `updated_at`, `webmail_user`, `webmail_pass`) VALUES
(1, '1111111', 'Administrator', 'admin@admin.com', 'System Administrator', 'IT', 'Bisnis', 'admin', '$2y$10$saO32bECFwcv1U5YoryhyOY5s10VkRJJjzWW1KwDP5PTHaFiqdZ1i', 'admin', 'avatar_1_1789024939.png', NULL, 'sig_sk_2_1790489064.png', NULL, 1, '2026-07-21 04:11:31', '2026-09-28 06:34:04', 'info@lju.co.id', 'Infolju@2026'),
(7, NULL, 'Ami Tri Cahyadi', 'cahyadi.ami@gmail.com', 'Staff', 'Infokom', 'Bisnis', 'ami', '$2y$10$NbxsYrfISkMyTwq/EKeP5.5YQK5h5wh9ikMihSj025QFtYDOgfRHW', 'user', 'avatar_6a7bfd28e9a4f_1786510632.PNG', NULL, 'sig_st_6_1790563308.png', 'f3:1e:c0:02', 1, '2026-08-06 05:46:53', '2026-10-09 09:38:31', 'ami@lju.co.id', '1S@mpai12'),
(8, NULL, 'Dodi Subarkah', 'chocovolverdz@gmail.com', 'Kepala Bidang', 'Infokom', 'Bisnis', 'dodi', '$2y$10$ZmK4O6ggtvHUeAEMFJOjDeL076ag4NA9c93OQqCiZvZA0F1e7orqa', 'user', 'avatar_8_1789358505.jpeg', 'photo_6aacca0c15bce_1789708812.jpeg', 'signature_6ab2321317181_1790063123.png', NULL, 1, '2026-08-06 06:12:14', '2026-09-28 07:37:28', 'dodisubarkah@lju.co.id', 'LJU@2026'),
(11, NULL, 'Ventania Gusti Amelza Agung', 'gustiventania@gmail.com', 'Kepala Bidang', 'Legal', 'Sekretariat', 'Legal', '$2y$10$g0CZtsf6glDkLI1CsdvkaeHWGZ6SnA8xu5nHF2gs955o0iSZnrnvK', 'user', 'avatar_11_1789359828.jpg', NULL, NULL, NULL, 1, '2026-09-14 03:42:00', '2026-10-14 02:35:24', 'gustiventania@lju.co.id', 'LJU@2026'),
(14, NULL, 'Innaya Rizky', 'innayarizky@gmail.com', 'Staff', 'Kesekretariatan', 'Sekretariat', 'innaya', '$2y$10$LQ8RcPL7z6wMviaXETfTMOHFHza1RDG.jdYOQuB22r4QJt6/y4BC6', 'op_arsip', NULL, NULL, 'signature_6ab3832f7e0be_1790149423.jpeg', NULL, 1, '2026-09-17 08:13:17', '2026-10-01 05:51:12', 'innayarizki@lju.co.id', 'LJU@2026'),
(15, NULL, 'OKTAVIANUS YULIA, S.T.', NULL, 'Direktur Utama', 'Direksi', 'Direksi', 'oki', '$2y$10$rNDocIZlwbul2pveRMIGzubiaQ197/PSLvm7Ee12tCOrXTvdaF4Im', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 03:36:08', '2026-09-21 03:37:40', '', ''),
(16, NULL, 'AMRI ZAMANI', 'amri@lju.co.id', 'Direktur Operasional', 'Direksi', 'Direksi', 'amri', '$2y$10$Jje78Urat6h1S1gWx796EecYnALZaW/ypSF4rZ5/UONMa0Soocmhq', 'user', 'avatar_16_1790843558.png', NULL, NULL, NULL, 1, '2026-09-21 03:56:50', '2026-10-01 08:32:38', '', ''),
(17, NULL, 'Ahmad Marulloh', NULL, 'Kepala Divisi', NULL, 'Keuangan & Umum', 'arul', '$2y$10$rbzOQQ7/0eGPF1QlVCsN5ebx1wexLRDQ8vChwjRudcNllVtQIQSuK', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 03:59:41', '2026-09-21 03:59:41', '', ''),
(18, NULL, 'Abdul Yamin', NULL, 'Kepala Divisi', NULL, 'Bisnis', 'yamin', '$2y$10$HbCkICU0YDQZZeMJHOyVx./rgh4yLZk8Bpl1zpWXETTzzxdIbbR7O', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:00:35', '2026-10-01 05:41:54', 'abdulyamin@lju.co.id', 'LJU@2026'),
(19, NULL, 'Edi Wahyudi', 'corsec@lju.co.id', 'Corporate Secretary', NULL, 'Sekretariat', 'yudi', '$2y$12$RgsmPp3oFw3lys/2go.wTOIOMZBjYrG6bND7SI.0j0RH8b4rzvnZi', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:01:30', '2026-11-03 09:03:24', '', ''),
(20, NULL, 'Iqbal Prayudha', NULL, 'Kepala Bidang', 'Keuangan', 'Keuangan & Umum', 'iqbalkeu', '$2y$10$m8aITR0i27vp5GtrVOKmS.etcaxi2YmX960nslEpeznjHQS.EmUm6', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:02:29', '2026-10-07 03:29:22', 'iqbalprayudha@lju.co.id', 'LJU@2026'),
(21, NULL, 'Dewi Safitri', '02dewisafitri@gmail.com', 'Kepala Bidang', 'SDM', 'Sekretariat', 'dewi', '$2y$10$e8E8CRm3OwGlgm/2tJ4m7uOyEx5ySxEsSR4JqQjuuxmPvymWGaYzK', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:04:25', '2026-10-07 03:27:17', 'dewisafitri@lju.co.id', 'LJU@2026'),
(22, '199003012016121005', 'Iqbal Damara', 'iqbaldamara90@gmail.com', 'Kepala Bidang', 'Jasa Konstruksi', 'Bisnis', 'kanjengmum', '$2y$10$9hudw8gDAARylKTe1fdAoOwREKGBVG9idKhRsoGWVlM.wsqhzxqc.', 'user', 'avatar_22_9cba61a4f91bcdd5.jpg', 'photo_22_49caffd0ab194164.jpg', 'signature_6ab1f95d703ff_1790048605.png', NULL, 1, '2026-09-21 04:05:34', '2026-10-23 01:18:52', 'iqbaldamara@lju.co.id', 'LJU@2026'),
(23, NULL, 'Arya Jaya Putra Sumbahan', 'aryajaya72606@gmail.com', 'Kepala Bidang', 'Pengangkutan & Pergudangan', 'Bisnis', 'jaya', '$2y$10$EcJC1Qsa3pvUi5/dB7BoBeQrEMMBoiMjwPxdUAM0ZBN5AFiR3qW1.', 'user', 'avatar_6ab365b895706_1790141880.png', 'photo_6ab365b89599a_1790141880.png', NULL, NULL, 1, '2026-09-21 04:06:18', '2026-10-01 05:48:06', 'aryajaya@lju.co.id', 'LJU@2026'),
(24, NULL, 'M Rido Radiansyah', 'radiansyahrido@gmail.com', 'Kepala Bidang', 'Perdagangan', 'Bisnis', 'ridoradiansyah', '$2y$10$3cv0WXgvDC1B/PUOGLdOjuKWd2TQv6FXOoa7S42vH9.2kXw6GEd.q', 'user', NULL, 'photo_6ab32f5740533_1790127959.jpg', 'signature_6ab32f0f0cd44_1790127887.jpg', NULL, 1, '2026-09-21 04:07:02', '2026-10-01 05:48:29', 'rido_radiansyah@lju.co.id', 'LJU@2026'),
(25, NULL, 'Mitha Aprilia', NULL, 'Staff', 'Jasa Konstruksi', 'Bisnis', 'mitha', '$2y$10$P6mw1rveCgO7tBoAcm46nuNwtP6hXxih8ezbpY.vZAY6ltK7nqAh.', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:07:47', '2026-10-01 05:49:58', 'mitha_aprilia@lju.co.id', 'LJU@2026'),
(26, NULL, 'Aldi Aditya', NULL, 'Staff', 'Pengangkutan & Pergudangan', 'Bisnis', 'aldi', '$2y$10$hXFSPoZeF4Mi6BlVcenn5.xPn9wWt6O7CB0ddfUL3ira1XWHnA7nK', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:08:30', '2026-10-01 05:51:37', 'aldi_aditya@lju.co.id', 'LJU@2026'),
(28, NULL, 'M Mukhtaridi.R.A', 'muhammadmuktaridiratuagung@gmail.com', 'Staff', 'Perdagangan', 'Bisnis', 'mukhtar', '$2y$10$WOGvlMyS8ljFSPIEIah4F.hZ9T.sgqyt519bVzrKOYbN7b3uT8pAi', 'user', 'avatar_6ab337750b818_1790130037.jpg', NULL, NULL, NULL, 1, '2026-09-21 04:09:56', '2026-10-01 05:52:14', 'mukhtaridi@lju.co.id', 'LJU@2026'),
(29, NULL, 'M Adrian Gumelar', NULL, 'Kepala Bidang', 'Pengadaan', 'Sekretariat', 'adrian', '$2y$10$j2KoBJQJKAoe8Q5RIswFiOFn02D694XNe4vkUF4rU4QYNdb7kTk7S', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:11:51', '2026-10-01 05:53:43', 'adrian@lju.co.id', 'LJU@2026'),
(30, NULL, 'Afrilia Damayanti', NULL, 'Sekretaris Direksi', 'Kesekretariatan', 'Sekretariat', 'afril', '$2y$10$onEQdw5MqcE4OoIGl9.jQeNvwIsv6ILeLhEKQQ1thIF1AoK6kaply', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:12:59', '2026-10-01 05:54:45', 'afrilia_damayanti@lju.co.id', 'LJU@2026'),
(31, NULL, 'Adhi Mulia', NULL, 'Staff', 'Pengadaan', 'Sekretariat', 'adi', '$2y$10$O0VJyHCcGtvZwKXPPoJOgOjPBSvE2nWPz7yY8ziOqbvcMo3vVR38m', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-21 04:13:34', '2026-10-07 03:28:20', 'adhimulia@lju.co.id', 'LJU@2026'),
(32, NULL, 'Dede Maysaroh', 'dedemaysaroh24@gmail.com', 'Sekretaris Komisaris', 'Kesekretariatan', 'Sekretariat', 'dede', '$2y$10$jHuSrYIxekX9wgCNxvFTqurvHMSHP2Fy2cg0v2AYsrVxVvugitopi', 'user', NULL, NULL, 'signature_6ab385cdc2ae5_1790150093.jpeg', NULL, 1, '2026-09-21 04:14:47', '2026-10-01 05:55:58', 'dede_maysaroh@lju.co.id', 'LJU@2026'),
(33, NULL, 'Muhammad Nico Santana', NULL, 'Staff', 'Perdagangan', 'Bisnis', 'niko', '$2y$10$RQOUSbFezKx8dDOrSC0yLOKS9MS1hoGVv4G0jkUJWJno6IU3aYjG6', 'user', NULL, NULL, NULL, NULL, 1, '2026-09-23 02:28:22', '2026-10-01 05:57:02', 'nico@lju.co.id', 'LJU@2026'),
(34, NULL, 'Kharasia Fatra P', 'kharasiafp@gmail.com', 'Staff', 'Keuangan', 'Keuangan & Umum', 'kharasia', '$2y$10$zDnO9M9ME3BCeI7gkMxpkOz/d6bOnLUP3DB2HtjZBDYVHphrxOJne', 'user', NULL, NULL, 'signature_6ab382c06955a_1790149312.png', NULL, 1, '2026-09-23 02:31:27', '2026-10-01 05:57:55', 'kharasia@lju.co.id', 'LJU@2026'),
(35, '', 'dummy HRs', NULL, 'Kepala Bidang', 'SDM', 'Sekretariat', 'dummyHR', '$2y$10$mkxf6VndyzAqM5q5iH1cN.EOyCC4qxH7nuCnCTBfdiWU4Rc2ll.9G', 'user', 'avatar_35_915e354d157d9f93.jpg', NULL, NULL, NULL, 1, '2026-10-01 10:46:43', '2026-10-02 09:10:17', '', ''),
(36, NULL, 'dummyFIN2', NULL, 'Kepala Divisi', 'Keuangan', 'Keuangan & Umum', 'dummyFIN', '$2y$10$cP3w9mos21mB7cDjCQqLBeU96xnuNl3p7NhXy7nlA2e.Hqp7Wd6U.', 'user', 'avatar_36_c8f052f454fd4c1e.jpg', NULL, NULL, NULL, 1, '2026-10-02 22:18:20', '2026-10-02 22:24:25', '', ''),
(37, NULL, 'dummyDO', NULL, 'Direktur Operasional', 'Direksi', 'Direksi', 'dummyDO', '$2y$10$z97LEgHfEMbcy2Sh6yL/dOG4k27gGMHWne0UfWBcC7KnA/s628HF.', 'user', NULL, NULL, NULL, NULL, 1, '2026-10-06 00:51:16', '2026-10-06 00:51:16', '', ''),
(38, NULL, 'dummyKD', NULL, 'Kepala Divisi', NULL, 'Bisnis', 'dummyKD', '$2y$10$Ux5gyCKHFKuy.igGTDMULuhIK07E0pySAS/ovLtecrJfe5Zoybn/6', 'user', NULL, NULL, NULL, NULL, 1, '2026-10-06 06:05:45', '2026-10-06 06:05:45', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `document_id` (`document_id`) USING BTREE;

--
-- Indexes for table `audit_trail`
--
ALTER TABLE `audit_trail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `category_metadata_fields`
--
ALTER TABLE `category_metadata_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `dispositions`
--
ALTER TABLE `dispositions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `document_id` (`document_id`) USING BTREE,
  ADD KEY `from_user_id` (`from_user_id`) USING BTREE,
  ADD KEY `to_user_id` (`to_user_id`) USING BTREE;

--
-- Indexes for table `disposition_history`
--
ALTER TABLE `disposition_history`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `disposition_id` (`disposition_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE,
  ADD KEY `to_user_id` (`to_user_id`) USING BTREE;

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `document_number` (`document_number`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `documents_arsip`
--
ALTER TABLE `documents_arsip`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `archive_number` (`archive_number`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `folder_id` (`folder_id`),
  ADD KEY `uploaded_by` (`uploaded_by`),
  ADD KEY `idx_expiry` (`expiry_date`,`status`),
  ADD KEY `idx_title` (`title`);
ALTER TABLE `documents_arsip` ADD FULLTEXT KEY `ft_search` (`title`,`description`);

--
-- Indexes for table `document_categories`
--
ALTER TABLE `document_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `document_loans`
--
ALTER TABLE `document_loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `borrower_id` (`borrower_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `document_locations`
--
ALTER TABLE `document_locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_doc_location` (`document_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `document_metadata`
--
ALTER TABLE `document_metadata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `field_id` (`field_id`);

--
-- Indexes for table `document_permissions`
--
ALTER TABLE `document_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `document_tags`
--
ALTER TABLE `document_tags`
  ADD PRIMARY KEY (`document_id`,`tag_id`),
  ADD KEY `fk_doctag_tag` (`tag_id`);

--
-- Indexes for table `document_versions`
--
ALTER TABLE `document_versions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `fk_ver_uploader` (`uploaded_by`);

--
-- Indexes for table `folders`
--
ALTER TABLE `folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `nota_dinas`
--
ALTER TABLE `nota_dinas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_nota_from_user` (`from_user_id`),
  ADD KEY `fk_nota_to_user` (`to_user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_read` (`is_read`,`user_id`);

--
-- Indexes for table `numbering_counters`
--
ALTER TABLE `numbering_counters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_counter` (`category_id`,`year`,`month`);

--
-- Indexes for table `physical_locations`
--
ALTER TABLE `physical_locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_location` (`room`,`cabinet`,`box`);

--
-- Indexes for table `signatures`
--
ALTER TABLE `signatures`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `document_id` (`document_id`) USING BTREE,
  ADD KEY `user_id` (`user_id`) USING BTREE;

--
-- Indexes for table `surat_keluar`
--
ALTER TABLE `surat_keluar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `tbl_surat_tugas`
--
ALTER TABLE `tbl_surat_tugas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomor_surat` (`nomor_surat`);

--
-- Indexes for table `tbl_surat_tugas_personil`
--
ALTER TABLE `tbl_surat_tugas_personil`
  ADD PRIMARY KEY (`id`),
  ADD KEY `surat_tugas_id` (`surat_tugas_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`) USING BTREE,
  ADD UNIQUE KEY `nik` (`nik`) USING BTREE,
  ADD UNIQUE KEY `rfid` (`rfid`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=571;

--
-- AUTO_INCREMENT for table `audit_trail`
--
ALTER TABLE `audit_trail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=516;

--
-- AUTO_INCREMENT for table `category_metadata_fields`
--
ALTER TABLE `category_metadata_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `dispositions`
--
ALTER TABLE `dispositions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `disposition_history`
--
ALTER TABLE `disposition_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `documents_arsip`
--
ALTER TABLE `documents_arsip`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `document_categories`
--
ALTER TABLE `document_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `document_loans`
--
ALTER TABLE `document_loans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `document_locations`
--
ALTER TABLE `document_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `document_metadata`
--
ALTER TABLE `document_metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=235;

--
-- AUTO_INCREMENT for table `document_permissions`
--
ALTER TABLE `document_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `document_versions`
--
ALTER TABLE `document_versions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `folders`
--
ALTER TABLE `folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=905;

--
-- AUTO_INCREMENT for table `nota_dinas`
--
ALTER TABLE `nota_dinas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `numbering_counters`
--
ALTER TABLE `numbering_counters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `physical_locations`
--
ALTER TABLE `physical_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `signatures`
--
ALTER TABLE `signatures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `surat_keluar`
--
ALTER TABLE `surat_keluar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_surat_tugas`
--
ALTER TABLE `tbl_surat_tugas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_surat_tugas_personil`
--
ALTER TABLE `tbl_surat_tugas_personil`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `activity_logs_ibfk_2` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `category_metadata_fields`
--
ALTER TABLE `category_metadata_fields`
  ADD CONSTRAINT `fk_meta_category` FOREIGN KEY (`category_id`) REFERENCES `document_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dispositions`
--
ALTER TABLE `dispositions`
  ADD CONSTRAINT `dispositions_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `dispositions_ibfk_2` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `dispositions_ibfk_3` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `disposition_history`
--
ALTER TABLE `disposition_history`
  ADD CONSTRAINT `disposition_history_ibfk_1` FOREIGN KEY (`disposition_id`) REFERENCES `dispositions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `disposition_history_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `disposition_history_ibfk_3` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `documents_arsip`
--
ALTER TABLE `documents_arsip`
  ADD CONSTRAINT `fk_doc_category` FOREIGN KEY (`category_id`) REFERENCES `document_categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_doc_folder` FOREIGN KEY (`folder_id`) REFERENCES `folders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_doc_uploader` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `document_loans`
--
ALTER TABLE `document_loans`
  ADD CONSTRAINT `fk_loan_doc` FOREIGN KEY (`document_id`) REFERENCES `documents_arsip` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `document_locations`
--
ALTER TABLE `document_locations`
  ADD CONSTRAINT `fk_docloc_doc` FOREIGN KEY (`document_id`) REFERENCES `documents_arsip` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_docloc_loc` FOREIGN KEY (`location_id`) REFERENCES `physical_locations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `document_metadata`
--
ALTER TABLE `document_metadata`
  ADD CONSTRAINT `fk_docmeta_doc` FOREIGN KEY (`document_id`) REFERENCES `documents_arsip` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_docmeta_field` FOREIGN KEY (`field_id`) REFERENCES `category_metadata_fields` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `document_permissions`
--
ALTER TABLE `document_permissions`
  ADD CONSTRAINT `fk_perm_doc` FOREIGN KEY (`document_id`) REFERENCES `documents_arsip` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_perm_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `document_tags`
--
ALTER TABLE `document_tags`
  ADD CONSTRAINT `fk_doctag_doc` FOREIGN KEY (`document_id`) REFERENCES `documents_arsip` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_doctag_tag` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `document_versions`
--
ALTER TABLE `document_versions`
  ADD CONSTRAINT `fk_ver_doc` FOREIGN KEY (`document_id`) REFERENCES `documents_arsip` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ver_uploader` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `folders`
--
ALTER TABLE `folders`
  ADD CONSTRAINT `fk_folder_parent` FOREIGN KEY (`parent_id`) REFERENCES `folders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `nota_dinas`
--
ALTER TABLE `nota_dinas`
  ADD CONSTRAINT `fk_nota_from_user` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_nota_to_user` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `signatures`
--
ALTER TABLE `signatures`
  ADD CONSTRAINT `signatures_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `signatures_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tbl_surat_tugas_personil`
--
ALTER TABLE `tbl_surat_tugas_personil`
  ADD CONSTRAINT `fk_st_personil` FOREIGN KEY (`surat_tugas_id`) REFERENCES `tbl_surat_tugas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
