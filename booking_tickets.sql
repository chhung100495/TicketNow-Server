-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.36-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for booking_tickets
-- DROP DATABASE IF EXISTS `booking_tickets`;
-- CREATE DATABASE IF NOT EXISTS `booking_tickets` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
-- USE `booking_tickets`;

DROP DATABASE IF EXISTS `heroku_9795ac331e55444`;
CREATE DATABASE IF NOT EXISTS `heroku_9795ac331e55444` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `heroku_9795ac331e55444`;

-- Dumping structure for table booking_tickets.accounts
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ACCOUNTS_USERS` (`user_id`),
  CONSTRAINT `FK_ACCOUNTS_USERS` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.accounts: ~7 rows (approximately)
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`, `username`, `password`, `user_id`) VALUES
	(1, 'chhung', 'e10adc3949ba59abbe56e057f20f883e', 1),
	(2, 'nnhuy', 'e10adc3949ba59abbe56e057f20f883e', 2),
	(3, 'dnmluan', 'e10adc3949ba59abbe56e057f20f883e', 3),
	(4, 'mttan', 'e10adc3949ba59abbe56e057f20f883e', 4),
	(5, 'pmtrung', 'e10adc3949ba59abbe56e057f20f883e', 5),
	(6, 'tester', 'e10adc3949ba59abbe56e057f20f883e', 6);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.auditoriums
DROP TABLE IF EXISTS `auditoriums`;
CREATE TABLE IF NOT EXISTS `auditoriums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cinema_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_AUDITORIUMS_CINEMAS` (`cinema_id`),
  KEY `FK_AUDITORIUMS_LOCATIONS` (`location_id`),
  CONSTRAINT `FK_AUDITORIUMS_CINEMAS` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_AUDITORIUMS_LOCATIONS` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.auditoriums: ~18 rows (approximately)
/*!40000 ALTER TABLE `auditoriums` DISABLE KEYS */;
INSERT INTO `auditoriums` (`id`, `cinema_id`, `location_id`) VALUES
	(1, 1, 4),
	(2, 1, 5),
	(3, 1, 6),
	(4, 2, 7),
	(5, 2, 8),
	(6, 2, 9),
	(7, 3, 10),
	(8, 3, 11),
	(9, 3, 12),
	(10, 4, 13),
	(11, 4, 14),
	(12, 4, 15),
	(13, 5, 16),
	(14, 5, 17),
	(15, 5, 18),
	(16, 6, 19),
	(17, 6, 20),
	(18, 6, 21);
/*!40000 ALTER TABLE `auditoriums` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.blocks
DROP TABLE IF EXISTS `blocks`;
CREATE TABLE IF NOT EXISTS `blocks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_BLOCKS_LOCATIONS` (`location_id`),
  CONSTRAINT `FK_BLOCKS_LOCATIONS` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.blocks: ~10 rows (approximately)
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` (`id`, `name`, `location_id`) VALUES
	(1, 'A', 4),
	(2, 'B', 4),
	(3, 'C', 4),
	(4, 'D', 4),
	(5, 'E', 4),
	(6, 'G', 4),
	(7, 'H', 4),
	(8, 'I', 4),
	(9, 'K', 4),
	(10, 'L', 4);
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.booked_combos
DROP TABLE IF EXISTS `booked_combos`;
CREATE TABLE IF NOT EXISTS `booked_combos` (
  `booking_id` int(10) unsigned NOT NULL,
  `combo_id` int(10) unsigned NOT NULL,
  `price` double DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`booking_id`,`combo_id`),
  KEY `FK_BOOKED_COMBOS_COMBOS` (`combo_id`),
  KEY `FK_BOOKED_COMBOS_BOOKINGS` (`booking_id`),
  CONSTRAINT `FK_BOOKED_COMBOS_BOOKINGS` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_BOOKED_COMBOS_COMBOS` FOREIGN KEY (`combo_id`) REFERENCES `combos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.booked_combos: ~3 rows (approximately)
/*!40000 ALTER TABLE `booked_combos` DISABLE KEYS */;
INSERT INTO `booked_combos` (`booking_id`, `combo_id`, `price`, `quantity`) VALUES
	(1, 1, 279000, 1),
	(2, 2, 639000, 1),
	(2, 3, 269000, 1);
/*!40000 ALTER TABLE `booked_combos` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.booked_seats
DROP TABLE IF EXISTS `booked_seats`;
CREATE TABLE IF NOT EXISTS `booked_seats` (
  `booking_id` int(10) unsigned NOT NULL,
  `seat_id` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL,
  PRIMARY KEY (`booking_id`,`seat_id`),
  KEY `FK_BOOKED_SEATS_BOOKINGS` (`booking_id`),
  KEY `FK_BOOKED_SEATS_SEATS` (`seat_id`),
  CONSTRAINT `FK_BOOKED_SEATS_BOOKINGS` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_BOOKED_SEATS_SEATS` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.booked_seats: ~4 rows (approximately)
/*!40000 ALTER TABLE `booked_seats` DISABLE KEYS */;
INSERT INTO `booked_seats` (`booking_id`, `seat_id`, `price`) VALUES
	(1, 1, 88000),
	(2, 2, 88000),
	(2, 3, 88000),
	(3, 4, 88000);
/*!40000 ALTER TABLE `booked_seats` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.bookings
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `booking_for_date_time` datetime NOT NULL,
  `movie_showings_id` int(10) unsigned NOT NULL,
  `code` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_BOOKINGS_ACCOUNTS` (`account_id`),
  KEY `FK_BOOKINGS_MOVIE_SHOWINGS` (`movie_showings_id`),
  CONSTRAINT `FK_BOOKINGS_ACCOUNTS` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_BOOKINGS_MOVIE_SHOWINGS` FOREIGN KEY (`movie_showings_id`) REFERENCES `movie_showings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.bookings: ~3 rows (approximately)
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` (`id`, `account_id`, `booking_for_date_time`, `movie_showings_id`, `code`, `created_at`) VALUES
	(1, 6, '2019-04-10 08:10:00', 1, 'CGV0001', '2019-04-10 08:10:00'),
	(2, 6, '2019-04-17 12:00:00', 73, 'BHD0001', '2019-04-17 12:00:00'),
	(3, 6, '2019-04-20 18:45:00', 152, 'GLX0001', '2019-04-20 18:45:00');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.cinemas
DROP TABLE IF EXISTS `cinemas`;
CREATE TABLE IF NOT EXISTS `cinemas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `icon_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `address` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.cinemas: ~6 rows (approximately)
/*!40000 ALTER TABLE `cinemas` DISABLE KEYS */;
INSERT INTO `cinemas` (`id`, `name`, `icon_url`, `address`, `phone`) VALUES
	(1, 'CGV', 'https://drive.google.com/uc?id=1_z9wnHeevMJYpci5__WQdDsT07ZeRLVp', 'Tầng 2, Rivera Park Saigon - Số 7/28 Thành Thái, P.14, Q.10, TP.HCM', '1900 6017'),
	(2, 'BHD Star Cineplex', 'https://drive.google.com/uc?id=1Fuk60XPv5ga18G1tblcMv1LP5wqNKQuo', 'L3-Bitexco Icon 68, 2 Hải Triều, Q.1', '028 6267 0670'),
	(3, 'GLX - Nguyễn Du', 'https://drive.google.com/uc?id=1rk9g8_RcsUaqMi9BIzFcCICkSndbawHz', '116 Nguyễn Du, Q.1', '1900 2224'),
	(4, 'Lotte Cinema Nowzone', 'https://drive.google.com/uc?id=1bthl6vmz7B62oyRj9A5gohb8RypBovjB', 'L5-Nowzone, 235 Nguyễn Văn Cừ, Q.1', '028 3926 2255'),
	(5, 'CinemaBox', 'https://drive.google.com/uc?id=1XVxfIUhuAdUrYoxTFqg9D3hJsJFYXBB-', '212 Lý Chính Thắng, Q.3', '028 3526 4818'),
	(6, 'Mega GS', 'https://drive.google.com/uc?id=17-aQUOfjscXp2b8HDozTB86LnXflz83D', '19 Cao Thắng, Q.3', '028 6264 9911');
