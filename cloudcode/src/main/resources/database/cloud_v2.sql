/*
SQLyog v10.2 
MySQL - 5.5.28 : Database - base
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`base` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `base`;

/*Table structure for table `tb_device` */

DROP TABLE IF EXISTS `tb_device`;

CREATE TABLE `tb_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) DEFAULT NULL COMMENT '设备名称',
  `port_a` int(11) DEFAULT NULL COMMENT '绑定端口',
  `port_c` int(11) DEFAULT NULL COMMENT '状态',
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_device` */

/*Table structure for table `tb_relation` */

DROP TABLE IF EXISTS `tb_relation`;

CREATE TABLE `tb_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `device_id` int(11) DEFAULT NULL COMMENT '设备id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_relation` */

/*Table structure for table `tb_resource` */

DROP TABLE IF EXISTS `tb_resource`;

CREATE TABLE `tb_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `is_hide` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `source_key` varchar(255) DEFAULT NULL,
  `source_url` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKf5ra2gn0xedeida2op8097sr5` (`parent_id`),
  CONSTRAINT `FKf5ra2gn0xedeida2op8097sr5` FOREIGN KEY (`parent_id`) REFERENCES `tb_resource` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `tb_resource` */

insert  into `tb_resource`(`id`,`create_time`,`description`,`icon`,`is_hide`,`level`,`name`,`sort`,`source_key`,`source_url`,`type`,`update_time`,`parent_id`) values (0,'2017-01-10 13:56:51','系统管理',NULL,0,1,'系统管理',1,'system','javascript:void(0);',1,'2017-01-10 13:59:01',NULL),(1,'2017-01-10 13:56:51','用户管理',NULL,0,2,'用户管理',1,'system:user:index','/admin/user/index',1,'2017-01-10 13:59:01',0),(2,'2017-01-10 13:56:51','用户编辑',NULL,0,3,'用户编辑',1,'system:user:edit','/admin/user/edit*',2,'2017-01-10 16:26:42',1),(3,'2017-01-11 16:48:48','用户添加',NULL,0,3,'用户添加',2,'system:user:add','/admin/user/add',2,'2017-01-11 16:49:26',1),(4,'2017-01-11 16:48:48','用户删除',NULL,0,3,'用户删除',3,'system:user:deleteBatch','/admin/user/deleteBatch',2,'2017-01-18 14:11:41',1),(5,'2017-01-11 16:48:48','角色分配',NULL,0,3,'角色分配',4,'system:user:grant','/admin/user/grant/**',2,'2017-01-18 14:11:51',1),(6,'2017-01-12 16:45:10','角色管理',NULL,0,2,'角色管理',2,'system:role:index','/admin/role/index',1,'2017-01-12 16:46:52',0),(7,'2017-01-12 16:47:02','角色编辑',NULL,0,3,'角色编辑',1,'system:role:edit','/admin/role/edit*',2,'2017-01-18 10:24:06',1),(8,'2017-01-12 16:47:23','角色添加',NULL,0,3,'角色添加',2,'system:role:add','/admin/role/add',2,'2017-01-12 16:49:16',6),(9,'2017-01-12 16:47:23','角色删除',NULL,0,3,'角色删除',3,'system:role:deleteBatch','/admin/role/deleteBatch',2,'2017-01-18 14:12:03',6),(10,'2017-01-12 16:47:23','资源分配',NULL,0,3,'资源分配',4,'system:role:grant','/admin/role/grant/**',2,'2017-01-18 14:12:11',6),(11,'2017-01-17 11:21:12','资源管理',NULL,0,2,'资源管理',3,'system:resource:index','/admin/resource/index',1,'2017-01-17 11:21:42',0),(12,'2017-01-17 11:21:52','资源编辑',NULL,0,3,'资源编辑',1,'system:resource:edit','/admin/resource/edit*',2,'2017-01-17 11:22:36',11),(13,'2017-01-17 11:21:54','资源添加',NULL,0,3,'资源添加',2,'system:resource:add','/admin/resource/add',2,'2017-01-17 11:22:39',11),(14,'2017-01-17 11:21:54','资源删除',NULL,0,3,'资源删除',3,'system:resource:deleteBatch','/admin/resource/deleteBatch',2,'2017-01-18 14:12:31',11);

/*Table structure for table `tb_role` */

DROP TABLE IF EXISTS `tb_role`;

CREATE TABLE `tb_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role_key` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tb_role` */

insert  into `tb_role`(`id`,`create_time`,`description`,`name`,`role_key`,`status`,`update_time`) values (1,'2017-01-09 17:25:30','超级管理员','administrator','administrator',0,'2018-04-09 17:26:25');

/*Table structure for table `tb_role_resource` */

DROP TABLE IF EXISTS `tb_role_resource`;

CREATE TABLE `tb_role_resource` (
  `role_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`resource_id`),
  KEY `FK868kc8iic48ilv5npa80ut6qo` (`resource_id`),
  CONSTRAINT `FK7ffc7h6obqxflhj1aq1mk20jk` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`),
  CONSTRAINT `FK868kc8iic48ilv5npa80ut6qo` FOREIGN KEY (`resource_id`) REFERENCES `tb_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_role_resource` */

insert  into `tb_role_resource`(`role_id`,`resource_id`) values (1,0),(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14);

/*Table structure for table `tb_user` */

DROP TABLE IF EXISTS `tb_user`;

CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `delete_status` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `locked` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `tb_user` */

insert  into `tb_user`(`id`,`user_name`,`password`,`nick_name`,`avatar`,`delete_status`,`description`,`email`,`locked`,`create_time`,`update_time`) values (1,'admin','114CNIIUINKMJK72AA1P5807U3','admin','/assets/img/touxiang.PNG',0,'超级管理员','1164712029@qq.com',0,'2018-04-09 17:26:41','2018-04-13 16:52:27'),(2,'xuezhen','3931MUEQD1939MQMLM4AISPVNE','Jerry',NULL,0,NULL,NULL,0,'2018-04-19 17:05:31','2018-04-19 17:05:31'),(7,'test','UUKHSDDI5KPA43A8VL06V0TU2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'test123','UUKHSDDI5KPA43A8VL06V0TU2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `tb_user_role` */

DROP TABLE IF EXISTS `tb_user_role`;

CREATE TABLE `tb_user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FKea2ootw6b6bb0xt3ptl28bymv` (`role_id`),
  CONSTRAINT `FK7vn3h53d0tqdimm8cp45gc0kl` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`),
  CONSTRAINT `FKea2ootw6b6bb0xt3ptl28bymv` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_user_role` */

insert  into `tb_user_role`(`user_id`,`role_id`) values (1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
