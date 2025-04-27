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
-- Table structure for table `foods`
--

DROP TABLE IF EXISTS `foods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `allergens` varchar(255) DEFAULT NULL,
  `carbs` double DEFAULT NULL,
  `diabetes_type` varchar(255) NOT NULL,
  `food_type` varchar(255) NOT NULL,
  `glycemic_index` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foods`
--

LOCK TABLES `foods` WRITE;
/*!40000 ALTER TABLE `foods` DISABLE KEYS */;
INSERT INTO `foods` VALUES (1,'None',21.3,'Type 2','Veg',53,'Quinoa'),(2,'None',20.1,'Type 2','Veg',32,'Lentils'),(3,'None',27.4,'Type 2','Veg',28,'Chickpeas'),(4,'None',6,'All','Veg',15,'Broccoli'),(5,'None',3.6,'All','Veg',15,'Spinach'),(6,'Tree Nuts',21.7,'All','Veg',15,'Almonds'),(7,'Fish',0,'All','Non-Veg',0,'Salmon'),(8,'None',0,'All','Non-Veg',0,'Grilled Chicken'),(9,'Eggs',0.6,'All','Non-Veg',0,'Eggs'),(10,'None',23,'Type 2','Veg',68,'Brown Rice'),(11,'Gluten',12,'Type 2','Veg',69,'Whole Wheat Bread'),(12,'None',20.1,'Type 2','Veg',63,'Sweet Potato'),(13,'Soy',2.3,'Type 1','Veg',15,'Tofu'),(14,'Dairy',3.6,'Type 1','Veg',35,'Greek Yogurt'),(15,'Dairy',3.4,'Type 1','Veg',30,'Cottage Cheese'),(16,'None',8.5,'Gestational','Veg',15,'Avocado'),(17,'Tree Nuts',13.7,'Gestational','Veg',15,'Walnuts'),(18,'None',42.1,'Gestational','Veg',30,'Chia Seeds'),(19,'Gluten',75,'Type 2','Veg',55,'Dalia (Broken Wheat)'),(20,'Gluten',30,'Type 2','Veg',45,'Methi Paratha'),(21,'None',15,'Type 2','Veg',40,'Sambar with Less Tamarind'),(22,'Fish',5,'All','Non-Veg',0,'Grilled Fish Curry'),(23,'None',3.7,'Type 2','Veg',18,'Bitter Gourd (Karela)'),(24,'None',5.8,'All','Veg',10,'Cabbage'),(25,'None',5,'All','Veg',15,'Cauliflower'),(26,'None',7,'All','Veg',30,'Green Beans'),(27,'None',3.1,'All','Veg',15,'Zucchini'),(28,'Dairy',1.2,'Type 1','Veg',27,'Paneer (Low-Fat)'),(29,'Soy',8.9,'Type 1','Veg',15,'Edamame'),(30,'Peanuts',16.1,'All','Veg',14,'Peanuts (Unsalted)'),(31,'None',14,'Gestational','Veg',25,'Pumpkin Seeds'),(32,'None',20,'All','Veg',35,'Sunflower Seeds'),(33,'Eggs',0.5,'All','Non-Veg',0,'Boiled Egg White'),(34,'Fish',0,'All','Non-Veg',0,'Mackerel Fish'),(35,'Shellfish',0.2,'All','Non-Veg',0,'Prawns (Grilled)'),(36,'None',0,'All','Non-Veg',0,'Turkey Breast'),(37,'Eggs',1,'All','Non-Veg',0,'Egg Omelette (No Cheese)'),(38,'Gluten',20,'Type 2','Veg',35,'Ragi Dosa'),(39,'None',6.5,'All','Veg',15,'Bottle Gourd Curry'),(40,'Dairy',4,'Type 1','Veg',20,'Cucumber Raita'),(41,'None',7.5,'All','Veg',28,'Mixed Vegetable Soup'),(42,'None',18,'Type 2','Veg',29,'Horse Gram Sundal'),(43,'None',14.3,'Gestational','Veg',31,'Guava'),(44,'None',14,'Type 1','Veg',36,'Apple (Small)'),(45,'None',7.7,'All','Veg',41,'Strawberries'),(46,'None',10,'All','Veg',25,'Blackberries'),(47,'None',14,'Type 2','Veg',35,'Pomegranate Seeds'),(48,'None',0,'Type 1','Non-Veg',0,'Boiled Chicken Breast'),(49,'Eggs',1.1,'Type 1','Non-Veg',0,'Scrambled Eggs (No Butter)'),(50,'Shellfish',0.2,'Gestational','Non-Veg',0,'Grilled Shrimp Skewers'),(51,'Fish',3,'Gestational','Non-Veg',35,'Tuna Salad (Low Fat Mayo)'),(52,'Gluten',32,'Type 2','Veg',55,'Upma with Vegetables'),(53,'None',18.5,'Type 2','Veg',50,'Vegetable Kurma'),(54,'None',12.5,'All','Veg',30,'Kootu (Dal + Veg)'),(55,'None',22,'Type 2','Veg',50,'Thinai Pongal (Foxtail Millet)'),(56,'None',4.5,'All','Veg',15,'Zucchini Noodles'),(57,'None',6,'All','Veg',10,'Cauliflower Rice Bowl'),(58,'Fish',0,'All','Non-Veg',0,'Baked Cod Fish'),(59,'None',1,'Gestational','Non-Veg',0,'Grilled Turkey with Veggies'),(60,'None',20,'Type 2','Veg',28,'Roasted Chana'),(61,'Tree Nuts',10,'All','Veg',20,'Homemade Trail Mix (Seeds/Nuts)'),(62,'None',5,'All','Veg',15,'Baked Kale Chips'),(63,'Dairy',1,'Type 1','Veg',30,'Low-Fat Cheese Cubes'),(64,'Dairy',2,'All','Veg',25,'Buttermilk (No Salt)'),(65,'None',0,'All','Veg',0,'Cinnamon Herbal Tea'),(66,'None',1,'All','Veg',5,'Lemon Cucumber Water'),(67,'Tree Nuts',1,'All','Veg',25,'Unsweetened Almond Milk'),(68,'Dairy',5.5,'Type 1','Veg',30,'Palak Paneer (Low Fat)'),(69,'None',22.5,'Type 2','Veg',27,'Rajma Curry (Less Oil)'),(70,'None',7,'All','Veg',25,'Bhindi Fry (Air Fried)'),(71,'None',6.5,'All','Veg',20,'Tinda Masala'),(72,'Eggs',0.6,'All','Non-Veg',0,'Boiled Egg'),(73,'None',3.6,'All','Veg',15,'Spinach'),(74,'None',4,'All','Veg',15,'Asparagus'),(75,'Fish',0,'All','Non-Veg',0,'Salmon'),(76,'None',3.1,'All','Veg',15,'Zucchini'),(77,'None',0,'All','Non-Veg',0,'Turkey Breast'),(78,'Fish',0,'All','Non-Veg',0,'Mackerel'),(79,'None',2,'All','Non-Veg',10,'Chicken Tikka (Grilled)'),(80,'None',8,'All','Veg',59,'Papaya (100g)'),(81,'None',9,'Gestational','Veg',65,'Guava Juice (No Sugar)'),(82,'None',6,'All','Veg',63,'Coconut Water (100ml)'),(83,'Eggs',5,'All','Non-Veg',60,'Egg Omelette (With Veg)'),(84,'None',7.6,'All','Veg',76,'Watermelon (100g)'),(85,'Gluten',9,'Type 2','Veg',82,'Rice Crackers'),(86,'Shellfish',4,'All','Non-Veg',75,'Shrimp Stir Fry'),(87,'None',19,'All','Veg',36,'Apple (Medium)'),(88,'None',21,'All','Veg',28,'Chickpeas (Boiled)'),(89,'Dairy',5,'All','Veg',11,'Greek Yogurt (Plain)'),(90,'Soy',2.3,'Type 1','Veg',15,'Tofu'),(91,'Fish',0,'All','Non-Veg',0,'Tuna (Canned in Water)'),(92,'Eggs',1,'All','Non-Veg',0,'Boiled Duck Egg'),(93,'None',23,'Type 2','Veg',68,'Brown Rice (100g)'),(94,'Gluten',12,'Type 2','Veg',69,'Whole Wheat Bread'),(95,'None',20.1,'All','Veg',63,'Sweet Potato'),(96,'None',18,'Type 2','Non-Veg',65,'Grilled Chicken Salad'),(97,'Gluten',13,'All','Veg',75,'White Bread (1 slice)'),(98,'None',22,'All','Veg',81,'Cornflakes (No Sugar)'),(99,'None',23,'All','Veg',89,'Jasmine Rice'),(100,'Fish',24,'Type 2','Non-Veg',78,'Fried Fish Cutlet'),(101,'None',40,'All','Veg',32,'Lentils (Boiled, 1 cup)'),(102,'None',35,'All','Veg',30,'Black Beans'),(103,'Sesame',27,'All','Veg',25,'Hummus'),(104,'None',32,'All','Non-Veg',50,'Chicken Soup (with Veg)'),(105,'Gluten',30,'Type 2','Veg',62,'Pita Bread (Whole Wheat)'),(106,'None',39,'Type 2','Veg',65,'Millet'),(107,'Gluten',35,'All','Veg',64,'Ragi Dosa'),(108,'None',47,'Type 2','Non-Veg',66,'Chicken Biryani (Brown Rice)'),(109,'None',45,'All','Veg',72,'Basmati Rice (1 cup)'),(110,'None',30,'All','Veg',82,'Boiled Potatoes (150g)'),(111,'None',38,'All','Veg',85,'Tapioca'),(112,'None',40,'All','Non-Veg',80,'Fried Chicken Strips'),(113,'Gluten',55,'Type 2','Veg',50,'Dalia (Broken Wheat)'),(114,'None',60,'All','Veg',45,'Horse Gram Sundal'),(115,'None',52,'All','Veg',54,'Lobia Curry (Black Eyed Peas)'),(116,'Fish, Gluten',58,'All','Non-Veg',55,'Grilled Tuna Sandwich (Whole Wheat)'),(117,'None',58,'Type 2','Veg',67,'Vegetable Pulao'),(118,'Gluten',53,'All','Veg',60,'Upma'),(119,'Eggs, Gluten',62,'All','Non-Veg',65,'Chicken Kathi Roll'),(120,'None',60,'All','Veg',78,'White Rice (1.5 cups)'),(121,'None',65,'All','Veg',90,'Boiled Tapioca (Cassava)'),(122,'Gluten',70,'All','Veg',85,'Glucose Biscuits'),(123,'Soy',75,'All','Non-Veg',90,'Chicken Manchurian with Rice'),(124,'None',8,'Gestational','Veg',15,'Avocado'),(125,'None',14,'Gestational','Veg',25,'Pumpkin Seeds'),(126,'None',20,'Gestational','Veg',30,'Chia Pudding (Unsweetened)'),(127,'Fish',7,'Gestational','Non-Veg',0,'Fish Curry (Grilled, No Coconut)'),(128,'Eggs',4,'Gestational','Non-Veg',5,'Egg Bhurji (Low Oil)'),(129,'Contains: Gluten',15,'Type 2','Veg',38,'Idli'),(130,'Contains: Gluten',18,'Type 2','Veg',55,'Dosa'),(131,'Contains: Gluten',20,'Type 2','Veg',35,'Ragi Dosa'),(132,'Contains: Dairy, Gluten',32,'All','Veg',56,'Ven Pongal'),(133,'Contains: Coconut',28,'All','Veg',60,'Appam with Coconut Milk'),(134,'Contains: None',15,'All','Veg',40,'Sambar (with Vegetables)'),(135,'Contains: None',18,'All','Veg',35,'Kootu (Chana Dal + Veg)'),(136,'Contains: Coconut, Dairy',20,'All','Veg',45,'Avial'),(137,'Contains: None',12,'All','Veg',25,'Cabbage Poriyal'),(138,'Contains: None',10,'All','Veg',45,'Pulikuzhambu (Tamarind Curry)'),(139,'Contains: Fish',6,'All','Non-Veg',0,'Fish Curry (Tamil Style)'),(140,'Contains: None',4,'All','Non-Veg',20,'Chicken Chettinad'),(141,'Contains: None',2,'All','Non-Veg',15,'Mutton Chukka'),(142,'Contains: Fish',3,'All','Non-Veg',0,'Nethili Fry (Anchovy)'),(143,'Contains: Eggs',5,'All','Non-Veg',10,'Egg Kurma'),(144,'Contains: None',20,'Type 2','Veg',28,'Sundal (Chickpea)'),(145,'Contains: Gluten',25,'All','Veg',65,'Kara Sev'),(146,'Contains: Gluten',30,'All','Veg',70,'Murukku'),(147,'Contains: Gluten',22,'All','Veg',65,'Medhu Vada'),(148,'Contains: None',20,'All','Veg',55,'Paruppu Vadai'),(149,'Contains: Gluten, Dairy',45,'All','Veg',75,'Kesari (Rava Kesari)'),(150,'Contains: Dairy',50,'All','Veg',70,'Sakkarai Pongal'),(151,'Contains: Dairy',55,'All','Veg',80,'Mysore Pak'),(152,'Contains: Dairy',48,'All','Veg',82,'Boondi Ladoo'),(153,'Contains: Gluten',52,'All','Veg',85,'Adhirasam'),(154,'Contains: Dairy',4,'Gestational','Veg',15,'Buttermilk (Spiced)'),(155,'Contains: None',5,'All','Veg',20,'Sukku Coffee (Dry Ginger Brew)'),(156,'Contains: Dairy',6,'All','Veg',30,'Filter Coffee (with milk, no sugar)'),(157,'Contains: Coconut',5,'All','Veg',50,'Tender Coconut Water');
/*!40000 ALTER TABLE `foods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-27 12:03:34
