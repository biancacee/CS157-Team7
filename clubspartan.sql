-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: clubspartan
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `amentities`
--

DROP TABLE IF EXISTS `amentities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amentities` (
  `amentity_id` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`amentity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amentities`
--

LOCK TABLES `amentities` WRITE;
/*!40000 ALTER TABLE `amentities` DISABLE KEYS */;
INSERT INTO `amentities` VALUES (0,'https://d2rzw8waxoxhv2.cloudfront.net/facilities/xlarge/7fb0579ab742b965eefa/1672239213179-758-106.jpg','Theater','Movie night for everyone.'),(1,'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Backyardpool.jpg/1200px-Backyardpool.jpg','Swimming Pool','Swimming pools are equipped with filtration and chlorination systems to maintain water quality.'),(2,'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/WiFi_Logo.svg/640px-WiFi_Logo.svg.png','Wi-Fi Access','Wi-Fi is commonly available in public places such as cafes, hotels, airports, and residential buildings.'),(3,'https://www.hussle.com/blog/wp-content/uploads/2020/12/Gym-structure-1080x675.png','Gym','A fitness center or gym is a facility equipped with exercise machines, weights, and other fitness equipment for physical workouts and exercise routines.'),(4,'https://media.timeout.com/images/105859999/750/422/image.jpg','Pet-Friendly','Accommodations welcome pets, allowing guests to bring their furry companions along for their stay, making travel more accessible for pet owners.'),(5,'https://t3.gstatic.com/licensed-image?q=tbn:ANd9GcQcHbxCjB7FY6Rttw1VZFdh0gIZmm4MLLjfmD0dhA11saxBKG_D49VVkmlvz3sE71-b','Pizza','Wheat-based dough topped with tomatoes, cheese, and often various other ingredients');
/*!40000 ALTER TABLE `amentities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club`
--

DROP TABLE IF EXISTS `club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club` (
  `club_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `discord_link` varchar(255) DEFAULT NULL,
  `instagram_link` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `membership_fee` decimal(10,0) NOT NULL DEFAULT '0',
  `is_active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club`
--

LOCK TABLES `club` WRITE;
/*!40000 ALTER TABLE `club` DISABLE KEYS */;
INSERT INTO `club` VALUES (0,'Computer Science Club','https://i.imgur.com/a6W3vxM.jpeg','sjsucsclub@gmail.com','https://discord.gg/12ajfm31','https://www.instagram.com/sjsucsclub/','Best club ever for anyone who wants to code',5,1),(1,'iRobots','https://www.airport-technology.com/wp-content/uploads/sites/14/2022/01/Ameca_White_BG_03-1038x778.jpg','irobot@sjsu.edu',NULL,NULL,'Build your own robots in our club.',10,1),(2,'Black Business Student Association','https://www.sjsu.edu/cob/pics/BBSA%20LOGO%20200x200.jpg','bbsasjsu@gmail.com',NULL,'https://www.instagram.com/bbsasjsu/','The mission of the Black Business Student Association (BBSA) is to support Black students in their academic, personal, and professional development within the Lucas College of Business.',0,1),(3,'International Student Club','https://www.sjsu.edu/cob/pics/IBA%20new.png','isc.president.sjsu@gmail.com',NULL,'https://www.instagram.com/iscsjsu/','A professional networking organization for students, faculty and alumni from all majors interested in global commerce.',0,1),(4,'Spartan Analytics ','https://www.sjsu.edu/cob/pics/SALogo.png','sjsu.spartananalytics@gmail.com',NULL,'https://www.instagram.com/sjsuspartananalytics/','The goal of Spartan Analytics is to further the knowledge of data analytics, enhance professional career skills, and create networking opportunities for members of San Jose State University.',25,0),(5,'Women in Business','https://www.sjsu.edu/cob/pics/NEW%20WIB%20logo.png','connect.sjsuwib@gmail.com ',NULL,'https://www.instagram.com/sjsuwib/','Women in Business is a pre-professional business organization founded in 2016 with the goal of breaking glass-ceiling boundaries in the business world today.',0,1);
/*!40000 ALTER TABLE `club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `user_id` int NOT NULL,
  `review_id` int NOT NULL,
  `message` text NOT NULL,
  KEY `comment_user_id_fk_idx` (`user_id`),
  KEY `comment_review_id_fk_idx` (`review_id`),
  CONSTRAINT `comment_review_id_fk` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`),
  CONSTRAINT `comment_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (0,3,'I completely agree!'),(3,3,'I couldn\'t agree more'),(2,1,'Maybe it\'s a good club'),(5,2,'Platform to meet like-minded individuals and create lasting friendships'),(0,0,'I disagree'),(4,1,'You\'re spot on');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` int NOT NULL,
  `club_id` int NOT NULL,
  `location` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `club_id_idx` (`club_id`),
  CONSTRAINT `club_event_fk` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,0,'211 S 9th Student Union Building','Orientation','We will show around the campus','2024-10-06','14:00:00','14:45:00'),(2,1,'Student Union, Inc. Spartan Recreation and Aquatic Center','Graduate Studies','Explore part-time, full-time, online, or in-person graduate degrees','2024-10-14','09:30:00','11:30:00'),(3,2,'Washington Square Hall','Presentation','Presentation of our achievements','2024-11-01','10:15:00','10:30:00'),(4,1,'211 S 9th Student Union Building','Research','Our group will work on researching new technologies.','2024-11-03','09:30:00','11:30:00'),(5,3,'1 Washington Sq, San Jose, CA 95192','Graduation','Prepare for the graduation ceremony.','2024-11-05','14:00:00','14:45:00');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_includes`
--

DROP TABLE IF EXISTS `event_includes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_includes` (
  `event_id` int NOT NULL,
  `amentity_id` int NOT NULL,
  KEY `event_includes_id_fk_idx` (`event_id`),
  KEY `amentity_id_fk_idx` (`amentity_id`),
  CONSTRAINT `amentity_id_fk` FOREIGN KEY (`amentity_id`) REFERENCES `amentities` (`amentity_id`),
  CONSTRAINT `event_includes_id_fk` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_includes`
--

LOCK TABLES `event_includes` WRITE;
/*!40000 ALTER TABLE `event_includes` DISABLE KEYS */;
INSERT INTO `event_includes` VALUES (1,0),(1,2),(2,2),(2,1),(2,0),(4,5),(4,3);
/*!40000 ALTER TABLE `event_includes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like`
--

DROP TABLE IF EXISTS `like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like` (
  `user_id` int NOT NULL,
  `review_id` int NOT NULL,
  KEY `like_user_id_fk_idx` (`user_id`),
  KEY `like_review_id_fk_idx` (`review_id`),
  CONSTRAINT `like_review_id_fk` FOREIGN KEY (`review_id`) REFERENCES `review` (`review_id`),
  CONSTRAINT `like_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like`
--

LOCK TABLES `like` WRITE;
/*!40000 ALTER TABLE `like` DISABLE KEYS */;
INSERT INTO `like` VALUES (0,2),(0,5),(4,1),(3,5),(3,2),(1,0),(4,2),(1,0);
/*!40000 ALTER TABLE `like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moderates`
--

DROP TABLE IF EXISTS `moderates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moderates` (
  `user_id` int NOT NULL,
  `club_id` int NOT NULL,
  KEY `user_id_fk_idx` (`user_id`),
  KEY `club_id_fk_idx` (`club_id`),
  CONSTRAINT `club_id_fk` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`),
  CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moderates`
--

LOCK TABLES `moderates` WRITE;
/*!40000 ALTER TABLE `moderates` DISABLE KEYS */;
INSERT INTO `moderates` VALUES (0,0),(1,0),(2,0),(3,1),(4,2),(5,3);
/*!40000 ALTER TABLE `moderates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_message`
--

DROP TABLE IF EXISTS `private_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `private_message` (
  `message_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `message` text NOT NULL,
  `time_stamp` datetime NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `sender_id_idx` (`sender_id`),
  KEY `receiver_id_idx` (`receiver_id`),
  CONSTRAINT `receiver_id_fk` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_message`
--

LOCK TABLES `private_message` WRITE;
/*!40000 ALTER TABLE `private_message` DISABLE KEYS */;
INSERT INTO `private_message` VALUES (0,0,1,'How\'s your day going?','2023-10-01 12:52:12'),(1,1,0,'It\'s been a busy day at work, but I\'m hanging in there. How about you?','2023-10-01 20:52:12'),(2,0,1,'I just finished \"The Martian\" by Andy Weir. It\'s incredible. You should definitely check it out if you haven\'t already.','2023-10-01 20:53:32'),(3,2,0,'Hiking sounds like a fantastic idea! I\'m meeting up with some old friends on Saturday for a barbecue, and on Sunday, I\'ll probably catch up on some Netflix shows.','2023-10-02 12:32:32'),(4,2,0,'If you find any great hiking spots, let me know. We should swap recommendations more often!','2023-10-02 14:34:34'),(5,1,2,'I\'m thinking of going hiking on Saturday.','2023-10-02 14:54:09'),(6,2,1,'That sounds amazing! I\'m actually going to a concert on Saturday night.','2023-10-03 21:33:29');
/*!40000 ALTER TABLE `private_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate`
--

DROP TABLE IF EXISTS `rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate` (
  `user_id` int NOT NULL,
  `club_id` int NOT NULL,
  `rating` int NOT NULL,
  KEY `user_rate_id_fk_idx` (`user_id`),
  KEY `rate_club_id_fk_idx` (`club_id`),
  CONSTRAINT `rate_club_id_fk` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`),
  CONSTRAINT `rate_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate`
--

LOCK TABLES `rate` WRITE;
/*!40000 ALTER TABLE `rate` DISABLE KEYS */;
INSERT INTO `rate` VALUES (0,1,5),(3,2,5),(2,1,4),(1,1,5),(5,4,3),(3,1,1);
/*!40000 ALTER TABLE `rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL,
  `user_id` int NOT NULL,
  `club_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`review_id`),
  KEY `review_user_id_fk_idx` (`user_id`),
  KEY `review_club_id_fk_idx` (`club_id`),
  CONSTRAINT `review_club_id_fk` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`),
  CONSTRAINT `review_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (0,0,1,'Amazing','Joining university clubs has been an incredible experience for me. The diverse range of clubs available at my university has allowed me to explore my interests and connect with like-minded individuals. '),(1,0,3,'Fantastic Hub','They offer leadership opportunities, community service initiatives, and chances to network with peers and professionals. '),(2,3,2,'Unleash Your Potential ','From attending club meetings to participating in events, these experiences have broadened my horizons and given me a well-rounded education beyond the classroom. '),(3,1,0,'Well-Rounded Experience!','This club provides a safe and nurturing environment to explore and experiment.'),(4,2,1,'Finding My Passion','Whether it\'s a themed party organized by a cultural club or a weekend hiking trip with the outdoor enthusiasts, these clubs offer countless opportunities to socialize and have a blast.'),(5,5,5,'The Social Lifeline','hey provide a sense of belonging that makes you feel at home in the sprawling campus community.');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `sjsu_email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `major` varchar(255) NOT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `sjsu_email_UNIQUE` (`sjsu_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'spartak.gevorgyan@sjsu.edu','12345','Spartak Gevorgyan','SE','https://i.imgur.com/C8vkb0Y.jpeg'),(1,'burl.moreno@sjsu.edu','brulM','Burl Moreno','SE',NULL),(2,'ricky.esparza@sjsu.edu','totallae','Ricky Esparza','CS','https://i.imgur.com/EF98MFH.jpeg'),(3,'lucio.gallegos@sjsu.edu','interestingPass','Lucio Gallegos','CS','https://i.imgur.com/SEgUP2K.jpeg'),(4,'omar.cabrera@sjsu.edu','guessPssword1233','Omar Cabrera','SE',NULL),(5,'rudolph.bond@sjsu.edu','7462973A','Rudolph Bond','ART',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-16 13:28:43
