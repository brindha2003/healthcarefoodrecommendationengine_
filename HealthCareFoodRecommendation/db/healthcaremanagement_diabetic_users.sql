-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: healthcaremanagement
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `diabetic_users`
--

DROP TABLE IF EXISTS `diabetic_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diabetic_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `age` int DEFAULT NULL,
  `alcohol_habit` enum('Yes','No') DEFAULT 'No',
  `allergies` varchar(255) DEFAULT NULL,
  `blood_Sugar_Range` varchar(255) DEFAULT NULL,
  `diabetes_type` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `food_Preference` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `height` double DEFAULT NULL,
  `insulin_usage` enum('Yes','No') DEFAULT 'No',
  `job_Profession` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `smoking_habit` enum('Yes','No') DEFAULT 'No',
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diabetic_users`
--

LOCK TABLES `diabetic_users` WRITE;
/*!40000 ALTER TABLE `diabetic_users` DISABLE KEYS */;
INSERT INTO `diabetic_users` VALUES (1,21,'Yes','Dairy','145','Gestational','brindhamurugan010@gmail.com','Veg','Female',154,'Yes','IT','brindha','1200','9789980487','Yes',60),(2,21,'Yes','peanuts','150','Type 2','bhuvi1200@gmail.com','Non-Veg','Female',155,'No','Teacher','Bhuvana','123','6666666666','No',48),(3,26,'Yes','peanuts','150','Gestational','deepi@gmail.com','Non-Veg','Female',160,'No','Teacher','deepi','8888','8888888888','Yes',55),(4,26,'Yes','peanuts','150','Gestational','deepi@gmail.com','Non-Veg','Female',160,'No','Teacher','nirmala','8888','8888888888','Yes',55),(5,26,'Yes','peanuts','150','Gestational','deepi@gmail.com','Non-Veg','Female',160,'No','Teacher','nirmala','8888','8888888888','Yes',55),(6,21,'No','peanuts','145','Type 1','brindhamurugan010@gmail.com','Non-Veg','Female',154,'Yes','IT','brindha','1200','9789980487','No',60),(7,10,'Yes','nuts','128','Type 2','niswan@gmail.com','Veg','Male',148,'Yes','Teacher','Niswan','1200','7878787877','Yes',45),(8,43,'No','Potato','145','Type 2','malar1200@gmail.com','Veg','Female',155,'Yes','Tailor','Malar','1200','9750281143','Yes',75),(9,21,'No','milk','160','Type 2','aarthy@gmail.com','Veg','Female',165,'Yes','IT','aarthy','aarthy_1','6789906789','No',55),(10,21,'Yes','none','130','Other','deepz@gmail.com','Non-Veg','Female',155,'No','IT','deepika','1200','7878789898','Yes',58),(11,38,'Yes','none','210','Type 1','deepz@gmail.com','Veg','Female',152,'No','House Wife','revathisaravanan','1200','8965888888','No',65);
/*!40000 ALTER TABLE `diabetic_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-27 12:03:35
