-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: scrumboard
-- ------------------------------------------------------
-- Server version	5.7.8-rc-log

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
-- Current Database: `scrumboard`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `scrumboard` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `scrumboard`;

--
-- Table structure for table `_release`
--

DROP TABLE IF EXISTS `_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_release` (
  `id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqwn43p5n86ro4wdn6ih1ekaq8` (`team`),
  CONSTRAINT `FKqwn43p5n86ro4wdn6ih1ekaq8` FOREIGN KEY (`team`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_release`
--

LOCK TABLES `_release` WRITE;
/*!40000 ALTER TABLE `_release` DISABLE KEYS */;
INSERT INTO `_release` VALUES (1,1,'ECE 16');
/*!40000 ALTER TABLE `_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_oic035rk9hq7fs2iy3wcie01f` (`avatar`),
  KEY `FKfkq83m79uj8r06c6t6wv636md` (`team`),
  CONSTRAINT `FKfkq83m79uj8r06c6t6wv636md` FOREIGN KEY (`team`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (3,1,'Ivvan',NULL),(4,1,'Jenning',NULL),(5,1,'Mary',NULL),(6,1,'Matches',NULL),(7,1,'Nianxiang',NULL),(8,1,'Wenping',NULL),(9,1,'Echo','Echo.png');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprint`
--

DROP TABLE IF EXISTS `sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sprint` (
  `id` int(11) NOT NULL,
  `_release` int(11) NOT NULL,
  `number` int(11) DEFAULT NULL,
  `start_time` date DEFAULT NULL,
  `duration_week` int(11) DEFAULT NULL,
  `velocity` int(11) DEFAULT NULL,
  `manday` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKibd1v83ommtwmrna0dml9qsp4` (`_release`),
  CONSTRAINT `FKibd1v83ommtwmrna0dml9qsp4` FOREIGN KEY (`_release`) REFERENCES `_release` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprint`
--

LOCK TABLES `sprint` WRITE;
/*!40000 ALTER TABLE `sprint` DISABLE KEYS */;
INSERT INTO `sprint` VALUES (1,1,0,'2015-12-17',0,0,0),(2,1,1,'2015-12-17',1,1,1);
/*!40000 ALTER TABLE `sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `planTime` int(11) DEFAULT NULL,
  `actualTime` int(11) DEFAULT NULL,
  `followUp` varchar(500) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `cpiChange` bit(1) DEFAULT NULL,
  `user_story` int(11) DEFAULT NULL,
  `member` int(11) DEFAULT NULL,
  `sprint` int(11) DEFAULT NULL,
  `backlog` bit(1) NOT NULL,
  `issue` longtext,
  PRIMARY KEY (`id`),
  KEY `FKabkpmb0bgaa8j1x0m6ntgcndp` (`user_story`),
  KEY `FKi1tj6bstnvdjw5995yqb7xhdp` (`member`),
  KEY `FKlfmmmoplx7vi821fhqjkiso0e` (`sprint`),
  CONSTRAINT `FKabkpmb0bgaa8j1x0m6ntgcndp` FOREIGN KEY (`user_story`) REFERENCES `user_story` (`id`),
  CONSTRAINT `FKi1tj6bstnvdjw5995yqb7xhdp` FOREIGN KEY (`member`) REFERENCES `member` (`id`),
  CONSTRAINT `FKlfmmmoplx7vi821fhqjkiso0e` FOREIGN KEY (`sprint`) REFERENCES `sprint` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (3,'M2M performance test tuning','ONGOING',1,1,'','',1,'\0',1,6,2,'\0',NULL),(4,'M2M performance test ci environment setup\n- Nagios \n- provisioning pass\n- case single run pass (11 cases)','DONE',1,1,'','',1,'\0',1,6,2,'\0',NULL),(5,'M2M performance test result report (including SILK)','TODO',1,1,'','',1,'\0',1,NULL,2,'\0',NULL),(6,'DP scrips implement','REVIEW',1,1,'',' - DP-authenticate-Traffic/LBS\n - DP-Identity-Traffic/LBS',1,'\0',2,7,2,'\0',NULL),(7,'Session management restful service - create\n- wrap AuthenticationSessionManager::createSession','REVIEW',1,1,'','',1,'\0',2,3,2,'\0',NULL),(8,'CI2 env setup for new DP','ONGOING',1,1,'',' - add new vip-DP-authenticate-LBS configuration',1,'\0',2,3,2,'\0',NULL),(9,'Session management restful service - update','REVIEW',1,1,'',' - wrap AuthenticationSessionManager::refresh',1,'\0',2,7,2,'\0',NULL),(10,'Session management restful service - query','REVIEW',1,1,'',' - wrap AuthenticationSessionManager::getSession',1,'\0',2,7,2,'\0',NULL),(11,'Session management restful service - validate','REVIEW',1,1,'',' - wrap AuthenticationSessionManager::checkSession',1,'\0',2,7,2,'\0',NULL),(31,'Session management restful service - delete','REVIEW',1,1,'','- wrap AuthenticationSessionManager::removeSession, removeSessionByOwnerId & removeSessionByOwnerIdExceptSessionId',1,'\0',2,7,2,'\0',NULL),(32,'Alarm support for session data access','TODO',1,1,'',' - test manually if alarm in session management is valid or not \n - if not valid, add alarm mechanism in session dao',1,'\0',2,NULL,2,'\0',NULL),(33,'Test point for session management restful service','FOLLOWUP',1,1,'','',1,'\0',2,5,2,'\0',NULL),(34,'Test case for session management restful service','ONGOING',1,1,'','',1,'\0',2,5,2,'\0',NULL),(35,'Modify authorize service to use new session management restful service to replace session manager calling','ONGOING',1,1,'','',1,'\0',2,7,2,'\0',NULL),(36,'Test point/Test case for authorize API','TODO',1,1,'','',1,'\0',2,5,2,'\0',NULL),(37,'Implement authenticate service & manager without:\n - real counter function, real password encrypt, IP configured','ONGOING',1,1,'','',1,'\0',2,8,2,'\0',NULL),(38,'Implement default hash algorithm used for password/securityAnswer\n - Add password encrypt in authenticate','TODO',1,1,'','',1,'\0',2,NULL,2,'\0',NULL),(39,'Test point for authenticate API','REVIEW',1,1,'','',1,'\0',2,5,2,'\0',NULL),(40,'Remove all authenticate related codes from oauth repo (not remove session related codes this time)','TODO',1,1,'','',1,'\0',2,NULL,2,'\0',NULL),(41,'Test point for US E2E level','TODO',1,1,'','',1,'\0',2,NULL,2,'\0',NULL),(42,'Feature LSV QS','TODO',1,1,'','',1,'\0',2,NULL,2,'\0',NULL),(43,'Counters: \n- product default impl: local counter in Redis','TODO',1,1,'','',1,'\0',3,NULL,2,'\0',NULL),(44,'Password encryption algorithm\n- product default impl: Hash with salt','ONGOING',1,1,'','',1,'\0',3,4,2,'\0',NULL),(45,'Non-Functional (TBD)','ONGOING',1,1,'','',1,'\0',3,4,2,'\0',NULL),(46,'UX','TODO',1,1,'','',1,'\0',4,9,2,'\0',NULL),(47,'Manual testing','TODO',1,1,'','',1,'\0',4,9,2,'\0',NULL),(48,'Verify oauth basic function ','DONE',1,1,'','',1,'\0',5,3,1,'\0',NULL),(49,'Make existing north responders start successsfully\n  - APP_LA_SMS\n  - APP_LA_MMS','DONE',1,1,'','',1,'\0',6,8,1,'\0',NULL),(50,'Write jmeter scripts for test cases: \n  - provisioning (only SC)\n  - NTT2_LMA_MO_SMS_RB_010\n  - NTT2_LMA_MT_SMS_SB_030\n  - NTT2_LMA_MO_MMM_RB_010\n  - NTT2_LMA_MT_MMM_SA_010','FOLLOWUP',1,1,'1. Add step to auto  check/restart responder \r\n2. Add step to auto config messaging-server\r\n3. Change test case name to not use FT\'s name\r\n4. Add component check-health after install enhanced-messaging\r\n5. Not hardcode the version of enhanced-messaging\r\n6. Use thread group','',1,'\0',6,8,1,'\0',NULL),(51,'ECE6000/ECE1240 env prepare for Local Messaging Verify','DONE',1,1,'','Change to ECE1240',1,'\0',6,8,1,'\0',NULL),(52,'ECE GP12 installation (6160)','DONE',1,1,'','',1,'\0',13,6,1,'\0',NULL),(53,'M2M performance test script prepare \n- separate to single jmx instead of combined one\n- CPT autotest scripts','REVIEW',1,1,'','test script: https://eforge.ericsson.se/svn/repos/ece_lsv/trunk/automated_test/Service_Exposure/testcases/cvc13_ece15',1,'\0',13,6,1,'\0',NULL),(54,'M2M performance test ci environment setup\n- Nagios \n- provisioning pass\n- case single run pass (11 cases)','ONGOING',1,1,'','Continue on sprnt#1',1,'\0',13,6,1,'\0',NULL),(55,'M2M performance test tuning','TODO',1,1,'','Move to sprint#1',1,'\0',13,NULL,1,'\0',NULL),(56,'M2M performance test result report (including SILK)','TODO',1,1,'','Move to sprint#1 ',1,'\0',13,NULL,1,'\0',NULL),(57,'Authenticate','DONE',1,1,'','',1,'\0',7,3,1,'\0',NULL),(58,'Session Management API','DONE',1,1,'','',1,'\0',7,3,1,'\0',NULL),(59,'Sign Out','DONE',1,1,'','',1,'\0',7,3,1,'\0',NULL),(60,'Validate Temp Password','DONE',1,1,'','',1,'\0',7,4,1,'\0',NULL),(61,'Change Password','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(62,'Reset Password','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(63,'Query Security Questions','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(64,'ValidateSecurityAnswer','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(65,'Get Allowed Password Reset Methods','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(66,'LinkIdentity','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(67,'Counters','ONGOING',1,1,'','Continue on sprnt#1',1,'\0',11,3,1,'\0',NULL),(68,'Security','TODO',1,1,'','Move to sprint#1',1,'\0',11,NULL,1,'\0',NULL),(69,'Password Encryption','TODO',1,1,'','Move to sprint#1',1,'\0',11,NULL,1,'\0',NULL),(70,'Authorize','DONE',1,1,'','',1,'\0',10,3,1,'\0',NULL),(71,'Revoke Consent By ID','DONE',1,1,'','No Workload',1,'\0',10,3,1,'\0',NULL),(72,'Query Consents By Owner ID','DONE',1,1,'','No Workload',1,'\0',10,3,1,'\0',NULL),(73,'ci improvement: Install real multiple DPs in CI2 env\n- OAuth BM, OAuth Traffic','REVIEW',1,1,'','',1,'\0',12,4,1,'\0',NULL),(74,'Shit','TODO',0,1,'asdadasd','aassdfasfs',3,'',13,NULL,2,'','1231323');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `team_name` varchar(255) NOT NULL,
  `team_logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'VOICE','');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_story`
--

DROP TABLE IF EXISTS `user_story`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_story` (
  `id` int(11) NOT NULL,
  `_release` int(11) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `description` longtext,
  `team` int(11) NOT NULL,
  `type` longtext,
  `assumptions` longtext,
  PRIMARY KEY (`id`),
  KEY `FKpuqs2ntor5f8nug1v5j5vjcso` (`_release`),
  KEY `FKm15ehmi0xup2rwusaobkbto18` (`team`),
  CONSTRAINT `FKm15ehmi0xup2rwusaobkbto18` FOREIGN KEY (`team`) REFERENCES `team` (`id`),
  CONSTRAINT `FKpuqs2ntor5f8nug1v5j5vjcso` FOREIGN KEY (`_release`) REFERENCES `_release` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_story`
--

LOCK TABLES `user_story` WRITE;
/*!40000 ALTER TABLE `user_story` DISABLE KEYS */;
INSERT INTO `user_story` VALUES (1,1,'#16138','GP12 M2M Performance',1,'UserStory',NULL),(2,1,'#16832','IAM3.0 AA - Authorize',1,'UserStory',NULL),(3,1,'','IAM3.0 QS',1,'UserStory',NULL),(4,NULL,'','e-WhiteBoard',1,'Development',NULL),(5,1,'','JBOSS SDE functional test',1,'UserStory',NULL),(6,1,'','Local Messaging Smoke Test Script',1,'UserStory',NULL),(7,1,'','IAM 3.0 QS (Phase 1) DP-AUTHN-TRAFFIC API',1,'UserStory',NULL),(9,1,'','IAM 3.0 QS (Phase 1) DP-IDENTITY-BM API',1,'UserStory',NULL),(10,1,'','IAM 3.0 QS (Phase 1) DP-AUTH-TRAFFIC API',1,'UserStory',NULL),(11,1,'','IAM 3.0 QS (Phase 1)',1,'UserStory',NULL),(12,NULL,'','Team Improvement',1,'Development',NULL),(13,NULL,'','GP12 M2M Performance',1,'Performance','');
/*!40000 ALTER TABLE `user_story` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `scrumboard`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `scrumboard` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `scrumboard`;

--
-- Table structure for table `_release`
--

DROP TABLE IF EXISTS `_release`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_release` (
  `id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqwn43p5n86ro4wdn6ih1ekaq8` (`team`),
  CONSTRAINT `FKqwn43p5n86ro4wdn6ih1ekaq8` FOREIGN KEY (`team`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_release`
--

LOCK TABLES `_release` WRITE;
/*!40000 ALTER TABLE `_release` DISABLE KEYS */;
INSERT INTO `_release` VALUES (1,1,'ECE 16');
/*!40000 ALTER TABLE `_release` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_oic035rk9hq7fs2iy3wcie01f` (`avatar`),
  KEY `FKfkq83m79uj8r06c6t6wv636md` (`team`),
  CONSTRAINT `FKfkq83m79uj8r06c6t6wv636md` FOREIGN KEY (`team`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (3,1,'Ivvan',NULL),(4,1,'Jenning',NULL),(5,1,'Mary',NULL),(6,1,'Matches',NULL),(7,1,'Nianxiang',NULL),(8,1,'Wenping',NULL),(9,1,'Echo','Echo.png');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sprint`
--

DROP TABLE IF EXISTS `sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sprint` (
  `id` int(11) NOT NULL,
  `_release` int(11) NOT NULL,
  `number` int(11) DEFAULT NULL,
  `start_time` date DEFAULT NULL,
  `duration_week` int(11) DEFAULT NULL,
  `velocity` int(11) DEFAULT NULL,
  `manday` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKibd1v83ommtwmrna0dml9qsp4` (`_release`),
  CONSTRAINT `FKibd1v83ommtwmrna0dml9qsp4` FOREIGN KEY (`_release`) REFERENCES `_release` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sprint`
--

LOCK TABLES `sprint` WRITE;
/*!40000 ALTER TABLE `sprint` DISABLE KEYS */;
INSERT INTO `sprint` VALUES (1,1,0,'2015-12-17',0,0,0),(2,1,1,'2015-12-17',1,1,1);
/*!40000 ALTER TABLE `sprint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `planTime` int(11) DEFAULT NULL,
  `actualTime` int(11) DEFAULT NULL,
  `followUp` varchar(500) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `cpiChange` bit(1) DEFAULT NULL,
  `user_story` int(11) DEFAULT NULL,
  `member` int(11) DEFAULT NULL,
  `sprint` int(11) DEFAULT NULL,
  `backlog` bit(1) NOT NULL,
  `issue` longtext,
  PRIMARY KEY (`id`),
  KEY `FKabkpmb0bgaa8j1x0m6ntgcndp` (`user_story`),
  KEY `FKi1tj6bstnvdjw5995yqb7xhdp` (`member`),
  KEY `FKlfmmmoplx7vi821fhqjkiso0e` (`sprint`),
  CONSTRAINT `FKabkpmb0bgaa8j1x0m6ntgcndp` FOREIGN KEY (`user_story`) REFERENCES `user_story` (`id`),
  CONSTRAINT `FKi1tj6bstnvdjw5995yqb7xhdp` FOREIGN KEY (`member`) REFERENCES `member` (`id`),
  CONSTRAINT `FKlfmmmoplx7vi821fhqjkiso0e` FOREIGN KEY (`sprint`) REFERENCES `sprint` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (3,'M2M performance test tuning','ONGOING',1,1,'','',1,'\0',1,6,2,'\0',NULL),(4,'M2M performance test ci environment setup\n- Nagios \n- provisioning pass\n- case single run pass (11 cases)','DONE',1,1,'','',1,'\0',1,6,2,'\0',NULL),(5,'M2M performance test result report (including SILK)','TODO',1,1,'','',1,'\0',1,NULL,2,'\0',NULL),(6,'DP scrips implement','REVIEW',1,1,'',' - DP-authenticate-Traffic/LBS\n - DP-Identity-Traffic/LBS',1,'\0',2,7,2,'\0',NULL),(7,'Session management restful service - create\n- wrap AuthenticationSessionManager::createSession','REVIEW',1,1,'','',1,'\0',2,3,2,'\0',NULL),(8,'CI2 env setup for new DP','ONGOING',1,1,'',' - add new vip-DP-authenticate-LBS configuration',1,'\0',2,3,2,'\0',NULL),(9,'Session management restful service - update','REVIEW',1,1,'',' - wrap AuthenticationSessionManager::refresh',1,'\0',2,7,2,'\0',NULL),(10,'Session management restful service - query','REVIEW',1,1,'',' - wrap AuthenticationSessionManager::getSession',1,'\0',2,7,2,'\0',NULL),(11,'Session management restful service - validate','REVIEW',1,1,'',' - wrap AuthenticationSessionManager::checkSession',1,'\0',2,7,2,'\0',NULL),(31,'Session management restful service - delete','REVIEW',1,1,'','- wrap AuthenticationSessionManager::removeSession, removeSessionByOwnerId & removeSessionByOwnerIdExceptSessionId',1,'\0',2,7,2,'\0',NULL),(32,'Alarm support for session data access','TODO',1,1,'',' - test manually if alarm in session management is valid or not \n - if not valid, add alarm mechanism in session dao',1,'\0',2,NULL,2,'\0',NULL),(33,'Test point for session management restful service','FOLLOWUP',1,1,'','',1,'\0',2,5,2,'\0',NULL),(34,'Test case for session management restful service','ONGOING',1,1,'','',1,'\0',2,5,2,'\0',NULL),(35,'Modify authorize service to use new session management restful service to replace session manager calling','ONGOING',1,1,'','',1,'\0',2,7,2,'\0',NULL),(36,'Test point/Test case for authorize API','TODO',1,1,'','',1,'\0',2,5,2,'\0',NULL),(37,'Implement authenticate service & manager without:\n - real counter function, real password encrypt, IP configured','ONGOING',1,1,'','',1,'\0',2,8,2,'\0',NULL),(38,'Implement default hash algorithm used for password/securityAnswer\n - Add password encrypt in authenticate','TODO',1,1,'','',1,'\0',2,NULL,2,'\0',NULL),(39,'Test point for authenticate API','REVIEW',1,1,'','',1,'\0',2,5,2,'\0',NULL),(40,'Remove all authenticate related codes from oauth repo (not remove session related codes this time)','TODO',1,1,'','',1,'\0',2,NULL,2,'\0',NULL),(41,'Test point for US E2E level','TODO',1,1,'','',1,'\0',2,NULL,2,'\0',NULL),(42,'Feature LSV QS','TODO',1,1,'','',1,'\0',2,NULL,2,'\0',NULL),(43,'Counters: \n- product default impl: local counter in Redis','TODO',1,1,'','',1,'\0',3,NULL,2,'\0',NULL),(44,'Password encryption algorithm\n- product default impl: Hash with salt','ONGOING',1,1,'','',1,'\0',3,4,2,'\0',NULL),(45,'Non-Functional (TBD)','ONGOING',1,1,'','',1,'\0',3,4,2,'\0',NULL),(46,'UX','TODO',1,1,'','',1,'\0',4,9,2,'\0',NULL),(47,'Manual testing','TODO',1,1,'','',1,'\0',4,9,2,'\0',NULL),(48,'Verify oauth basic function ','DONE',1,1,'','',1,'\0',5,3,1,'\0',NULL),(49,'Make existing north responders start successsfully\n  - APP_LA_SMS\n  - APP_LA_MMS','DONE',1,1,'','',1,'\0',6,8,1,'\0',NULL),(50,'Write jmeter scripts for test cases: \n  - provisioning (only SC)\n  - NTT2_LMA_MO_SMS_RB_010\n  - NTT2_LMA_MT_SMS_SB_030\n  - NTT2_LMA_MO_MMM_RB_010\n  - NTT2_LMA_MT_MMM_SA_010','FOLLOWUP',1,1,'1. Add step to auto  check/restart responder \r\n2. Add step to auto config messaging-server\r\n3. Change test case name to not use FT\'s name\r\n4. Add component check-health after install enhanced-messaging\r\n5. Not hardcode the version of enhanced-messaging\r\n6. Use thread group','',1,'\0',6,8,1,'\0',NULL),(51,'ECE6000/ECE1240 env prepare for Local Messaging Verify','DONE',1,1,'','Change to ECE1240',1,'\0',6,8,1,'\0',NULL),(52,'ECE GP12 installation (6160)','DONE',1,1,'','',1,'\0',13,6,1,'\0',NULL),(53,'M2M performance test script prepare \n- separate to single jmx instead of combined one\n- CPT autotest scripts','REVIEW',1,1,'','test script: https://eforge.ericsson.se/svn/repos/ece_lsv/trunk/automated_test/Service_Exposure/testcases/cvc13_ece15',1,'\0',13,6,1,'\0',NULL),(54,'M2M performance test ci environment setup\n- Nagios \n- provisioning pass\n- case single run pass (11 cases)','ONGOING',1,1,'','Continue on sprnt#1',1,'\0',13,6,1,'\0',NULL),(55,'M2M performance test tuning','TODO',1,1,'','Move to sprint#1',1,'\0',13,NULL,1,'\0',NULL),(56,'M2M performance test result report (including SILK)','TODO',1,1,'','Move to sprint#1 ',1,'\0',13,NULL,1,'\0',NULL),(57,'Authenticate','DONE',1,1,'','',1,'\0',7,3,1,'\0',NULL),(58,'Session Management API','DONE',1,1,'','',1,'\0',7,3,1,'\0',NULL),(59,'Sign Out','DONE',1,1,'','',1,'\0',7,3,1,'\0',NULL),(60,'Validate Temp Password','DONE',1,1,'','',1,'\0',7,4,1,'\0',NULL),(61,'Change Password','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(62,'Reset Password','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(63,'Query Security Questions','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(64,'ValidateSecurityAnswer','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(65,'Get Allowed Password Reset Methods','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(66,'LinkIdentity','DONE',1,1,'','',1,'\0',9,4,1,'\0',NULL),(67,'Counters','ONGOING',1,1,'','Continue on sprnt#1',1,'\0',11,3,1,'\0',NULL),(68,'Security','TODO',1,1,'','Move to sprint#1',1,'\0',11,NULL,1,'\0',NULL),(69,'Password Encryption','TODO',1,1,'','Move to sprint#1',1,'\0',11,NULL,1,'\0',NULL),(70,'Authorize','DONE',1,1,'','',1,'\0',10,3,1,'\0',NULL),(71,'Revoke Consent By ID','DONE',1,1,'','No Workload',1,'\0',10,3,1,'\0',NULL),(72,'Query Consents By Owner ID','DONE',1,1,'','No Workload',1,'\0',10,3,1,'\0',NULL),(73,'ci improvement: Install real multiple DPs in CI2 env\n- OAuth BM, OAuth Traffic','REVIEW',1,1,'','',1,'\0',12,4,1,'\0',NULL),(74,'Shit','TODO',0,1,'asdadasd','aassdfasfs',3,'',13,NULL,2,'','1231323');
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `team_name` varchar(255) NOT NULL,
  `team_logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'VOICE','');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_story`
--

DROP TABLE IF EXISTS `user_story`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_story` (
  `id` int(11) NOT NULL,
  `_release` int(11) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `description` longtext,
  `team` int(11) NOT NULL,
  `type` longtext,
  `assumptions` longtext,
  PRIMARY KEY (`id`),
  KEY `FKpuqs2ntor5f8nug1v5j5vjcso` (`_release`),
  KEY `FKm15ehmi0xup2rwusaobkbto18` (`team`),
  CONSTRAINT `FKm15ehmi0xup2rwusaobkbto18` FOREIGN KEY (`team`) REFERENCES `team` (`id`),
  CONSTRAINT `FKpuqs2ntor5f8nug1v5j5vjcso` FOREIGN KEY (`_release`) REFERENCES `_release` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_story`
--

LOCK TABLES `user_story` WRITE;
/*!40000 ALTER TABLE `user_story` DISABLE KEYS */;
INSERT INTO `user_story` VALUES (1,1,'#16138','GP12 M2M Performance',1,'UserStory',NULL),(2,1,'#16832','IAM3.0 AA - Authorize',1,'UserStory',NULL),(3,1,'','IAM3.0 QS',1,'UserStory',NULL),(4,NULL,'','e-WhiteBoard',1,'Development',NULL),(5,1,'','JBOSS SDE functional test',1,'UserStory',NULL),(6,1,'','Local Messaging Smoke Test Script',1,'UserStory',NULL),(7,1,'','IAM 3.0 QS (Phase 1) DP-AUTHN-TRAFFIC API',1,'UserStory',NULL),(9,1,'','IAM 3.0 QS (Phase 1) DP-IDENTITY-BM API',1,'UserStory',NULL),(10,1,'','IAM 3.0 QS (Phase 1) DP-AUTH-TRAFFIC API',1,'UserStory',NULL),(11,1,'','IAM 3.0 QS (Phase 1)',1,'UserStory',NULL),(12,NULL,'','Team Improvement',1,'Development',NULL),(13,NULL,'','GP12 M2M Performance',1,'Performance','');
/*!40000 ALTER TABLE `user_story` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-21 17:07:39
