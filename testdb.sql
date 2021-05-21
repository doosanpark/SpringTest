-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.8-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- testdb 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `testdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `testdb`;

-- 테이블 testdb.account_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `account_info` (
  `account_no` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `reg_date` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`account_no`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='account info';

-- 테이블 데이터 testdb.account_info:~17 rows (대략적) 내보내기
/*!40000 ALTER TABLE `account_info` DISABLE KEYS */;
INSERT INTO `account_info` (`account_no`, `email`, `password`, `phone`, `reg_date`) VALUES
	(1, 'erid3232@naver.com', 'asdf', '1048424008', '0000-00-00'),
	(2, 'erid3232@nate.com', 'doosan', '0104842', '2021-02-18'),
	(3, 'erid3232@nate.com', 'doosan', '0104842', '2021-02-18'),
	(4, 'erid3232@gmail.com', 'asdf', '01048424008', '2021-02-22'),
	(5, 'erid3232@nate.com', 'asdf', '01048424997', '2021-02-24'),
	(6, 'erid3232@nate.com', 'asdf!S', '01048424997', '2021-02-24'),
	(7, 'erid3232@nate.com', 'asdf!S5123', '01048424997', '2021-02-24'),
	(8, 'erid3232@nate.com', 'asdf!S5123', '01048424997', '2021-02-24'),
	(9, 'erid3232', 'asdf!S5123', '01048424997', '2021-02-24'),
	(10, 'erid3232@', 'asdf!S5123', '01048424997', '2021-02-24'),
	(11, 'erid3232@bn', 'asdf!S5123', '01048424997', '2021-02-24'),
	(12, 'erid3232@bn.', 'asdf!S5123', '01048424997', '2021-02-24'),
	(13, 'erid3232@bn.a', 'asdf!S5123', '01048424997', '2021-02-24'),
	(14, 'erid3232@bn.c', 'asdf!S5123', '01048424997', '2021-02-24'),
	(15, 'erid3232@bn.cd', 'asdf!S5123', '01048424997', '2021-02-24'),
	(16, 'erid3232@nave.co', 'asdf2J!sI8', '01048424008', '2021-02-24'),
	(17, 'erid3232@nate.comm', 'DDoosan77!@', '010484242402', '2021-02-24');
/*!40000 ALTER TABLE `account_info` ENABLE KEYS */;

-- 테이블 testdb.books 구조 내보내기
CREATE TABLE IF NOT EXISTS `books` (
  `ID` varchar(5) NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `WRITER` varchar(20) NOT NULL,
  `PRICE` decimal(10,2) DEFAULT 0.00,
  `GENRE` varchar(20) NOT NULL,
  `PUBLISHER` varchar(20) NOT NULL,
  `CNT` decimal(10,0) DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 testdb.books:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` (`ID`, `NAME`, `WRITER`, `PRICE`, `GENRE`, `PUBLISHER`, `CNT`) VALUES
	('A1', '홍길동전', '허균', 300.00, '소설', '허균 출판사', 0),
	('B1', '레미제라블', '빅토르 위고', 900.00, '소설', '빅토르 위고 출판사', 0);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;

-- 테이블 testdb.login_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `login_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `access` char(1) NOT NULL DEFAULT 'n',
  `date` date NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- 테이블 데이터 testdb.login_history:~19 rows (대략적) 내보내기
/*!40000 ALTER TABLE `login_history` DISABLE KEYS */;
INSERT INTO `login_history` (`id`, `email`, `access`, `date`) VALUES
	(1, 'erid3232@bbdg.com', 'n', '2021-02-19'),
	(2, 'erid3232@bbdg.com', 'n', '2021-02-20'),
	(3, 'erid3232@daum.net', 'n', '2021-02-20'),
	(4, 'erid3232@daum.net', 'n', '2021-02-21'),
	(5, 'erid3232@naver.com', 'y', '2021-02-22'),
	(6, 'asdf@nate.com', 'n', '2021-02-22'),
	(7, 'erid3232@naver.com', 'n', '2021-02-22'),
	(8, 'erid3232@naver.com', 'y', '2021-02-25'),
	(9, 'erid3232@naver.com', 'n', '2021-02-25'),
	(10, 'erid3232@naver.com', 'y', '2021-02-25'),
	(11, 'erid3232@naver.com', 'y', '2021-02-25'),
	(12, 'erid3232@naver.com', 'n', '2021-02-25'),
	(13, 'erid3232@naver.com', 'n', '2021-02-25'),
	(14, 'erid3232@naver.com', 'y', '2021-02-26'),
	(15, 'erid3232@naver.com', 'y', '2021-02-26'),
	(16, 'erid3232@daum.net', 'y', '2021-02-26'),
	(17, 'erid3232@bbdg.com', 'y', '2021-02-26'),
	(18, 'erid3232@naver.com', 'y', '2021-02-26'),
	(19, 'erid3232@nate.com', 'y', '2021-02-26');
/*!40000 ALTER TABLE `login_history` ENABLE KEYS */;

-- 테이블 testdb.tab_mybatis 구조 내보내기
CREATE TABLE IF NOT EXISTS `tab_mybatis` (
  `name` varchar(10) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 testdb.tab_mybatis:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tab_mybatis` DISABLE KEYS */;
INSERT INTO `tab_mybatis` (`name`, `email`, `phone`) VALUES
	('말코임', 'qewdq@naee.com', '1234654'),
	('커피임', 'thosit@naee.com', '01044472343'),
	('호랑이', 'thosit@naee.com', '01044472343');
/*!40000 ALTER TABLE `tab_mybatis` ENABLE KEYS */;

-- 테이블 testdb.tbl_member 구조 내보내기
CREATE TABLE IF NOT EXISTS `tbl_member` (
  `userid` varchar(50) NOT NULL,
  `userpw` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `regdate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedate` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 testdb.tbl_member:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tbl_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_member` ENABLE KEYS */;

-- 테이블 testdb.users 구조 내보내기
CREATE TABLE IF NOT EXISTS `users` (
  `userid` varchar(30) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 testdb.users:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
