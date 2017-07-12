/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.18-0ubuntu0.17.04.1 : Database - castinq
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `cms_block` */

DROP TABLE IF EXISTS `cms_block`;

CREATE TABLE `cms_block` (
  `block_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `contents` text,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_block_mapper` */

DROP TABLE IF EXISTS `cms_block_mapper`;

CREATE TABLE `cms_block_mapper` (
  `block_id` int(10) unsigned NOT NULL,
  `cms_id` int(10) unsigned NOT NULL,
  `order_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`block_id`,`cms_id`),
  KEY `cms_id` (`cms_id`),
  CONSTRAINT `cms_block_mapper_ibfk_1` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`block_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_block_mapper_ibfk_2` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_category` */

DROP TABLE IF EXISTS `cms_category`;

CREATE TABLE `cms_category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `modified_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_category_mapper` */

DROP TABLE IF EXISTS `cms_category_mapper`;

CREATE TABLE `cms_category_mapper` (
  `cms_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`cms_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `cms_category_mapper_ibfk_1` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_category_mapper_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `cms_category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_category_path` */

DROP TABLE IF EXISTS `cms_category_path`;

CREATE TABLE `cms_category_path` (
  `category_id` int(11) unsigned NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`parent_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `cms_category_path_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `cms_category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_category_path_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `cms_category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_comments` */

DROP TABLE IF EXISTS `cms_comments`;

CREATE TABLE `cms_comments` (
  `comment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `review_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `comment` text NOT NULL,
  `created_at` int(11) NOT NULL,
  `update_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `email` (`email`),
  KEY `review_id` (`review_id`),
  KEY `user_id` (`user_id`),
  KEY `email_2` (`email`),
  CONSTRAINT `cms_comments_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `cms_reviews` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_field` */

DROP TABLE IF EXISTS `cms_field`;

CREATE TABLE `cms_field` (
  `field_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `section` enum('None','Summary','Requirements','Skills') DEFAULT 'None',
  `field` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `type` enum('Text','TextArea','Radio','List','MultiList') DEFAULT 'Text',
  `order_by` int(10) unsigned DEFAULT NULL,
  `status` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`field_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `cms_field_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `cms_category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_field_option` */

DROP TABLE IF EXISTS `cms_field_option`;

CREATE TABLE `cms_field_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `field_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`option_id`),
  KEY `field_id` (`field_id`),
  CONSTRAINT `cms_field_option_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `cms_field` (`field_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_field_value` */

DROP TABLE IF EXISTS `cms_field_value`;

CREATE TABLE `cms_field_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cms_id` int(10) unsigned NOT NULL,
  `field_id` int(10) unsigned NOT NULL,
  `value` varchar(250) NOT NULL,
  PRIMARY KEY (`value_id`),
  KEY `job_id` (`cms_id`),
  KEY `field_id` (`field_id`),
  CONSTRAINT `cms_field_value_ibfk_1` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_field_value_ibfk_2` FOREIGN KEY (`field_id`) REFERENCES `cms_field` (`field_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_gallary` */

DROP TABLE IF EXISTS `cms_gallary`;

CREATE TABLE `cms_gallary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cms_id` int(10) unsigned NOT NULL,
  `title` varchar(250) NOT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1 - image, 2 - video',
  PRIMARY KEY (`id`),
  KEY `cms_id` (`cms_id`),
  CONSTRAINT `cms_gallary_ibfk_1` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_gallary_item` */

DROP TABLE IF EXISTS `cms_gallary_item`;

CREATE TABLE `cms_gallary_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gallery_id` int(10) unsigned NOT NULL,
  `item` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gallery_id` (`gallery_id`),
  CONSTRAINT `cms_gallary_item_ibfk_1` FOREIGN KEY (`gallery_id`) REFERENCES `cms_gallary` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_item` */

DROP TABLE IF EXISTS `cms_item`;

CREATE TABLE `cms_item` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `layout_id` int(10) unsigned DEFAULT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  `slug` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `external_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `image` varchar(200) DEFAULT NULL,
  `media` varchar(200) DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `latitude` decimal(10,3) DEFAULT NULL,
  `longitude` decimal(10,3) DEFAULT NULL,
  `restricted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` smallint(6) DEFAULT NULL,
  `meta_title` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `meta_description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `meta_keywords` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `modified_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `parent_id` (`parent_id`),
  KEY `layout` (`layout_id`),
  KEY `user_id` (`user_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `cms_item_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_item_ibfk_3` FOREIGN KEY (`layout_id`) REFERENCES `cms_layout` (`layout_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `cms_item_ibfk_4` FOREIGN KEY (`type_id`) REFERENCES `cms_type` (`type_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Table structure for table `cms_keyword` */

DROP TABLE IF EXISTS `cms_keyword`;

CREATE TABLE `cms_keyword` (
  `keyword_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_layout` */

DROP TABLE IF EXISTS `cms_layout`;

CREATE TABLE `cms_layout` (
  `layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`layout_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `cms_media` */

DROP TABLE IF EXISTS `cms_media`;

CREATE TABLE `cms_media` (
  `media_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cms_id` int(10) unsigned NOT NULL,
  `file` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`media_id`),
  KEY `cms_id` (`cms_id`),
  CONSTRAINT `cms_media_ibfk_1` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_menu` */

DROP TABLE IF EXISTS `cms_menu`;

CREATE TABLE `cms_menu` (
  `menu_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `data` text,
  PRIMARY KEY (`menu_id`),
  KEY `parent` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_menu_path` */

DROP TABLE IF EXISTS `cms_menu_path`;

CREATE TABLE `cms_menu_path` (
  `menu_id` int(11) unsigned NOT NULL,
  `parent_id` int(11) unsigned NOT NULL,
  `level` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`,`parent_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `cms_menu_path_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `cms_menu` (`menu_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_menu_path_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `cms_menu` (`menu_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_path` */

DROP TABLE IF EXISTS `cms_path`;

CREATE TABLE `cms_path` (
  `cms_id` int(10) unsigned NOT NULL,
  `path_id` int(10) unsigned NOT NULL,
  `level` int(11) DEFAULT NULL,
  PRIMARY KEY (`cms_id`,`path_id`),
  KEY `path_id` (`path_id`),
  CONSTRAINT `cms_path_ibfk_3` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_path_ibfk_4` FOREIGN KEY (`path_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_ratting` */

DROP TABLE IF EXISTS `cms_ratting`;

CREATE TABLE `cms_ratting` (
  `cms_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ratting` varchar(250) CHARACTER SET utf8 NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cms_id`),
  CONSTRAINT `cms_ratting_ibfk_1` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

/*Table structure for table `cms_relation` */

DROP TABLE IF EXISTS `cms_relation`;

CREATE TABLE `cms_relation` (
  `cms_id` int(10) unsigned NOT NULL,
  `keyword_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cms_id`,`keyword_id`),
  KEY `cms_keyword_id` (`keyword_id`),
  CONSTRAINT `cms_relation_ibfk_3` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_relation_ibfk_4` FOREIGN KEY (`keyword_id`) REFERENCES `cms_keyword` (`keyword_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_reviews` */

DROP TABLE IF EXISTS `cms_reviews`;

CREATE TABLE `cms_reviews` (
  `review_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cms_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `review` text NOT NULL,
  `status` tinyint(1) DEFAULT '1',
  `created_at` int(10) unsigned NOT NULL,
  `update_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`review_id`),
  KEY `cms_id` (`cms_id`),
  KEY `email` (`email`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cms_reviews_ibfk_1` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_to_user` */

DROP TABLE IF EXISTS `cms_to_user`;

CREATE TABLE `cms_to_user` (
  `cms_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `status` enum('Favorite','Seen') NOT NULL DEFAULT 'Seen',
  `dated` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cms_id`,`user_id`,`status`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cms_to_user_ibfk_1` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_to_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cms_type` */

DROP TABLE IF EXISTS `cms_type`;

CREATE TABLE `cms_type` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `cms_widget` */

DROP TABLE IF EXISTS `cms_widget`;

CREATE TABLE `cms_widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `widget` varchar(250) NOT NULL,
  `data` text,
  PRIMARY KEY (`widget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cms_widget_mapper` */

DROP TABLE IF EXISTS `cms_widget_mapper`;

CREATE TABLE `cms_widget_mapper` (
  `widget_id` int(10) unsigned NOT NULL,
  `cms_id` int(10) unsigned NOT NULL,
  `order_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`widget_id`,`cms_id`),
  KEY `cms_id` (`cms_id`),
  CONSTRAINT `cms_widget_mapper_ibfk_1` FOREIGN KEY (`widget_id`) REFERENCES `cms_widget` (`widget_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_widget_mapper_ibfk_2` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
