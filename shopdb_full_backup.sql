-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: ShopDB
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Products` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (1,'AwersomeProduct1'),(2,'AwersomeProduct2'),(3,'AwersomeProduct3'),(4,'AwersomeProduct4'),(5,'AwersomeProduct5'),(6,'AwersomeProduct6'),(7,'AwersomeProduct7'),(8,'AwersomeProduct8'),(9,'AwersomeProduct9'),(10,'AwersomeProduct10'),(11,'AwersomeProduct11'),(12,'AwersomeProduct12'),(13,'AwersomeProduct13'),(14,'AwersomeProduct14'),(15,'AwersomeProduct15'),(16,'AwersomeProduct16'),(17,'AwersomeProduct17'),(18,'AwersomeProduct18'),(19,'AwersomeProduct19'),(20,'AwersomeProduct20'),(21,'AwersomeProduct21'),(22,'AwersomeProduct22'),(23,'AwersomeProduct23'),(24,'AwersomeProduct24'),(25,'AwersomeProduct25'),(26,'AwersomeProduct26'),(27,'AwersomeProduct27'),(28,'AwersomeProduct28'),(29,'AwersomeProduct29'),(30,'AwersomeProduct30'),(31,'AwersomeProduct31'),(32,'AwersomeProduct32'),(33,'AwersomeProduct33'),(34,'AwersomeProduct34'),(35,'AwersomeProduct35'),(36,'AwersomeProduct36'),(37,'AwersomeProduct37'),(38,'AwersomeProduct38'),(39,'AwersomeProduct39'),(40,'AwersomeProduct40'),(41,'AwersomeProduct41'),(42,'AwersomeProduct42'),(43,'AwersomeProduct43'),(44,'AwersomeProduct44'),(45,'AwersomeProduct45'),(46,'AwersomeProduct46'),(47,'AwersomeProduct47'),(48,'AwersomeProduct48'),(49,'AwersomeProduct49'),(50,'AwersomeProduct50'),(51,'AwersomeProduct51'),(52,'AwersomeProduct52'),(53,'AwersomeProduct53'),(54,'AwersomeProduct54'),(55,'AwersomeProduct55'),(56,'AwersomeProduct56'),(57,'AwersomeProduct57'),(58,'AwersomeProduct58'),(59,'AwersomeProduct59'),(60,'AwersomeProduct60');
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-28  9:55:30