/*!40000 ALTER TABLE `cinemas` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.combos
DROP TABLE IF EXISTS `combos`;
CREATE TABLE IF NOT EXISTS `combos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `img_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `cinema_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_COMBOS_CINEMAS` (`cinema_id`),
  CONSTRAINT `FK_COMBOS_CINEMAS` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.combos: ~6 rows (approximately)
/*!40000 ALTER TABLE `combos` DISABLE KEYS */;
INSERT INTO `combos` (`id`, `name`, `price`, `img_url`, `description`, `cinema_id`) VALUES
	(1, 'CAPTAIN MARVEL COMBO', 279000, 'https://drive.google.com/uc?id=1rsrp5XEpPKU4UqBDqfcu0QnSUhcqwK78', 'Đón chào Tháng 3 với sức mạnh vô song đến từ Captain Marvel.', 1),
	(2, 'GUDETAMA COMBO', 639000, 'https://drive.google.com/uc?id=1kVC0ZoDiIrYiTfEJzQwccHA8vS2lh7B8', 'GUDETAMA – Bé trứng lười đã xuất hiện tại CGV.', 1),
	(3, 'WHITE VALENTINE COMBO', 269000, 'https://drive.google.com/uc?id=1Em8j2cCneOb8QpSaLqycIrenle-M-rhc', 'COMBO TÌNH YÊU CHO NGÀY VALENTINE TRẮNG NGỌT LỊM!', 1),
	(4, 'SJORA - NƯỚC TRÁI CÂY VỊ ĐÀO VÀ XOÀI', 39000, 'https://drive.google.com/uc?id=1Dl1q_2-wyK7bB1CCMO2mkBIDgTEfyEq-', 'Sjora – nước trái cây vị Đào và Xoài huyền thoại của đất nước Singapore và Malaysia nay đã có mặt tại CGV Việt Nam.', 1),
	(5, 'BÁNH WAFFLE - GIÒN THƠM KHÓ CƯỠNG', 39000, 'https://drive.google.com/uc?id=1_WXSm8eFwIIviLCPGT2R2jzc21BKa6e2', 'Bánh nướng Waffle giòn thơm đã có mặt tại CGV .', 1),
	(6, 'PIZZA NÓNG HỔI, VỪA THỔI VỪA ĂN', 115000, 'https://drive.google.com/uc?id=1DVo1RDZKntGwyVjYbH6tegjhMv6O6bHc', 'Sản phẩm Pizza mới được làm thủ công hoàn toàn theo phong cách Ý. Đế bánh được làm từ bột mì cao cấp để đảm bảo được chất lượng và hương vị tốt nhất. Các thành phần phủ bánh được chọn lọc kỹ lưỡng giữ nguyên hương vị tươi mới cho sản phẩm. Cà chua và phô mai được nhập khẩu từ Ý, giữ đúng nguyên bản hương vị truyền thống.', 1);
/*!40000 ALTER TABLE `combos` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.events
DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organizer` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.events: ~7 rows (approximately)
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`id`, `name`, `img_url`, `organizer`, `type`, `description`) VALUES
	(1, 'Việt Nam - Jordan', 'https://drive.google.com/uc?id=1FuLliJ8w-yR-iMZ5ZLeD17bNDcU-jOPu', 'Liên đoàn Bóng đá Việt Nam  - VFF', 'Thể Thao', 'ĐTQG VIỆT NAM -  ĐTQG JORDAN | BẢNG C - VÒNG LOẠI ASIAN CUP 2019'),
	(2, 'Việt Nam - Philipines', 'https://drive.google.com/uc?id=1W-RyEA_Z8SrKzClKS4HXUO3QWFBIvLyQ', 'Liên đoàn Bóng đá Việt Nam  - VFF', 'Thể Thao', 'ĐTQG VIỆT NAM -  ĐTQG PHILIPINES | VÒNG BÁN KẾT LƯỢT ĐI AFF SUZUKI CUP 2018'),
	(3, 'Hà Nội - Bình Dương', 'https://drive.google.com/uc?id=1rE2C61lDtkXN8hc8jktD7Qv_U1SOVMz3', 'Công ty Cổ phần Bóng đá chuyên nghiệp Việt Nam - V', 'Thể Thao', 'Hà Nội và cơ hội đòi nợ Bình Dương ở Siêu Cup quốc gia 2019'),
	(4, 'Việt Nam - Malaysia', 'https://drive.google.com/uc?id=1vQwy0JQm8H-uUp7qNiljjykLxeob9oxb', 'Liên đoàn Bóng đá Việt Nam  - VFF', 'Thể Thao', 'ĐTQG VIỆT NAM -  ĐTQG MALAYSIA | VÒNG BẢNG AFF SUZUKI CUP 2018'),
	(5, 'Việt Nam - Indonesia', 'https://drive.google.com/uc?id=19qcCvhHvgaN5zvjApcKcWhZz8prfkgHI', 'Liên đoàn Bóng đá thế giới - FIFA', 'Thể Thao', 'Giải World - Friendlies'),
	(6, 'Việt Nam - Nhật Bản', 'https://drive.google.com/uc?id=1rbwAJcaanCIVxUqFyPgrC7Nt1yq-FHHU', 'Liên đoàn bóng đá châu Á - AFC', 'Thể Thao', 'Giải Asian Cup 2019'),
	(7, 'Việt Nam - Yamen', 'https://drive.google.com/uc?id=1Nbe-tKBs069_-a1JMyh-4DwW8McWJv9l', 'Liên đoàn bóng đá châu Á - AFC', 'Thể Thao', 'Giải Asian Cup 2019');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.event_showings
DROP TABLE IF EXISTS `event_showings`;
CREATE TABLE IF NOT EXISTS `event_showings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL,
  `venue_id` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL,
  `status` int(10) unsigned NOT NULL,
  `release_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_EVENT_SHOWINGS_EVENTS` (`event_id`),
  KEY `FK_EVENT_SHOWINGS_VENUES` (`venue_id`),
  CONSTRAINT `FK_EVENT_SHOWINGS_EVENTS` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_EVENT_SHOWINGS_VENUES` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.event_showings: ~3 rows (approximately)
/*!40000 ALTER TABLE `event_showings` DISABLE KEYS */;
INSERT INTO `event_showings` (`id`, `event_id`, `venue_id`, `price`, `status`, `release_date`) VALUES
	(1, 1, 1, 100000, 0, '2018-06-13 19:00:00'),
	(2, 2, 2, 150000, 0, '2018-12-06 19:30:00'),
	(3, 3, 3, 150000, 0, '2019-02-16 16:00:00');
