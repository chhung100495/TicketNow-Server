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
  `full_name` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit_card_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.accounts: ~5 rows (approximately)
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`, `username`, `password`, `full_name`, `email`, `phone`, `credit_card_number`, `expiration_date`) VALUES
	(1, 'chhung', 'e10adc3949ba59abbe56e057f20f883e', 'Châu Hải Hùng', 'haihung100495@gmail.com', '0915512337', '0', '0000-00-00'),
	(2, 'nnhuy', 'e10adc3949ba59abbe56e057f20f883e', 'Ngô Nhật Huy', 'nhathuy.carvin@gmail.com', '01297653154', '0', '0000-00-00'),
	(3, 'dnmluan', 'e10adc3949ba59abbe56e057f20f883e', 'Đỗ Nguyễn Minh Luân', 'donguyenminhluan96@gmail.com', '0937817912', '0', '0000-00-00'),
	(4, 'mttan', 'e10adc3949ba59abbe56e057f20f883e', 'Mai Thanh Tân', 'thanhtan9876@gmail.com', '0973869608', '0', '0000-00-00'),
	(5, 'pmtrung', 'e10adc3949ba59abbe56e057f20f883e', 'Phạm Minh Trung', 'pmtrung@hcmus.edu.vn', '0909764990', '0', '0000-00-00');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.auditoriums: ~2 rows (approximately)
/*!40000 ALTER TABLE `auditoriums` DISABLE KEYS */;
INSERT INTO `auditoriums` (`id`, `cinema_id`, `location_id`) VALUES
	(1, 1, 3),
	(2, 1, 4);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.blocks: ~0 rows (approximately)
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.booked_combos
DROP TABLE IF EXISTS `booked_combos`;
CREATE TABLE IF NOT EXISTS `booked_combos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` int(10) unsigned NOT NULL,
  `combo_id` int(10) unsigned NOT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_BOOKED_COMBOS_COMBOS` (`combo_id`),
  KEY `FK_BOOKED_COMBOS_BOOKINGS` (`booking_id`),
  CONSTRAINT `FK_BOOKED_COMBOS_BOOKINGS` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_BOOKED_COMBOS_COMBOS` FOREIGN KEY (`combo_id`) REFERENCES `combos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.booked_combos: ~0 rows (approximately)
/*!40000 ALTER TABLE `booked_combos` DISABLE KEYS */;
/*!40000 ALTER TABLE `booked_combos` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.booked_seats
DROP TABLE IF EXISTS `booked_seats`;
CREATE TABLE IF NOT EXISTS `booked_seats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` int(10) unsigned NOT NULL,
  `seat_id` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_BOOKED_SEATS_BOOKINGS` (`booking_id`),
  KEY `FK_BOOKED_SEATS_SEATS` (`seat_id`),
  CONSTRAINT `FK_BOOKED_SEATS_BOOKINGS` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_BOOKED_SEATS_SEATS` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.booked_seats: ~0 rows (approximately)
/*!40000 ALTER TABLE `booked_seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `booked_seats` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.bookings
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(10) unsigned NOT NULL,
  `booking_for_date_time` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_BOOKINGS_ACCOUNTS` (`account_id`),
  CONSTRAINT `FK_BOOKINGS_ACCOUNTS` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.bookings: ~0 rows (approximately)
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.cinemas
DROP TABLE IF EXISTS `cinemas`;
CREATE TABLE IF NOT EXISTS `cinemas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `address` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.cinemas: ~1 rows (approximately)
/*!40000 ALTER TABLE `cinemas` DISABLE KEYS */;
INSERT INTO `cinemas` (`id`, `name`, `address`, `phone`) VALUES
	(1, 'CGV', 'Tầng 2, Rivera Park Saigon - Số 7/28 Thành Thái, P.14, Q.10, TPHCM.', '19006017');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.event_showings: ~2 rows (approximately)
/*!40000 ALTER TABLE `event_showings` DISABLE KEYS */;
INSERT INTO `event_showings` (`id`, `event_id`, `venue_id`, `price`, `status`, `release_date`) VALUES
	(1, 1, 1, 100000, 0, '2018-06-13 19:00:00'),
	(2, 2, 2, 150000, 0, '2018-12-06 19:30:00');
