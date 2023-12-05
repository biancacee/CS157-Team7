CREATE DATABASE  IF NOT EXISTS `clubspartan` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `clubspartan`;
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
  `amentity_id` int NOT NULL AUTO_INCREMENT,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`amentity_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amentities`
--

LOCK TABLES `amentities` WRITE;
/*!40000 ALTER TABLE `amentities` DISABLE KEYS */;
INSERT INTO `amentities` VALUES (19,'https://cdn-icons-png.flaticon.com/512/3334/3334344.png','Lecture','A talk given by an expert to share information on a particular topic with an audience'),(20,'https://i5.walmartimages.com/asr/89374058-c341-4ea2-ab15-86de49aa5327.8b8c9042cdca5dfd9833bc0a49b9072f.png','Gaming Console','A dedicated electronic device designed primarily for playing video games'),(21,'https://cdn-icons-png.flaticon.com/512/5087/5087262.png','Free Wi-Fi','Free Wi-Fi for seamless online access anytime, anywhere'),(22,'https://static.wixstatic.com/media/9499fa_b00e056cdd514f07af27dbe9efc59f2d~mv2_d_2500_2500_s_4_2.png/v1/crop/x_629,y_633,w_1267,h_1250/fill/w_608,h_600,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/TFF_FACILITIES2.png','Fitness Center','A state-of-the-art fitness center for a healthier, stronger you'),(23,'https://images.squarespace-cdn.com/content/v1/5a482c48ccc5c58d3a3f6a20/1514850634819-1BMCAIUY2ZORVIQ5CVFD/Pet+Friendly+Logo.png','Pet-Friendly','Enjoy a pet-friendly environment for a delightful stay'),(24,'https://www.bigpoppasmokers.com/media/catalog/product/cache/6216d3e9c74b03bd2b760d79be3d502b/image/2502f4a5/meadow-creek-bbq42-charcoal-grill-chicken-flipper.png','BBQ','Unleash your inner chef at our BBQ area for a flavorful experience'),(25,'https://www.cliocoffee.com/cdn/shop/files/coffee-lovers-cup-mobile_400x.png','Coffee Shop','Our cozy coffee shop awaits with your favorite brews and delightful ambiance'),(26,'https://capstoneadvisers.com/wp-content/uploads/2023/03/SJSU_athletic_logo.png','Alumni Center','A hub for networking and cherished memories'),(27,'https://cdn-icons-png.flaticon.com/512/3377/3377647.png','Sports Equipment','Explore our top-notch sports equipment for peak performance and enjoyment'),(28,'https://cdn-icons-png.flaticon.com/512/2620/2620769.png','Hackathon Support','We provide comprehensive support for your hackathon, fostering creativity and breakthrough solutions'),(29,'https://www.delta.edu/_resources/images/infographics/speaker.png','Guest Speakers','Engage with our distinguished guest speakers for valuable insights'),(30,'https://www.alamo.edu/siteassets/nvc/academics/faculty-student-mentoring/images/nvc-facutlystudentmentoring.png','Mentorship Program','Join our mentorship program to accelerate your personal and professional development'),(31,'https://images.credly.com/images/25078016-d3b2-47c6-a28e-1fa6ac4530d9/image.png','Leadership Training','Elevate your skills with our leadership training for impactful and effective leadership'),(32,'https://divino-pizzeria.com/wp-content/uploads/2021/03/pizzeria-template-header-pizza-img.png','Pizza','Indulge in our delicious pizza, crafted to perfection for a taste sensation');
/*!40000 ALTER TABLE `amentities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `club`
--

DROP TABLE IF EXISTS `club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `club` (
  `club_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `discord_link` varchar(255) DEFAULT NULL,
  `instagram_link` varchar(255) DEFAULT NULL,
  `description` text NOT NULL,
  `membership_fee` decimal(10,0) NOT NULL DEFAULT '0',
  `is_active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club`
--

LOCK TABLES `club` WRITE;
/*!40000 ALTER TABLE `club` DISABLE KEYS */;
INSERT INTO `club` VALUES (1,'Database Wizards','https://www.cati.com/wp-content/uploads/2022/02/solidworks-1589214628010.png','database.wizards@sjsu.edu','https://discord.gg/databasewizards','https://www.instagram.com/databasewizards','The Database Wizards club is a dynamic and collaborative community dedicated to exploring the intricacies of database management and the wizardry of data manipulation.  From mastering SQL queries to discussing cutting-edge advancements in database technologies, the Database Wizards foster an environment that encourages knowledge sharing, problem-solving, and skill development. Whether members are database enthusiasts, aspiring data engineers, or seasoned data wizards, the club provides a supportive space to exchange ideas, engage in hands-on projects, and collectively elevate their expertise in the ever-evolving realm of data management.',0,1),(14,'Quantum Explorers Club','https://quantum.ieee.org/images/files/images/atom-29539_640.png','quantumexplorers@example.com','https://discord.gg/quantumexplorers','https://www.instagram.com/quantumexplorers','Join the Quantum Explorers Club to delve into the fascinating world of quantum physics. We organize engaging discussions, hands-on experiments, and guest lectures from leading experts in the field. Whether you are a seasoned physicist or just curious about the quantum realm, everyone is welcome to unravel the mysteries together!',10,1),(15,'Eco Warriors Alliance','https://www.global-ecoforum.org/wp-content/uploads/2022/02/Logo_BlueEcoForum_verd.png','ecowarriors@example.com','https://discord.gg/ecowarriors','https://www.instagram.com/ecowarriors','The Eco Warriors Alliance is committed to promoting environmental awareness and sustainable practices on campus. Join us for tree planting events, eco-friendly workshops, and community clean-ups. Together, we strive to create a greener and more sustainable university environment for current and future generations.',0,1),(16,'CodeCrafters Society','https://nexwebsites.com/images/blog/web-development-languages.png','codecrafters@example.com','https://discord.gg/codecrafters','https://www.instagram.com/codecrafters','Are you passionate about coding? Join the CodeCrafters Society to collaborate on coding projects, attend hackathons, and share knowledge about the latest programming languages and technologies. Whether you are a beginner or an experienced coder, our diverse community welcomes all levels of expertise.',15,1),(17,'Global Minds Exchange','https://i0.wp.com/sailemagazine.com/wp-content/uploads/2021/02/third-culture-kid_.png','globalminds@example.com','https://discord.gg/globalminds','https://www.instagram.com/globalminds','Join the Global Minds Exchange to connect with students from diverse backgrounds and cultures. We organize cultural events, language exchange sessions, and discussions on global issues. Expand your worldview and make lasting connections with like-minded individuals from around the world.',5,1),(18,'Health and Wellness Club','https://www.cdc.gov/physicalactivity/activepeoplehealthynation/everyone-can-be-involved/images/icon-public-health.png','wellnessclub@example.com','https://discord.gg/wellnessclub','https://www.instagram.com/wellnessclub','The Health and Wellness Club is dedicated to promoting physical and mental well-being on campus. Join us for fitness classes, mindfulness workshops, and discussions on maintaining a healthy lifestyle. Let us create a supportive community that prioritizes the holistic well-being of every member.',20,1),(19,'Space Enthusiasts Society','https://cdn1.iconfinder.com/data/icons/transport-1-12/52/82-512.png','spacesociety@example.com','https://discord.gg/spacesociety','https://www.instagram.com/spacesociety','If you are fascinated by the cosmos and beyond, the Space Enthusiasts Society is the place for you. Explore the wonders of the universe through stargazing events, space-themed lectures, and telescope workshops. Join us on a cosmic journey as we reach for the stars together.',10,1),(20,'Artistic Expression Collective','https://www.leroyneiman.com/wp-content/uploads/2019/01/cropped-LRN_Favicon_011419-11.png','artisticexpress@example.com','https://discord.gg/artisticexpress','https://www.instagram.com/artisticexpress','Unleash your creativity with the Artistic Expression Collective. Whether you are a painter, poet, musician, or simply appreciate the arts, our club provides a space for self-expression and collaboration. Join us for art exhibitions, open mic nights, and workshops that celebrate the diversity of artistic talents on campus.',5,1),(21,'Robotics Innovators Club','https://cdn2.iconfinder.com/data/icons/robotics-butterscotch-vol-2/512/Robot_Head-512.png','roboticsinnovators@example.com','https://discord.gg/roboticsinnovators','https://www.instagram.com/roboticsinnovators','Dive into the world of robotics and automation with the Robotics Innovators Club. From building and programming robots to participating in national competitions, our club offers hands-on experience and a chance to explore cutting-edge technologies. Join us and be part of the future of robotics.',20,1),(22,'Business Leaders Forum','https://images.squarespace-cdn.com/content/v1/5c6e2dad94d71a1ea569fca0/1632212931273-BXY3KBGVOQSQXPMZBUDA/Business+Development+Manager+blog.png','businessleaders@example.com','https://discord.gg/businessleaders','https://www.instagram.com/businessleaders','The Business Leaders Forum is a hub for aspiring entrepreneurs and business enthusiasts. Join us for networking events, guest lectures from successful business leaders, and workshops on entrepreneurship and innovation. Connect with like-minded individuals and gain insights into the dynamic world of business.',15,1),(23,'Film and Media Society','https://dejpknyizje2n.cloudfront.net/svgcustom/clipart/preview/director-movie-film-actor-actress-camera-3038-14315-550x550.png','filmandmedia@example.com','https://discord.gg/filmandmedia','https://www.instagram.com/filmandmedia','Lights, camera, action! Join the Film and Media Society to explore the world of filmmaking, screenwriting, and media production. Whether you are a film buff or aspire to work in the industry, our club provides a platform for creative expression and collaboration on various multimedia projects.',10,1),(24,'Culinary Arts Club','https://theinspirationacademy.org/wp-content/uploads/2022/06/Culinary-Arts-Module-Logo-768x768.png','culinaryarts@example.com','https://discord.gg/culinaryarts','https://www.instagram.com/culinaryarts','Savor the flavors with the Culinary Arts Club. Join us for cooking classes, food tastings, and culinary adventures. Whether you are a seasoned chef or a kitchen novice, our club welcomes everyone who shares a passion for good food and wants to explore the world of gastronomy.',25,1),(25,'Literature Lovers Society','https://png.pngtree.com/png-vector/20230318/ourmid/pngtree-book-clipart-vector-png-image_6653535.png','litlovers@example.com','https://discord.gg/litlovers','https://www.instagram.com/litlovers','Immerse yourself in the world of words with the Literature Lovers Society. From book discussions and poetry readings to creative writing workshops, our club is a haven for those who appreciate the power of storytelling. Join us to celebrate literature and share your love for the written word.',5,0),(26,'Psychology Explorers Society','https://images.squarespace-cdn.com/content/v1/5ea336f30099752dcabe3772/1587756896636-7IVB58QVL2CILJWBE2J7/PAC_School+of+Professional+Psychology_Brain+art.png','psychexplorers@example.com','https://discord.gg/psychexplorers','https://www.instagram.com/psychexplorers','Delve into the mysteries of the human mind with the Psychology Explorers Society. Join us for insightful discussions, guest lectures, and psychology experiments. Whether you are a psychology major or just curious about the mind, our club provides a platform for exploration and understanding.',5,0),(27,'Astronomy and Astrobiology Club','https://cdn-icons-png.flaticon.com/512/3429/3429250.png','astroclub@example.com','https://discord.gg/astroclub','https://www.instagram.com/astroclub','Embark on a cosmic journey with the Astronomy and Astrobiology Club. Join us for stargazing events, discussions on extraterrestrial life, and space exploration activities. Whether you are an aspiring astronomer or simply awed by the universe, our club is your gateway to the mysteries of the cosmos.',10,1),(28,'Environmental Science Club','https://healthycommunitiesathome.ca/wp-content/uploads/2021/10/icon-natural.png','enviroscience@example.com','https://discord.gg/enviroscience','https://www.instagram.com/enviroscience','Join the Environmental Science Club to explore and discuss the latest developments in environmental research and conservation efforts. We organize field trips, guest lectures, and hands-on projects that contribute to a better understanding of our planet. Whether you are majoring in environmental science or simply passionate about sustainability, our club welcomes you to be a part of positive change.',10,1);
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
INSERT INTO `comment` VALUES (23,60,'Totally agree! I learned so much in Database Wizards. It is a cool place to grow your skills.'),(24,60,'The club helped me a lot too. Nice to see others benefiting!'),(25,60,'I thought databases were boring, but Database Wizards changed my mind. Learning can be fun'),(26,60,'The club helped me with my college project. Big thanks to everyone'),(27,61,'Yeah, Mike Wu is awesome! Super friendly vibes in the club.'),(28,61,'I felt a bit shy at first, but the community made me feel right at home.'),(29,62,'Hands-on projects are the best way to learn.'),(30,62,'I used to struggle with theory, but the projects here made it click.'),(31,62,'The projects feel like puzzles. Solving them is so satisfying'),(32,63,'Same here! Love the journey from novice to wizard-in-training. It is motivating!'),(33,65,'Shoutout to Mike Wu! Always patient with our questions'),(34,66,'The events keep things interesting'),(35,66,'The journey feels like a game. Each step forward is a win'),(36,66,'The club helped me with my college project. Big thanks to everyone who shared tips');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `club_id` int NOT NULL,
  `location` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `start_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `club_id_idx` (`club_id`),
  CONSTRAINT `club_event_fk` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (25,1,'MacQuarrie Hall 225','Final','Be prepared to showcase your mastery of database principles and skills in the final assessment, demonstrating a comprehensive understanding of design, implementation, and effective database management.','2023-12-08','14:45:00','16:10:00'),(26,1,'MacQuarrie Hall 225','Project Presentation','Final Project Presentation & Demo (5, 13, 9, 7, 1)','2023-12-05','16:30:00','18:00:00'),(27,1,'Online','Final Report Due','Please submit your final project report.','2023-12-08','11:59:00','23:59:00'),(28,1,'Online (via Discord)','SQL Basics Workshop','Join us for a beginner-friendly workshop on SQL basics. Learn the fundamentals of database querying and get hands-on experience with real-world examples.','2023-12-15','16:00:00','18:00:00'),(29,1,'Engineering Building, Room 210','Database Design Seminar','Dive into the principles of effective database design. Explore entity-relationship models and normalization techniques. Ideal for those looking to enhance their data modeling skills.','2024-01-10','14:30:00','16:30:00'),(30,1,'Student Union, Meeting Room C','Data Analytics Panel Discussion','Engage with industry experts in a panel discussion on the role of data analytics in today\'s business landscape. Gain insights into the skills and tools needed for successful data analysis.','2024-02-05','17:00:00','19:00:00'),(31,1,'Student Union Ballroom','Hackathon: Database Edition','Form teams and participate in a hands-on hackathon focused on database challenges. Solve real-world problems and showcase your database wizardry.','2024-03-20','10:00:00','16:00:00'),(32,1,'Online (via Discord)','NoSQL Database Workshop','Explore the world of NoSQL databases. Learn about document, key-value, and graph databases. Perfect for those curious about alternative database technologies.','2024-04-08','15:00:00','17:00:00'),(33,1,'BBC 032','Database Internship Panel','Hear from students who have completed database-related internships. Gain insights into the internship application process and the day-to-day tasks of a database intern.','2024-05-15','18:30:00','20:00:00'),(34,1,'Engineering Building, Room 310','Advanced SQL Querying Workshop','Take your SQL skills to the next level with advanced querying techniques. Explore subqueries, joins, and optimization strategies for efficient database operations.','2024-06-05','13:00:00','15:00:00'),(35,1,'Student Union Ballroom','Database Job Fair','Connect with companies seeking database talents. Bring your resumes and network with recruiters looking for skilled individuals in the field of database management.','2024-07-20','11:00:00','14:00:00'),(36,1,'Online (via Discord)','Data Security Workshop','Understand the importance of data security in databases. Learn encryption techniques, access control, and best practices for securing sensitive information.','2024-08-12','16:30:00','18:30:00'),(37,1,'Student Union Terrace','Database Wizards Social Mixer','Join us for a casual social event. Network with fellow database enthusiasts, share experiences, and enjoy some refreshments. Open to all members and those interested in joining the club.','2024-09-07','18:00:00','20:00:00'),(38,1,'Engineering Auditorium','Big Data Symposium','Explore the challenges and opportunities of handling big data. Industry professionals will share insights into big data technologies and their impact on the database landscape.','2024-10-18','15:00:00','17:00:00'),(39,1,'Student Union, Room 312','Database Wizards Showcase','Members showcase their database projects and accomplishments. A great opportunity to see the diversity of skills within the club and get inspired for your own projects.','2024-11-15','19:00:00','21:00:00');
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
INSERT INTO `event_includes` VALUES (28,30),(28,29),(28,21),(29,31),(29,28),(29,26),(30,26),(30,29),(30,31),(31,29),(31,28),(31,30),(33,21),(33,32),(33,31);
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
  PRIMARY KEY (`user_id`,`review_id`),
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
INSERT INTO `like` VALUES (23,60),(24,60),(25,60),(26,60),(27,61),(28,61),(29,61),(30,62),(31,62),(32,35),(32,36),(32,37),(32,38),(32,63),(32,64);
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
  PRIMARY KEY (`club_id`,`user_id`),
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
INSERT INTO `moderates` VALUES (1,1),(23,14),(24,15),(24,18),(25,16),(25,18),(26,17),(27,18),(28,15),(28,19),(29,20),(30,21),(31,22),(32,23),(32,25),(33,24),(34,25),(35,26),(36,27),(37,28);
/*!40000 ALTER TABLE `moderates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_message`
--

DROP TABLE IF EXISTS `private_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `private_message` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `message` text NOT NULL,
  `time_stamp` datetime NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `sender_id_idx` (`sender_id`),
  KEY `receiver_id_idx` (`receiver_id`),
  CONSTRAINT `receiver_id_fk` FOREIGN KEY (`receiver_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `sender_id_fk` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_message`
--

LOCK TABLES `private_message` WRITE;
/*!40000 ALTER TABLE `private_message` DISABLE KEYS */;
INSERT INTO `private_message` VALUES (10,22,23,'Hey, class canceled tomorrow. Lucky break!','2023-09-12 06:23:21'),(11,22,24,'Anyone understand the math homework?','2023-09-13 06:23:21'),(12,22,25,'Party at my place this weekend. Be there','2023-08-12 06:23:21'),(13,25,22,'Can I borrow your notes from yesterday lecture','2023-09-15 06:23:21'),(14,24,22,'Need a study break. Coffee?','2023-04-12 06:23:21'),(15,23,22,'Group project due next week. Let meet up.','2023-09-21 06:23:21'),(16,22,23,'Cant, swamped with exams. Can we Skype?','2023-09-12 06:23:21'),(17,22,24,'Late-night pizza run tonight?','2023-09-13 06:23:21'),(18,22,25,'Count me in. Pepperoni. Be there','2023-08-12 06:23:21'),(19,25,22,'Professor moved the deadline to Friday','2023-09-15 06:23:21'),(20,24,22,'Thank the academic gods. Let celebrate','2023-04-12 06:23:21'),(21,23,22,'Sure, but do not lose it too','2023-09-21 06:23:21'),(22,25,22,'oncert this weekend','2023-09-15 06:23:21'),(23,24,22,'Presentation went well!','2023-04-12 06:23:21'),(24,23,22,'Count me in.','2023-09-21 06:23:21'),(25,22,23,'Hey, class canceled tomorrow. Lucky break!','2023-09-12 06:23:21'),(26,22,24,'Anyone understand the math homework?','2023-09-13 06:23:21'),(27,22,25,'Party at my place this weekend. Be there','2023-08-12 06:23:21'),(28,25,22,'Can I borrow your notes from yesterday lecture','2023-09-15 06:23:21'),(29,24,22,'Need a study break. Coffee?','2023-04-12 06:23:21'),(30,23,22,'Group project due next week. Let meet up.','2023-09-21 06:23:21'),(31,22,23,'Cant, swamped with exams. Can we Skype?','2023-09-12 06:23:21'),(32,22,24,'Late-night pizza run tonight?','2023-09-13 06:23:21'),(33,22,25,'Count me in. Pepperoni. Be there','2023-08-12 06:23:21'),(34,25,22,'Professor moved the deadline to Friday','2023-09-15 06:23:21'),(35,24,22,'Thank the academic gods. Let celebrate','2023-04-12 06:23:21'),(36,23,22,'Sure, but do not lose it too','2023-09-21 06:23:21'),(37,25,22,'oncert this weekend','2023-09-15 06:23:21'),(38,24,22,'Presentation went well!','2023-04-12 06:23:21'),(39,23,22,'Count me in.','2023-09-21 06:23:21'),(40,22,1,'Thank you for the class','2023-12-04 18:22:57');
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
  PRIMARY KEY (`user_id`,`club_id`),
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
INSERT INTO `rate` VALUES (23,1,5),(24,1,5),(25,1,5),(26,1,5),(27,1,5),(28,1,5),(29,1,4),(30,1,5),(31,1,5),(32,1,5),(33,1,4),(34,1,5),(35,1,5),(36,1,5),(37,1,4);
/*!40000 ALTER TABLE `rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `club_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`review_id`),
  KEY `review_user_id_fk_idx` (`user_id`),
  KEY `review_club_id_fk_idx` (`club_id`),
  CONSTRAINT `review_club_id_fk` FOREIGN KEY (`club_id`) REFERENCES `club` (`club_id`),
  CONSTRAINT `review_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (15,23,14,'Quantum Delights','I love this club! The Quantum Explorers Club provides a fantastic platform to delve into the complexities of quantum physics. The discussions are engaging, experiments are hands-on, and the guest lectures truly broaden your understanding of the quantum realm. It is a must-join for physics enthusiasts!'),(16,24,14,'A Quantum Leap in Learning','The Quantum Explorers Club is a really helpful club for anyone looking to deepen their knowledge of quantum physics. The mix of discussions, experiments, and expert talks is well-balanced. The $10 membership fee is a steal for the wealth of knowledge and experiences you gain.'),(17,25,14,'Quantum Mysteries Unraveled','I joined the Quantum Explorers Club out of sheer curiosity, and it has exceeded my expectations. The club caters to both beginners and experts, fostering a welcoming environment for learning. The $10 fee is a small investment for the profound insights you will gain into the quantum world.'),(18,26,14,'Quantum Quandaries','The Quantum Explorers Club falls short on its promise. While the discussions are interesting, the experiments feel rudimentary, and the guest lectures are infrequent. For $10, I expected more in terms of depth and variety. Disappointed with the overall experience.'),(19,27,14,'Quantum Minds Unite','As a seasoned physicist, the Quantum Explorers Club has been a haven for me. The discussions are intellectually stimulating, and the experiments provide hands-on experiences that complement theoretical knowledge. The $10 membership fee is a negligible expense for the value received.'),(20,28,15,'Earth Champions Unite!','I love this club! Eco Warriors Alliance is a beacon of hope for environmental enthusiasts. The commitment to sustainability is inspiring, and the events, from tree planting to clean-ups, make a tangible impact. The fact that it is free to join makes it accessible to everyone.'),(21,29,15,'Environmental Awakening','The Eco Warriors Alliance is a really helpful club for those wanting to make a difference. The club initiatives are commendable, and the absence of a membership fee encourages widespread participation. It is heartening to see a community come together for the betterment of the environment.'),(22,30,15,'Green Dreams Realized',' I joined the Eco Warriors Alliance to contribute to a greener campus, and it is been an enriching experience. The workshops and clean-up events foster a sense of environmental responsibility. The fact that membership is free ensures that anyone can be part of this positive movement.'),(23,31,15,'Eco Letdown','Despite the promising premise, the Eco Warriors Alliance disappoints. The events lack organization, and the club seems more focused on symbolism than making a real impact. It is free to join, but my time could be better spent on more effective environmental initiatives.'),(24,32,15,'Green Revolutionaries','The Eco Warriors Alliance is doing a fantastic job in raising awareness about environmental issues. The free membership ensures that there are no barriers to entry, allowing a diverse group to come together for a common cause. Truly an exemplary club for eco-conscious individuals.'),(25,33,16,'Code Collaboration Haven','I love this club! The CodeCrafters Society is a fantastic space for coders of all levels. The collaborative projects, hackathons, and knowledge-sharing sessions create a dynamic environment for learning. The $15 membership fee is a reasonable investment for the opportunities provided.'),(26,34,16,'CodeCrafting Excellence','The CodeCrafters Society is a really helpful club for aspiring and experienced coders alike. The club focus on collaboration and staying updated on the latest technologies is commendable. The $15 fee is justified for the valuable experiences and networking opportunities it brings.'),(27,35,16,'Coding Community Gem','Joining the CodeCrafters Society has been a rewarding experience. The diverse community, ranging from beginners to seasoned coders, fosters a supportive learning environment. The $15 membership fee is a small price to pay for the knowledge exchange and project collaborations.'),(28,36,16,'CodeCrafters Dilemma','While the CodeCrafters Society claims to be inclusive, it leans heavily towards advanced coding discussions. Beginners might feel overwhelmed, and the $15 fee seems steep for the limited support offered to those still mastering the basics.'),(29,37,16,'CodeCrafters Network','The CodeCrafters Society is an essential club for anyone serious about coding. The $15 membership fee is justified for the networking opportunities, hackathons, and collaborative projects that the club consistently delivers. A great investment for anyone passionate about programming.'),(30,23,17,'Cultural Odyssey','I love this club! Global Minds Exchange is a cultural melting pot, bringing together students from diverse backgrounds. The events, language exchange sessions, and discussions create a truly global experience. The $5 membership fee is a token investment for the broadening of perspectives.'),(31,24,17,'Passport to Friendship','The Global Minds Exchange is a really helpful club for international students and those wanting to broaden their cultural horizons. The club emphasis on inclusivity and understanding different perspectives is commendable. The $5 membership fee is a small price for the friendships and global connections formed.'),(32,25,17,'Global Minds, Local Hearts','Joining the Global Minds Exchange has been a delightful journey. The club events foster a sense of unity among students from different corners of the world. The $5 membership fee is negligible compared to the cultural richness and friendships gained.'),(33,26,17,'Global Missteps Exchange','The Global Minds Exchange falls short on its promise of fostering cultural understanding. The events are poorly organized, and the discussions lack depth. The $5 membership fee feels like an unnecessary expense for the limited value provided'),(34,27,17,'Global Harmony Hub','Global Minds Exchange is a must-join for anyone seeking a global perspective. The events are well-curated, and the discussions are enlightening. The $5 membership fee is a minimal investment for the wealth of experiences and connections made with like-minded individuals worldwide'),(35,28,18,'Wellness Wonderland','I love this club! The Health and Wellness Club goes beyond just fitness; it fosters a holistic approach to well-being. From engaging fitness classes to mindfulness workshops, it a sanctuary for those seeking balance. The $20 membership fee is a worthwhile investment in your health journey.'),(36,29,18,'Mind and Body Oasis','The Health and Wellness Club is a really helpful club for anyone looking to prioritize their mental and physical health. The diverse range of activities, from fitness classes to discussions on healthy living, ensures there is something for everyone. The $20 membership fee is justified for the comprehensive well-being support.'),(37,30,18,'Wellness Warriors Unite','Joining the Health and Wellness Club has been transformative. The community support, combined with diverse activities, has helped me adopt a healthier lifestyle. The $20 membership fee is reasonable for the array of resources and events aimed at promoting well-being'),(38,31,18,'Wellness Club Woes','Despite the promise of holistic well-being, the Health and Wellness Club falls short. The fitness classes lack variety, and the discussions are superficial. The $20 membership fee feels excessive for the limited value provided, especially for those seeking more specialized support'),(39,32,18,'Health Haven Hub','The Health and Wellness Club is an essential for anyone committed to a healthy lifestyle. The $20 membership fee is a small price for the invaluable resources, support, and community that the club provides. A worthwhile investment in your health journey'),(40,33,19,'Stellar Community','I love this club! The Space Enthusiasts Society has created a stellar community of individuals fascinated by the cosmos. The stargazing events, lectures, and workshops make it a thrilling journey into the universe. The $10 membership fee is a nominal cost for the cosmic experiences shared'),(41,34,19,'Journey to the Stars','The Space Enthusiasts Society is a really helpful club for those with a passion for space. The events, especially the telescope workshops, offer hands-on experiences. The $10 membership fee is justified for the unique opportunities to explore the wonders of the universe'),(42,35,19,'Galactic Gatherings','Joining the Space Enthusiasts Society has been an out-of-this-world experience. The club commitment to exploring the cosmos is evident in every event. The $10 membership fee is a small contribution for the vast knowledge and celestial experiences gained'),(43,36,19,'Space Society Stumbles','Despite the promising premise, the Space Enthusiasts Society disappoints. The events lack organization, and the telescope workshops are infrequent. The $10 membership fee feels excessive for the limited opportunities to engage with space enthusiasts'),(44,37,19,'Celestial Connection','The Space Enthusiasts Society is a must-join for anyone fascinated by the cosmos. The stargazing events foster a sense of wonder, and the $10 membership fee is a negligible cost for the celestial experiences and knowledge shared within the community'),(45,23,20,'Creative Haven','I love this club! The Artistic Expression Collective is a haven for creativity. Whether you are a seasoned artist or just starting, the club exhibitions, open mic nights, and workshops celebrate the diversity of artistic talents on campus. The $5 membership fee is a small investment for the artistic inspiration gained.'),(46,24,20,'Artistic Alchemy','The Artistic Expression Collective is a really helpful club for unleashing your creativity. The inclusive environment and varied events cater to artists of all kinds. The $5 membership fee is a token amount for the wealth of inspiration and collaboration opportunities provided.'),(47,25,20,'Creative Vibes Central','Joining the Artistic Expression Collective has been an enriching experience. The club commitment to celebrating various forms of art creates a vibrant and supportive community. The $5 membership fee is a minimal investment for the creative vibes and inspiration it brings'),(48,26,20,'Artistic Disarray','The Artistic Expression Collective falls short on its promise. The events lack cohesion, and the workshops are disorganized. The $5 membership fee feels excessive for the limited value provided, especially for those seeking a more structured artistic community'),(49,27,20,'Palette of Possibilities','The Artistic Expression Collective is an essential club for anyone passionate about the arts. The $5 membership fee is a small price for the diverse range of events and the opportunity to connect with fellow creatives. A must-join for those looking to explore the palette of artistic possibilities'),(50,28,21,'Robo Revolution','I love this club! The Robotics Innovators Club is at the forefront of technological exploration. From building robots to national competitions, the hands-on experience is invaluable. The $20 membership fee is a wise investment for those looking to be part of the future of robotics'),(51,29,21,'Tech Titans Unite','The Robotics Innovators Club is a really helpful club for tech enthusiasts. The club focus on cutting-edge technologies and competitions provides a platform for skill development. The $20 membership fee is justified for the exposure to advanced robotics'),(52,30,21,'Innovation Hub','Joining the Robotics Innovators Club has been a journey into innovation. The club emphasis on hands-on experience and exposure to cutting-edge technologies sets it apart. The $20 membership fee is a reasonable investment for those aspiring to be robotics innovators'),(53,31,22,'Business Brilliance','I love this club! The Business Leaders Forum is a hub for aspiring entrepreneurs. The networking events, guest lectures, and entrepreneurship workshops provide valuable insights. The $15 membership fee is a reasonable investment for those looking to thrive in the dynamic world of business'),(54,32,22,'Entrepreneurial Elevation','The Business Leaders Forum is a really helpful club for business enthusiasts. The club focus on connecting with successful leaders and learning about innovation is commendable. The $15 membership fee is justified for the wealth of knowledge and opportunities it brings'),(55,33,23,'Cinematic Exploration Hub','The Film and Media Society is a must-join for anyone passionate about filmmaking and creative expression. The $10 membership fee is a small price for the collaborative projects and cinematic exploration opportunities. An essential club for those dreaming of making an impact in the film industry'),(56,34,23,'Cinematic Symphony','I love this club! The Film and Media Society provides a platform for creative expression in filmmaking and media production. The collaborative projects and open discussions make it a haven for film enthusiasts. The $10 membership fee is a small price for the cinematic experiences shared'),(57,35,23,'Very Good Club','Despite the promise of creative expression, the Film and Media Society disappoints. The projects lack direction, and the open mic nights are inconsistent. The $10 membership fee feels excessive for the limited opportunities to engage with fellow film enthusiasts'),(58,36,24,'Culinary Catastrophe','Despite the promise of culinary adventures, the Culinary Arts Club disappoints. The cooking classes lack variety, and the culinary adventures are poorly organized. The $25 membership fee feels excessive for the limited value provided, especially for those seeking more specialized culinary experiences'),(59,37,25,'Literary Wonderland','I love this club! The Literature Lovers Society is a haven for those who appreciate the power of storytelling. From book discussions to creative writing workshops, it a celebration of the written word. The $5 membership fee is a small investment for the literary wonders shared'),(60,1,1,'Great Learning Experience!','Database Wizards is an excellent club for anyone looking to enhance their database skills. The community is friendly, and the discussions range from beginner-friendly topics to advanced database technologies. It is a fantastic place to learn and grow'),(61,1,1,'Friendly Community for Database Enthusiasts','The Database Wizards club is like a welcoming haven for database enthusiasts. The moderators, especially Mike Wu, create a positive environment where everyone feels comfortable asking questions. It is a great place to connect with fellow data lovers!'),(62,1,1,'Hands-On Learning at its Best','Joining Database Wizards was a game-changer for me! The club emphasis on hands-on projects helped me apply theoretical knowledge to practical scenarios. I have gained a deeper understanding of database management, thanks to the engaging projects and discussions.'),(63,1,1,'From Novice to Wizard','As a newbie to databases, joining Database Wizards was a wise decision. The discussions cater to all skill levels, and I have seen myself evolve from a novice to feeling like a database wizard-in-training. The supportive atmosphere makes the learning journey enjoyable!'),(64,1,1,'Informative and Accessible','Database Wizards strikes the right balance between being informative and accessible. The club covers a wide range of topics without overwhelming beginners. It is the perfect place for those looking to explore the world of databases without feeling lost.'),(65,1,1,'Knowledgeable Moderators','Mike Wu and the other moderators at Database Wizards are knowledgeable and approachable. They provide guidance and answer questions with patience. The club owes much of its success to the friendly and supportive atmosphere cultivated by its dedicated moderators.'),(66,1,1,'Fun and Educational Events','I love the variety of events organized by Database Wizards. From fun challenges to educational webinars, there is always something exciting happening. It keeps the learning experience fresh and enjoyable. Highly recommended for anyone interested in databases!');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `sjsu_email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `major` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `sjsu_email_UNIQUE` (`sjsu_email`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'mike.wu@sjsu.edu','123456','Mike Wu','CS'),(22,'spartak.gevorgyan@sjsu.edu','123456','Spartak Gevorgyan','SE'),(23,'emily.johnson@sjsu.edu','EJPass123','Emily Johnson','SE'),(24,'daniel.smith@sjsu.edu','DS1234Pass','Daniel Smith','CS'),(25,'sarah.lee@sjsu.edu','SLee5678','Sarah Lee','EE'),(26,'alex.rodriguez@sjsu.edu','ARPassWord!','Alex Rodriguez','DS'),(27,'jessica.taylor@sjsu.edu','JT9876!','Jessica Taylor','CE'),(28,'brandon.chen@sjsu.edu','BChen456','Brandon Chen','ME'),(29,'olivia.kim@sjsu.edu','OKimPass','Olivia Kim','IT'),(30,'justin.wu@sjsu.edu','Jwu7890!','Justin Wu','CS'),(31,'megan.patel@sjsu.edu','MPatel@2023','Megan Patel','SE'),(32,'ryan.chang@sjsu.edu','RChangPass','Ryan Chang','CS'),(33,'lauren.miller@sjsu.edu','LM12345!','Lauren Miller','IS'),(34,'kevin.liu@sjsu.edu','KevinLiuPass','Kevin Liu','CE'),(35,'allison.wong@sjsu.edu','AW5678@','Allison Wong','SE'),(36,'chris.davis@sjsu.edu','CDavisPass!','Chris Davis','CS'),(37,'maya.patel@sjsu.edu','MayaP!234','Maya Patel','DS');
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

-- Dump completed on 2023-12-04 18:26:36
