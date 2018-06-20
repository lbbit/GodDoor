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
/*Table structure for table `tb_device` */

DROP TABLE IF EXISTS `tb_device`;

CREATE TABLE `tb_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) DEFAULT NULL COMMENT '设备名称',
  `port_a` int(11) DEFAULT NULL COMMENT '绑定端口',
  `port_c` int(11) DEFAULT NULL COMMENT '状态',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_device` */

insert  into `tb_device`(`id`,`name`,`port_a`,`port_c`,`update_time`) values (1,'1',1001,10003,'2018-05-27 17:19:50'),(2,'100',10001,10002,'2018-06-06 22:53:37');

/*Table structure for table `tb_relation` */

DROP TABLE IF EXISTS `tb_relation`;

CREATE TABLE `tb_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `device_id` int(11) DEFAULT NULL COMMENT '设备id',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `tb_relation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`),
  CONSTRAINT `tb_relation_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `tb_device` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_relation` */

/*Table structure for table `tb_resource` */

DROP TABLE IF EXISTS `tb_resource`;

CREATE TABLE `tb_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `source_key` varchar(255) DEFAULT NULL,
  `source_url` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `is_hide` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKf5ra2gn0xedeida2op8097sr5` (`parent_id`),
  CONSTRAINT `FKf5ra2gn0xedeida2op8097sr5` FOREIGN KEY (`parent_id`) REFERENCES `tb_resource` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `tb_resource` */

insert  into `tb_resource`(`id`,`name`,`source_key`,`source_url`,`level`,`sort`,`parent_id`,`icon`,`type`,`is_hide`,`description`,`create_time`,`update_time`) values (0,'云平台管理','system','javascript:void(0);',1,1,NULL,NULL,1,0,'系统管理','2017-01-10 13:56:51','2018-05-26 16:46:00'),(1,'用户管理','system:user:index','/admin/user/index',2,1,0,NULL,1,0,'用户管理','2017-01-10 13:56:51','2018-01-10 13:59:01'),(2,'用户编辑','system:user:edit','/admin/user/edit*',3,1,1,NULL,2,0,'用户编辑','2017-01-10 13:56:51','2018-01-10 16:26:42'),(3,'用户添加','system:user:add','/admin/user/add',3,2,1,NULL,2,0,'用户添加','2017-01-11 16:48:48','2018-01-11 16:49:26'),(4,'用户删除','system:user:deleteBatch','/admin/user/deleteBatch',3,3,1,NULL,2,0,'用户删除','2017-01-11 16:48:48','2018-01-18 14:11:41'),(5,'角色分配','system:user:grant','/admin/user/grant/**',3,4,1,NULL,2,0,'角色分配','2017-01-11 16:48:48','2018-01-18 14:11:51'),(6,'角色管理','system:role:index','/admin/role/index',2,2,0,NULL,1,0,'角色管理','2017-01-12 16:45:10','2018-01-12 16:46:52'),(7,'角色编辑','system:role:edit','/admin/role/edit*',3,1,1,NULL,2,0,'角色编辑','2017-01-12 16:47:02','2018-01-18 10:24:06'),(8,'角色添加','system:role:add','/admin/role/add',3,2,6,NULL,2,0,'角色添加','2017-01-12 16:47:23','2018-01-12 16:49:16'),(9,'角色删除','system:role:deleteBatch','/admin/role/deleteBatch',3,3,6,NULL,2,0,'角色删除','2017-01-12 16:47:23','2018-01-18 14:12:03'),(10,'资源分配','system:role:grant','/admin/role/grant/**',3,4,6,NULL,2,0,'资源分配','2017-01-12 16:47:23','2018-01-18 14:12:11'),(11,'资源管理','system:resource:index','/admin/resource/index',2,3,0,NULL,1,0,'资源管理','2017-01-17 11:21:12','2018-01-17 11:21:42'),(12,'资源编辑','system:resource:edit','/admin/resource/edit*',3,1,11,NULL,2,0,'资源编辑','2017-01-17 11:21:52','2018-01-17 11:22:36'),(13,'资源添加','system:resource:add','/admin/resource/add',3,2,11,NULL,2,0,'资源添加','2017-01-17 11:21:54','2018-01-17 11:22:39'),(14,'资源删除','system:resource:deleteBatch','/admin/resource/deleteBatch',3,3,11,NULL,2,0,'资源删除','2017-01-17 11:21:54','2018-01-18 14:12:31'),(15,'设备管理','system:dev:index','/admin/dev/index',2,4,0,NULL,1,0,'设备管理','2018-04-27 16:50:11','2018-05-27 16:50:11'),(16,'设备编辑','system:dev:edit','/admin/dev/show*',3,1,15,NULL,2,0,'设备编辑','2018-04-27 17:22:40','2018-05-27 17:24:01'),(17,'设备删除','system:dev:delete','/admin/dev/delete',3,2,15,NULL,2,0,'设备删除','2018-04-27 17:24:49','2018-05-27 17:25:07');

/*Table structure for table `tb_role` */

DROP TABLE IF EXISTS `tb_role`;

CREATE TABLE `tb_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `role_key` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tb_role` */

insert  into `tb_role`(`id`,`name`,`role_key`,`status`,`description`,`create_time`,`update_time`) values (1,'administrator','administrator',0,'超级管理员','2018-04-09 17:25:30','2018-04-09 17:26:25'),(2,'云平台管理员','user_manager',0,'云平台管理员','2018-06-06 17:14:39','2018-06-06 17:51:11');

/*Table structure for table `tb_role_resource` */

DROP TABLE IF EXISTS `tb_role_resource`;

CREATE TABLE `tb_role_resource` (
  `role_id` int(11) DEFAULT NULL,
  `resource_id` int(11) DEFAULT NULL,
  KEY `FK868kc8iic48ilv5npa80ut6qo` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_role_resource` */

insert  into `tb_role_resource`(`role_id`,`resource_id`) values (1,0),(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(2,NULL),(2,15),(2,2),(2,1),(2,5),(2,3),(2,4),(2,16),(2,17),(2,7),(2,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `tb_user` */

insert  into `tb_user`(`id`,`user_name`,`password`,`nick_name`,`avatar`,`delete_status`,`description`,`email`,`locked`,`create_time`,`update_time`) values (1,'admin','114CNIIUINKMJK72AA1P5807U3','admin','/assets/img/touxiang.PNG',0,'超级管理员','1164712029@qq.com',0,'2018-04-09 17:26:41','2018-05-27 17:02:47'),(2,'xuezhen','114CNIIUINKMJK72AA1P5807U3','Jerry','/assets/img/touxiang.PNG',0,'test用户',NULL,0,'2018-04-19 17:05:31','2018-04-19 17:05:31'),(7,'test','UUKHSDDI5KPA43A8VL06V0TU2','test','/assets/img/touxiang.PNG',NULL,'测试用户',NULL,0,'2018-04-20 17:05:31','2018-06-06 17:13:14'),(8,'test123','UUKHSDDI5KPA43A8VL06V0TU2','123123','/assets/img/touxiang.PNG',NULL,'222222',NULL,0,'2018-04-22 17:05:31','2018-06-06 17:13:37'),(9,'testUser','UUKHSDDI5KPA43A8VL06V0TU2','testUser','/assets/img/touxiang.PNG',0,NULL,NULL,0,'2018-05-28 10:34:38','2018-05-28 10:34:38');

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

insert  into `tb_user_role`(`user_id`,`role_id`) values (1,1),(2,2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
