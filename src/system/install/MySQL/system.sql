
insert into sys_privilege
(id,pro_privilege_id,code_,name_,url_,desc_)
values
(1    , 0,   1, '内部权限', NULL, NULL),
(2    , 0,   2, '外部权限', NULL, NULL),

(1011 , 1, 101, '查询用户', NULL, NULL),
(1012 , 1, 102, '创建用户', NULL, NULL),
(1013 , 1, 103, '更新用户(含权限)', NULL, NULL),
(1014 , 1, 104, '删除用户', NULL, NULL),
(1019 , 1, 109, '更新用户', NULL, NULL),

(1021 , 1, 121, '查询组织', NULL, NULL),
(1022 , 1, 122, '创建组织', NULL, NULL),
(1023 , 1, 123, '更新组织', NULL, NULL),
(1024 , 1, 124, '删除组织', NULL, NULL),

(1031 , 1, 131, '查询角色', NULL, NULL),
(1032 , 1, 132, '创建角色', NULL, NULL),
(1033 , 1, 133, '更新角色', NULL, NULL),
(1034 , 1, 134, '删除角色', NULL, NULL),



(2101 , 2, 10101, '查询公司', NULL, NULL),
(2102 , 2, 10102, '创建公司', NULL, NULL),
(2103 , 2, 10103, '更新公司', NULL, NULL),
(2104 , 2, 10104, '删除公司', NULL, NULL),


(2201 , 2, 10201, '查询联系人', NULL, NULL),
(2202 , 2, 10202, '创建联系人', NULL, NULL),
(2203 , 2, 10203, '更新联系人', NULL, NULL),
(2204 , 2, 10204, '删除联系人', NULL, NULL),

(2011 , 2, 109, '更新用户', NULL, NULL);


-- MySQL dump 10.10
--
-- Host: localhost    Database: jbpm_demo
-- ------------------------------------------------------
-- Server version	5.0.9-beta

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `system_organization`
--