/*!40000 ALTER TABLE `event_showings` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.locations
DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_seats` int(10) unsigned NOT NULL,
  `type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.locations: ~4 rows (approximately)
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` (`id`, `name`, `total_seats`, `type`) VALUES
	(1, 'SVĐ Thống Nhất', 15000, 1),
	(2, 'Sân vận động Quốc gia Mỹ Đình', 40192, 1),
	(3, 'Phòng A-01', 100, 0),
	(4, 'Phòng A-02', 100, 0);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.movies
DROP TABLE IF EXISTS `movies`;
CREATE TABLE IF NOT EXISTS `movies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `img_url` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` double unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_age` int(10) unsigned NOT NULL,
  `director` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cast` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `running_time` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `genre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.movies: ~7 rows (approximately)
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` (`id`, `name`, `img_url`, `score`, `description`, `min_age`, `director`, `cast`, `running_time`, `genre`) VALUES
	(1, 'Captain Marvel', 'https://drive.google.com/uc?id=13CthOX7v05pn-yE6z5xJaFd5xmW_FeVl', 7.9, 'Lấy bối cảnh những năm 90s, Captain Marvel là một cuộc phiêu lưu hoàn toàn mới đến với một thời kỳ chưa từng xuất hiện trong vũ trụ điện ảnh Marvel. Bộ phim kể về con đường trở thành siêu anh hùng mạnh mẽ nhất vũ trụ của Carol Danvers. Bên cạnh đó, trận chiến ảnh hưởng đến toàn vũ trụ giữa tộc Kree và tộc Skrull đã lan đến Trái Đất, liệu Danvers và các đồng minh có thể ngăn chặn binh đoàn Skrull cũng như các thảm họa tương lai?', 13, 'Anna Boden, Ryan Fleck', 'Brie Larson, Samuel L Jackson, Ben Mendelsohn,...', '129 phút', 'Hành Động, Phiêu Lưu'),
	(2, 'Công viên kỳ diệu', 'https://drive.google.com/uc?id=1kCDL0c5906PXyPyFikTvHIKjlm-l6bAU', 7.6, 'Một công viên lung linh, kỳ ảo được tạo nên bởi trí tưởng tượng vô tận của những đứa trẻ.', 6, 'Robert Iscove, Clare Kilner, David Feiss', 'Brianna Denski, Jennifer Garner, Ken Hudson Campbell', '91 phút', 'Hoạt Hình, Phiêu Lưu'),
	(3, 'Hạnh phúc của mẹ', 'https://drive.google.com/uc?id=10xhsb61luO2D-6O4zOy-PIWQkJYTYGmJ', 7.5, 'Hạnh Phúc Của Mẹ là hành trình người mẹ đơn thân, nghèo khó và nhiều bệnh tật Tuệ (Cát Phượng) giúp con trai Tim mắc hội chứng tự kỷ (bé Huy Khang) thực hiện đam mê nhảy múa, sống hào hứng mỗi ngày…', 6, 'Huỳnh Đông', 'Cát Phượng, Kiều Minh Tuấn, bé Huy Khang,…', '93 phút', 'Tâm Lý'),
	(4, 'Yêu nhầm bạn thân', 'https://drive.google.com/uc?id=1g4cyR-ALZDybqLckiRMzct4_Jv6bHALA', 8, 'Friend Zone xoay quanh mối tình đơn phương của Palm – một tiếp viên hàng không. Ngay từ lúc còn ngồi trên ghế nhà trường, anh đã thầm yêu Gink, nhưng sau đó, quyết định giữ tình bạn thân thiết. Nhưng điều gi sẽ xảy ra khi một ngày kia Gink quyết định có bạn trai?', 16, 'Chayanop ‘Mu’ Boonprakob', 'Pimchanok “Baifern” Leuwisetpaiboon, Naphat “Nine” Siangsomboon, Jason Young', '120 phút', 'Hài, Tình cảm'),
	(5, 'Chúa quỷ', 'https://drive.google.com/uc?id=1_rdDGBLNMRMwrFxQ07NO1vZDIB6p7_fj', 7.3, 'Dịch bệnh đã bùng phát ở một ngôi làng Do Thái. Để cứu sống dân làng, Hanna đã dựa vào thế lực thần bí tạo ra một thực thể lạ. Chính điều này lại là nguồn cơn gieo rắc tội ác.', 18, 'Doron Paz, Yoav Paz', 'Alex Tritenko, Brynie Furstenberg, Hani Furstenberg, Ishai Golan', '97 phút', 'Kinh Dị'),
	(6, 'Bảy viên ngọc rồng siêu cấp: Broly', 'https://drive.google.com/uc?id=1dMipO_y2bDHaCi4b2w1Tn7xQjTYZBzHf', 8.1, 'Dragon Ball Super: Broly là bộ phim thứ 20 trong series Dragon Ball và là phần đầu tiên mang thương hiệu Dragon Ball Super, lấy bối cảnh khi đế chế Frieza đàn áp, đặt ách thống trị, bắt người Saiyan phải phải phục vụ làm việc dưới quyền của chúng. Khi đó 3 đứa trẻ Saiyan đã được sinh ra cùng một lúc, nhưng số phận của chúng lại hoàn toàn khác nhau: Vegeta là hoàng tử của tộc người Saiyan, Kakalot (Goku) là con trai của tướng quân Bardock, và Broly là con của Paragus.', 13, 'Tatsuya Nagamine', '', '102 phút', 'Hành Động, Hoạt Hình'),
	(7, 'Chúng ta (US)', 'https://drive.google.com/uc?id=1AHks6wNU_ELTlavy5SthjFTmEm9vWg0D', 8.3, 'Us, một tác phẩm đến từ hãng phim Monkeypaw, lấy bối cảnh tại một bờ biển mang tính biểu tượng phía Bắc California trong thời điểm hiện tại, với sự tham gia của các diễn viên như nữ diễn viên đạt giải Oscar Lupita Nyong’o với vai Adelaide Wilson, người đã trở lại căn nhà bên bờ biển mà cô sống thời ấu thơ cùng người chồng Gabe (ngôi sao Winston Duke của Black Panther) và hai người con (Shahadi Wright Joseph, Evan Alex) trong kì nghỉ hè. Bị ám ảnh bởi một chấn thương không thể giải thích trong quá khứ, kết hợp với một chuỗi các sự việc trùng hợp kỳ lạ, Adelaide cảm thấy sự hoang tưởng của bản thân đang tăng ở mức cảnh giác cao độ khi cô ngày càng chắc chắn rằng một điều gì đó tồi tệ sẽ xảy đến với gia đình mình. Sau một ngày vui chơi trên biển cùng một gia đình khác, nhà Tylers (nữ diễn viên thắng giải Emmy – Elisabeth Moss, Tim Heidecker, Cali Sheldon, Noelle Sheldon), Adelaide và gia đình cô chở về ngôi nhà của mình. Khi màn đêm buông xuống, nhà Wilsons bỗng thấy bóng của một gia đình 4 người đang nắm tay nhau đứng trên đường cao tốc. Us đẩy một gia đình Mỹ phải chống lại một đối thủ ghê rợn và kỳ lạ: những bản sao thực thể ma quái của chính họ.', 18, 'Jordan Peele', 'Anna Diop, Elisabeth Moss, Lupita Nyong\'o ,...', '122 phút', 'Hồi hộp');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.movie_showings
DROP TABLE IF EXISTS `movie_showings`;
CREATE TABLE IF NOT EXISTS `movie_showings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `movie_id` int(10) unsigned NOT NULL DEFAULT '0',
  `auditorium_id` int(10) unsigned NOT NULL,
  `price` double unsigned NOT NULL DEFAULT '0',
  `status` int(10) unsigned NOT NULL,
  `release_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MOVIE_SHOWINGS_MOVIES` (`movie_id`),
  KEY `FK_MOVIE_SHOWINGS_AUDITORIUMS` (`auditorium_id`),
  CONSTRAINT `FK_MOVIE_SHOWINGS_AUDITORIUMS` FOREIGN KEY (`auditorium_id`) REFERENCES `auditoriums` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_MOVIE_SHOWINGS_MOVIES` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.movie_showings: ~2 rows (approximately)
/*!40000 ALTER TABLE `movie_showings` DISABLE KEYS */;
INSERT INTO `movie_showings` (`id`, `movie_id`, `auditorium_id`, `price`, `status`, `release_date`) VALUES
	(1, 1, 1, 88000, 0, '2019-03-08'),
	(2, 2, 2, 88000, 0, '2019-03-15');
