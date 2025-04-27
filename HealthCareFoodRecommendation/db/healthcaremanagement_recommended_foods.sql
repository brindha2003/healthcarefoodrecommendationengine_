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
-- Table structure for table `recommended_foods`
--

DROP TABLE IF EXISTS `recommended_foods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommended_foods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(100) NOT NULL,
  `food_type` enum('Veg','Non-Veg','All Types','Pescatarian','Vegan') NOT NULL,
  `meal_type` enum('All Meals','Breakfast','Lunch','Dinner') NOT NULL,
  `glycemic_index` int DEFAULT NULL,
  `carbs` decimal(5,2) DEFAULT NULL,
  `contains_gluten` tinyint(1) DEFAULT '0',
  `contains_nuts` tinyint(1) DEFAULT '0',
  `contains_dairy` tinyint(1) DEFAULT '0',
  `contains_eggs` tinyint(1) DEFAULT '0',
  `contains_soy` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `recommended_foods_chk_1` CHECK ((`glycemic_index` between 0 and 200)),
  CONSTRAINT `recommended_foods_chk_2` CHECK ((`carbs` between 0 and 200))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommended_foods`
--

LOCK TABLES `recommended_foods` WRITE;
/*!40000 ALTER TABLE `recommended_foods` DISABLE KEYS */;
INSERT INTO `recommended_foods` VALUES (1,'Ragi Dosa','Veg','Breakfast',35,20.00,1,0,0,0,0,'2025-04-21 10:47:44'),(2,'Grilled Chicken','Non-Veg','Lunch',0,0.00,0,0,0,0,0,'2025-04-21 10:47:44'),(3,'Tofu Stir Fry','Vegan','Dinner',15,8.00,0,0,0,0,1,'2025-04-21 10:47:44'),(4,'Apple Slices','Veg','All Meals',36,14.00,0,0,0,0,0,'2025-04-21 10:47:44');
/*!40000 ALTER TABLE `recommended_foods` ENABLE KEYS */;
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
