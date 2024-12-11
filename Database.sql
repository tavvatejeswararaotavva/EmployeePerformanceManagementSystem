-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: employeedatalist
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'John Doe'),(2,'Jane Smith'),(3,'Alice Johnson'),(4,'Bob Brown'),(5,'Charlie Davis'),(6,'David Evans'),(7,'Emily White'),(8,'Frank Harris'),(9,'Grace Lee'),(10,'Henry Walker'),(11,'Isla Hall'),(12,'Jack King'),(13,'Kelly Scott'),(14,'Leo Adams'),(15,'Mia Nelson'),(16,'Nathan Carter'),(17,'Olivia Mitchell'),(18,'Peter Perez'),(19,'Quinn Roberts'),(20,'Rachel Clark'),(21,'Sam Turner'),(22,'Tina Gonzalez'),(23,'Ursula Martinez'),(24,'Vince Hernandez'),(25,'Wendy Wright'),(26,'Xander Cooper'),(27,'Yara Rogers'),(28,'Zachary Foster'),(29,'Amy Lewis'),(30,'Brian Hall'),(31,'Catherine Young'),(32,'Daniel Allen'),(33,'Eva King'),(34,'Felix Thompson'),(35,'Gina Perez'),(36,'Hannah Carter'),(37,'Ian Evans'),(38,'Julia Martin'),(39,'Kyle Taylor'),(40,'Lydia Brown'),(41,'Mike Harris'),(42,'Nora Jackson'),(43,'Oscar Lewis'),(44,'Paula Clark'),(45,'Quincy Adams'),(46,'Rita Wright'),(47,'Steve Johnson'),(48,'Tanya King'),(49,'Ulysses Roberts'),(50,'Victoria Scott');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager_review`
--

DROP TABLE IF EXISTS `manager_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `review_text` longtext,
  `rating` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `manager_review_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `manager_review_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_review`
--

LOCK TABLES `manager_review` WRITE;
/*!40000 ALTER TABLE `manager_review` DISABLE KEYS */;
INSERT INTO `manager_review` VALUES (1,1,'The employee has shown leadership skills and exceeded expectations.',5,'2024-12-11 00:16:17');
/*!40000 ALTER TABLE `manager_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `self_review`
--

DROP TABLE IF EXISTS `self_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `self_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_id` bigint NOT NULL,
  `review_text` longtext,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `self_rating` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `self_review_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `self_review_chk_1` CHECK ((`self_rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `self_review`
--

LOCK TABLES `self_review` WRITE;
/*!40000 ALTER TABLE `self_review` DISABLE KEYS */;
INSERT INTO `self_review` VALUES (1,1,'I met my targets for the year and contributed to team projects.','2024-12-11 00:14:29',4);
/*!40000 ALTER TABLE `self_review` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-11 11:41:24