/*!40000 ALTER TABLE `event_showings` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.locations
DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_seats` int(10) unsigned NOT NULL,
  `type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- Dumping data for table booking_tickets.locations: ~21 rows (approximately)
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` (`id`, `name`, `total_seats`, `type`) VALUES
	(1, 'Sân vận động Thống Nhất', 15000, 1),
	(2, 'Sân vận động Quốc gia Mỹ Đình', 40192, 1),
	(3, 'Sân vận động Hàng Đẫy', 22500, 1),
	(4, 'Phòng chiếu CGV-01', 100, 0),
	(5, 'Phòng chiếu CGV-02', 100, 0),
	(6, 'Phòng chiếu CGV-03', 100, 0),
	(7, 'Phòng chiếu BHD-01', 100, 0),
	(8, 'Phòng chiếu BHD-02', 100, 0),
	(9, 'Phòng chiếu BHD-03', 100, 0),
	(10, 'Phòng chiếu GLX-01', 100, 0),
	(11, 'Phòng chiếu GLX-02', 100, 0),
	(12, 'Phòng chiếu GLX-03', 100, 0),
	(13, 'Phòng chiếu LC-01', 100, 0),
	(14, 'Phòng chiếu LC-02', 100, 0),
	(15, 'Phòng chiếu LC-03', 100, 0),
	(16, 'Phòng chiếu CB-01', 100, 0),
	(17, 'Phòng chiếu CB-02', 100, 0),
	(18, 'Phòng chiếu CB-03', 100, 0),
	(19, 'Phòng chiếu MGS-01', 100, 0),
	(20, 'Phòng chiếu MGS-02', 100, 0),
	(21, 'Phòng chiếu MGS-03', 100, 0);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.movies
DROP TABLE IF EXISTS `movies`;
CREATE TABLE IF NOT EXISTS `movies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trailer_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` double unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_age` int(10) unsigned NOT NULL,
  `director` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cast` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `running_time` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_release` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.movies: ~12 rows (approximately)
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` (`id`, `name`, `img_url`, `trailer_url`, `score`, `description`, `min_age`, `director`, `cast`, `running_time`, `genre`, `initial_release`) VALUES
	(1, 'Captain Marvel', 'https://drive.google.com/uc?id=13CthOX7v05pn-yE6z5xJaFd5xmW_FeVl', 'https://www.youtube.com/embed/Z1BCujX3pw8', 8.1, 'Lấy bối cảnh những năm 90s, Captain Marvel là một cuộc phiêu lưu hoàn toàn mới đến với một thời kỳ chưa từng xuất hiện trong vũ trụ điện ảnh Marvel. Bộ phim kể về con đường trở thành siêu anh hùng mạnh mẽ nhất vũ trụ của Carol Danvers. Bên cạnh đó, trận chiến ảnh hưởng đến toàn vũ trụ giữa tộc Kree và tộc Skrull đã lan đến Trái Đất, liệu Danvers và các đồng minh có thể ngăn chặn binh đoàn Skrull cũng như các thảm họa tương lai?', 13, 'Anna Boden, Ryan Fleck', 'Brie Larson, Samuel L Jackson, Ben Mendelsohn,...', '129 phút', 'Hành Động, Phiêu Lưu', '2019-02-27'),
	(2, 'Công viên kỳ diệu', 'https://drive.google.com/uc?id=1kCDL0c5906PXyPyFikTvHIKjlm-l6bAU', 'https://www.youtube.com/embed/U-pFuw9LEgg', 7.6, 'Một công viên lung linh, kỳ ảo được tạo nên bởi trí tưởng tượng vô tận của những đứa trẻ.', 6, 'Robert Iscove, Clare Kilner, David Feiss', 'Brianna Denski, Jennifer Garner, Ken Hudson Campbell', '91 phút', 'Hoạt Hình, Phiêu Lưu', '2019-03-14'),
	(3, 'Hạnh phúc của mẹ', 'https://drive.google.com/uc?id=10xhsb61luO2D-6O4zOy-PIWQkJYTYGmJ', 'https://www.youtube.com/embed/ct5ooLDbi40', 7.5, 'Hạnh Phúc Của Mẹ là hành trình người mẹ đơn thân, nghèo khó và nhiều bệnh tật Tuệ (Cát Phượng) giúp con trai Tim mắc hội chứng tự kỷ (bé Huy Khang) thực hiện đam mê nhảy múa, sống hào hứng mỗi ngày…', 6, 'Huỳnh Đông', 'Cát Phượng, Kiều Minh Tuấn, bé Huy Khang,…', '93 phút', 'Tâm Lý', '2019-03-08'),
	(4, 'Yêu nhầm bạn thân', 'https://drive.google.com/uc?id=1g4cyR-ALZDybqLckiRMzct4_Jv6bHALA', 'https://www.youtube.com/embed/i8X2hXPd1XU', 8, 'Friend Zone xoay quanh mối tình đơn phương của Palm – một tiếp viên hàng không. Ngay từ lúc còn ngồi trên ghế nhà trường, anh đã thầm yêu Gink, nhưng sau đó, quyết định giữ tình bạn thân thiết. Nhưng điều gi sẽ xảy ra khi một ngày kia Gink quyết định có bạn trai?', 16, 'Chayanop ‘Mu’ Boonprakob', 'Pimchanok “Baifern” Leuwisetpaiboon, Naphat “Nine” Siangsomboon, Jason Young', '120 phút', 'Hài, Tình cảm', '2019-03-15'),
	(5, 'Chúa quỷ', 'https://drive.google.com/uc?id=1_rdDGBLNMRMwrFxQ07NO1vZDIB6p7_fj', 'https://www.youtube.com/embed/P--oOfNyDwc', 7.3, 'Dịch bệnh đã bùng phát ở một ngôi làng Do Thái. Để cứu sống dân làng, Hanna đã dựa vào thế lực thần bí tạo ra một thực thể lạ. Chính điều này lại là nguồn cơn gieo rắc tội ác.', 18, 'Doron Paz, Yoav Paz', 'Alex Tritenko, Brynie Furstenberg, Hani Furstenberg, Ishai Golan', '97 phút', 'Kinh Dị', '2019-02-05'),
	(6, 'Chúng ta (US)', 'https://drive.google.com/uc?id=1CS4FDT2XmSm2CvEIW_8-CjBPuxKNCX1W', 'https://www.youtube.com/embed/hNCmb-4oXJA', 8.3, 'Us, một tác phẩm đến từ hãng phim Monkeypaw, lấy bối cảnh tại một bờ biển mang tính biểu tượng phía Bắc California trong thời điểm hiện tại, với sự tham gia của các diễn viên như nữ diễn viên đạt giải Oscar Lupita Nyong’o với vai Adelaide Wilson, người đã trở lại căn nhà bên bờ biển mà cô sống thời ấu thơ cùng người chồng Gabe (ngôi sao Winston Duke của Black Panther) và hai người con (Shahadi Wright Joseph, Evan Alex) trong kì nghỉ hè. Bị ám ảnh bởi một chấn thương không thể giải thích trong quá khứ, kết hợp với một chuỗi các sự việc trùng hợp kỳ lạ, Adelaide cảm thấy sự hoang tưởng của bản thân đang tăng ở mức cảnh giác cao độ khi cô ngày càng chắc chắn rằng một điều gì đó tồi tệ sẽ xảy đến với gia đình mình. Sau một ngày vui chơi trên biển cùng một gia đình khác, nhà Tylers (nữ diễn viên thắng giải Emmy – Elisabeth Moss, Tim Heidecker, Cali Sheldon, Noelle Sheldon), Adelaide và gia đình cô chở về ngôi nhà của mình. Khi màn đêm buông xuống, nhà Wilsons bỗng thấy bóng của một gia đình 4 người đang nắm tay nhau đứng trên đường cao tốc. Us đẩy một gia đình Mỹ phải chống lại một đối thủ ghê rợn và kỳ lạ: những bản sao thực thể ma quái của chính họ.', 18, 'Jordan Peele', 'Anna Diop, Elisabeth Moss, Lupita Nyong\'o ,...', '122 phút', 'Hồi hộp', '2019-03-22'),
	(7, 'Phượng Hoàng Bóng Tối - X-Men: Dark Phoenix', 'https://drive.google.com/uc?id=1bTtch5hhzM7Rgi4yXUzaRaj0WfLYikrj', 'https://www.youtube.com/embed/gxs4J9Q6wRw', 0, 'Jean Gray bắt đầu phát triển sức mạnh phi thường, tiềm ẩn trong mình và nó đã biến cô thành Dark Phoenix. Bây giờ X-Men sẽ phải quyết định xem cuộc sống của một thành viên trong nhóm có đáng giá hơn tất cả những người sống trên thế giới.', 13, 'Simon Kinberg', 'Michael Fassbender, James McAvoy, Olivia Munn, Jennifer Lawrence, Jessica Chastain', '120 phút', 'Hành động, Phiêu lưu, Viễn tưởng', '2019-07-06'),
	(8, 'Annabelle 3', 'https://drive.google.com/uc?id=1LxzqMV0FLHJAemOegT51bGOuznPgct4E', 'https://www.youtube.com/embed/bCxm7cTpBAs', 0, 'Trong lúc Ed và Lorraine Warren vắng nhà, búp bê quỷ ám Annabelle đã phá vỡ phong ấn và thao túng các đồ vật tà ma ở phòng trưng bày. Mục tiêu tấn công của chúng là cô con gái nhỏ Judy 10 tuổi của hai vợ chồng. Cùng với cô giữ trẻ và một người bạn, Judy phải tìm cách chống trả các thế lực ác quỷ trước khi cha mẹ cô bé về “dẹp loạn”. ', 18, 'Gary Dauberman', 'Chưa có thông tin', '100 phút', 'Kinh dị, Huyền bí', '2019-07-03'),
	(9, 'Spider-Man: Người Nhện Xa Nhà', 'https://drive.google.com/uc?id=11K_1VKmiGNm2vaNDg61F578m7I6GLTjh', 'https://www.youtube.com/embed/sMxUb1A59MI', 0, 'Sau các sự kiện trong Avengers 4, Spider-Man (Tom Holland) cùng bạn bè đến châu Âu du lịch. Tại đây, cậu bắt tay cùng Mysterio (Jake Gyllenhaal) giải cứu thế giới khỏi những kẻ phản diện nguy hiểm.', 13, 'Jon Watts', 'Cobie Smulders, Marisa Tomei, Jon Favreau, Samuel L. Jackson, Zendaya, Jake Gyllenhaal, Tom Holland', 'Chưa có thông tin', 'Hành động, Viễn tưởng', '2019-07-05'),
	(10, 'Hobbs & Shaw', 'https://drive.google.com/uc?id=1u-bX1T-aSknqPuVcImbJFmcotoo8EjiW', 'https://www.youtube.com/embed/5ds_R_K5-fc', 0, 'Phần ngoại truyện của hai nhân vật được fan yêu thích từ loạt phim đình đám Fast & Furious: Luke Hobbs (The Rock) và Deckard Shaw (Jason Statham). Hai anh chàng thích đấu khẩu luôn mồm này sẽ bắt tay hợp tác trong một phi vụ nghẹt thở.', 16, 'David Leitch', 'Chưa có thông tin', '110 phút', 'Hành động', '2019-08-02'),
	(11, 'Chú Hề Ma Quái 2 - It: Chapter two', 'https://drive.google.com/uc?id=1oZU8JEFdo6M5Ug6zUmnARq7aVrxYgwC2', 'https://www.youtube.com/embed/OvfCQ2g4s0s', 0, 'Đúng chu kỳ 27 năm sau phần phim đầu tiên, thực thể ma quái dưới hình dạng chú hề tái xuất để khủng bố thị trấn Derry. Các thành viên của nhóm Loser’s Club năm xưa phải tập hợp để tiêu diệt It một lần và mãi mãi.', 18, 'Andy Muschietti', 'Chưa có thông tin', 'Chưa có thông tin', 'Kinh dị', '2019-09-06'),
	(12, 'Nữ Hoàng Băng Giá 2 - Frozen 2', 'https://drive.google.com/uc?id=1vZme3wDZ-frw_5Be1T7dZG9AtbHVY54m', 'https://www.youtube.com/embed/DwTls2hIOrA', 0, 'Phần 2 của bom tấn hoạt hình Nữ Hoàng Băng Giá.', 6, 'Jennifer Lee, Chris Buck', 'Jonathan Groff, Kristen Bell, Idina Menzel', '120 phút', 'Jonathan Groff, Kristen Bell, Idina Menzel', '2019-11-22');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.movie_showings
DROP TABLE IF EXISTS `movie_showings`;
CREATE TABLE IF NOT EXISTS `movie_showings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int(10) unsigned NOT NULL DEFAULT '0',
  `auditorium_id` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL DEFAULT '0',
  `status` int(10) unsigned NOT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `release_date` date NOT NULL,
  `time` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MOVIE_SHOWINGS_MOVIES` (`movie_id`),
  KEY `FK_MOVIE_SHOWINGS_AUDITORIUMS` (`auditorium_id`),
  CONSTRAINT `FK_MOVIE_SHOWINGS_AUDITORIUMS` FOREIGN KEY (`auditorium_id`) REFERENCES `auditoriums` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_MOVIE_SHOWINGS_MOVIES` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=343 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.movie_showings: ~342 rows (approximately)
/*!40000 ALTER TABLE `movie_showings` DISABLE KEYS */;
INSERT INTO `movie_showings` (`id`, `movie_id`, `auditorium_id`, `price`, `status`, `type`, `release_date`, `time`) VALUES
	(1, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-10', '16:00:00'),
	(2, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-10', '17:35:00'),
	(3, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-10', '18:55:00'),
	(4, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-10', '21:15:00'),
	(5, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-10', '22:15:00'),
	(6, 1, 1, 88000, 0, '3D - Phụ đề', '2019-05-11', '16:00:00'),
	(7, 1, 1, 88000, 0, '3D - Phụ đề', '2019-05-11', '17:35:00'),
	(8, 1, 1, 88000, 0, '3D - Phụ đề', '2019-05-11', '18:55:00'),
	(9, 1, 1, 88000, 0, '3D - Phụ đề', '2019-05-11', '21:15:00'),
	(10, 1, 1, 88000, 0, '3D - Phụ đề', '2019-05-11', '22:15:00'),
	(11, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-12', '16:00:00'),
	(12, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-12', '17:35:00'),
	(13, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-12', '18:55:00'),
	(14, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-12', '21:15:00'),
	(15, 1, 1, 88000, 0, '2D - Phụ đề', '2019-05-12', '22:15:00'),
	(16, 2, 2, 88000, 0, '2D - Phụ đề', '2019-05-15', '14:05:00'),
	(17, 2, 2, 88000, 0, '2D - Phụ đề', '2019-05-15', '18:25:00'),
	(18, 2, 2, 88000, 0, '2D - Phụ đề', '2019-05-15', '21:05:00'),
	(19, 2, 2, 88000, 0, '3D - Phụ đề', '2019-05-16', '14:05:00'),
	(20, 2, 2, 88000, 0, '3D - Phụ đề', '2019-05-16', '18:25:00'),
	(21, 2, 2, 88000, 0, '3D - Phụ đề', '2019-05-16', '21:05:00'),
	(22, 2, 2, 88000, 0, '2D - Phụ đề', '2019-05-17', '14:05:00'),
	(23, 2, 2, 88000, 0, '2D - Phụ đề', '2019-05-17', '18:25:00'),
	(24, 2, 2, 88000, 0, '2D - Phụ đề', '2019-05-17', '21:05:00'),
	(25, 3, 3, 88000, 0, '3D - Phụ đề', '2019-05-18', '18:00:00'),
	(26, 3, 3, 88000, 0, '3D - Phụ đề', '2019-05-18', '20:40:00'),
	(27, 3, 3, 88000, 0, '3D - Phụ đề', '2019-05-18', '23:05:00'),
	(28, 3, 3, 88000, 0, '2D - Phụ đề', '2019-05-19', '18:00:00'),
	(29, 3, 3, 88000, 0, '2D - Phụ đề', '2019-05-19', '20:40:00'),
	(30, 3, 3, 88000, 0, '2D - Phụ đề', '2019-05-19', '23:05:00'),
	(31, 3, 3, 88000, 0, '2D - Phụ đề', '2019-05-20', '18:00:00'),
	(32, 3, 3, 88000, 0, '2D - Phụ đề', '2019-05-20', '20:40:00'),
	(33, 3, 3, 88000, 0, '2D - Phụ đề', '2019-05-20', '23:05:00'),
	(34, 4, 1, 80000, 0, '3D - Phụ đề', '2019-05-19', '16:35:00'),
	(35, 4, 1, 80000, 0, '3D - Phụ đề', '2019-05-19', '18:40:00'),
	(36, 4, 1, 80000, 0, '2D - Phụ đề', '2019-05-20', '16:35:00'),
	(37, 4, 1, 80000, 0, '2D - Phụ đề', '2019-05-20', '18:40:00'),
	(38, 4, 1, 80000, 0, '2D - Phụ đề', '2019-05-21', '16:35:00'),
	(39, 4, 1, 80000, 0, '2D - Phụ đề', '2019-05-21', '18:40:00'),
	(40, 5, 2, 85000, 0, '2D - Phụ đề', '2019-05-20', '14:35:00'),
	(41, 5, 2, 85000, 0, '2D - Phụ đề', '2019-05-20', '20:20:00'),
	(42, 5, 2, 85000, 0, '2D - Phụ đề', '2019-05-20', '23:50:00'),
	(43, 5, 2, 85000, 0, '3D - Phụ đề', '2019-05-21', '14:35:00'),
	(44, 5, 2, 85000, 0, '3D - Phụ đề', '2019-05-21', '20:20:00'),
	(45, 5, 2, 85000, 0, '3D - Phụ đề', '2019-05-21', '23:50:00'),
	(46, 5, 2, 85000, 0, '2D - Phụ đề', '2019-05-22', '14:35:00'),
	(47, 5, 2, 85000, 0, '2D - Phụ đề', '2019-05-22', '20:20:00'),
	(48, 5, 2, 85000, 0, '2D - Phụ đề', '2019-05-22', '23:50:00'),
	(49, 6, 3, 88000, 0, '2D - Phụ đề', '2019-05-30', '14:05:00'),
	(50, 6, 3, 88000, 0, '2D - Phụ đề', '2019-05-30', '18:25:00'),
	(51, 6, 3, 88000, 0, '2D - Phụ đề', '2019-05-30', '21:05:00'),
	(52, 6, 3, 88000, 0, '2D - Phụ đề', '2019-06-01', '14:05:00'),
	(53, 6, 3, 88000, 0, '2D - Phụ đề', '2019-06-01', '18:25:00'),
	(54, 6, 3, 88000, 0, '2D - Phụ đề', '2019-06-01', '21:05:00'),
	(55, 6, 3, 88000, 0, '2D - Phụ đề', '2019-06-02', '14:05:00'),
	(56, 6, 3, 88000, 0, '2D - Phụ đề', '2019-06-02', '18:25:00'),
	(57, 6, 3, 88000, 0, '2D - Phụ đề', '2019-06-02', '21:05:00'),
	(58, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-10', '16:00:00'),
	(59, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-10', '17:35:00'),
	(60, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-10', '18:55:00'),
	(61, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-10', '21:15:00'),
	(62, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-10', '22:15:00'),
	(63, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-11', '16:00:00'),
	(64, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-11', '17:35:00'),
	(65, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-11', '18:55:00'),
	(66, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-11', '21:15:00'),
	(67, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-11', '22:15:00'),
	(68, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-12', '16:00:00'),
	(69, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-12', '17:35:00'),
	(70, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-12', '18:55:00'),
	(71, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-12', '21:15:00'),
	(72, 1, 4, 88000, 0, '2D - Phụ đề', '2019-05-12', '22:15:00'),
	(73, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-15', '14:05:00'),
	(74, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-15', '18:25:00'),
	(75, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-15', '21:05:00'),
	(76, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-16', '14:05:00'),
	(77, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-16', '18:25:00'),
	(78, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-16', '21:05:00'),
	(79, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-17', '14:05:00'),
	(80, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-17', '18:25:00'),
	(81, 2, 5, 88000, 0, '2D - Phụ đề', '2019-05-17', '21:05:00'),
	(82, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-18', '18:00:00'),
	(83, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-18', '20:40:00'),
	(84, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-18', '23:05:00'),
	(85, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-19', '18:00:00'),
	(86, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-19', '20:40:00'),
	(87, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-19', '23:05:00'),
	(88, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-20', '18:00:00'),
	(89, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-20', '20:40:00'),
	(90, 3, 6, 88000, 0, '2D - Phụ đề', '2019-05-20', '23:05:00'),
	(91, 4, 4, 80000, 0, '2D - Phụ đề', '2019-05-19', '16:35:00'),
	(92, 4, 4, 80000, 0, '2D - Phụ đề', '2019-05-19', '18:40:00'),
	(93, 4, 4, 80000, 0, '2D - Phụ đề', '2019-05-20', '16:35:00'),
	(94, 4, 4, 80000, 0, '2D - Phụ đề', '2019-05-20', '18:40:00'),
	(95, 4, 4, 80000, 0, '2D - Phụ đề', '2019-05-21', '16:35:00'),
	(96, 4, 4, 80000, 0, '2D - Phụ đề', '2019-05-21', '18:40:00'),
	(97, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-20', '14:35:00'),
	(98, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-20', '20:20:00'),
	(99, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-20', '23:50:00'),
	(100, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-21', '14:35:00'),
	(101, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-21', '20:20:00'),
	(102, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-21', '23:50:00'),
	(103, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-22', '14:35:00'),
	(104, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-22', '20:20:00'),
	(105, 5, 5, 85000, 0, '2D - Phụ đề', '2019-05-22', '23:50:00'),
	(106, 6, 6, 88000, 0, '2D - Phụ đề', '2019-05-30', '14:05:00'),
	(107, 6, 6, 88000, 0, '2D - Phụ đề', '2019-05-30', '18:25:00'),
	(108, 6, 6, 88000, 0, '2D - Phụ đề', '2019-05-30', '21:05:00'),
	(109, 6, 6, 88000, 0, '2D - Phụ đề', '2019-06-01', '14:05:00'),
	(110, 6, 6, 88000, 0, '2D - Phụ đề', '2019-06-01', '18:25:00'),
	(111, 6, 6, 88000, 0, '2D - Phụ đề', '2019-06-01', '21:05:00'),
	(112, 6, 6, 88000, 0, '2D - Phụ đề', '2019-06-02', '14:05:00'),
	(113, 6, 6, 88000, 0, '2D - Phụ đề', '2019-06-02', '18:25:00'),
	(114, 6, 6, 88000, 0, '2D - Phụ đề', '2019-06-02', '21:05:00'),
	(115, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-10', '16:00:00'),
	(116, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-10', '17:35:00'),
	(117, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-10', '18:55:00'),
	(118, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-10', '21:15:00'),
	(119, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-10', '22:15:00'),
	(120, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-11', '16:00:00'),
	(121, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-11', '17:35:00'),
	(122, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-11', '18:55:00'),
	(123, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-11', '21:15:00'),
	(124, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-11', '22:15:00'),
	(125, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-12', '16:00:00'),
	(126, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-12', '17:35:00'),
	(127, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-12', '18:55:00'),
	(128, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-12', '21:15:00'),
	(129, 1, 7, 88000, 0, '2D - Phụ đề', '2019-05-12', '22:15:00'),
	(130, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-15', '14:05:00'),
	(131, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-15', '18:25:00'),
	(132, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-15', '21:05:00'),
	(133, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-16', '14:05:00'),
	(134, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-16', '18:25:00'),
	(135, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-16', '21:05:00'),
	(136, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-17', '14:05:00'),
	(137, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-17', '18:25:00'),
	(138, 2, 8, 88000, 0, '2D - Phụ đề', '2019-05-17', '21:05:00'),
	(139, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-18', '18:00:00'),
	(140, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-18', '20:40:00'),
	(141, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-18', '23:05:00'),
	(142, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-19', '18:00:00'),
	(143, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-19', '20:40:00'),
	(144, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-19', '23:05:00'),
	(145, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-20', '18:00:00'),
	(146, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-20', '20:40:00'),
	(147, 3, 9, 88000, 0, '2D - Phụ đề', '2019-05-20', '23:05:00'),
	(148, 4, 7, 80000, 0, '2D - Phụ đề', '2019-05-19', '16:35:00'),
	(149, 4, 7, 80000, 0, '2D - Phụ đề', '2019-05-19', '18:40:00'),
	(150, 4, 7, 80000, 0, '2D - Phụ đề', '2019-05-20', '16:35:00'),
	(151, 4, 7, 80000, 0, '2D - Phụ đề', '2019-05-20', '18:40:00'),
	(152, 4, 7, 80000, 0, '2D - Phụ đề', '2019-05-21', '16:35:00'),
	(153, 4, 7, 80000, 0, '2D - Phụ đề', '2019-05-21', '18:40:00'),
	(154, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-20', '14:35:00'),
	(155, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-20', '20:20:00'),
	(156, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-20', '23:50:00'),
	(157, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-21', '14:35:00'),
	(158, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-21', '20:20:00'),
	(159, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-21', '23:50:00'),
	(160, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-22', '14:35:00'),
	(161, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-22', '20:20:00'),
	(162, 5, 8, 85000, 0, '2D - Phụ đề', '2019-05-22', '23:50:00'),
	(163, 6, 9, 88000, 0, '2D - Phụ đề', '2019-05-30', '14:05:00'),
	(164, 6, 9, 88000, 0, '2D - Phụ đề', '2019-05-30', '18:25:00'),
	(165, 6, 9, 88000, 0, '2D - Phụ đề', '2019-05-30', '21:05:00'),
	(166, 6, 9, 88000, 0, '2D - Phụ đề', '2019-06-01', '14:05:00'),
	(167, 6, 9, 88000, 0, '2D - Phụ đề', '2019-06-01', '18:25:00'),
	(168, 6, 9, 88000, 0, '2D - Phụ đề', '2019-06-01', '21:05:00'),
	(169, 6, 9, 88000, 0, '2D - Phụ đề', '2019-06-02', '14:05:00'),
	(170, 6, 9, 88000, 0, '2D - Phụ đề', '2019-06-02', '18:25:00'),
	(171, 6, 9, 88000, 0, '2D - Phụ đề', '2019-06-02', '21:05:00'),
	(172, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-10', '16:00:00'),
	(173, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-10', '17:35:00'),
	(174, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-10', '18:55:00'),
	(175, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-10', '21:15:00'),
	(176, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-10', '22:15:00'),
	(177, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-11', '16:00:00'),
	(178, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-11', '17:35:00'),
	(179, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-11', '18:55:00'),
	(180, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-11', '21:15:00'),
	(181, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-11', '22:15:00'),
	(182, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-12', '16:00:00'),
	(183, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-12', '17:35:00'),
	(184, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-12', '18:55:00'),
	(185, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-12', '21:15:00'),
	(186, 1, 10, 88000, 0, '2D - Phụ đề', '2019-05-12', '22:15:00'),
	(187, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-15', '14:05:00'),
	(188, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-15', '18:25:00'),
	(189, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-15', '21:05:00'),
	(190, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-16', '14:05:00'),
	(191, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-16', '18:25:00'),
	(192, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-16', '21:05:00'),
	(193, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-17', '14:05:00'),
	(194, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-17', '18:25:00'),
	(195, 2, 11, 88000, 0, '2D - Phụ đề', '2019-05-17', '21:05:00'),
	(196, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-18', '18:00:00'),
	(197, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-18', '20:40:00'),
	(198, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-18', '23:05:00'),
	(199, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-19', '18:00:00'),
	(200, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-19', '20:40:00'),
	(201, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-19', '23:05:00'),
	(202, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-20', '18:00:00'),
	(203, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-20', '20:40:00'),
	(204, 3, 12, 88000, 0, '2D - Phụ đề', '2019-05-20', '23:05:00'),
	(205, 4, 10, 80000, 0, '2D - Phụ đề', '2019-05-19', '16:35:00'),
	(206, 4, 10, 80000, 0, '2D - Phụ đề', '2019-05-19', '18:40:00'),
	(207, 4, 10, 80000, 0, '2D - Phụ đề', '2019-05-20', '16:35:00'),
	(208, 4, 10, 80000, 0, '2D - Phụ đề', '2019-05-20', '18:40:00'),
	(209, 4, 10, 80000, 0, '2D - Phụ đề', '2019-05-21', '16:35:00'),
	(210, 4, 10, 80000, 0, '2D - Phụ đề', '2019-05-21', '18:40:00'),
	(211, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-20', '14:35:00'),
	(212, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-20', '20:20:00'),
	(213, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-20', '23:50:00'),
	(214, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-21', '14:35:00'),
	(215, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-21', '20:20:00'),
	(216, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-21', '23:50:00'),
	(217, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-22', '14:35:00'),
	(218, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-22', '20:20:00'),
	(219, 5, 11, 85000, 0, '2D - Phụ đề', '2019-05-22', '23:50:00'),
	(220, 6, 12, 88000, 0, '2D - Phụ đề', '2019-05-30', '14:05:00'),
	(221, 6, 12, 88000, 0, '2D - Phụ đề', '2019-05-30', '18:25:00'),
	(222, 6, 12, 88000, 0, '2D - Phụ đề', '2019-05-30', '21:05:00'),
	(223, 6, 12, 88000, 0, '2D - Phụ đề', '2019-06-01', '14:05:00'),
	(224, 6, 12, 88000, 0, '2D - Phụ đề', '2019-06-01', '18:25:00'),
	(225, 6, 12, 88000, 0, '2D - Phụ đề', '2019-06-01', '21:05:00'),
	(226, 6, 12, 88000, 0, '2D - Phụ đề', '2019-06-02', '14:05:00'),
	(227, 6, 12, 88000, 0, '2D - Phụ đề', '2019-06-02', '18:25:00'),
	(228, 6, 12, 88000, 0, '2D - Phụ đề', '2019-06-02', '21:05:00'),
	(229, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-10', '16:00:00'),
	(230, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-10', '17:35:00'),
	(231, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-10', '18:55:00'),
	(232, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-10', '21:15:00'),
	(233, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-10', '22:15:00'),
	(234, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-11', '16:00:00'),
	(235, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-11', '17:35:00'),
	(236, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-11', '18:55:00'),
	(237, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-11', '21:15:00'),
	(238, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-11', '22:15:00'),
	(239, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-12', '16:00:00'),
	(240, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-12', '17:35:00'),
	(241, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-12', '18:55:00'),
	(242, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-12', '21:15:00'),
	(243, 1, 13, 88000, 0, '2D - Phụ đề', '2019-05-12', '22:15:00'),
	(244, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-15', '14:05:00'),
	(245, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-15', '18:25:00'),
	(246, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-15', '21:05:00'),
	(247, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-16', '14:05:00'),
	(248, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-16', '18:25:00'),
	(249, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-16', '21:05:00'),
	(250, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-17', '14:05:00'),
	(251, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-17', '18:25:00'),
	(252, 2, 14, 88000, 0, '2D - Phụ đề', '2019-05-17', '21:05:00'),
	(253, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-18', '18:00:00'),
	(254, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-18', '20:40:00'),
	(255, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-18', '23:05:00'),
	(256, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-19', '18:00:00'),
	(257, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-19', '20:40:00'),
	(258, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-19', '23:05:00'),
	(259, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-20', '18:00:00'),
	(260, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-20', '20:40:00'),
	(261, 3, 15, 88000, 0, '2D - Phụ đề', '2019-05-20', '23:05:00'),
	(262, 4, 13, 80000, 0, '2D - Phụ đề', '2019-05-19', '16:35:00'),
	(263, 4, 13, 80000, 0, '2D - Phụ đề', '2019-05-19', '18:40:00'),
	(264, 4, 13, 80000, 0, '2D - Phụ đề', '2019-05-20', '16:35:00'),
	(265, 4, 13, 80000, 0, '2D - Phụ đề', '2019-05-20', '18:40:00'),
	(266, 4, 13, 80000, 0, '2D - Phụ đề', '2019-05-21', '16:35:00'),
	(267, 4, 13, 80000, 0, '2D - Phụ đề', '2019-05-21', '18:40:00'),
	(268, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-20', '14:35:00'),
	(269, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-20', '20:20:00'),
	(270, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-20', '23:50:00'),
	(271, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-21', '14:35:00'),
	(272, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-21', '20:20:00'),
	(273, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-21', '23:50:00'),
	(274, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-22', '14:35:00'),
	(275, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-22', '20:20:00'),
	(276, 5, 14, 85000, 0, '2D - Phụ đề', '2019-05-22', '23:50:00'),
	(277, 6, 15, 88000, 0, '2D - Phụ đề', '2019-05-30', '14:05:00'),
	(278, 6, 15, 88000, 0, '2D - Phụ đề', '2019-05-30', '18:25:00'),
	(279, 6, 15, 88000, 0, '2D - Phụ đề', '2019-05-30', '21:05:00'),
	(280, 6, 15, 88000, 0, '2D - Phụ đề', '2019-06-01', '14:05:00'),
	(281, 6, 15, 88000, 0, '2D - Phụ đề', '2019-06-01', '18:25:00'),
	(282, 6, 15, 88000, 0, '2D - Phụ đề', '2019-06-01', '21:05:00'),
	(283, 6, 15, 88000, 0, '2D - Phụ đề', '2019-06-02', '14:05:00'),
	(284, 6, 15, 88000, 0, '2D - Phụ đề', '2019-06-02', '18:25:00'),
	(285, 6, 15, 88000, 0, '2D - Phụ đề', '2019-06-02', '21:05:00'),
	(286, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-10', '16:00:00'),
	(287, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-10', '17:35:00'),
	(288, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-10', '18:55:00'),
	(289, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-10', '21:15:00'),
	(290, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-10', '22:15:00'),
	(291, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-11', '16:00:00'),
	(292, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-11', '17:35:00'),
	(293, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-11', '18:55:00'),
	(294, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-11', '21:15:00'),
	(295, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-11', '22:15:00'),
	(296, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-12', '16:00:00'),
	(297, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-12', '17:35:00'),
	(298, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-12', '18:55:00'),
	(299, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-12', '21:15:00'),
	(300, 1, 16, 88000, 0, '2D - Phụ đề', '2019-05-12', '22:15:00'),
	(301, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-15', '14:05:00'),
	(302, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-15', '18:25:00'),
	(303, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-15', '21:05:00'),
	(304, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-16', '14:05:00'),
	(305, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-16', '18:25:00'),
	(306, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-16', '21:05:00'),
	(307, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-17', '14:05:00'),
	(308, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-17', '18:25:00'),
	(309, 2, 17, 88000, 0, '2D - Phụ đề', '2019-05-17', '21:05:00'),
	(310, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-18', '18:00:00'),
	(311, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-18', '20:40:00'),
	(312, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-18', '23:05:00'),
	(313, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-19', '18:00:00'),
	(314, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-19', '20:40:00'),
	(315, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-19', '23:05:00'),
	(316, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-20', '18:00:00'),
	(317, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-20', '20:40:00'),
	(318, 3, 18, 88000, 0, '2D - Phụ đề', '2019-05-20', '23:05:00'),
	(319, 4, 16, 80000, 0, '2D - Phụ đề', '2019-05-19', '16:35:00'),
	(320, 4, 16, 80000, 0, '2D - Phụ đề', '2019-05-19', '18:40:00'),
	(321, 4, 16, 80000, 0, '2D - Phụ đề', '2019-05-20', '16:35:00'),
	(322, 4, 16, 80000, 0, '2D - Phụ đề', '2019-05-20', '18:40:00'),
	(323, 4, 16, 80000, 0, '2D - Phụ đề', '2019-05-21', '16:35:00'),
	(324, 4, 16, 80000, 0, '2D - Phụ đề', '2019-05-21', '18:40:00'),
	(325, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-20', '14:35:00'),
	(326, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-20', '20:20:00'),
	(327, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-20', '23:50:00'),
	(328, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-21', '14:35:00'),
	(329, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-21', '20:20:00'),
	(330, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-21', '23:50:00'),
	(331, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-22', '14:35:00'),
	(332, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-22', '20:20:00'),
	(333, 5, 17, 85000, 0, '2D - Phụ đề', '2019-05-22', '23:50:00'),
	(334, 6, 18, 88000, 0, '2D - Phụ đề', '2019-05-30', '14:05:00'),
	(335, 6, 18, 88000, 0, '2D - Phụ đề', '2019-05-30', '18:25:00'),
	(336, 6, 18, 88000, 0, '2D - Phụ đề', '2019-05-30', '21:05:00'),
	(337, 6, 18, 88000, 0, '2D - Phụ đề', '2019-06-01', '14:05:00'),
	(338, 6, 18, 88000, 0, '2D - Phụ đề', '2019-06-01', '18:25:00'),
	(339, 6, 18, 88000, 0, '2D - Phụ đề', '2019-06-01', '21:05:00'),
	(340, 6, 18, 88000, 0, '2D - Phụ đề', '2019-06-02', '14:05:00'),
	(341, 6, 18, 88000, 0, '2D - Phụ đề', '2019-06-02', '18:25:00'),
	(342, 6, 18, 88000, 0, '2D - Phụ đề', '2019-06-02', '21:05:00');
/*!40000 ALTER TABLE `movie_showings` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.seats
DROP TABLE IF EXISTS `seats`;
CREATE TABLE IF NOT EXISTS `seats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `row` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` char(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `block_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SEATS_LOCATIONS` (`location_id`),
  KEY `FK_SEATS_BLOCKS` (`block_id`),
  CONSTRAINT `FK_SEATS_BLOCKS` FOREIGN KEY (`block_id`) REFERENCES `blocks` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SEATS_LOCATIONS` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.seats: ~4 rows (approximately)
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
INSERT INTO `seats` (`id`, `row`, `number`, `type`, `location_id`, `block_id`) VALUES
	(1, 'A', '1', 0, 4, 1),
	(2, 'F', '1', 0, 7, 2),
	(3, 'F', '2', 0, 7, 2),
	(4, 'B', '1', 0, 10, 3);
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` int(10) unsigned DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_card_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.users: ~6 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `full_name`, `gender`, `birthday`, `email`, `phone`, `address`, `credit_card_number`, `expiration_date`) VALUES
	(1, 'Châu Hải Hùng', 1, '1995-04-10', 'haihung100495@gmail.com', '0915512337', 'Tp. HCM', NULL, NULL),
	(2, 'Ngô Nhật Huy', 1, '1995-08-30', 'nhathuy.carvin@gmail.com', '01297653154', 'Tp. HCM', NULL, NULL),
	(3, 'Đỗ Nguyễn Minh Luân', 1, '1996-12-12', 'donguyenminhluan96@gmail.com', '0937817912', 'Tp. HCM', NULL, NULL),
	(4, 'Mai Thanh Tân', 1, '1993-08-28', 'thanhtan9876@gmail.com', '0973869608', 'Tp. HCM', NULL, NULL),
	(5, 'Phạm Minh Trung', 1, '1989-07-21', 'pmtrung@hcmus.edu.vn', '0909764990', 'Tp. HCM', NULL, NULL),
	(6, 'Tester', 1, '2000-01-01', 'tester@gmail.com', '19001560', 'Tp. HCM', NULL, NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.venues
DROP TABLE IF EXISTS `venues`;
CREATE TABLE IF NOT EXISTS `venues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_VENUES_LOCATIONS` (`location_id`),
  CONSTRAINT `FK_VENUES_LOCATIONS` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.venues: ~0 rows (approximately)
/*!40000 ALTER TABLE `venues` DISABLE KEYS */;
INSERT INTO `venues` (`id`, `address`, `location_id`) VALUES
	(1, '138 Đào Duy Từ, Phường 6, Quận 10, Hồ Chí Minh', 1),
	(2, 'Đường Lê Đức Thọ, Mỹ Đình, Nam Từ Liêm, Hà Nội', 2),
	(3, 'Sân vận động Hàng Đẫy, Số 9 Trịnh Hoài Đức, Cát Linh, Đống Đa, Hà Nội', 3);
/*!40000 ALTER TABLE `venues` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