/*!40000 ALTER TABLE `movie_showings` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.seats
DROP TABLE IF EXISTS `seats`;
CREATE TABLE IF NOT EXISTS `seats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `row` int(10) unsigned NOT NULL,
  `number` int(10) unsigned NOT NULL,
  `type` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `block_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SEATS_LOCATIONS` (`location_id`),
  KEY `FK_SEATS_BLOCKS` (`block_id`),
  CONSTRAINT `FK_SEATS_BLOCKS` FOREIGN KEY (`block_id`) REFERENCES `blocks` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_SEATS_LOCATIONS` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.seats: ~0 rows (approximately)
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;

-- Dumping structure for table booking_tickets.venues
DROP TABLE IF EXISTS `venues`;
CREATE TABLE IF NOT EXISTS `venues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_VENUES_LOCATIONS` (`location_id`),
  CONSTRAINT `FK_VENUES_LOCATIONS` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table booking_tickets.venues: ~2 rows (approximately)
/*!40000 ALTER TABLE `venues` DISABLE KEYS */;
INSERT INTO `venues` (`id`, `address`, `location_id`) VALUES
	(1, '138 Đào Duy Từ, Phường 6, Quận 10, Hồ Chí Minh', 1),
	(2, 'Đường Lê Đức Thọ, Mỹ Đình, Nam Từ Liêm, Hà Nội', 2);
/*!40000 ALTER TABLE `venues` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
