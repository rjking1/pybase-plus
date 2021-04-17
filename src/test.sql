-- MySQL dump 10.13  Distrib 5.5.62, for Linux (x86_64)
--
-- Host: localhost    Database: art25285_test
-- ------------------------------------------------------
-- Server version	5.5.62-cll

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
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_date` date NOT NULL DEFAULT '0000-00-00',
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'2021-03-08','Mava Exhibition - Heather sitting'),(2,'2021-03-02','Mava Exhibition opens'),(3,'2021-03-10','Mava Exhibition end'),(4,'2021-03-14','Anything Goes opens'),(5,'2021-03-28','Anything Goes closes'),(6,'2021-04-11','Four mediums opens\r\nto 25 April'),(22,'2021-04-25','Four Mediums closes');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `No` int(11) DEFAULT NULL,
  `TITLE` varchar(20) DEFAULT NULL,
  `NAME` varchar(100) NOT NULL,
  `LASTNAME` varchar(100) DEFAULT NULL,
  `ADDRESS` varchar(200) DEFAULT NULL,
  `SUBURB` varchar(100) DEFAULT NULL,
  `STATE` char(3) DEFAULT NULL,
  `POSTCODE` varchar(10) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `Paid` date DEFAULT NULL,
  `financial_to` date DEFAULT NULL,
  `MOBILE` varchar(50) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `JOINED` varchar(20) DEFAULT NULL,
  `EC_Name` varchar(50) DEFAULT NULL,
  `EC_Number` varchar(50) DEFAULT NULL,
  `workshop_class` varchar(60) DEFAULT NULL,
  `COMMENTS` varchar(1000) DEFAULT NULL,
  `News_Email` char(1) DEFAULT NULL,
  `News_Hut` char(1) DEFAULT NULL,
  `News_Post` char(1) DEFAULT NULL,
  `Vol_Duties_1` varchar(10) DEFAULT NULL,
  `Vol_Duties_1_Desc` varchar(60) DEFAULT NULL,
  `Vol_Duties_2` varchar(10) DEFAULT NULL,
  `Vol_Duties_2_Desc` varchar(60) DEFAULT NULL,
  `Vol_Duties_3` varchar(10) DEFAULT NULL,
  `Vol_Duties_3_Desc` varchar(60) DEFAULT NULL,
  `GEX` int(11) DEFAULT NULL,
  `GCW` int(11) DEFAULT NULL,
  `GEA` int(11) DEFAULT NULL,
  `GED` int(11) DEFAULT NULL,
  `GCF` int(11) DEFAULT NULL,
  `MB` int(11) DEFAULT NULL,
  `MC` int(11) DEFAULT NULL,
  `MG` int(11) DEFAULT NULL,
  `MSP` int(11) DEFAULT NULL,
  `KID` int(11) DEFAULT NULL,
  `VDM` int(11) DEFAULT NULL,
  `UN` int(11) DEFAULT NULL,
  `Sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `No` (`No`)
) ENGINE=MyISAM AUTO_INCREMENT=10135 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,1,'President','Shirley','Dougan','169 York Rd','Montrose','VIC','3765',NULL,'2020-01-25','2021-12-31','0409 013 106','','shirley.dougan@bigpond.com','2015','Les Dougan','0448 036 133','Clay (Sat m)',NULL,'Y','','','0','Exec Committee + Admin + workshop','3','Media  [TL]','1C','Catering/Social/Fund',1,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,2,NULL,1),(2,2,'Secretary','Sibylle','Pulsford','16 Margaret Ave','Bayswater ','VIC','3153',NULL,NULL,'2021-12-31','0406 515 297','9762 8192','sibyllep@live.com','p2015',NULL,NULL,'',NULL,'Y','Y','','0','Exec Committee','1C','Catering/Social/Fund','','',1,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2),(3,3,'Treasurer','Janet','Barralet','24 Heath Ave','Ferntree Gully','VIC','3156',NULL,'2020-01-12','2021-12-31','0400 822 899','9758 4103','janetphiloc@gmail.com ','2015','Phillip Gregory','0407 804 304','',NULL,'Y','','','0','Exec Committee + Admin','1A','Exhib Admin','2D','Supplies/Purch',1,NULL,2,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,3),(4,4,'Vice President','Marian','Lowe','10B Royalden Close','Boronia ','VIC','3155',NULL,'2020-01-09','2021-12-31','0404 294 687','9762 9429','marian.lowe@outlook.com','p2015','Rani Lutwyche','0431 260 126','',NULL,'Y','','','0','Exec Committee + M\'ship + Admin','2D','Supplies/Purch','1C','Catering/Social/Fund',1,NULL,NULL,NULL,3,NULL,NULL,NULL,2,NULL,NULL,NULL,4),(5,5,'Committee','Ron','Ashworth','14 Jellicoe Ave','Monbulk','VIC','3793',NULL,NULL,'2021-12-31','0407 531 513',NULL,NULL,'p2015','Not given','Not given',NULL,'prev email ashworth_ron@yahoo.com.au',NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,NULL,5),(7,7,'Committee','John','Dunne','251 Mt Dandenong Tourist Rd','Ferny Creek','VIC','3786',NULL,'2020-01-01','2021-12-31',NULL,'9755 1028 ','barocco3@bigpond.com ','p2015','Not given','Not given','Mixed (Thur + Mon)',NULL,'Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7),(8,8,'Committee','Glenda','Guy','4 Jeanette St','Bayswater ','VIC','3153',NULL,NULL,'2021-12-31','0437 571 140','9729 7952','glendaguy@y7mail.com ','p2015','Terry Guy','9729 7952','Life Drawing (Tue)',NULL,'Y','','','1','Committee + workshop','','','','',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,8),(9,9,'Committee','Kaye','Webb','15 Phillip Rd','Knoxfield ','VIC','3180',NULL,'2020-01-12','2021-12-31','0409 128 746',NULL,'kayerwebb@outlook.com','p2015','Not given','Not given','Print (Mon m)',NULL,'Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,9),(67,67,'Committee','Heather','King','2 Dorset St','Glen Waverly','VIC','3150',NULL,'2020-02-20','2021-12-31','0413 556 179','','heather@artspace7.com.au','2020','Richard','0413 398 510','','','Y','','','1A','Exhibition admin','1C','Catering/Social/funds','2C','Gardening',NULL,NULL,1,NULL,2,NULL,NULL,3,NULL,NULL,NULL,NULL,12),(27,27,'Committee','Sharon','Harrison','3 Birdwood Ave','Ferntree Gully','VIC','3156',NULL,'2020-01-14','2021-12-31','0438 204 090',NULL,'sharon@harrisons.id.au','2016','Shirley Harris','0407 119 294 or 9758 6224',NULL,NULL,'Y',NULL,NULL,'3','Various duties','2C','Gardening',NULL,'Assist Kids if available',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,3,1,NULL,11),(41,41,'Committee','Olga','Megele','25 Renown St','Ferntree Gully','VIC','3156',NULL,'2020-01-30','2021-12-31','0433 558 080','9758 7309','olmeg@msn.com','p2015','Max Megele','0435 308 420','',NULL,'Y','','','3','Various duties','1C','Catering/Social/Fund','','',NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,1,NULL,10),(12,12,'Committee','Dorothy','Davies','P.O. Box 8186','Ferntree Gully','VIC','3156','Life',NULL,'2099-12-31',NULL,'8756 4286','dotfern@hotkey.net.au','p2015','Not given','Not given','Creative (Sat m)',NULL,'Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,13),(31,31,NULL,'Linda','Allen','16 Haygarth Court','Wantirna South','VIC','3152',NULL,NULL,'2021-12-31','0423 781 763','','haygarth@tpg.com.au','2019','Peter','0416 075 588','','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(66,66,NULL,'Robin Leslie','Archdall','17 Clevedon Rd','The Basin','VIC','3154',NULL,'2020-02-20','2021-12-31','0417 144 405','','archdall@live.com','2020','Ann Archdall','Not supplied','','','Y','','','3','Various duties','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,99),(11,11,NULL,'Sharon','Baragwanath','8 Kallara Cres','Narre Warren','VIC','3805',NULL,NULL,'2021-12-11','0497 670 949',NULL,'cerulean.sb@gmail.com',NULL,'Not given','Not given',NULL,'NO FORM','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(57,57,NULL,'David','Barnett','8 Milan St','Wantirna','VIC','3152',NULL,'2020-02-11','2021-12-31','0488 399 584','','carovid@bigpond.net.au','2016','Carolyn Barnett','0458 583 574','','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(6,6,'','Gillian','Barralet','Unit 2 / 13 Mason St','Ferntree Gully','VIC','3156',NULL,'2020-01-12','2021-12-31','','9758 0192','gbarralet@gmail.com','p2015','Janet Barralet','9758 4103','FF incl portrait (Fri m)','','Y','','','5','Unable to volunteer','1A','Exhib Admin','2D','Supplies/Purch',NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,1,99),(45,45,NULL,'Rachel','Bowen','8 Titania Cres','Tremont','VIC','3785',NULL,'2020-01-28','2021-12-31','0413 277 199',NULL,'messmate@aapt.net.au','2020','Not given','Not given',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(32,32,NULL,'Anne','Boyd','3 Bambury Place','Ferntree Gully','VIC','3156',NULL,'2020-01-08','2021-12-31','0418 272 745','9758 8278','anneboyd@westnet.com.au','2015','Elinor Boyd','Not supplied','FTG News promotion','','Y','','','5','Unable to volunteer','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,99),(15,15,NULL,'Teresa','Canon','31 Kia Ora Parade','Ferntree Gully','VIC','3156',NULL,'2020-01-06','2021-12-31','0415 414 820','','tcannon@bigpond.net.au','p2015','Bernard Canon','0400 325 322','Cemetary Tour hosting','','Y','','','1C','Catering/Social/Fund','2B','Cleaning: Interior','2C','Gardening',NULL,NULL,NULL,NULL,1,NULL,2,3,NULL,NULL,NULL,NULL,99),(19,19,NULL,'David','Chaney','Apt 168 / 466 Burwood Hwy','Wantirna South','VIC','3152',NULL,'2020-01-09','2021-12-31','0428 319 084','','daval68@bigpond.com.au','2019','Valerie Chaney','9887 0178','','','y','','','3','Various duties','2A','working bee','2C ','Gardening',NULL,NULL,NULL,NULL,NULL,2,NULL,3,NULL,NULL,1,NULL,99),(58,58,NULL,'Jean','Clay',' Unit 63 / 15 Fulhard Rd','Rowville ','VIC','3178',NULL,'2020-02-11','2021-12-31','','9753 3437','','2015',NULL,NULL,'','','','Y','','1A','Exhibition admin.','','','','',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(29,29,NULL,'Karen','Cooper','34 Bales S','Ferntree Gully','VIC','3156',NULL,'2020-01-25','2021-12-31','0423 280 790','','karencoopeart@gmail.com','p2015',NULL,NULL,'','Works','Y','','','6','Volunteer details not shown','','','','Working bees',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(68,68,NULL,'Anita','Cribb','6/29 Hutton Ave','Ferntree Gully','VIC','3156',NULL,'2020-02-08','2021-12-31','0412 495 564','','anita.jane@me.com','2020','Jordan','0488 981 354','','','Y','','','1A','Exhibition Admin','2B','Cleaning: interior','2C','Gardening',NULL,NULL,1,NULL,NULL,NULL,2,3,NULL,NULL,NULL,NULL,99),(56,56,NULL,'Kaitlyn','Davis','10 Rosewood Place','Chirnside Park','VIC','3116',NULL,'2020-02-09','2021-12-31','0425 791 190','','kaitlyn92davis@gmail.com','2019','Mitchell Adams','0447 560 598','','','Y','','','1C','Catering/social/funds','2B','cleaning interior','2C','gardening',NULL,NULL,NULL,NULL,1,NULL,2,3,NULL,NULL,NULL,NULL,99),(50,50,NULL,'Robin','Dawson','49B Ford St','Ringwood','VIC','3134',NULL,'2020-02-01','2021-12-31','0417 833 403','','bdawson@bigpond.net.au','p2015','Tiffany Borg','0403 057 181','','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(33,33,NULL,'Robert','Diss','165 Murrindal Drive','Rowville ','VIC','3178',NULL,NULL,'2021-12-31',NULL,'9752 7507','robertdiss@yahoo.com.au','2015','wife','9752 7507',NULL,'#?','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(30,30,NULL,'Ann Maree','Dunn','1/56 Elsie St','Boronia','VIC','3155',NULL,'2020-01-13','2021-12-31','0407 852 958','','dunnannmaree@gmail.com','2020','Helen Dunn','0418 531 186','','','Y','','','1A','Exhibition admin','1C','Catering','1B','Exhibs/Demos/Hire',NULL,NULL,1,3,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(46,46,NULL,'Geoff','Eady','125 Underwood Rd','Ferntree Gully','VIC','3156',NULL,'2020-01-28','2021-12-31','0448 505 416','9758 2170','meg.eady125@gmail.com','p2015','Margaret','9758 2170',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(47,47,NULL,'Margaret','Eady','125 Underwood Rd','Ferntree Gully','VIC','3156',NULL,'2020-01-28','2021-12-31','0448 505 416','9758 2170','meg.eady125@gmail.com','p2015','Geoff','9758 2170',NULL,NULL,'Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(28,28,NULL,'Josephine','Fitzgerald','137 Terrys Hill','Tecoma','VIC','3160',NULL,'2020-01-25','2021-12-31','','9758 1938','dubois-2@hotmail.com','2020','Ian Boys','0437 716 790 or 9758 1938','','','Y','','','1C','Catering/Social/Fund','2B','Cleaning interior','','',NULL,NULL,NULL,NULL,1,NULL,2,NULL,NULL,NULL,NULL,NULL,99),(61,61,NULL,'Marlene','Frances','12A Purser Ave','Ringwood ','VIC','3135',NULL,NULL,'2021-12-31','0421 994 598','','artistmf@bigpond.net.au ','p2015','Jon Leary','0413 878 322','Pastel Class (Wed)','True Colour Creations','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(73,73,NULL,'Julie','Frankeni','2/33 Bambury St','Boronia','VIC','3155','NEW',NULL,'2021-12-31','0407 553 286',NULL,'julie.frankeni@gmail.com','2021','Callum McCluskey','0431 520 476',NULL,NULL,'y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,99),(55,55,NULL,'Annette','Gaertner','2 Marong Court','Boronia','VIC','3155',NULL,'2020-01-30','2021-12-31','0406 012 009','','annieg1810@gmail.com','2019','Nick','0413 243 491','','','Y','','','2C','Gardening','1C','Catering','','',NULL,NULL,NULL,NULL,2,NULL,NULL,1,NULL,NULL,NULL,NULL,99),(63,63,NULL,'Nancy ','Helliwell','129 Albert Ave','Boronia','VIC','3155',NULL,'2020-02-18','2021-12-31','','97624859','nancyhelliwell@icloud.com','2019',NULL,'0419 576 445','','No EC NAME','Y','','','2B','Cleaning','','','','',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,99),(59,59,NULL,'Roberta','Hilt','6 Bonview Road','Ferny Creek','VIC','3786',NULL,'2020-02-11','2021-12-31','','9755 1436','robertahilt@gmail.com','2020',NULL,NULL,'','','','','Y','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(16,16,NULL,'Liesl','Horne','46 Koolamara Boulevard','Ferntree Gully','VIC','3156',NULL,'2020-01-09','2021-12-31','0417 385 520 ','','lieslhorne@bigpond.com','2019',NULL,NULL,'','','Y','','','1C','Catering/Social/Fund','','','','',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(17,17,NULL,'Jasmine','Horne','46 Koolamara Boulevard','Ferntree Gully','VIC','3156',NULL,'2020-01-09','2021-12-31','0417 385 520 ',NULL,'lieslhorne@bigpond.com','2020',NULL,NULL,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(51,51,NULL,'Pauline','Hosking','244 Olinda-Monbulk Rd','Monbulk','VIC','3793',NULL,'2020-02-04','2021-12-31','0425 789 034','9756 7873','hoskingpauline@gmail.com','2015','Penny or Rachel','0427 935 799 or 0410 400 148','Still Life (Tue)','','Y','Y','','2C','Gardening','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,99),(49,49,NULL,'Debra','Howlett','19 Moira St','Ferntree Gully','VIC','3156',NULL,'2020-01-30','2021-12-31','0448 993 865','','debra.howlett@optusnet.com.au','2020','Neil','0408 874 822','','','Y','Y','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(53,53,NULL,'Margaret','Hynds-Ryman','52 Ireland Ave','Wantirna South','VIC','3152',NULL,'2020-01-30','2021-12-31','0403 166 858','','hynds1511@icloud.com','2019','Nicki Reed','0458 198 002','','','','Y','','1A','Exhibition admin','2B ','Cleaning','2C','Gardening',NULL,NULL,1,NULL,NULL,NULL,2,3,NULL,NULL,NULL,NULL,99),(69,69,NULL,'Kelly','Ingram','32 Thomson Rd','Upwey ','VIC','3158',NULL,'2020-02-08','2021-12-31','0410 571 331','','kell.ingram78@gmail.com','2017',NULL,NULL,'','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(22,22,'','Yvonne','Jonas','3 Sassafras Court','Boronia','VIC','3155',NULL,'2020-01-18','2021-12-31','0419 407 025','9762 4070','yvonnejonas@westnet.com.au','p2015','Julianne Jonas','0409 936 926','','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(64,64,NULL,'Joanna','Kulik','433 Dandelion Drive','Rowville ','VIC','3178',NULL,'2020-02-18','2021-12-31','','9755 5214','greenleo45@hotmail.com','2015','Chris','0477 586 907','','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(65,65,NULL,'Lidia','Kulik','433 Dandelion Drive','Rowville ','VIC','3178',NULL,'2020-02-18','2021-12-31',NULL,'9755 5214','greenleo45@hotmail.com','2015','Chris','0477 586 907',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,2,NULL,NULL,NULL,99),(20,20,NULL,'Christine','Lacreole','35 Lockwoods Rd','Boronia ','VIC','3155',NULL,'2020-01-19','2021-12-31','0422 566 723','9779 0559','clacreole@optusnet.com.au','p2015','Peter Shanahan','0402 037 574','','','y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(14,14,'','Sue','Lawson','2/10 Paton Cres','Boronia','VIC','3155',NULL,'2020-01-06','2021-12-31','0416 610 878','9778 8438','','2020','Sarah Young','0402 612 087','','','','Y','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(40,40,NULL,'Kathleen','Loxton','Unit 1 / 41 St Elmo Ave','Ferntree Gully','VIC','3156',NULL,NULL,'2021-12-31',NULL,'9758 3112','kloxot@gmail.com','p2015',NULL,NULL,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(35,35,NULL,'Rod','Mackie','26 Rothan Ave','Boronia ','VIC','3155','NEW',NULL,'2021-12-31','0401 862 999',NULL,'macrodm@outlook.com','2016',NULL,NULL,NULL,'NO FORM.  #?','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(71,71,NULL,'Mahshid','Malekazari','330 Forest Rd','The Basin','VIC','3154','NEW',NULL,'2021-12-31','0401 759 165',NULL,'mahshid213@yahoo.com','2021','Hoss','0416 730 761',NULL,'CHECK DUTIES','y',NULL,NULL,'4','Kids Art','1','Gardening','2','Exhibition Admin',NULL,NULL,2,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,99),(54,54,'','Tom','McGowan','3/13 Dawson St','U. Ferntree Gully','VIC','3156',NULL,'2020-02-04','2021-12-31','0438 494 490','','tommcgowan1948@gmail.com','2020','','','','previous member','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(70,70,NULL,'Mari','Metcalfe','18 School Rd','Olinda ','VIC','3788',NULL,NULL,'2021-12-31','0417 310 337','9751 2053','marimetcalfe47@yahoo.co.uk','2021','David Foote','0417 310 337','','','y','','','2B','Cleaning','','','','',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,99),(42,42,NULL,'Kathie','Morris','15 Government Rd','The Basin','VIC','3154',NULL,'2020-01-30','2021-12-31','4120730183','','K_bambridge@bigpond.com','2020','Steve Morris','0418 178 425','','','Y','','','3','Various duties','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,99),(52,52,NULL,'Nora','O\'Brien','43 Underwood Rd','Boronia','VIC','3155',NULL,'2020-02-04','2021-12-31','','9778 8847','noratob@gmail.com','2018','Paul Nicholas','0415 565 387','','','Y','Y','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(44,44,NULL,'Judith','O\'Donnell','Unit 5 / 26 Station St','Ferntree Gully','VIC','3156',NULL,'2020-02-01','2021-12-31','0406 594 581','9758 7170','SZOD@bigpond.com','p2015','Patrick O\'Donnell','9758 7170','','','Y','Y','','1A','Exhibition admin','1B','Exhibition/Demos','1C','Catering/Social/Fund',NULL,NULL,1,2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(72,72,NULL,'Amani','Pereira','7 Priscilla Court','Wantirna','VIC','3152','NEW',NULL,'2021-12-31','0407 698 201',NULL,'amanipereira@gmail.com','2021',NULL,NULL,NULL,NULL,'y',NULL,NULL,'1A','Exhibition admin','2C','Gardening','1C','Catering',NULL,NULL,1,NULL,3,NULL,NULL,2,NULL,NULL,NULL,NULL,99),(43,43,NULL,'It Hao','Pheh','6 Thelma Ave','Boronia','VIC','3155',NULL,'2020-02-01','2021-12-31','0426 764 499','','phehithao@gmail.com','2020','Catherine','0468 903 040','W/C class Thur/Fri','','Y','Y','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(23,23,NULL,'Janita','Phelan','55 Kellbourne Drive','Rowville ','VIC','3178',NULL,'2020-01-18','2021-12-31','0402 810 518','','m_j_phelan@bigpond.com','2017','Mark Phelan','0401 810 518','','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(60,60,NULL,'Dulcie','Pletes','11 Moore St','Ferntree Gully','VIC','3156',NULL,'2020-02-13','2021-12-31','0490 003 561','9758 3996','info@sonyapletes.com','2015','Sonya','0490 003 561','','','Y','','Y','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(62,62,NULL,'Stephen','Powell','64 Hume St','Upwey ','VIC','3158',NULL,'2020-02-11','2021-12-31',' 0439 975 422','','stephen@stephenpowell.com.au','','Colin Powell','0417 522 538','','','y','','','2A','Building maintenance','3','Media','2C','Gardening',NULL,NULL,NULL,NULL,NULL,1,NULL,3,NULL,NULL,2,NULL,99),(36,36,NULL,'Janice','Reynolds','17 Price Rd','Kalorama','VIC','3766',NULL,'2020-02-01','2021-12-31','0400 092 143','9728 1551','jreyart@gmail.com','2017','Charlot Cowdery','0498 982 433',NULL,'#?','y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(13,13,NULL,'Peter','Schmutter','4/10-12 Tooronga Rd','Ringwood East','VIC','3135',NULL,'2019-12-29','2021-12-31','0410 517 812','','kezpete@optusnet.com.au','2020','Kerry Waite','0408 907 990','','','y','','','2A','Building maintenance','2B','Cleaning interior','2c','Gardening',NULL,NULL,NULL,NULL,NULL,1,2,3,NULL,NULL,NULL,NULL,99),(24,24,NULL,'Jaqueline','Sleeman','3 Melaleuca Court','Berwick','VIC','3806',NULL,'2020-01-18','2021-12-31','0407 053 873','','jacjacjacqui@hotmail.com','2017','Anthony Ferriere','0400 002 048','','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(26,26,NULL,'Wendy','Steenwinkel','23 Clematis Ave','Ferntree Gully','VIC','3156',NULL,'2020-01-22','2021-12-31','0407 076 922','','steenwc@gmail.com','2020','Harry Oshman','0407 076 922','','','Y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(25,25,NULL,'Margaret','Thomson','460 Sheffield Rd','Montrose','VIC','3765',NULL,'2020-01-18','2021-12-31','0425 729 009','','margthomson@me.com','2020','Carly Thomson','0425 730 132','','','Y','','','4','Kids Art','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,99),(48,48,NULL,'Rebecca','Tregear','3 Birkdale Close','Wantirna','VIC','3152',NULL,'2020-01-28','2021-12-31','0437 001 729',NULL,'rctregear@yahoo.com','2019','Nick Kotsonis','0411 195 540',NULL,NULL,'Y',NULL,NULL,'3','Various duties','1A','Exhibition Admin','2D','Supplies/purchasing',NULL,NULL,2,NULL,NULL,NULL,NULL,NULL,3,NULL,1,NULL,99),(38,38,NULL,'Gerard','Van Buuren','678 Burwood Hwy','Ferntree Gully','VIC','3156',NULL,'2020-02-01','2021-12-31','0410 620 562',NULL,'gerardus@netspace.net.au','2016','Trudy','0410 620 562',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,2,NULL,NULL,NULL,NULL,99),(39,39,NULL,'Trudy','Van Buuren Naus','678 Burwood Hwy','Ferntree Gully','VIC','3156',NULL,'2020-02-01','2021-12-31','0410 620 562','','tnaus@hotmail.com','2017','Gerard','0410 620 562','','','Y','','','2A','Building maintenance','2C','Gardening','1A','Exhibition admin.',NULL,NULL,3,NULL,NULL,1,NULL,2,NULL,NULL,NULL,NULL,99),(21,21,NULL,'Betty','Vella','48 Ropley Grange','Upwey ','VIC','3158',NULL,'2020-01-25','2021-12-31','0438 323 407','','betty.v@iinet.net.au ','p2015',NULL,'0421 335 229','Still Life (Tue)','','y','','','2C','Gardening','2B','Cleaning interior','2A','Building maintenance',NULL,NULL,NULL,NULL,NULL,3,2,1,NULL,NULL,NULL,NULL,99),(18,18,NULL,'Ross','Waghorn','28 Judith Ave','Boronia','VIC','3155',NULL,'2020-01-09','2021-12-31','0448 398 218','9779 0318','ross@rosswaghorn.com','2017','Lyn Wagorn','9762 2438','Artist\'s w/s (Thur)','','y','','','6','Volunteer details not shown','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(74,74,NULL,'Ram','Welti','35 Frances Crescent','Ferntree Gully','VIC','3156','NEW','2021-02-09','2021-12-31','0437198452',NULL,'getgoinggrowing@gmail.com','2021','Kelly','0491149179',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,99),(75,75,NULL,'Barbra','Vernon','36 Avington Crescent','Boronia','VIC','3155','NEW','2021-03-08','2021-12-31','0426922591? or 0426922541?',NULL,'artladyforever@gmail.com','2021','Ian Bartos','0415978857',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(76,76,NULL,'Georgia','Brain','156 Lum Rd','Wheelers Hill','VIC','3150','NEW','2021-03-08','2021-12-31','0418394206',NULL,'petal281@tpg.com.au','2021','Grant Brain','0438303982',NULL,'life model','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(77,77,NULL,'Diane (Ann)','Glenane','2136 Doysal Ave','Ferntree Gully','VIC','3156','NEW','2021-02-11',NULL,'0410633495',NULL,'dianeglenane@gmail.com','2021','Ahmet','0407 966 838',NULL,'working with children check to 19/11/24','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,1,2,NULL,99),(78,78,'','Marjorie','Reaburn','Glengollan Village 3A Hutton Ave','Ferntree Gully','VIC','3156',NULL,'2021-03-09',NULL,'','97564231','margreaburn@outlook.com','2021','janet Deogood','0432142117','','','Y','Y','','5','unable to volunteer','','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,99),(79,79,NULL,'Wendy','Lawerence','123 Oambridge Rd','Mooroolbark','VIC','3138','NEW','2021-03-07','2021-12-31','0428412963',NULL,'wlawrence7@bigpond.com','2021','Darrell','0429997012',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,1,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,99),(80,80,NULL,'James','McLean','1A Hope Avenue','Montrose','VIC','3765','NEW','2021-03-06','2021-12-31','0409 850 279',NULL,'jamesmclean-art@hotmail.com','2021','Jeannette Ottley','0415 037 616 or 9728 6714',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(10125,84,NULL,'Priyanka','Kaur','6 Hilton Grove','Belgrave','VIC','3160','NEW',NULL,NULL,'0426 512 569',NULL,'Info@artbypriyanka.com.au','2021-03-24','Daizy','0490 125 541',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,NULL,NULL,NULL,NULL,4,NULL,3,NULL,99),(10117,81,NULL,'Kim','Wetzels','52 Landscape Drive','Boronia','VIC','3155','NEW','2021-03-27','2021-12-31','0421 881 136','0421881136','mrswetzels@gmail.com','2021','Maureen Baker','9702 6164',NULL,NULL,'y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(10118,82,NULL,'Jodi','Sinclair','1/30 Hutton Avenue','Ferntree Gully','Vic','3156','New','2021-03-27','2021-12-31','0404 924 718',NULL,'jodi.sinclair1@gmail.com','2021','Imogen Ball','0406 836 849',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(10,10,NULL,'Richard','King','2 Dorset Street','Glen Waverley','VIC','3150','test',NULL,NULL,NULL,NULL,'rjking58@gmail.com','2021','Heather','0413556179',NULL,'only here for testing','Y','Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,99),(10127,37,NULL,'Fiona','Valentine',NULL,NULL,NULL,NULL,'NEW',NULL,'2021-12-31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Not in spreadsheet.  Has receipt for 2020',NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(34,34,NULL,'Rob','Ewing','12 Helena Ave','Kallista ','VIC','3791',NULL,'2020-01-23','2021-12-31','0417 577 632','9752 6265','kew93300@bigpond.net.au','2015','Kaye','9756 6205',NULL,'paid twice? receipts 29 and 41?','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,3,1,NULL,NULL,NULL,NULL,99),(10119,83,NULL,'Imogen','Ball','1/30 Hutton Ave','Ferntree Gully','VIC','3156',NULL,'2021-03-27','2021-12-31','0406836849',NULL,'Imogen.ball8@gmail.com',NULL,'Jodi Sinclair','0404 924 718',NULL,'Student. Family membership with Jodi Sinclair.','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,99),(10128,85,NULL,'Rhiannon','Matthews','8 Heathcote Drive','Forest Hill','VIC','3131','New','2021-04-11','2021-12-11','0400 064 965',NULL,'this.matthews93@gmail.com','10/04/21','Kiman','0407 536 919',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,3,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,99),(10129,86,NULL,'Elle','Cameron','34 Amesbury Ave','Wantirna','VIC','3152','New','2021-03-25','2021-12-31','0430 375 334',NULL,'e_m_cameron@hotmail.com','25/03/2021','Steven Cameron','0452 385 486',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,3,NULL,NULL,99),(10130,87,NULL,'Peter','Cooper','37 Johnson Drive','Ferntree Gully','VIC','3156','New','2021-04-11','2021-12-31','0490777574',NULL,'petercooper@optusnet.com.au','11/04/2021','Ros Yarwood','9560 3337',NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,3,NULL,2,1,NULL,NULL,NULL,NULL,99);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`art25285`@`localhost`*/ /*!50003 TRIGGER `members_before_insert` BEFORE INSERT ON `members`
 FOR EACH ROW BEGIN
/*
IF NEW.Status is null THEN
    SET NEW.Status = 'NEW';
END IF;
*/
IF NEW.No = 0 or new.No is null THEN
    SET @a = (SELECT max(No) from members);
    SET NEW.No = @a + 1;
END IF;
    
if new.news_email is null
and new.news_hut is null
and new.news_post is null then 
    IF new.email is not null THEN
    	SET new.news_email = 'Y';
    ELSE
    	SET new.news_hut = 'Y';
    end if;
end if;

IF NEW.Sort = 0 or new.Sort is null THEN
    SET NEW.Sort = 99;
END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_read` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (2,'2021-04-13 02:41:10',1,9,'test 2','y'),(4,'2021-04-13 02:47:08',1,9,'test to shirley from richard','1'),(7,'2021-04-13 07:41:26',2,1,'This is the second message I have sent. \nIs this live now?',NULL),(8,'2021-04-13 07:42:11',2,1,'Have you sent Janet her login or am I doing that?',NULL),(9,'2021-04-13 23:24:13',1,2,'I have created the additional accounts. We need to decide on what they can see and do. ',NULL),(10,'2021-04-14 13:01:43',1,2,'Marian password is ml004\nJanet password is jb003\nShirley password is sd001\n\nYou can login as either and check they cannot edit anything and they only have 5 views. Are you happy with that?  Back now takes you back to the Home screen. ',NULL);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `Note` text,
  `Priority` int(11) DEFAULT NULL,
  `done` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (1,'missing numbers','original spreadsheet has missing numbers of 10,11 and 37.   Have assigned myself as 10 and sarah b as 11.  37 assigned to Fiona Valentine (added from receipt book as not in XL s/sheet)',0,0),(2,'Heather. sarah B has no number. assigned 11','check form/receipt book',0,0),(3,'Heather. Emergency contacts','Need to review and complete all',0,0),(4,'Richard. Add permission control ','add, edit, delete. Also delete confirmation',0,1),(5,'Richard.  Rework duties','9 or so columns from 6 existing as per form. Will be refined later',0,1),(6,'Richard. Support field types','number, date, memo, combo, lookup. combo = unique values from same column. lookup=fk/table eg bike_id',0,0),(7,'Richard. Remove IDs','Hide ID column when editing /adding records',1,1),(8,'Richard. Fix default sort ','= 99 if blank not null',0,1),(9,'Richard. Members v events','Member as viewname everywhere is wrong',0,1),(10,'Richard. sql logging','On server',0,1),(11,'Richard. weird bug','updating existing records is failing. appears to be for members table only. got to use post!',0,1),(14,'Richard. fix members insert trigger','null in No and Sort should work. remove not null?',NULL,1),(15,'Add at the top',NULL,NULL,1),(16,'Search in page','Filtering would do this',NULL,NULL),(17,'Sorting','and filtering and paging?',NULL,NULL),(18,'Add receipt no col','might remove and show latest receipt details from view (join of members and receipts)',1234,1),(19,'Hide sub views when adding new','This applies to adding receipts. Must force user to add member first',3,1),(20,'Richard.  Single quotes','Got to handle everywhere but especially in messages',5,1),(21,'Messaging','Open after login. New, reply, forward. Only see your own or All. All is a special user. Id = 0? \nNeed special view. Unread are bolded.  Rich text input?',NULL,NULL),(22,'Nav bar','Got to hide email and query buttons esp from others. Home can be gone back to',9,1),(23,'scrolling','Stop nav bar and table headers scrolling off screen. ',NULL,NULL),(24,'audit trail','this\'ll reduce the need for messaging (but I\'ll keep messaging and notes for me and Heather until we no longer use it)',3,NULL),(26,'double login msg in audit trail','why?',NULL,NULL),(27,'save db to local storage','load and save db name',NULL,NULL),(30,'richard. align databases','rides2 with hut',2,NULL),(31,'richard. bug with audit trail','non-SQL, eg logging in adding two rows (SQL and message).  Check email not doing the same',2,1);
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_actions`
--

DROP TABLE IF EXISTS `py_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_actions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VIEW_ID` int(11) DEFAULT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `ACTION_TYPE` varchar(20) DEFAULT NULL,
  `SCRIPT` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=1025 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_actions`
--

LOCK TABLES `py_actions` WRITE;
/*!40000 ALTER TABLE `py_actions` DISABLE KEYS */;
INSERT INTO `py_actions` VALUES (1000,0,'Badge 2011 printed','exec_sql','update members set last_badge = \'2011\' where id=%d'),(1001,0,'Renewed for 2011','exec_sql','update members set status = \'Fin\', financial_to=\'Dec 2011\' where id=%d'),(1002,8642,'Delete log entries over 1 month old','sql','delete from py_logs where date_time < ADDDATE( NOW() , -31 )'),(1007,0,'Email selected members','email','select email from members where id=%d'),(1005,8642,'Delete selected entries','exec_sql','delete from py_logs where id=%d'),(1008,9153,'Copy selected template','exec_sql','insert into py_templates select null,view_id,concat(name,\'2\'),class,get_sql,control,contents from py_templates where id=%d'),(1009,0,'Print Please Renew Letters','print','Please Renew Letter'),(1010,0,'Print Magazine Labels','print','Magazine Labels'),(1011,0,'Print Badges','print','Badges'),(1013,0,'Print Welcome Letters','print','Welcome Letter'),(1014,0,'Print Proxy Letters','print','Proxy Letter'),(1015,0,'Print Labels','print','Magazine Labels'),(1016,0,'Mark as For','exec_sql','update members set proxy = \'For\' where id=%d'),(1017,0,'Mark as Against','exec_sql','update members set proxy = \'Against\' where id=%d'),(1018,0,'Print Magazine Labels','print','Magazine Labels'),(1020,0,'Print tickets','print','Tickets'),(1021,0,'Print ticket covers','print','Ticket covers'),(1022,0,'Email selected members','email','select email from tickets where id=%d'),(1023,9157,'Mark as paid','exec_sql','update members set paid = now() where id in (%d)'),(1024,9149,'Copy selected view','exec_sql','insert into py_views select null, `NAME`, `FORMDESC`, `fields`, `subviews`, `GET_SQL`, `PUT_SQL`, `INCL_IN_INDEX`, `TO_VIEW`, `COMMENT`, `table_name`, `FILTER_COLUMNS`, `multi_edit_columns`, `HEADER_1`, `HEADER_2`, `work_area`, `image_index from py_views where id=%d');
/*!40000 ALTER TABLE `py_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_assocs`
--

DROP TABLE IF EXISTS `py_assocs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_assocs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(32) NOT NULL DEFAULT '',
  `TABLE_A` varchar(32) DEFAULT NULL,
  `TABLE_B` varchar(32) DEFAULT NULL,
  `CARDINALITY` char(3) DEFAULT NULL,
  `COMMENT` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8603 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_assocs`
--

LOCK TABLES `py_assocs` WRITE;
/*!40000 ALTER TABLE `py_assocs` DISABLE KEYS */;
INSERT INTO `py_assocs` VALUES (8596,'','py_views','py_actions','1-N',''),(8599,'','py_roles','py_users','1-N',''),(8601,'','py_tables','py_columns','1-N',''),(8602,'member_receipts','members','receipts','1-N','');
/*!40000 ALTER TABLE `py_assocs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_columns`
--

DROP TABLE IF EXISTS `py_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_columns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `type` varchar(50) NOT NULL DEFAULT '',
  `size` int(11) DEFAULT NULL,
  `decimals` int(11) DEFAULT NULL,
  `table_id` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_columns`
--

LOCK TABLES `py_columns` WRITE;
/*!40000 ALTER TABLE `py_columns` DISABLE KEYS */;
INSERT INTO `py_columns` VALUES (3,'name','varchar(50)',50,NULL,2,'Name'),(4,'Note','varchar(1000)',1000,NULL,12,NULL),(5,'ADate','date',10,NULL,12,NULL);
/*!40000 ALTER TABLE `py_columns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_logs`
--

DROP TABLE IF EXISTS `py_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text,
  `sql_` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_logs`
--

LOCK TABLES `py_logs` WRITE;
/*!40000 ALTER TABLE `py_logs` DISABLE KEYS */;
INSERT INTO `py_logs` VALUES (1,1,'2021-04-16 12:23:49','RICHARD logged in',NULL),(2,0,'2021-04-16 12:24:26','note \"richard. bug with audit trail\" updated by RICHARD',NULL),(3,1,'2021-04-16 12:26:36','emailed rjking58@gmail.com subject test response OK',NULL),(4,2,'2021-04-16 12:42:48','Heather logged in',NULL),(5,0,'2021-04-16 12:43:20','receipt \"75\" updated by Heather',NULL),(6,1,'2021-04-16 12:48:14','RICHARD logged in',NULL),(7,1,'2021-04-17 03:39:37','RICHARD logged in',NULL),(8,1,'2021-04-17 06:26:26','RICHARD logged in',NULL),(9,1,'2021-04-17 06:41:09','RICHARD logged in',NULL),(10,1,'2021-04-17 06:41:54','RICHARD logged in',NULL);
/*!40000 ALTER TABLE `py_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_named_values`
--

DROP TABLE IF EXISTS `py_named_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_named_values` (
  `ID` varchar(60) NOT NULL DEFAULT '',
  `USER_ID` int(11) NOT NULL DEFAULT '0',
  `VAL` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_named_values`
--

LOCK TABLES `py_named_values` WRITE;
/*!40000 ALTER TABLE `py_named_values` DISABLE KEYS */;
INSERT INTO `py_named_values` VALUES ('sys.db.version',0,'9999'),('sys.cust.id',0,'demo'),('sys.cust.key',0,'81013AB90601D4'),('exit.prompt',0,'Y'),('sys.download.url',0,'http://pybase.com/download/pybase102.exe'),('sys.prod.copyr',0,'Copyright ? 2008-2010 Richard King'),('sys.autotextdel',0,' .,'),('sys.prog.version',0,'1009'),('at.kgm',0,'Weight: {WEIGHT}kg'),('program.1',0,'\"calc.exe\",\"Calculator\",\"Ctrl Q\"'),('program.2',0,'\"\",\"\",\"\"'),('py_action_add_click1',0,'# a comment\r\n\r\naction_type.value = \"sql\"\r\n'),('sys.society.short',0,'test'),('sys.society.long',0,'Test Arts Society');
/*!40000 ALTER TABLE `py_named_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_roles`
--

DROP TABLE IF EXISTS `py_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `def_capab` char(1) NOT NULL DEFAULT 'N',
  `exceptions` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_roles`
--

LOCK TABLES `py_roles` WRITE;
/*!40000 ALTER TABLE `py_roles` DISABLE KEYS */;
INSERT INTO `py_roles` VALUES (1,'Admin','Y','member_delete \r\nemail\r\nzzz_test\r\n'),(7,'Treasurer','N','All Members\r\nNew Members\r\nEmergency Contacts Listing\r\nAll Members with latest receipt\r\nReceipts\r\naction_Mark as paid\r\nAudit trail'),(4,'Developer','D',''),(2,'Committee','N','All Members\r\nNew Members\r\nEmergency Contacts Listing\r\nAll Members with latest receipt\r\nReceipts\r\nAudit trail'),(6,'Reception','N','Emergency Contacts Listing');
/*!40000 ALTER TABLE `py_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_tables`
--

DROP TABLE IF EXISTS `py_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_tables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `display_name` varchar(50) DEFAULT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_tables`
--

LOCK TABLES `py_tables` WRITE;
/*!40000 ALTER TABLE `py_tables` DISABLE KEYS */;
INSERT INTO `py_tables` VALUES (10,'py_views','',NULL,NULL),(2,'members','Members',74,54),(3,'py_tables',NULL,NULL,NULL),(4,'py_assocs',NULL,NULL,NULL),(5,'py_columns','',NULL,NULL),(6,'py_templates','',NULL,NULL),(7,'py_roles','',NULL,NULL),(8,'py_users','',NULL,NULL),(12,'Notes','Notes',261,127);
/*!40000 ALTER TABLE `py_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_templates`
--

DROP TABLE IF EXISTS `py_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `view_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '',
  `class` varchar(10) NOT NULL DEFAULT '',
  `get_sql` text,
  `control` text,
  `contents` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_templates`
--

LOCK TABLES `py_templates` WRITE;
/*!40000 ALTER TABLE `py_templates` DISABLE KEYS */;
INSERT INTO `py_templates` VALUES (1,9092,'Magazine Labels','label','SELECT if( magazine_name != \'\', magazine_name, trim(concat_ws( \' \', title, name, lastname ) ) ) as name1, address, upper(concat_ws(\'  \',suburb,state,postcode)) as address2, title_position, organisation, copies FROM members where id=%d','.numberAcross 3\r\n.numberDown 11\r\n.topMargin 20 \r\n.leftMargin 12\r\n.horizPitch 66.5\r\n.vertPitch 24.3\r\n.lineHeight 4.0\r\n.fontName Arial\r\n.fontSize 11.0\r\n','.x 53 !copies .x 0 !name1 .cnl\r\n!title_position .cnl\r\n!organisation .cnl\r\n!address .cnl\r\n!address2\r\n'),(2,9091,'Badges','label','select * from members where id=%d','.numberAcross 2\r\n.numberDown 5\r\n.topMargin 20 \r\n.leftMargin 15.2\r\n.horizPitch 90.0\r\n.vertPitch 51.8\r\n.lineHeight 7.0\r\n.font Arial 14.0\r\n.bmp 1 9x5cm_label.bmp\r\n','.bmp 1\r\n.font Arial 14 .nl \r\n.iy 5 \r\n.ix 35 !name .nl \r\n.ix 35 !lastname .nl \r\n.iy 5 \r\n.ix 35 !badge_title .nl \r\n.iy 5 \r\n.ix 5 .b \"Waverley Arts Society        2012\" ./b .iy 4 .ix -12 .font \"Arial Narrow\" 8 \"Exp 02/13\"\r\n'),(3,9157,'Enquiry Letter','letter','select * from members where id=%d','.topMargin 10\r\n.leftMargin 30\r\n.headerHeight 40\r\n.footerHeight 20\r\n.lineHeight 4.0\r\n.bmp 1 letter_header.png\r\n.bmp 2 letter_footer.png\r\n','.header\r\n.bmp 1\r\n.body\r\n.font \"Times New Roman\" 13\r\n\r\n\r\n\r\n\r\n\r\n!title !name !lastname\r\n!address\r\n!suburb\r\n!state  !postcode\r\n\r\n.date .nl\r\n\r\n\r\n\r\nDear !name\r\n\r\nThank you for your enquiry on joining the Waverley Arts Society.  \r\n\r\nI have enclosed a brochure on the Society that outlines the classes we provide.\r\nThere are a number of groups that may interest you, perhaps our Portrait classes or the Life Drawing classes or our new Watercolour class,\r\n\r\nPlease come along to our Monthly Meetings,  evry month we have an interesting talk or  art demonstration.  Meetings are held on the third Wednesday of each month at the Mt Waverley Community Hall in Miller Cres, Mt Waverley, commencing at 7.30pm.  So our next meeting is on 16th February. \r\nPlease introduce your self to the members front desk who will let you in for no charge and no obligation so you can see if you enjoy the society. \r\nI\'m sure you will , as there are so many lovely members who are friendly  supportive and sharing.\r\n\r\n\r\n\r\nPlease call me if you need any further information.\r\n\r\nI look forward to meeting you at the Waverley Arts Society meetings.\r\n\r\n\r\nRegards\r\n\r\nHeather King \r\nMembership Secretary			Mob 0413556179   Home 95622459\r\n\r\nEnc:  Brochure and Kaleidoscope \r\n\r\n\r\n.footer\r\n.bmp 2\r\n'),(4,9098,'Welcome Letter','letter','select * from members where id=%d','.topMargin 10\r\n.leftMargin 30\r\n.headerHeight 40\r\n.footerHeight 20\r\n.lineHeight 4.0\r\n.bmp 1 ftgas_header.png\r\n.bmp 2 ftgas_thehut.png\r\n','.header\r\n.bmp 1\r\n.body\r\n.font \"Times New Roman\" 13\r\n\r\n\r\n\r\n\r\n\r\n\r\n!name !lastname\r\n!address\r\n!suburb\r\n!state  !postcode\r\n\r\n.date .nl\r\n\r\n\r\n\r\nDear !name\r\n\r\nWelcome to the Ferntree Gully Arts Society.\r\n\r\nAs a new member I hope you will enjoy participating in the many events and activities that the Society holds throughout the year.\r\n\r\nI also encourage you to attend our regular classes and workshops, plein air, members only exhibitions and make use of the library.\r\n\r\nThe Society has many active groups and you will be most welcome to join any of them, whether you are an experienced artist or a beginner.\r\n\r\nI hope that you will feel very welcome in the Frentree Gully Arts Society and that your artistic talents are encouraged and rewarded.\r\n\r\n\r\nRegards\r\n\r\nHeather King \r\nMembership Secretary \"      \" Mob 0413 556 179 \"      \" Home 9562 2459\r\n\r\n\r\n.font Arial 9\r\n\r\n.footer\r\n.bmp 2\r\n'),(7,9090,'Please Renew Letter','letter','select * from members where id=%d','.topMargin 10\r\n.leftMargin 30\r\n.headerHeight 40\r\n.footerHeight 20\r\n.lineHeight 4.0\r\n.bmp 1 ftgas_header.png\r\n.bmp 2 ftgas_thehut.png\r\n','.header\r\n.bmp 1\r\n.body\r\n.font \"Times New Roman\" 13\r\n\r\n\r\n\r\n\r\n\r\n\r\n!title !name !lastname\r\n!address\r\n!suburb\r\n!state  !postcode\r\n\r\n.date .nl\r\n\r\n\r\n\r\nDear !name\r\n\r\nI am writing to you on behalf of the Ferntree Gully Art Society as I have noticed you have not rejoined the society this year. I understand there may be many reasons why you have chosen not to renew or, it may be that you have just forgotten. I ask you to consider rejoining the Society as this is shaping up to be a very exciting year for us.\r\n\r\nThe Society was formed with the idea of creating a place for artists to congregate, share ideas and work together, and to further the acceptance of the Arts in our region.\r\n\r\n\r\nI urge you to renew your membership.\r\n\r\n\r\nRegards\r\n\r\nHeather King \r\nMembership Secretary \"      \" Mob 0413 556 179 \"      \" Home 9562 2459\r\n\r\n\r\n\r\n\r\n\r\n.footer\r\n.bmp 2\r\n'),(11,9098,'Welcome email','email','select * from members where id=%d','','<html>\r\n<img src=\"https://artspace7.com.au/pybase/hut/ftgas_email_header.png\" >\r\n<br>\r\nHi !name\r\n<p>\r\nWelcome to the Ferntree Gully Arts Society.\r\n<p>\r\nAs a new member I hope you will enjoy participating in the many events and activities that the Society holds throughout the year.\r\n<p>\r\nI also encourage you to attend our regular classes and workshops, plein air, members only exhibitions and make use of the library.\r\n<p>\r\nThe Society has many active groups and you will be most welcome to join any of them, whether you are an experienced artist or a beginner.\r\n<p>\r\nI hope that you will feel very welcome in the Ferntree Gully Arts Society and that your artistic talents are encouraged and rewarded.\r\n<p>\r\nRegards\r\n<p>\r\nHeather\r\n<p>\r\nMembership Secretary\r\n<p>\r\n<img src=\"https://artspace7.com.au/pybase/hut/ftgas_email_footer.png\" >\r\n</html>'),(5,9158,'Proxy Letter','letter','select * from members where id=%d','.topMargin 10\r\n.leftMargin 30\r\n.headerHeight 40\r\n.footerHeight 20\r\n.lineHeight 4.0\r\n.bmp 1 letter_header.png\r\n.bmp 2 letter_footer.png\r\n','.header\r\n.bmp 1\r\n.body\r\n.font \"Times New Roman\" 13\r\n\r\n\r\n\r\n\r\n\r\n\r\n!title !name !lastname\r\n!address\r\n!suburb\r\n!state  !postcode\r\n\r\n.date .nl\r\n\r\n\r\n\r\nDear !name\r\n\r\nProxy text for page 1\r\n\r\n.footer\r\n.bmp 2\r\n.np\r\n.y 30\r\n\r\nProxy text for page 2\r\n\r\n\r\n\r\n\r\nRegards\r\n\r\nHeather King \r\nMembership Secretary \"      \" Mob 0413 556 179 \"      \" Home 9562 2459\r\n\r\n.footer\r\n.bmp 2\r\n'),(8,9160,'Tickets','label','select starting_ticket from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B1 from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B2 from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B3 from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B4 from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B5 from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B6 from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B7 from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B8 from tickets where id=%0:d\r\nunion\r\nselect starting_ticket%%2B9 from tickets where id=%0:d\r\norder by 1\r\n','.numberAcross 2\r\n.numberDown 5\r\n.topMargin 20 \r\n.leftMargin 15.2\r\n.horizPitch 90.0\r\n.vertPitch 51.8\r\n.lineHeight 3.5\r\n.font Arial 8.0\r\n.bmp 1 9x5cm_ticket.png\r\n','.bmp 1\r\n.font \"Arial\" 9\r\n.y 5\r\n.x 3 .b Waverley Arts .nl \r\n.x 3 Society Inc. .nl .iy 2\r\n.x 3 Art Raffle \"   \" \r\n.font \"Arial\" 14 $2 .font \"Arial\" 9 .nl .iy 2\r\n.x 3 Ticket No !starting_ticket ./b .nl .nl\r\n.x 3 Name:.................... .nl .iy 2\r\n.x 3 Address:................. .nl .iy 2\r\n.x 3 ............................ .nl .iy 2\r\n.x 3 ............................ .nl .iy 2\r\n.x 3 Tel:....................... \r\n\r\n.y 5\r\n.x 35 .b Waverley Arts Society Inc. .nl\r\n.x 35 Art Raffle Ticket No !starting_ticket \"   \"\r\n.font \"Arial\" 14 $2 .font \"Arial\" 7\r\n./b .nl .nl\r\n.x 35 Win one of three unframed pastel paintings by .nl\r\n.font \"Arial\" 8\r\n.x 35 International artist Tony Allain .nl .nl\r\n.x 35 1st prize \'The Boats\' Value $650 .nl\r\n.x 35 2nd  prize \'On the Shore\' Value $600 .nl\r\n.x 35 3rd  prize \'Flowers\' Value $550 .nl\r\n.font \"Arial\" 7\r\n.x 35 To be drawn at .nl\r\n.x 35 The Highway Gallery  12:00 8th December 2010 .nl\r\n.x 35 Winners notified by phone or letter .nl\r\n.x 35 Total prize pool $1800\r\n'),(9,9160,'Ticket Covers','label','select * from tickets where id=%0:d\r\n','.numberAcross 2\r\n.numberDown 5\r\n.topMargin 20 \r\n.leftMargin 15.2\r\n.horizPitch 90.0\r\n.vertPitch 51.8\r\n.lineHeight 6\r\n.font Arial 14.0\r\n','.y 5\r\n.x 35 !name !last_name .nl\r\n.x 35 !starting_ticket \" - \" !ending_ticket\r\n'),(10,9091,'Test','letter','select * from members where id=%d','.topMargin 10\r\n.leftMargin 30\r\n.headerHeight 40\r\n.footerHeight 20\r\n.lineHeight 4.0\r\n.bmp 1 letter_header.png\r\n.bmp 2 letter_footer.png\r\n','.header\r\n.bmp 1\r\n.body\r\n.font \"Times New Roman\" 13\r\n\r\n\r\n\r\n\r\n\r\n\r\n!title !name !lastname\r\n!address\r\n!suburb\r\n!state  !postcode\r\n\r\n.date .nl\r\n\r\n\r\n\r\nDear !name\r\n\r\nWelcome to the Ferntree Gully Arts Society.\r\n\r\nAs a new member I hope you will enjoy participating in the many events and activities that the Society holds throughout the year.\r\n\r\nI also encourage you to attend our regular Monthly Meetings, held on the third Wednesday of each month at the Mount Waverley Community Centre, Miller Crescent, Mount Waverley, commencing at 7.30pm.  \r\nGuest artists give demonstrations each month and the meetings are very enjoyable and informative.\r\n\r\nA small $2.00 donation is requested to help defray costs.\r\n\r\nThe Society has many active groups and you will be most welcome to join  any of them, whether you are an experienced artist or a beginner.\r\n\r\nI hope that you will feel very welcome in the Waverley Arts Society and that your artistic talents are encouraged and rewarded.\r\n\r\n\r\nRegards\r\n\r\nHeather King \r\nMembership Secretary \"      \" Mob 0413 556 179 \"      \" Home 9562 2459\r\n\r\n\r\n.font Arial 9\r\nEnc: Constitution and badge\r\n\r\n.footer\r\n.bmp 2\r\n');
/*!40000 ALTER TABLE `py_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_users`
--

DROP TABLE IF EXISTS `py_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT '0',
  `USER_NAME` varchar(32) NOT NULL DEFAULT '',
  `PASSWORD` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(100) DEFAULT NULL,
  `smtp_host` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_users`
--

LOCK TABLES `py_users` WRITE;
/*!40000 ALTER TABLE `py_users` DISABLE KEYS */;
INSERT INTO `py_users` VALUES (1,4,'RICHARD','viking','rjking@tpg.com.au','mail.artspace7.com.au'),(2,1,'Heather','goldie','heather@artspace7.com.au','mail.artspace7.com.au'),(4,2,'Shirley','sd001',NULL,NULL),(10,2,'Marian','ml004',NULL,NULL),(6,2,'rk','viking',NULL,NULL),(9,6,'000','000',NULL,NULL),(11,7,'Janet','jb003',NULL,NULL);
/*!40000 ALTER TABLE `py_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `py_views`
--

DROP TABLE IF EXISTS `py_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `py_views` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(32) NOT NULL DEFAULT '',
  `FORMDESC` text,
  `fields` text,
  `subviews` text,
  `GET_SQL` text,
  `PUT_SQL` text,
  `INCL_IN_INDEX` char(1) NOT NULL DEFAULT 'N',
  `TO_VIEW` varchar(32) DEFAULT NULL,
  `COMMENT` text,
  `table_name` varchar(64) DEFAULT '',
  `FILTER_COLUMNS` text,
  `multi_edit_columns` text,
  `HEADER_1` varchar(32) DEFAULT NULL,
  `HEADER_2` varchar(32) DEFAULT NULL,
  `work_area` varchar(32) DEFAULT NULL,
  `image_index` int(11) NOT NULL DEFAULT '0',
  `audit_template` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NAME` (`NAME`)
) ENGINE=MyISAM AUTO_INCREMENT=9188 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `py_views`
--

LOCK TABLES `py_views` WRITE;
/*!40000 ALTER TABLE `py_views` DISABLE KEYS */;
INSERT INTO `py_views` VALUES (9098,'All Members','','[\r\n{\"fieldName\":\"ec\", \"visibility\":false},\r\n{\"fieldName\":\"sort\", \"visibility\":false},\r\n{\"fieldName\":\"paid\", \"type\":\"date\", \"visibility\":false},\r\n{\"fieldName\":\"financial_to\", \"type\":\"date\"},\r\n{\"fieldName\":\"vol_duties_1\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_1_desc\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_2\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_2_desc\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_3\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_3_desc\", \"visibility\":false}\r\n]',NULL,'select * from members order by sort, lastname, name','','Y','member','This database is confidential and is not to be copied or distributed without authorisation from a committee member.','members','status','status','Members','',NULL,50,NULL),(9185,'message',NULL,'[\r\n{\"fieldName\":\"date_time\", \"type\":\"datetime\"},\r\n{\"fieldName\":\"from_user_id\", \"type\":\"lookup\", \"sql\":\"select id, user_name as name from py_users order by 2\"},\r\n{\"fieldName\":\"to_user_id\", \"type\":\"lookup\", \"sql\":\"select id, user_name as name from py_users order by 2\"},\r\n{\"fieldName\":\"message\", \"type\":\"textarea\"},\r\n{\"fieldName\":\"is_read\", \"type\":\"checkbox\"}\r\n]',NULL,'select * from messages where id=%d',NULL,'N',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,0,NULL),(9091,'Badges Required','',NULL,NULL,'select * from members where status in (\'Fin\',\'Hon\',\'Life\',\'Fam\') and (last_badge is null or last_badge = \'\') order by lastname, organisation','','N','member','members whose status is in (\'Fin\',\'Hon\',\'Life\' or\'Fam\') and last_badge = blank','','',NULL,'Badges Required','',NULL,0,NULL),(9092,'News Email','',NULL,NULL,'select * from members where email is not null and news_email = \'Y\' order by sort, lastname','','Y','member','members where status in (\'Fin\',\'Hon\',\'Life\',\'Free\') and News_Email = \'Y\'','','',NULL,'Magazine Labels','',NULL,0,NULL),(8597,'py_actions','',NULL,NULL,'select * from py_actions order by name','','Y','py_action','','','','','Py Actions','','Developer',0,NULL),(8599,'py_action','\"class=TKeyComboBox,label=View,name=view_id,\"\"!sql=select id,name from views\"\"\"\r\n\"!edit=name\"\r\n\"!edit=action_type\"\r\n\"!memo=script\"\r\n',NULL,NULL,'select * from py_actions where id=%d','update py_actions set view_id=:view_id,name=:name,action_type=:action_type,script=:script where id=:id','N','','','','',NULL,'<name>','',NULL,0,NULL),(8600,'py_action_add','\"class=TKeyComboBox,label=View,name=view_id,\"\"!sql=select id,name from views\"\"\"\r\n\"!edit=name\"\r\n\"!edit=action_type\"\r\n\"!memo=script\"\r\n\"class=TpyButton,caption=Test,PythonProc=click1\"\r\n',NULL,NULL,'','insert into py_actions (view_id,name,action_type,script) values (:view_id,:name,:action_type,:script)','N','','','','',NULL,'New Py Action','',NULL,0,NULL),(9157,'New Members','','[\r\n{\"fieldName\":\"ec\", \"visibility\":false},\r\n{\"fieldName\":\"sort\", \"visibility\":false},\r\n{\"fieldName\":\"paid\", \"type\":\"date\"},\r\n{\"fieldName\":\"financial_to\", \"type\":\"date\"},\r\n{\"fieldName\":\"vol_duties_1\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_1_desc\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_2\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_2_desc\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_3\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_3_desc\", \"visibility\":false}\r\n]',NULL,'select * from members where upper(status) = \'NEW\' order by sort,\r\nlastname','','Y','member','New members (status=NEW)','','',NULL,'New Members','',NULL,50,NULL),(9158,'Financial Members','',NULL,NULL,'select * from members where status in (\'Fin\',\'Hon\',\'Life\',\'Fam\') order by sort,lastname','','N','member','members whose status is in (\'Fin\', \'Hon\', \'Life\' or \'Fam\')','','','','Financial Members','',NULL,50,NULL),(9099,'member','\"!edit=title\"\r\n\"!edit=name\"\r\n\"!edit=lastname\"\r\n\"!edit=address\"\r\n\"!edit=suburb\"\r\n\"!edit=state\"\r\n\"!edit=postcode\"\r\n\"!edit=phone\"\r\n\"!edit=mobile\"\r\n\"!edit=email\"\r\n\"class=TComboBox,label=,name=status,\"\"!ddl=select distinct status from members\"\"\"\r\n\"!date=paid\"\r\n\"!date=financial_to\"\r\n\"!edit=workshop_class\"\r\n\"!edit=news_email\"\r\n\"!edit=news_hut\"\r\n\"!edit=news_post\"\r\n\"!edit=ec\"\r\n\"!edit=ec_name\"\r\n\"!edit=ec_number\"\r\n\"class=TComboBox,label=,name=vol_duties_1,\"\"!ddl=select distinct vol_duties_1 from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_1_desc,\"\"!ddl=select distinct vol_duties_1_desc from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_2,\"\"!ddl=select distinct vol_duties_2 from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_2_desc,\"\"!ddl=select distinct vol_duties_2_desc from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_3,\"\"!ddl=select distinct vol_duties_3 from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_3_desc,\"\"!ddl=select distinct vol_duties_3_desc from members\"\"\"\r\n\"!edit=no\"\r\n\"!edit=joined\"\r\n\"!memo=comments\"\r\n\"!edit=sort\"','[\r\n{\"fieldName\":\"ec\", \"visibility\":false},\r\n{\"fieldName\":\"paid\", \"type\":\"date\"},\r\n{\"fieldName\":\"financial_to\", \"type\":\"date\"},\r\n{\"fieldName\":\"vol_duties_1\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_1_desc\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_2\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_2_desc\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_3\", \"visibility\":false},\r\n{\"fieldName\":\"vol_duties_3_desc\", \"visibility\":false},\r\n{\"fieldName\":\"comments\", \"type\":\"textarea\"}\r\n]\r\n','{\"receipts\":\"member$receipts\"}','select * from members where id=%d','update members set title=:title,name=:name,lastname=:lastname,address=:address,suburb=:suburb,state=:state,postcode=:postcode,phone=:phone,mobile=:mobile,email=:email,financial_to=:financial_to,\r\ncomments=:comments,\r\nnews_email=:news_email,\r\nnews_hut=:news_hut,\r\nnews_post=:news_post,\r\nstatus=:status,joined=:joined,\r\nec=:ec,ec_name=:ec_name,ec_number=:ec_number,\r\nworkshop_class=:workshop_class,no=:no,\r\nvol_duties_1=:vol_duties_1,vol_duties_1_desc=:vol_duties_1_desc,\r\nvol_duties_2=:vol_duties_2,vol_duties_2_desc=:vol_duties_2_desc,\r\nvol_duties_3=:vol_duties_3,vol_duties_3_desc=:vol_duties_3_desc,\r\npaid=:paid,\r\nsort=:sort\r\nwhere id=:id','','','','','','','<name>','',NULL,0,NULL),(9100,'member_add','\"!edit=title\"\r\n\"!edit=name\"\r\n\"!edit=lastname\"\r\n\"!edit=address\"\r\n\"!edit=suburb\"\r\n\"!edit=state\"\r\n\"!edit=postcode\"\r\n\"!edit=phone\"\r\n\"!edit=mobile\"\r\n\"!edit=email\"\r\n\"class=TComboBox,label=,name=status,\"\"!ddl=select distinct status from members\"\"\"\r\n\"!date=paid\"\r\n\"!date=financial_to\"\r\n\"!edit=workshop_class\"\r\n\"!edit=news_email\"\r\n\"!edit=news_hut\"\r\n\"!edit=news_post\"\r\n\"!edit=ec\"\r\n\"!edit=ec_name\"\r\n\"!edit=ec_number\"\r\n\"class=TComboBox,label=,name=vol_duties_1,\"\"!ddl=select distinct vol_duties_1 from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_1_desc,\"\"!ddl=select distinct vol_duties_1_desc from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_2,\"\"!ddl=select distinct vol_duties_2 from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_2_desc,\"\"!ddl=select distinct vol_duties_2_desc from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_3,\"\"!ddl=select distinct vol_duties_3 from members\"\"\"\r\n\"class=TComboBox,label=,name=vol_duties_3_desc,\"\"!ddl=select distinct vol_duties_3_desc from members\"\"\"\r\n\"!edit=no\"\r\n\"!edit=joined\"\r\n\"!memo=comments\"',NULL,NULL,'','insert into members (title,name,lastname,address,suburb,state,postcode,phone,mobile,email,financial_to,comments,status,joined,paid,\r\nnews_email,news_hut,news_post,ec,ec_name,ec_number,workshop_class,no,vol_duties_1,vol_duties_1_desc,vol_duties_2,vol_duties_2_desc,vol_duties_3,vol_duties_3_desc) \r\nvalues (:title,:name,:lastname,:address,:suburb,:state,:postcode,:phone,:mobile,:email,:financial_to,:comments,:status,:joined,:paid,\r\n:news_email,:news_hut,:news_post,:ec,:ec_name,:ec_number,:workshop_class,:no,:vol_duties_1,:vol_duties_1_desc,:vol_duties_2,:vol_duties_2_desc,:vol_duties_3,:vol_duties_3_desc)','','','','','',NULL,'New Member','',NULL,0,NULL),(1,'index','!icons',NULL,NULL,'select id,name from py_views where incl_in_index = \'Y\' order by upper(name)\r\n',NULL,'N','field:name',NULL,'',NULL,NULL,'Home',NULL,NULL,0,NULL),(9090,'Not Renewed','',NULL,NULL,'SELECT m.id, m.no, m.title, m.name,m.lastname,m.mobile,m.phone,m.status,m.paid, m.financial_to,\r\nr.receipt_date,r.receipt_no,r.amount,r.note \r\nFROM `members` m \r\nleft join receipts r on r.member_id = m.id \r\nand r.receipt_date=(select max(r2.receipt_date) from receipts r2 where r2.member_id=m.id)\r\nwhere m.financial_to is null or m.financial_to < current_timestamp() \r\norder by sort, lastname, name\r\n','','Y','member','The Not Renewed list is the subset of All Members who are no longer financial.','','','','Not Renewed','',NULL,50,NULL),(8642,'Logs','',NULL,NULL,'select l.id,u.user_name, l.date_time, l.description from py_logs l left outer join py_users u on l.user_id=u.id order by date_time desc','','N','','Log, currently of logins','','',NULL,'Logs','','Developer',0,NULL),(9102,'Magazines by status','!chart pie',NULL,NULL,'select status, sum(if(copies=\'\',1,copies)) from members where status in (\'Fin\',\'Hon\',\'Life\',\'Free\') group by status','','N','','Pie chart of magazine copies broken down by status','','',NULL,'Magazines by status','',NULL,47,NULL),(9104,'Status Report','import pybase\r\n\r\nq = pybase.SQLQuery( \'\', \'select count(*) \"c\" from members\' )\r\nrep = \"Count of members: \" + q.FieldByName(\'c\').AsString\r\ndel q\r\n\r\nq = pybase.SQLQuery( \'\', \"select sum(if(copies=\'\',1,copies)) TOT from members where status in (\'Fin\',\'Hon\',\'Life\',\'Free\')\" )\r\nrep = rep + \"\\r\\nMagazines required: \" + q.FieldByName(\'TOT\').AsString\r\ndel q\r\n\r\nrep = rep + \'\\r\\nStatus breakdown:\'\r\n\r\nq = pybase.SQLQuery( \'\', \"select if(status=\'\', \'Other\', status) s, count(*) c from members group by status\" )\r\nwhile not q.eof:\r\n  rep = rep + \'\\r\\n\' + q.FieldByName(\'s\').AsString + \'=\' + q.FieldByName(\'c\').AsString\r\n  q.Next()\r\ndel q\r\n\r\nReport.value = rep\r\n',NULL,NULL,'','','N','','','','',NULL,'','',NULL,50,NULL),(9106,'Members by status','!chart pie',NULL,NULL,'select if(status=\'\', \'Other\', status), count(*)  from members group by status','','N','','Members by status','','',NULL,'Members by status','',NULL,47,NULL),(9120,'py_tables',NULL,NULL,NULL,'select * from py_tables order by name',NULL,'Y','py_table',NULL,'',NULL,NULL,'Py Tables',NULL,'Developer',0,NULL),(9117,'py_assocs',NULL,NULL,NULL,'select * from py_assocs order by name',NULL,'Y','py_assoc',NULL,'',NULL,NULL,'Py Assocs',NULL,'Developer',0,NULL),(9118,'py_assoc','\"!edit=name\"\r\n\"!edit=table_a\"\r\n\"!edit=table_b\"\r\n\"!edit=cardinality\"\r\n\"!edit=comment\"\r\n',NULL,NULL,'select * from py_assocs where id=%d','update py_assocs set name=:name,table_a=:table_a,table_b=:table_b,cardinality=:cardinality,comment=:comment where id=:id','N',NULL,NULL,'',NULL,NULL,'<name>',NULL,NULL,0,NULL),(9119,'py_assoc_add','\"!edit=name\"\r\n\"!edit=table_a\"\r\n\"!edit=table_b\"\r\n\"!edit=cardinality\"\r\n\"!edit=comment\"\r\n',NULL,NULL,'','insert into py_assocs (name,table_a,table_b,cardinality,comment) values (:name,:table_a,:table_b,:cardinality,:comment)','N',NULL,NULL,'',NULL,NULL,'New Py Assoc',NULL,NULL,0,NULL),(9125,'py_table$py_columns','',NULL,NULL,'select * from py_columns where table_id=%d','','N','py_column','','','',NULL,'<name>','Py Columns',NULL,0,NULL),(9122,'py_table','\"!edit=name\"\r\n\"!edit=display_name\"\r\n\"class=TLabelEx,caption=py_columns,!view=py_table$py_columns\"\r\n',NULL,NULL,'select * from py_tables where id=%d','update py_tables set name=:name,display_name=:display_name where id=:id','N',NULL,NULL,'',NULL,NULL,'<name>',NULL,NULL,0,NULL),(9123,'py_table_add','\"!edit=name\"\r\n\"!edit=display_name\"\r\n',NULL,NULL,'','insert into py_tables (name,display_name) values (:name,:display_name)','N',NULL,NULL,'',NULL,NULL,'New Py Table',NULL,NULL,0,NULL),(9124,'py_columns','',NULL,NULL,'select * from py_columns order by name','','N','py_column','','','',NULL,'Py Columns','','Developer',0,NULL),(9126,'py_column','\"!edit=name\"\r\n\"!edit=type\"\r\n\"!edit=size\"\r\n\"!edit=decimals\"\r\n\"class=TKeyComboBox,label=Table,name=table_id,\"\"!sql=select id,name from tables\"\"\"\r\n\"!edit=display_name\"\r\n',NULL,NULL,'select * from py_columns where id=%d','update py_columns set name=:name,type=:type,size=:size,decimals=:decimals,table_id=:table_id,display_name=:display_name where id=:id','N',NULL,NULL,'',NULL,NULL,'<name>',NULL,NULL,0,NULL),(9127,'py_column_add','\"!edit=name\"\r\n\"!edit=type\"\r\n\"!edit=size\"\r\n\"!edit=decimals\"\r\n\"class=TKeyComboBox,label=Table,name=table_id,\"\"!sql=select id,name from tables\"\"\"\r\n\"!edit=display_name\"\r\n',NULL,NULL,'','insert into py_columns (name,type,size,decimals,table_id,display_name) values (:name,:type,:size,:decimals,:table_id,:display_name)','N',NULL,NULL,'',NULL,NULL,'New Py Column',NULL,NULL,0,NULL),(9153,'Templates',NULL,NULL,NULL,'select * from py_templates order by name',NULL,'Y','py_template',NULL,'',NULL,NULL,'Py Templates',NULL,'Developer',0,NULL),(9155,'py_template','\"class=TKeyComboBox,label=View,name=view_id,\"\"!sql=select id,name from py_views\"\"\"\r\n\"!edit=name\"\r\n\"!edit=class\"\r\n\"!memo=get_sql\"\r\n\"!memo=control\"\r\n\"!memo=contents,height=200\"\r\n',NULL,NULL,'select * from py_templates where id=%d','update py_templates set view_id=:view_id,name=:name,class=:class,get_sql=:get_sql,control=:control,contents=:contents where id=:id','N',NULL,NULL,'',NULL,NULL,'<name>',NULL,NULL,0,NULL),(9156,'py_template_add','\"class=TKeyComboBox,label=View,name=view_id,\"\"!sql=select id,name from py_views\"\"\"\r\n\"!edit=name\"\r\n\"!edit=class\"\r\n\"!memo=get_sql\"\r\n\"!memo=control\"\r\n\"!memo=contents,height=100\"\r\n',NULL,NULL,'','insert into py_templates (view_id,name,class,get_sql,control,contents) values (:view_id,:name,:class,:get_sql,:control,:contents)','N',NULL,NULL,'',NULL,NULL,'New Py Template',NULL,NULL,0,NULL),(9132,'py_roles',NULL,NULL,NULL,'select * from py_roles order by name',NULL,'Y','py_role',NULL,'',NULL,NULL,'Py Roles',NULL,'Developer',0,NULL),(9137,'py_role$py_users','',NULL,NULL,'select * from py_users where role_id=%d','','N','py_user','','','',NULL,'<name>','Py Users',NULL,0,NULL),(9134,'py_role','\"!edit=name\"\r\n\"!edit=def_capab\"\r\n\"!memo=exceptions\"\r\n\"class=TLabelEx,caption=py_users,!view=py_role$py_users\"\r\n',NULL,NULL,'select * from py_roles where id=%d','update py_roles set name=:name,def_capab=:def_capab,exceptions=:exceptions where id=:id','N',NULL,NULL,'',NULL,NULL,'<name>',NULL,NULL,0,NULL),(9135,'py_role_add','\"!edit=name\"\r\n\"!edit=def_capab\"\r\n\"!edit=exceptions\"\r\n',NULL,NULL,'','insert into py_roles (name,def_capab,exceptions) values (:name,:def_capab,:exceptions)','N',NULL,NULL,'',NULL,NULL,'New Py Role',NULL,NULL,0,NULL),(9136,'py_users',NULL,NULL,NULL,'select * from py_users order by user_name',NULL,'Y','py_user',NULL,'',NULL,NULL,'Py Users',NULL,'Developer',0,NULL),(9138,'py_user','\"class=TKeyComboBox,label=Role,name=role_id,\"\"!sql=select id,name from py_roles\"\"\"\r\n\"!edit=user_name\"\r\n\"!edit=password\"\r\n',NULL,NULL,'select * from py_users where id=%d','update py_users set role_id=:role_id,user_name=:user_name,password=:password where id=:id','N',NULL,NULL,'',NULL,NULL,'<name>',NULL,NULL,0,NULL),(9139,'py_user_add','\"class=TKeyComboBox,label=Role,name=role_id,\"\"!sql=select id,name from py_roles\"\"\"\r\n\"!edit=user_name\"\r\n\"!edit=password\"\r\n',NULL,NULL,'','insert into py_users (role_id,user_name,password) values (:role_id,:user_name,:password)','N',NULL,NULL,'',NULL,NULL,'New Py User',NULL,NULL,0,NULL),(9152,'modeller','!modeller',NULL,NULL,NULL,NULL,'N',NULL,NULL,'',NULL,NULL,'Modeller',NULL,NULL,0,NULL),(9154,'py_view$py_templates',NULL,NULL,NULL,'select * from py_templates where view_id=%d',NULL,'N','py_template',NULL,'',NULL,NULL,'<name>','Py Templates',NULL,0,NULL),(9149,'py_views',NULL,NULL,NULL,'select * from py_views order by name',NULL,'Y','py_view',NULL,'',NULL,NULL,'Py Views',NULL,'Developer',0,NULL),(9150,'py_view','\"!edit=name\"\r\n\"!edit=formdesc\"\r\n\"!edit=get_sql\"\r\n\"!edit=put_sql\"\r\n\"!edit=incl_in_index\"\r\n\"!edit=to_view\"\r\n\"!edit=comment\"\r\n\"!edit=table_name\"\r\n\"!edit=filter_columns\"\r\n\"!edit=multi_edit_columns\"\r\n\"!edit=header_1\"\r\n\"!edit=header_2\"\r\n\"!edit=work_area\"\r\n\"!edit=image_index\"\r\n',NULL,NULL,'select * from py_views where id=%d','update py_views set name=:name,formdesc=:formdesc,get_sql=:get_sql,put_sql=:put_sql,incl_in_index=:incl_in_index,to_view=:to_view,comment=:comment,table_name=:table_name,filter_columns=:filter_columns,multi_edit_columns=:multi_edit_columns,header_1=:header_1,header_2=:header_2,work_area=:work_area,image_index=:image_index where id=:id','N',NULL,NULL,'',NULL,NULL,'<name>',NULL,NULL,0,NULL),(9151,'py_view_add','\"!edit=name\"\r\n\"!edit=formdesc\"\r\n\"!edit=get_sql\"\r\n\"!edit=put_sql\"\r\n\"!edit=incl_in_index\"\r\n\"!edit=to_view\"\r\n\"!edit=comment\"\r\n\"!edit=table_name\"\r\n\"!edit=filter_columns\"\r\n\"!edit=multi_edit_columns\"\r\n\"!edit=header_1\"\r\n\"!edit=header_2\"\r\n\"!edit=work_area\"\r\n\"!edit=image_index\"\r\n',NULL,NULL,'','insert into py_views (name,formdesc,get_sql,put_sql,incl_in_index,to_view,comment,table_name,filter_columns,multi_edit_columns,header_1,header_2,work_area,image_index) values (:name,:formdesc,:get_sql,:put_sql,:incl_in_index,:to_view,:comment,:table_name,:filter_columns,:multi_edit_columns,:header_1,:header_2,:work_area,:image_index)','N',NULL,NULL,'',NULL,NULL,'New Py View',NULL,NULL,0,NULL),(9167,'Notes','',NULL,NULL,'select * from notes order by done, priority desc','','Y','note','','','','','Notes','','',0,NULL),(9169,'News Hut','',NULL,NULL,'select * from members where news_hut = \'Y\' order by sort, lastname','','Y','member','members where status in (\'Fin\',\'Hon\',\'Life\',\'Free\') and News_Hut = \'Y\'','','',NULL,'Magazine Labels','',NULL,0,NULL),(9179,'receipt',NULL,'[\r\n{\"fieldName\":\"receipt_date\", \"type\":\"date\", \"default\":\"today\"},\r\n{\"fieldName\":\"amount\", \"type\":\"number\"},\r\n{\"fieldName\":\"member_id\", \"type\":\"lookup\", \"sql\":\"select id, concat(name,\' \',lastname) as name from members order by 2\"}\r\n]',NULL,'select * from receipts where id=%d',NULL,'N',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,0,'receipt_no'),(9168,'News Post','',NULL,NULL,'select * from members where news_post = \'Y\' order by sort, lastname','','Y','member','members where status in (\'Fin\',\'Hon\',\'Life\',\'Free\') and News_post = \'Y\'','','',NULL,'Magazine Labels','',NULL,0,NULL),(9170,'Events','',NULL,NULL,'select * from events order by event_date desc','','N','event','','','',NULL,'Events','','',0,NULL),(9171,'event','\"!date=event_date\"\r\n\"!memo=description, height=150\"\r\n','[\r\n\r\n{\"fieldName\":\"event_date\", \"type\":\"date\"}\r\n\r\n]',NULL,'select * from events where id=%d','update events set event_date=:event_date,description=:description where id=:id','N',NULL,NULL,'',NULL,NULL,'<name>',NULL,NULL,0,NULL),(9172,'event_add','\"!date=event_date\"\r\n\"!memo=description,height=150\"\r\n',NULL,NULL,'','insert into events (event_date,description) values (:event_date,:description)','N',NULL,NULL,'',NULL,NULL,'New Event',NULL,NULL,0,NULL),(9173,'Event Calendar','!calendar',NULL,NULL,'select id, event_date, description from events order by event_date desc','','Y','event','','','','','Event Calendar','','',49,NULL),(9174,'Emergency Contacts Listing',NULL,NULL,NULL,'select id,title,name,lastname,ec_name,ec_number from members order by sort,lastname',NULL,'Y','member',NULL,'members',NULL,NULL,NULL,NULL,NULL,50,NULL),(9175,'Building Maintenance','',NULL,NULL,'select * from members where MB is not null order by sort, MB, lastname','','Y','member','Maintenance - Building','','',NULL,'','',NULL,50,NULL),(9176,'Gardening','',NULL,NULL,'select * from members where MG is not null order by sort, lastname','','Y','member','Maintenance - Gardening','','',NULL,'','',NULL,50,NULL),(9177,'Assist with kids','',NULL,NULL,'select * from members where KID is not null order by sort, lastname','','Y','member','Members who will assist with Kids','','',NULL,'','',NULL,50,NULL),(9178,'note',NULL,'[\r\n{\"fieldName\":\"note\", \"type\":\"textarea\"}\r\n]',NULL,'select * from notes where id=%d',NULL,'N',NULL,NULL,'notes',NULL,NULL,'Notes',NULL,NULL,0,NULL),(9180,'member$receipts',NULL,NULL,NULL,'select r.id, r.receipt_date, m.name, m.lastname, r.receipt_no, r.payment_method, round(r.amount,2) as amount, r.note  from receipts r join members m on r.member_id = m.id where member_id=%d order by receipt_no desc, receipt_date desc',NULL,'N','receipt',NULL,'',NULL,NULL,NULL,NULL,NULL,0,NULL),(9181,'zzz_test',NULL,NULL,NULL,'select * from members where lastname=\'King\'',NULL,'Y','member',NULL,'',NULL,NULL,NULL,NULL,NULL,0,NULL),(9182,'Receipts',NULL,NULL,NULL,'select r.id, r.receipt_no,  r.receipt_date, m.name, m.lastname, r.payment_method, round(r.amount,2) as amount, r.note  from receipts r join members m on r.member_id = m.id order by receipt_no desc, receipt_date desc',NULL,'Y','receipt',NULL,'',NULL,NULL,'Receipts',NULL,NULL,0,NULL),(9183,'All Members with latest receipt','',NULL,NULL,'SELECT m.id, m.no, m.title, m.name,m.lastname,m.mobile,m.phone,m.status,m.paid, m.financial_to,\r\nr.receipt_date,r.receipt_no,r.amount,r.note \r\nFROM `members` m \r\nleft join receipts r on r.member_id = m.id \r\nand r.receipt_date=(select max(r2.receipt_date) from receipts r2 where r2.member_id=m.id) \r\norder by sort, lastname, name','','Y','member','This database is confidential and is not to be copied or distributed without authorisation from a committee member.','members',NULL,NULL,'Members','',NULL,50,NULL),(9184,'Messages',NULL,NULL,NULL,'select m.id, m.date_time, u1.user_name as from_user, u2.user_name as to_user, m.message from messages m join py_users u1 on m.from_user_id=u1.id join py_users u2 on m.to_user_id=u2.id where is_read is null order by m.date_time desc',NULL,'Y','message',NULL,'',NULL,NULL,NULL,NULL,NULL,0,NULL),(9186,'py_logs',NULL,NULL,NULL,'select * from py_logs order by date_time desc limit 100',NULL,'Y',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,0,NULL),(9187,'Audit trail',NULL,NULL,NULL,'select date_time, description from py_logs where description not like \'%richard%\' order by date_time desc limit 50',NULL,'Y',NULL,NULL,'',NULL,NULL,NULL,NULL,NULL,0,NULL);
/*!40000 ALTER TABLE `py_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipts`
--

DROP TABLE IF EXISTS `receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receipts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receipt_no` int(11) NOT NULL,
  `receipt_date` date NOT NULL,
  `member_id` int(11) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `amount` float NOT NULL,
  `note` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `receipt_no` (`receipt_no`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipts`
--

LOCK TABLES `receipts` WRITE;
/*!40000 ALTER TABLE `receipts` DISABLE KEYS */;
INSERT INTO `receipts` VALUES (1,62,'2020-02-08',68,'?',50,'2020'),(2,63,'2020-02-08',69,'?',50,'2020'),(4,61,'2020-02-20',67,'?',50,'2020'),(6,67,'2021-01-01',73,'?',50,'2021. unsure of receipt date'),(7,66,'2021-01-01',72,'?',50,'2021'),(8,65,'2021-01-01',71,'?',50,'2021 unsure of receipt date'),(9,64,'2020-12-15',70,'?',50,'2020'),(15,2,'2020-01-12',3,'?',50,'2020'),(14,1,'2020-01-06',15,'?',50,'2020'),(16,3,'2020-01-09',4,'?',50,'2020'),(17,4,'2020-01-12',6,'?',50,'2020'),(18,5,'2020-01-01',7,'?',50,'2020'),(19,6,'2020-01-12',9,'?',50,'2020'),(20,7,'2019-12-29',13,'?',50,'2020'),(21,8,'2020-01-06',14,'?',50,'2020'),(22,9,'2020-01-09',16,'?',80,'2020. family (Jasmine)'),(23,10,'2020-01-09',18,'?',50,'2020'),(24,11,'2020-01-09',19,'?',50,'2020'),(25,12,'2020-01-19',20,'?',50,'2020'),(26,13,'2020-01-25',1,'?',50,'2020'),(27,14,'2020-01-25',21,'?',50,'2020'),(28,15,'2020-01-18',22,'?',50,'2020'),(29,16,'2020-01-18',23,'?',50,'2020'),(30,17,'2020-01-18',24,'?',50,'2020'),(31,18,'2020-01-18',25,'?',50,'2020'),(32,19,'2020-01-22',26,'?',50,'2020'),(33,20,'2020-01-20',8,'?',50,'no paid date recorded'),(34,21,'2020-01-14',27,'?',50,'2020'),(35,22,'2020-01-25',28,'?',50,'2020'),(36,23,'2020-01-25',2,'?',50,'no paid date recorded'),(37,24,'2020-01-25',29,'?',50,'2020'),(38,25,'2020-01-13',30,'?',50,'2020'),(39,26,'2020-01-25',31,'?',50,'no paid date'),(40,27,'2020-01-08',32,'?',50,'2020'),(41,28,'2020-01-25',33,'?',50,'no paid date recorded'),(42,29,'2020-01-23',34,'?',50,'2020'),(43,30,'2020-01-25',35,'?',50,'2020. no paid date'),(44,31,'2020-02-01',36,'?',50,'2020'),(45,32,'2020-02-01',10127,'?',50,'Fiona not in spreadsheet'),(46,33,'2020-02-01',40,'?',50,'no paid date'),(47,34,'2020-01-30',41,'?',50,'2020'),(48,35,'2020-01-30',42,'?',50,'2020'),(49,36,'2020-02-01',43,'?',50,'2020'),(50,37,'2020-02-01',44,'?',50,'2020'),(51,38,'2020-02-01',39,'?',80,'2020 family. and Gerard'),(52,39,'2020-01-29',45,'?',50,'2020'),(53,40,'2020-01-28',46,'?',80,'2020 family'),(54,41,'2020-01-23',34,'?',50,'2020'),(55,42,'2020-01-28',48,'?',50,'2020'),(56,43,'2020-01-30',49,'?',50,'2020'),(57,44,'2020-01-30',53,'?',50,'2020'),(58,45,'2020-02-01',50,'?',50,'2020'),(59,46,'2020-02-04',51,'?',50,'2020'),(60,47,'2020-02-04',52,'?',50,'2020'),(61,48,'2020-02-04',5,'?',50,'no paid date'),(62,49,'2020-02-04',54,'?',50,'2020'),(63,50,'2020-01-30',55,'?',50,'2020'),(64,51,'2020-02-09',56,'?',50,'2020'),(65,52,'2020-02-11',57,'?',50,'2020'),(66,53,'2020-02-11',58,'?',50,'2020'),(67,54,'2020-02-11',59,'?',50,'2020'),(68,55,'2020-02-13',60,'?',50,'2020'),(69,56,'2020-02-13',61,'?',50,'no paid date'),(70,57,'2020-02-11',62,'?',50,'2020'),(71,58,'2020-02-18',63,'?',50,'2020'),(72,59,'2020-02-18',64,'?',80,'2020 family. with Lidia'),(73,60,'2020-02-20',66,'?',50,'2020'),(76,75,'2021-04-11',10130,'Cash',50,'2021');
/*!40000 ALTER TABLE `receipts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-17 19:14:58
