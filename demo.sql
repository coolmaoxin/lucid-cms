# ************************************************************
# Sequel Pro SQL dump
# Version 3348
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.15)
# Database: dogself
# Generation Time: 2013-01-03 13:40:15 -0500
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table bi_images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bi_images`;

CREATE TABLE `bi_images` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `data` longblob NOT NULL,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table contact_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `contact_info`;

CREATE TABLE `contact_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile_phone` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `work_phone` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table custom_navigation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `custom_navigation`;

CREATE TABLE `custom_navigation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `site` varchar(255) NOT NULL,
  `url_path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table guestbook_entry
# ------------------------------------------------------------

DROP TABLE IF EXISTS `guestbook_entry`;

CREATE TABLE `guestbook_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table guestbook_entry_fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `guestbook_entry_fields`;

CREATE TABLE `guestbook_entry_fields` (
  `fields` bigint(20) DEFAULT NULL,
  `fields_idx` varchar(255) DEFAULT NULL,
  `fields_elt` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mls_listing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mls_listing`;

CREATE TABLE `mls_listing` (
  `listing_id` bigint(20) NOT NULL DEFAULT '0',
  `version` bigint(20) NOT NULL,
  `acres` double DEFAULT NULL,
  `agent_id` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `basement` varchar(255) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `garage_parking` varchar(255) DEFAULT NULL,
  `garage_spaces` int(11) DEFAULT NULL,
  `has_master_bath` bit(1) DEFAULT NULL,
  `living_levels` int(11) DEFAULT NULL,
  `lot_size` double DEFAULT NULL,
  `number_bedrooms` int(11) DEFAULT NULL,
  `number_full_baths` int(11) DEFAULT NULL,
  `number_half_baths` int(11) DEFAULT NULL,
  `number_rooms` int(11) DEFAULT NULL,
  `photo_count` int(11) DEFAULT NULL,
  `photo_date` varchar(255) DEFAULT NULL,
  `photo_mask` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `prop_type` varchar(255) DEFAULT NULL,
  `sf_type` varchar(255) DEFAULT NULL,
  `square_feet` double DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `street_name` varchar(255) DEFAULT NULL,
  `street_number` varchar(255) DEFAULT NULL,
  `style` varchar(255) DEFAULT NULL,
  `town_id` bigint(20) NOT NULL,
  `unit_number` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`listing_id`),
  KEY `FKA68213F9DDE268CB` (`town_id`),
  CONSTRAINT `FKA68213F9DDE268CB` FOREIGN KEY (`town_id`) REFERENCES `town` (`town_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table navigation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `navigation`;

CREATE TABLE `navigation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `active` bit(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `navigation_heading` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `show_in_nav` bit(1) NOT NULL,
  `url_path` varchar(255) DEFAULT NULL,
  `user_html_id` bigint(20) DEFAULT NULL,
  `children_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6F060A14C5797BE0` (`parent_id`),
  KEY `FK6F060A14AD9C357C` (`user_html_id`),
  CONSTRAINT `FK6F060A14AD9C357C` FOREIGN KEY (`user_html_id`) REFERENCES `user_html_page` (`id`),
  CONSTRAINT `FK6F060A14C5797BE0` FOREIGN KEY (`parent_id`) REFERENCES `navigation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `navigation` WRITE;
/*!40000 ALTER TABLE `navigation` DISABLE KEYS */;

INSERT INTO `navigation` (`id`, `version`, `active`, `name`, `navigation_heading`, `parent_id`, `show_in_nav`, `url_path`, `user_html_id`, `children_idx`)
VALUES
	(1,2,b'1','root',NULL,NULL,b'0',NULL,NULL,NULL),
	(2,1,b'1','Home',NULL,1,b'0','home',1,0),
	(3,0,b'1','Awesome Tab for YOU!',NULL,1,b'1','awesome-tab-for-you',2,1);

/*!40000 ALTER TABLE `navigation` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table pending_email_confirmation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pending_email_confirmation`;

CREATE TABLE `pending_email_confirmation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `confirmation_token` varchar(80) NOT NULL,
  `email_address` varchar(80) NOT NULL,
  `timestamp` datetime NOT NULL,
  `user_token` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `emailconf_timestamp_Idx` (`timestamp`),
  KEY `emailconf_token_Idx` (`confirmation_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `active` bit(1) NOT NULL,
  `date_created` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `long_desc` longtext,
  `main_product_image_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `navigation_id` bigint(20) NOT NULL,
  `price` double NOT NULL,
  `sale_price` double DEFAULT NULL,
  `short_desc` varchar(255) DEFAULT NULL,
  `sold` bit(1) NOT NULL,
  `products_idx` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKED8DCCEF39E30A36` (`navigation_id`),
  CONSTRAINT `FKED8DCCEF39E30A36` FOREIGN KEY (`navigation_id`) REFERENCES `navigation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;

INSERT INTO `product` (`id`, `version`, `active`, `date_created`, `last_updated`, `long_desc`, `main_product_image_name`, `name`, `navigation_id`, `price`, `sale_price`, `short_desc`, `sold`, `products_idx`)
VALUES
	(1,1,b'1','2013-01-03 13:23:08','2013-01-03 13:27:46','Bacon!!!','horsehead_last_supper.png','Baked Tasty',2,100,700,'Yes its good to eat',b'0',0);

/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `authority` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `authority` (`authority`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;

INSERT INTO `role` (`id`, `version`, `authority`)
VALUES
	(1,0,'ROLE_ADMIN'),
	(2,0,'ROLE_USER');

/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table site_component
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site_component`;

CREATE TABLE `site_component` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `contact` bit(1) NOT NULL,
  `guestbook` bit(1) NOT NULL,
  `login` bit(1) NOT NULL,
  `mls` bit(1) NOT NULL,
  `products` bit(1) NOT NULL,
  `visual_tours` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `site_component` WRITE;
/*!40000 ALTER TABLE `site_component` DISABLE KEYS */;

INSERT INTO `site_component` (`id`, `version`, `contact`, `guestbook`, `login`, `mls`, `products`, `visual_tours`)
VALUES
	(1,1,b'1',b'1',b'1',b'0',b'1',b'1');

/*!40000 ALTER TABLE `site_component` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table site_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site_config`;

CREATE TABLE `site_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `admin_created` bit(1) NOT NULL,
  `google_apps_meta` varchar(255) DEFAULT NULL,
  `mls_password` varchar(255) DEFAULT NULL,
  `mls_username` varchar(255) DEFAULT NULL,
  `stat_counter_enabled` bit(1) NOT NULL,
  `stat_counter_project` varchar(255) DEFAULT NULL,
  `stat_counter_security` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `site_config` WRITE;
/*!40000 ALTER TABLE `site_config` DISABLE KEYS */;

INSERT INTO `site_config` (`id`, `version`, `admin_created`, `google_apps_meta`, `mls_password`, `mls_username`, `stat_counter_enabled`, `stat_counter_project`, `stat_counter_security`)
VALUES
	(1,2,b'1',NULL,NULL,NULL,b'0',NULL,NULL);

/*!40000 ALTER TABLE `site_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table site_config_meta_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site_config_meta_tags`;

CREATE TABLE `site_config_meta_tags` (
  `meta_tags` bigint(20) DEFAULT NULL,
  `meta_tags_idx` varchar(255) DEFAULT NULL,
  `meta_tags_elt` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `site_config_meta_tags` WRITE;
/*!40000 ALTER TABLE `site_config_meta_tags` DISABLE KEYS */;

INSERT INTO `site_config_meta_tags` (`meta_tags`, `meta_tags_idx`, `meta_tags_elt`)
VALUES
	(1,'googleApps','well, this is no longer a free service :P'),
	(1,'description','Some site'),
	(1,'keywords','demo, grails');

/*!40000 ALTER TABLE `site_config_meta_tags` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table site_config_misc
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site_config_misc`;

CREATE TABLE `site_config_misc` (
  `misc` bigint(20) DEFAULT NULL,
  `misc_idx` varchar(255) DEFAULT NULL,
  `misc_elt` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table town
# ------------------------------------------------------------

DROP TABLE IF EXISTS `town`;

CREATE TABLE `town` (
  `town_id` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  `county` varchar(255) NOT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  PRIMARY KEY (`town_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `account_expired` bit(1) NOT NULL,
  `account_locked` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `password_expired` bit(1) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `zip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `version`, `account_expired`, `account_locked`, `enabled`, `name`, `password`, `password_expired`, `phone`, `username`, `zip`)
VALUES
	(1,0,b'0',b'0',b'1','','5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',b'0','','admin',''); /* password is: password */

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_editable_section
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_editable_section`;

CREATE TABLE `user_editable_section` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `html` longtext NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

LOCK TABLES `user_editable_section` WRITE;
/*!40000 ALTER TABLE `user_editable_section` DISABLE KEYS */;

INSERT INTO `user_editable_section` (`id`, `version`, `html`, `name`)
VALUES
	(1,3,'<span style=\"font-family: tahoma,geneva,sans-serif; position: relative; bottom: 5px;\"><strong><span><img alt=\"\" src=\"/grails/grails/userData/Image/catman.jpg\" style=\"width: 214px; height: 182px; float: left;\" /></span></strong>&nbsp; </span>\n\n	<span style=\"font-size:18px;\"><span style=\"font-family: trebuchet ms,helvetica,sans-serif;\">This is my awesome demo site header.</span></span>\n','Header Left'),
	(2,0,'','Header Right'),
	(3,0,'','Left Panel'),
	(4,1,'This is a <strong>demo</strong> of lucid CMS &copy; 2013','Footer'),
	(5,0,'','Contact Form');

/*!40000 ALTER TABLE `user_editable_section` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_html_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_html_page`;

CREATE TABLE `user_html_page` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `html` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

LOCK TABLES `user_html_page` WRITE;
/*!40000 ALTER TABLE `user_html_page` DISABLE KEYS */;

INSERT INTO `user_html_page` (`id`, `version`, `html`)
VALUES
	(1,1,'This <img alt=\"some picture i uploaded\" src=\"/grails/grails/userData/Image/catman.jpg\" style=\"width: 214px; height: 182px;\" /> is a demo of the page'),
	(2,1,'stuff is here');

/*!40000 ALTER TABLE `user_html_page` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `FK143BF46AA24743F6` (`role_id`),
  KEY `FK143BF46A477207D6` (`user_id`),
  CONSTRAINT `FK143BF46A477207D6` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK143BF46AA24743F6` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;

INSERT INTO `user_role` (`role_id`, `user_id`)
VALUES
	(1,1);

/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table visual_tour
# ------------------------------------------------------------

DROP TABLE IF EXISTS `visual_tour`;

CREATE TABLE `visual_tour` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `beds_baths` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `date_created` datetime NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `photo_full_path` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `slides` int(11) NOT NULL,
  `sq_ft` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `tour_id` int(11) NOT NULL,
  `tour_title` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table zillow_listing
# ------------------------------------------------------------

DROP TABLE IF EXISTS `zillow_listing`;

CREATE TABLE `zillow_listing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `estimate` double NOT NULL,
  `value_high` double NOT NULL,
  `value_low` double NOT NULL,
  `zpid` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table zipcode
# ------------------------------------------------------------

DROP TABLE IF EXISTS `zipcode`;

CREATE TABLE `zipcode` (
  `zip_code` varchar(255) NOT NULL,
  `area_code` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `county` varchar(255) NOT NULL,
  `lat` double NOT NULL,
  `lon` double NOT NULL,
  `state_name` varchar(255) NOT NULL,
  `state_prefix` varchar(255) NOT NULL,
  `time_zone` varchar(255) NOT NULL,
  PRIMARY KEY (`zip_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
