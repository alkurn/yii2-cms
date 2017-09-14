/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.19-0ubuntu0.17.04.1 : Database - castinq
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

/*Data for the table `cms_block` */

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

/*Data for the table `cms_block_mapper` */

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

/*Data for the table `cms_category` */

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

/*Data for the table `cms_category_mapper` */

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

/*Data for the table `cms_category_path` */

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

/*Data for the table `cms_comments` */

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

/*Data for the table `cms_field` */

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

/*Data for the table `cms_field_option` */

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

/*Data for the table `cms_field_value` */

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

/*Data for the table `cms_gallary` */

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

/*Data for the table `cms_gallary_item` */

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

/*Data for the table `cms_item` */

insert  into `cms_item`(`id`,`user_id`,`parent_id`,`layout_id`,`type_id`,`slug`,`external_url`,`title`,`content`,`image`,`media`,`location`,`latitude`,`longitude`,`restricted`,`status`,`meta_title`,`meta_description`,`meta_keywords`,`modified_date`,`created_at`) values (1,2,NULL,1,1,'about-us',NULL,'About us','<div>\r\n<div class=\"row\">\r\n<div class=\"col-sm-12\">\r\n<div class=\"abouttop\">\r\n<p>Welcome to Castinq,</p>\r\n\r\n<div class=\"content\">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</div>\r\n</div>\r\n\r\n<div class=\"aboutbottom\">\r\n<p>THE New Way</p>\r\n<img alt=\"\" src=\"http://castinq.alkurn.info/images/about-way.jpg\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n','C/1/S/w/N/e/f/H/C1SwNefHn5Bu_vNS-o0H3o-uTZ2UnaTA.jpg',NULL,NULL,NULL,NULL,0,1,'About us','About us','About us','2017-06-16 12:17:13',1503054473),(2,2,NULL,1,1,'terms-of-use',NULL,'Terms Of Use','<p><strong>hello Content Coming Soon&hellip;! test page</strong></p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. test</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'Terms Of Use','Terms Of Use','Terms Of Use','2017-06-16 12:26:34',1503056573),(3,1,NULL,1,1,'faq',NULL,'Faq','<div class=\"faqsection\">\r\n<div class=\"row\">\r\n<div class=\"col-sm-12\">\r\n<ul class=\"nav nav-pills text-center\">\r\n	<li><a href=\"#faqtalent\">FAQ for Talent</a></li>\r\n	<li class=\"active\"><a href=\"#faqmanager\">FAQ for Casting Manager</a></li>\r\n</ul>\r\n\r\n<div class=\"tab-content\">\r\n<div class=\"tab-pane fade\" id=\"faqtalent\">\r\n<div class=\"panel-group\" id=\"accordion\">\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a class=\"collapsed\" href=\"#collapse1\">1. Account</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse\" id=\"collapse1\" style=\"height: 0px;\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a class=\"collapsed\" href=\"#collapse2\">2. Can I change my Profile images?</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse\" id=\"collapse2\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a class=\"collapsed\" href=\"#collapse3\">3. Can I Become a Casting Manager?</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse\" id=\"collapse3\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a class=\"collapsed\" href=\"#collapse4\">4. Can I Change my Body Information?</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse\" id=\"collapse4\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a class=\"collapsed\" href=\"#collapse5\">5. How Can I Upload Videos</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse\" id=\"collapse5\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n\r\n<div class=\"panel-body\">New step for video upload</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"tab-pane fade active in\" id=\"faqmanager\">\r\n<div class=\"panel-group\" id=\"accordion2\">\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a href=\"#mancollapse1\">1. Account</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse in\" id=\"mancollapse1\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a href=\"#mancollapse2\">2. Can I change my Profile images?</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse in\" id=\"mancollapse2\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a href=\"#mancollapse3\">3. Can I Become a Casting Manager?</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse in\" id=\"mancollapse3\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a href=\"#mancollapse4\">4. Can I Change my Body Information?</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse\" id=\"mancollapse4\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n</div>\r\n</div>\r\n\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<p><a href=\"#mancollapse5\">5. How Can I Upload Videos</a></p>\r\n</div>\r\n\r\n<div class=\"panel-collapse collapse\" id=\"mancollapse5\">\r\n<div class=\"panel-body\">Yes you can edit your profile by going to the &quot;My account&quot; section and adding or removing your personal information from your account.</div>\r\n\r\n<div class=\"panel-body\">ok test</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'Faq','Faq','Faq','2017-06-16 13:07:24',1503477342),(5,2,NULL,1,1,'privacy-policy',NULL,'Privacy Policy','<p><strong>hello Content Coming Soon&hellip;!</strong></p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. test</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'Privacy Policy','Privacy Policy','Privacy Policy','2017-06-16 13:08:41',1503056576),(6,2,NULL,1,1,'support',NULL,'Support','<p><strong>test Content Coming Soon&hellip;!</strong></p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'Support','Support','Support','2017-06-16 13:09:01',1503056579),(7,2,NULL,1,2,'a-home-for-your-brand',NULL,'A home for your brand','<p>Personal or professional</p>\r\n\r\n<p>Select from hundreds of beautiful and customizable blog themes to give your blog a unique look.</p>\r\n\r\n<p>Perfectly personalized</p>\r\n\r\n<p>Change the layout, colors, and background of your blog, and add powerful widgets to engage with followers, fans, and friends.</p>\r\n','7/y/l/D/6/I/C/x/7ylD6ICxrU2p8M4cBBUSpoN2lbTQ11s-.png',NULL,NULL,NULL,NULL,0,1,'Change the layout, colors, and background of your blog, and add powerful widgets to engage with followers, fans, and friends.','Change the layout, colors, and background of your blog, and add powerful widgets to engage with followers, fans, and friends.','Change the layout, colors, and background of your blog, and add powerful widgets to engage with followers, fans, and friends.','2017-07-06 11:20:00',1501846624),(8,2,NULL,1,2,'an-all-new-media-library-for-the-ios-app',NULL,'An All-New Media Library for the iOS App','<p>We recently launched an all-new media picker for&nbsp; Android. Now, iOS users, you&rsquo;re next! The new 7.8 release for iOS includes a top-level Media Library section for each site you manage &mdash; making it even easier to share your images, video, and other media with the world.</p>\r\n\r\n<p>With just one tap from your site&rsquo;s details menu, you can view all your media, search, edit metadata, delete items, and upload new items.</p>\r\n','g/8/v/U/P/b/L/H/g8vUPbLH2uAIGewrhOnSyHqwMS-yJoWU.jpg',NULL,NULL,NULL,NULL,0,1,'An All-New Media Library for the iOS App','An All-New Media Library for the  iOS App','An All-New Media Library for the iOS App','2017-07-06 11:22:32',1501846945),(10,2,NULL,1,2,'test-blog-for-testing',NULL,'test blog for testing 123','<p>test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only&nbsp;test content lorem poram test only &nbsp;123</p>\r\n','m/q/-/-/z/G/C/7/mq--zGC7c3YqzNDaP8I-6HzHjE4re7zl.png',NULL,NULL,NULL,NULL,0,1,'test 12','test','test','2017-08-09 08:51:03',1502283247),(11,2,NULL,1,2,'test',NULL,'test','<p>test</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'ts','ts','edt','2017-08-09 08:55:03',1502283303),(13,2,NULL,1,2,'test-2',NULL,'test','<p>test 123</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'test','tst','test','2017-08-16 05:35:58',1502876229),(14,2,NULL,1,2,'new-blog',NULL,'New blog','<p>test</p>\r\n','t/v/T/A/k/H/L/n/tvTAkHLnfAno13bWFPH_F0rOzlbxwnxf.jpg',NULL,NULL,NULL,NULL,0,1,'test','test','test','2017-08-16 05:39:04',1502876344),(15,2,NULL,1,2,'new-blog-for-testing',NULL,'New blog for testing','<p>test blog</p>\r\n','x/X/N/e/7/i/C/8/xXNe7iC8Y1mO3FtrWiC7oxJFTTT5PpuE.jpg',NULL,NULL,NULL,NULL,0,1,'test','tst','test','2017-08-18 05:53:56',1503050110),(16,2,NULL,1,2,'new',NULL,'new','<p>new</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'new','new','new','2017-08-18 05:57:34',1503050254),(17,2,NULL,1,2,'for-pagination',NULL,'for pagination','<p>test</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'test','test','test','2017-08-18 05:58:21',1503050301),(18,2,NULL,1,2,'blog',NULL,'blog','<p>test</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'test','test','tes','2017-08-18 05:58:45',1503050325),(19,2,NULL,1,1,'page-2',NULL,'page 2','<p>page2</p>\r\n',NULL,NULL,NULL,NULL,NULL,0,1,'ok','ok','ok','2017-08-18 05:59:14',1503050354);

/*Table structure for table `cms_keyword` */

DROP TABLE IF EXISTS `cms_keyword`;

CREATE TABLE `cms_keyword` (
  `keyword_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cms_keyword` */

/*Table structure for table `cms_layout` */

DROP TABLE IF EXISTS `cms_layout`;

CREATE TABLE `cms_layout` (
  `layout_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`layout_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `cms_layout` */

insert  into `cms_layout`(`layout_id`,`name`) values (1,'one-column');

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

/*Data for the table `cms_media` */

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

/*Data for the table `cms_menu` */

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

/*Data for the table `cms_menu_path` */

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

/*Data for the table `cms_path` */

/*Table structure for table `cms_ratting` */

DROP TABLE IF EXISTS `cms_ratting`;

CREATE TABLE `cms_ratting` (
  `cms_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ratting` varchar(250) CHARACTER SET utf8 NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cms_id`),
  CONSTRAINT `cms_ratting_ibfk_1` FOREIGN KEY (`cms_id`) REFERENCES `cms_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

/*Data for the table `cms_ratting` */

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

/*Data for the table `cms_relation` */

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

/*Data for the table `cms_reviews` */

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

/*Data for the table `cms_to_user` */

/*Table structure for table `cms_type` */

DROP TABLE IF EXISTS `cms_type`;

CREATE TABLE `cms_type` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `cms_type` */

insert  into `cms_type`(`type_id`,`type`) values (1,'page'),(2,'blog');

/*Table structure for table `cms_widget` */

DROP TABLE IF EXISTS `cms_widget`;

CREATE TABLE `cms_widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `widget` varchar(250) NOT NULL,
  `data` text,
  PRIMARY KEY (`widget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cms_widget` */

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

/*Data for the table `cms_widget_mapper` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