DROP TABLE IF EXISTS `system_organization`;
CREATE TABLE `system_organization` (
  `organization_id` decimal(12,0) NOT NULL,
  `pro_organization_id` decimal(12,0) default NULL,
  `name_` varchar(50) character set utf8 default NULL,
  `desc_` varchar(2500) character set utf8 default NULL,
  KEY `FK_Reference_9` (`pro_organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `system_organization`
--


/*!40000 ALTER TABLE `system_organization` DISABLE KEYS */;
LOCK TABLES `system_organization` WRITE;
INSERT INTO `system_organization` VALUES ('1',NULL,'testr','tesat'),('2',NULL,'fadd','sdaf'),('3','1','fds','sdf'),('4','3','sdfff','sdf'),('5','2','12','12'),('6','2','test','test'),('8','2','t','t'),('9',NULL,'System Manage','');
UNLOCK TABLES;
/*!40000 ALTER TABLE `system_organization` ENABLE KEYS */;

--
-- Table structure for table `system_organization_privilege`
--

DROP TABLE IF EXISTS `system_organization_privilege`;
CREATE TABLE `system_organization_privilege` (
  `organization_id` decimal(12,0) NOT NULL,
  `privilege_id` decimal(12,0) NOT NULL,
  KEY `FK_Reference_10` (`organization_id`),
  KEY `FK_Reference_11` (`privilege_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `system_organization_privilege`
--


/*!40000 ALTER TABLE `system_organization_privilege` DISABLE KEYS */;
LOCK TABLES `system_organization_privilege` WRITE;
INSERT INTO `system_organization_privilege` VALUES ('5','6'),('5','5'),('5','4'),('5','1'),('6','3'),('6','9'),('9','17'),('9','16'),('9','15'),('8','9'),('9','14'),('9','13'),('9','12'),('9','11'),('9','21'),('9','19'),('9','18'),('9','20'),('9','22'),('9','23');
UNLOCK TABLES;
/*!40000 ALTER TABLE `system_organization_privilege` ENABLE KEYS */;

--
-- Table structure for table `system_privilege`
--

DROP TABLE IF EXISTS `system_privilege`;
CREATE TABLE `system_privilege` (
  `privilege_id` decimal(12,0) NOT NULL,
  `pro_privilege_id` decimal(12,0) default NULL,
  `code_` varchar(50) character set utf8 default NULL,
  `name_` varchar(50) character set utf8 default NULL,
  `url_` varchar(250) character set utf8 default NULL,
  `desc_` varchar(2500) character set utf8 default NULL,
  KEY `FK_Reference_14` (`pro_privilege_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `system_privilege`
--


/*!40000 ALTER TABLE `system_privilege` DISABLE KEYS */;
LOCK TABLES `system_privilege` WRITE;
INSERT INTO `system_privilege` VALUES ('1',NULL,'1','1',NULL,'1'),('2',NULL,'2','2',NULL,'2'),('3',NULL,'3','3',NULL,'3'),('4','1','11','11',NULL,'11'),('5','1','12','12',NULL,'12\";;\';#$$%%@#@'),('6','1','13','13',NULL,'13\rkh\rhk\rhk'),('7','2','21','21',NULL,'121'),('8','2','22','22',NULL,'22'),('9','3','32','32',NULL,'32'),('10','3','31','31',NULL,'31'),('11',NULL,'1','System Mangement',NULL,''),('12','11','101','User Management',NULL,'User Management'),('13','11','102','User Create',NULL,''),('14','11','103','User Update',NULL,''),('15','11','104','User Delete',NULL,''),('16','11','111','Org Management',NULL,''),('17','11','112','Org Create',NULL,''),('18','11','113','Org Update',NULL,''),('19','11','114','Org Delete',NULL,''),('21','11','122','Privilege Create',NULL,''),('20','11','121','Privilege Management',NULL,''),('22','11','123','Privilege Update',NULL,''),('23','11','124','Privilege Delete',NULL,'');
UNLOCK TABLES;
/*!40000 ALTER TABLE `system_privilege` ENABLE KEYS */;

--
-- Table structure for table `system_user`
--

DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
  `user_id` decimal(12,0) NOT NULL,
  `login_id` varchar(50) character set utf8 NOT NULL,
  `password_` varchar(50) character set utf8 NOT NULL,
  `name_` varchar(50) character set utf8 NOT NULL,
  `email_` varchar(50) character set utf8 default NULL,
  `REGION` varchar(50) character set utf8 default NULL,
  `status_` varchar(5) character set utf8 default NULL,
  `desc_` varchar(2500) character set utf8 default NULL,
  `organization_id` decimal(12,0) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `system_user`
--


/*!40000 ALTER TABLE `system_user` DISABLE KEYS */;
LOCK TABLES `system_user` WRITE;
INSERT INTO `system_user` VALUES ('1','5','C4CA4238A0B923820DCC509A6F75849B','53242','adfadfa@123.com',NULL,NULL,NULL,NULL),('2','677p','1679091C5A880FAF6FB5E6087EB1B2DC','6vzvzdsafai','22@163.com',NULL,NULL,NULL,NULL),('10','tt','ACCC9105DF5383111407FD5B41255E23','tt','tt@tt.com',NULL,NULL,NULL,NULL),('11','admin','21232F297A57A5A743894A0E4A801FC3','admin','admin@163.com',NULL,NULL,NULL,NULL),('8','8p','C9F0F895FB98AB9159F51FD0297E236D','8h','',NULL,NULL,NULL,NULL),('9','34ggg','ECCBC87E4B5CE2FE28308FD9F2A7BAF3','3','',NULL,NULL,NULL,NULL),('12','3432','6512BD43D9CAA6E02C990B0A82652DCA','?','11@11.com',NULL,NULL,NULL,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `system_user` ENABLE KEYS */;

--
-- Table structure for table `system_user_organization`
--

DROP TABLE IF EXISTS `system_user_organization`;
CREATE TABLE `system_user_organization` (
  `organization_id` decimal(12,0) NOT NULL,
  `user_id` decimal(12,0) NOT NULL,
  KEY `FK_Reference_7` (`user_id`),
  KEY `FK_Reference_8` (`organization_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `system_user_organization`
--


/*!40000 ALTER TABLE `system_user_organization` DISABLE KEYS */;
LOCK TABLES `system_user_organization` WRITE;
INSERT INTO `system_user_organization` VALUES ('5','10'),('2','10'),('6','10'),('8','10'),('9','11');
UNLOCK TABLES;
/*!40000 ALTER TABLE `system_user_organization` ENABLE KEYS */;

--
-- Table structure for table `system_user_privilege`
--

DROP TABLE IF EXISTS `system_user_privilege`;
CREATE TABLE `system_user_privilege` (
  `user_id` decimal(12,0) NOT NULL,
  `privilege_id` decimal(12,0) NOT NULL,
  KEY `FK_Reference_12` (`privilege_id`),
  KEY `FK_Reference_13` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `system_user_privilege`
--


/*!40000 ALTER TABLE `system_user_privilege` DISABLE KEYS */;
LOCK TABLES `system_user_privilege` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `system_user_privilege` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

