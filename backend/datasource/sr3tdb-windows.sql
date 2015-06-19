CREATE DATABASE  IF NOT EXISTS `sr3tdb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sr3tdb`;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `id` tinyint(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `md5hash` char(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (1,'add-users','bad3aaa77bb78c077aefb7d9d5753253'),(2,'edit-users','0cb5ab60ddaf6af4b46d2e8b82773001'),(3,'show-users','0450a0d78cc655fbd3b74a3ee00818a5'),(4,'delete-users','33b35c0278be3b2e210a3b32dad64a20'),(5,'add-robots','a7aa42096da0d20529a50b94bc83b866'),(6,'edit-robots','12d9eae8a6bfaeed5c9426b7a54f5c57'),(7,'show-robots','e45fee01d97764addc7fb8dad8768e62'),(8,'delete-robots','b22125aec66becb50b8489ff09ea4d57'),(9,'add-sensors','2e9dd558b1f691ce9673967b974467c3'),(10,'edit-sensors','415407b2e0966d8c73240d292214c675'),(11,'show-sensors','57109e17a958f5eebdd787807bcbd51b'),(12,'delete-sensors','9493c0a583cfd39edc5eb7932248be2b'),(13,'add-complements','e31e9f9bc6459d27194f6156e6088f0b'),(14,'edit-complements','8847fdcf4c9df6707062d4db26b0e87a'),(15,'show-complements','ddf72e46bcbec598e3acea56672785eb'),(16,'delete-complements','702eadefb377b3c4ece6388448033cef'),(32,'user-login','af8ef549bb444534f5b61d9beec5169f'),(33,'user-forgot-password','22cc218caffac6d2af32b3025d9646f8'),(34,'add-sensor-value','e77884c1c74ce13e59b127aec5ac9071'),(35,'add-cmpl-value','c6e5a85e5142c50829964f00ebf2585d'),(36,'user-contact','cd6690f8c68e837f0d4e4502827fcdb0');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actiontype`
--

DROP TABLE IF EXISTS `actiontype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actiontype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actiontype`
--

LOCK TABLES `actiontype` WRITE;
/*!40000 ALTER TABLE `actiontype` DISABLE KEYS */;
INSERT INTO `actiontype` VALUES (1,'add'),(2,'edit'),(3,'show'),(4,'delete');
/*!40000 ALTER TABLE `actiontype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complements`
--

DROP TABLE IF EXISTS `complements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `datatype` enum('int','bigint','float','double','string','char','text') NOT NULL,
  `imgurl` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complements`
--

LOCK TABLES `complements` WRITE;
/*!40000 ALTER TABLE `complements` DISABLE KEYS */;
/*!40000 ALTER TABLE `complements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forgotaccount`
--

DROP TABLE IF EXISTS `forgotaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forgotaccount` (
  `userid` int(11) NOT NULL,
  `requestcode` char(32) NOT NULL,
  `feedback` tinyint(1) NOT NULL DEFAULT '0',
  KEY `fk_users1` (`userid`),
  CONSTRAINT `fk_users1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forgotaccount`
--

LOCK TABLES `forgotaccount` WRITE;
/*!40000 ALTER TABLE `forgotaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `forgotaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relcompl`
--

DROP TABLE IF EXISTS `relcompl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relcompl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idrobot` int(11) NOT NULL,
  `idcmpl` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_robot1` (`idrobot`),
  KEY `fk_compl0` (`idcmpl`),
  CONSTRAINT `fk_compl0` FOREIGN KEY (`idcmpl`) REFERENCES `complements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_robot1` FOREIGN KEY (`idrobot`) REFERENCES `robot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relcompl`
--

LOCK TABLES `relcompl` WRITE;
/*!40000 ALTER TABLE `relcompl` DISABLE KEYS */;
/*!40000 ALTER TABLE `relcompl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relsensor`
--

DROP TABLE IF EXISTS `relsensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relsensor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idrobot` int(11) NOT NULL,
  `idsensor` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_robot0` (`idrobot`),
  KEY `fk_sensor0` (`idsensor`),
  CONSTRAINT `fk_sensor0` FOREIGN KEY (`idsensor`) REFERENCES `sensors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_robot0` FOREIGN KEY (`idrobot`) REFERENCES `robot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relsensor`
--

LOCK TABLES `relsensor` WRITE;
/*!40000 ALTER TABLE `relsensor` DISABLE KEYS */;
/*!40000 ALTER TABLE `relsensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsecodes`
--

DROP TABLE IF EXISTS `responsecodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responsecodes` (
  `name` varchar(45) NOT NULL,
  `md5hash` char(32) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsecodes`
--

LOCK TABLES `responsecodes` WRITE;
/*!40000 ALTER TABLE `responsecodes` DISABLE KEYS */;
INSERT INTO `responsecodes` VALUES ('add-cmplval-acepted','7829afd48e65aca6b03e29219e6b1a25'),('add-cmplval-error','f9e3e5d44613257f129b55ccd5fd64c4'),('add-complement-acepted','341867fc0cf2b82ac10e13c2bbb6406f'),('add-complement-error','7021e2a28dd2fd86dcdc78576e8b81cc'),('add-robot-acepted','abe3c63f80dfc3ec8eee2106d31b3b53'),('add-robot-error','5f241ec07f68ff43f5069cbfbfa9b617'),('add-sensor-acepted','4f6bf1b59d92a47797254ef02a18d294'),('add-sensor-error','dfa936c0b01ef96a49cc3f5e9759a0fb'),('add-sensorval-acepted','b5e163071014118de77315873653e069'),('add-sensorval-error','854e71b2758e0c7e5215ef73a64abe87'),('add-user-acepted','539387bd6efcace7b86a33f2ddfd975e'),('add-user-error','c929052a14680b40ee8dc77e71529f34'),('del-complement-acepted','e53db2aec05f42800066e3b50a0c7b56'),('del-complement-error','21b5312c894e0e934467bc70ca17a189'),('del-robot-acepted','39d584135b8d21092780b1c7f7b438c0'),('del-robot-error','bdd49830604525d667ca16f048b7228c'),('del-sensor-acepted','39f35d8b3ca142c8fb425a244cf7d61f'),('del-sensor-error','335a27795c8426dee8f6adaf78dd09b0'),('del-user-acepted','d3f23e518c8e46f4ced4e098de55ee91'),('del-user-error','6947fcdf2643f951d1c7bc8d6f8e400d'),('edit-complement-acepted','bdf19bc9ac13ef9e8753f50a151800d0'),('edit-complement-error','1a7bc911ec3f4df5afe8e323d03ccf5a'),('edit-robot-acepted','be0232127950fc67304cdc2c7c59b636'),('edit-robot-error','ddd86bfe31803715c0f79daa34ce0190'),('edit-sensor-acepted','97bbc91796bdd121f2e14cafba97f393'),('edit-sensor-error','b8be611385ab0244f38697298c17bdaa'),('edit-user-acepted','81cbe5063e6f0765f08ac5849197a3fd'),('edit-user-error','99f48584136cf1c5732637134dcb3df8'),('login-accepted','c908af3c5c30a302a50cf2b0a43e8176'),('login-error','4557e0bef6f9711ee3c416b77acd19a4'),('rcr-acepted','a98647fa26c10d1c3bf0f6618e7fe6fb'),('rcr-error','53adf0df4e74eab024dddf7eb4533b69'),('rsr-acepted','30b67a14a07157e51d8873f856ba1643'),('rsr-error','805cd049495ab7655a1fcfa68eba9110'),('sys-sqli-attack','24e7655789ac622fcf14670181d6eaee'),('user-exists-acepted','7e391bc80369734f9a3186e809095588'),('user-exists-error','9cd2ffaf58d12ccaa88a034040fa7704'),('user-rcode-acepted','b54e0836134a31249cd4f5072696514c'),('user-rcode-error','985aeea191b94391bffe683e594ad232'),('user-tracker-acepted','0b66305db2abe3becd377ecdd0ca0556'),('user-tracker-error','cca527d498165417690f25aed28dc821');
/*!40000 ALTER TABLE `responsecodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `robot`
--

DROP TABLE IF EXISTS `robot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `robot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users` (`iduser`),
  CONSTRAINT `fk_users` FOREIGN KEY (`iduser`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `robot`
--

LOCK TABLES `robot` WRITE;
/*!40000 ALTER TABLE `robot` DISABLE KEYS */;
/*!40000 ALTER TABLE `robot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensors`
--

DROP TABLE IF EXISTS `sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `datatype` enum('int','bigint','float','double','string','char','text') NOT NULL,
  `imgurl` varchar(1000) NOT NULL,
  `time` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensors`
--

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tablenames`
--

DROP TABLE IF EXISTS `tablenames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tablenames` (
  `id` tinyint(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tablenames`
--

LOCK TABLES `tablenames` WRITE;
/*!40000 ALTER TABLE `tablenames` DISABLE KEYS */;
INSERT INTO `tablenames` VALUES (1,'users'),(2,'robots'),(3,'sensors'),(4,'complements');
/*!40000 ALTER TABLE `tablenames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tracker`
--

DROP TABLE IF EXISTS `tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracker` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NOT NULL,
  `idaction` tinyint(2) NOT NULL,
  `_date` date NOT NULL,
  `_hour` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_users0` (`iduser`),
  KEY `fk_action0` (`idaction`),
  CONSTRAINT `fk_action0` FOREIGN KEY (`idaction`) REFERENCES `actions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_users0` FOREIGN KEY (`iduser`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tracker`
--

LOCK TABLES `tracker` WRITE;
/*!40000 ALTER TABLE `tracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `tracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utype` tinyint(1) NOT NULL DEFAULT '2',
  `name` varchar(40) NOT NULL,
  `email` varchar(30) NOT NULL,
  `md5hash` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_utype0` (`utype`),
  CONSTRAINT `fk_utype0` FOREIGN KEY (`utype`) REFERENCES `usertype` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'superrootboss','boss@root.net','66d6e4f737c901ef4076852867b69404');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertype` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `typename` varchar(20) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertype`
--

LOCK TABLES `usertype` WRITE;
/*!40000 ALTER TABLE `usertype` DISABLE KEYS */;
INSERT INTO `usertype` VALUES (1,'root','Root User: This is the unique user that cannot be deleted, but can track and delete the another users.'),(2,'guest','Guest User: Is a normal user and has not permissions for delete other users and track them.');
/*!40000 ALTER TABLE `usertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valrelcompl`
--

DROP TABLE IF EXISTS `valrelcompl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valrelcompl` (
  `idrelcompl` bigint(20) NOT NULL,
  `value` text NOT NULL,
  KEY `fk_relcompl0` (`idrelcompl`),
  CONSTRAINT `fk_relcompl0` FOREIGN KEY (`idrelcompl`) REFERENCES `relcompl` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valrelcompl`
--

LOCK TABLES `valrelcompl` WRITE;
/*!40000 ALTER TABLE `valrelcompl` DISABLE KEYS */;
/*!40000 ALTER TABLE `valrelcompl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valrelsensor`
--

DROP TABLE IF EXISTS `valrelsensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valrelsensor` (
  `idrelsensor` bigint(20) NOT NULL,
  `value` text NOT NULL,
  KEY `fk_relsensor0` (`idrelsensor`),
  CONSTRAINT `fk_relsensor0` FOREIGN KEY (`idrelsensor`) REFERENCES `relsensor` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valrelsensor`
--

LOCK TABLES `valrelsensor` WRITE;
/*!40000 ALTER TABLE `valrelsensor` DISABLE KEYS */;
/*!40000 ALTER TABLE `valrelsensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `viewComplementsByRobots`
--

DROP TABLE IF EXISTS `viewComplementsByRobots`;
/*!50001 DROP VIEW IF EXISTS `viewComplementsByRobots`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `viewComplementsByRobots` (
  `robotid` tinyint NOT NULL,
  `complementid` tinyint NOT NULL,
  `complementname` tinyint NOT NULL,
  `datatype` tinyint NOT NULL,
  `imgurl` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `viewRobotsByUsers`
--

DROP TABLE IF EXISTS `viewRobotsByUsers`;
/*!50001 DROP VIEW IF EXISTS `viewRobotsByUsers`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `viewRobotsByUsers` (
  `userid` tinyint NOT NULL,
  `robotid` tinyint NOT NULL,
  `robotname` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `viewSensorsByRobots`
--

DROP TABLE IF EXISTS `viewSensorsByRobots`;
/*!50001 DROP VIEW IF EXISTS `viewSensorsByRobots`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `viewSensorsByRobots` (
  `robotid` tinyint NOT NULL,
  `sensorid` tinyint NOT NULL,
  `sensorname` tinyint NOT NULL,
  `datatype` tinyint NOT NULL,
  `imgurl` tinyint NOT NULL,
  `time` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `viewValuesByComplements`
--

DROP TABLE IF EXISTS `viewValuesByComplements`;
/*!50001 DROP VIEW IF EXISTS `viewValuesByComplements`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `viewValuesByComplements` (
  `relcomplid` tinyint NOT NULL,
  `complementid` tinyint NOT NULL,
  `value` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `viewValuesBySensors`
--

DROP TABLE IF EXISTS `viewValuesBySensors`;
/*!50001 DROP VIEW IF EXISTS `viewValuesBySensors`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `viewValuesBySensors` (
  `relsensorid` tinyint NOT NULL,
  `sensorid` tinyint NOT NULL,
  `value` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'sr3tdb'
--
/*!50003 DROP FUNCTION IF EXISTS `addCmpl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `addCmpl`(n varchar(50), dt enum("int","bigint","float","double","string","char","text"), img varchar(100)) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-complement-error");
	if not exists(select id from complements where name = n) then
	begin
		insert into complements(name, datatype, imgurl) values(n, dt, img);
		set r = (select md5hash from responsecodes where name="add-complement-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `addCmplVal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `addCmplVal`(cid int, rid int, v text) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-cmplval-error");
	if exists(select idrobot from relcompl where idrobot=rid and idcmpl=cid) then
	begin
		
		
		insert into valrelcompl select relcompl.id, v from relcompl where relcompl.idcmpl = cid and relcompl.idrobot = rid;
		set r = (select md5hash from responsecodes where name="add-cmplval-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `addRobot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `addRobot`(uid int, n varchar(45)) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-robot-error");
	if not exists(select id from robot where iduser=uid and name=n) then
		insert into robot(iduser, name) values(uid, n);
		set r = (select md5hash from responsecodes where name="add-robot-acepted");
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `addSensor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `addSensor`(n varchar(50), dt enum("int","bigint","float","double","string","char","text"), img varchar(100), t float) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-sensor-error");
	if not exists(select id from sensors where name=n) then
	begin
		insert into sensors(name, datatype, imgurl, time) values(n, dt, img, t);
		set r = (select md5hash from responsecodes where name="add-sensor-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `addSensorVal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `addSensorVal`(rid int, sid int, v text) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-sensorval-error");

	if exists(select idrobot from relsensor where idrobot=rid and idsensor=sid) then
	begin
		
		
		insert into valrelsensor select relsensor.id, v from relsensor where relsensor.idrobot = rid and relsensor.idsensor = sid;
		set r = (select md5hash from responsecodes where name="add-sensorval-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `addUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `addUser`(n varchar(40), e varchar(30), m5h char(32)) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="add-user-error");
	if not exists(select id from users where email=e) then
	begin
		insert into users(name, email, md5hash) values(n, e, m5h);
		set r = (select md5hash from responsecodes where name="add-user-acepted");
	end; end if;
  return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `chUsrPass` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `chUsrPass`(rcode char(32), pm5h char(32)) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="user-rcode-error");
	if exists(select feedback from forgotaccount where requestcode = rcode) then
	begin
		declare uid int default (
			
			select userid from forgotaccount where requestcode=rcode
		);
		
		update users set md5hash=pm5h where id = uid;
		
		update forgotaccount set feedback=1 where responsecode=rcode;
		set r = (select md5hash from responsecodes where name="user-rcode-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `delCmpl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `delCmpl`(cid int) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="del-complement-error");
	if exists(select id from complements where id=cid) then
	begin
		delete from complements where id=cid;
		set r = (select md5hash from responsecodes where name="del-complement-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `delRobot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `delRobot`(rid int) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="del-robot-error");
	if exists(select id from robot where id=rid) then
	begin
		delete from robot where id=rid;
		set r = (select md5hash from responsecodes where name="del-robot-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `delSensor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `delSensor`(sid int) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="del-sensor-error");
	if exists(select id from sensors where id=sid) then
	begin
		update sensors set name=n, datatype = dt, imgurl = img, time = t where id=sid;
		set r = (select md5hash from responsecodes where name="del-sensor-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `delUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `delUser`(i int) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="del-user-error");
	if exists(select id from users where id=i and utype=2) then
	begin
		delete from users where id=i;
		set r = (select md5hash from responsecodes where name="del-user-acepted");
	end;
	end if;
	return r;
 end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `editCmpl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `editCmpl`(cid int, n varchar(50), dt enum("int","bigint","float","double","string","char","text"), img varchar(100)) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="edit-complement-error");
	if exists(select id from complements where id=cid) then
	begin
		update complements set name=n, datatype=dt, imgurl=img where id=cid;
		set r = (select md5hash from responsecodes where name="edit-complement-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `editRobot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `editRobot`(rid int, uid int, n varchar(45)) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="edit-robot-error");
	if exists(select id from robot where id=rid and iduser=uid) then
	begin
		update robot set name=n where id=rid;
		set r = (select md5hash from responsecodes where name="edit-robot-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `editSensor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `editSensor`(sid int, n varchar(50), dt enum("int","bigint","float","double","string","char","text"), img varchar(100), t float) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="edit-sensor-error");
	if exists(select id from sensors where id=sid) then
	begin
		update sensors set name=n, datatype = dt, imgurl = img, time = t where id=sid;
		set r = (select md5hash from responsecodes where name="edit-sensor-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `editUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `editUser`(i int, n varchar(40), e varchar(30), m5h char(32)) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="edit-user-error");
	if exists(select id from users where id=i) then
	begin
		update users set name=n, email=e, md5hash=m5h where id=i;
		set r = (select md5hash from responsecodes where name="edit-user-acepted");
	end;
	end if;
	return r;
 end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `refCmplToRobot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `refCmplToRobot`(cid int, rid int) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="rcr-error");
	if exists(select id from complements where id=cid) and exists(select id from robot where id=rid) then
	begin
		insert into relcompl(idrobot, idcmpl) values(rid, cid);
		set r = (select md5hash from responsecodes where name="rcr-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `refSensorToRobot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `refSensorToRobot`(sid int, rid int) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="rsr-error");
	if exists(select id from sensors where id=sid) and exists(select id from robot where id=rid) then
	begin
		insert into relsensor(idrobot, idsensor) values(sid, rid);
		set r = (select md5hash from responsecodes where name="rsr-acepted");
	end;
	end if;
	return r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `regForgotAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `regForgotAccount`(e varchar(30)) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from responsecodes where name="user-exists-error");
	if exists(select id from users where email=e) then
	begin
		insert into forgotaccount(userid, requestcode) select users.id, md5(concat(floor(rand()*10273), "$<%#$<(/K1)<=)>"));
		set r = (select md5hash from response where name="user-exists-acepted");
	end;
	end if;
	return  r;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `systemTracking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `systemTracking`(uid int, aid int) RETURNS char(32) CHARSET latin1
begin
	declare r char(32) default (select md5hash from actions where name="user-tracker-error");
	if exists(select id from users where id=uid) and exists(select id from actions where id=aid) then
		begin
			insert into tracker(iduser, idaction, _date, _hour) select uid, aid, curdate(), curtime();
			set r = (select md5hash from actions where name="user-tracker-acepted");
		end;
		return r;
	end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `userLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `userLogin`(e varchar(30), m5h char(32)) RETURNS char(32) CHARSET latin1
begin
 	declare r char(32) default (select md5hash from responsecodes where name="login-error");
	if exists(select id from users where email=e and md5hash=m5h) then
		set r = (select md5hash from responsecodes where name="login-accepted");
	end if;
	return r;
 end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `viewComplementsByRobots`
--

/*!50001 DROP TABLE IF EXISTS `viewComplementsByRobots`*/;
/*!50001 DROP VIEW IF EXISTS `viewComplementsByRobots`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `viewComplementsByRobots` AS (select `robot`.`id` AS `robotid`,`complements`.`id` AS `complementid`,`complements`.`name` AS `complementname`,`complements`.`datatype` AS `datatype`,`complements`.`imgurl` AS `imgurl` from ((`complements` join `robot`) join `relcompl`) where ((`relcompl`.`idrobot` = `robot`.`id`) and (`relcompl`.`idcmpl` = `complements`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewRobotsByUsers`
--

/*!50001 DROP TABLE IF EXISTS `viewRobotsByUsers`*/;
/*!50001 DROP VIEW IF EXISTS `viewRobotsByUsers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `viewRobotsByUsers` AS (select `users`.`id` AS `userid`,`robot`.`id` AS `robotid`,`robot`.`name` AS `robotname` from (`users` join `robot`) where (`users`.`id` = `robot`.`iduser`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewSensorsByRobots`
--

/*!50001 DROP TABLE IF EXISTS `viewSensorsByRobots`*/;
/*!50001 DROP VIEW IF EXISTS `viewSensorsByRobots`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `viewSensorsByRobots` AS (select `robot`.`id` AS `robotid`,`sensors`.`id` AS `sensorid`,`sensors`.`name` AS `sensorname`,`sensors`.`datatype` AS `datatype`,`sensors`.`imgurl` AS `imgurl`,`sensors`.`time` AS `time` from ((`sensors` join `robot`) join `relsensor`) where ((`relsensor`.`idrobot` = `robot`.`id`) and (`relsensor`.`idsensor` = `sensors`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewValuesByComplements`
--

/*!50001 DROP TABLE IF EXISTS `viewValuesByComplements`*/;
/*!50001 DROP VIEW IF EXISTS `viewValuesByComplements`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `viewValuesByComplements` AS (select `relcompl`.`id` AS `relcomplid`,`viewComplementsByRobots`.`complementid` AS `complementid`,`valrelcompl`.`value` AS `value` from ((`valrelcompl` join `viewComplementsByRobots`) join `relcompl`) where ((`relcompl`.`idrobot` = `viewComplementsByRobots`.`robotid`) and (`relcompl`.`idcmpl` = `viewComplementsByRobots`.`complementid`) and (`relcompl`.`id` = `valrelcompl`.`idrelcompl`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewValuesBySensors`
--

/*!50001 DROP TABLE IF EXISTS `viewValuesBySensors`*/;
/*!50001 DROP VIEW IF EXISTS `viewValuesBySensors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `viewValuesBySensors` AS (select `relsensor`.`id` AS `relsensorid`,`viewSensorsByRobots`.`sensorid` AS `sensorid`,`valrelsensor`.`value` AS `value` from ((`valrelsensor` join `viewSensorsByRobots`) join `relsensor`) where ((`relsensor`.`idrobot` = `viewSensorsByRobots`.`robotid`) and (`relsensor`.`idsensor` = `viewSensorsByRobots`.`sensorid`) and (`relsensor`.`id` = `valrelsensor`.`idrelsensor`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

