-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 2018-06-05 16:11:14
-- 服务器版本： 5.5.60-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `base`
--
CREATE DATABASE IF NOT EXISTS `base` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `base`;

-- --------------------------------------------------------

--
-- 表的结构 `tb_device`
--

CREATE TABLE `tb_device` (
  `id` int(11) NOT NULL,
  `name` varchar(55) DEFAULT NULL COMMENT '设备名称',
  `port_a` int(11) DEFAULT NULL COMMENT '绑定端口',
  `port_c` int(11) DEFAULT NULL COMMENT '状态',
  `update_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tb_device`
--

INSERT INTO `tb_device` (`id`, `name`, `port_a`, `port_c`, `update_time`) VALUES
(1, '1', 10003, 10002, '2018-05-12 12:00:00'),
(2, '650', 11301, 11300, '2018-05-26 20:43:18'),
(3, '10', 10021, 10020, '2018-05-10 10:17:00'),
(4, '676', 11353, 11352, '2018-05-14 19:05:05'),
(5, '271', 10543, 10542, '2018-05-14 19:13:55'),
(7, '716', 11433, 11432, '2018-05-14 20:20:46'),
(9, '222', 10445, 10444, '2018-05-16 17:51:28'),
(10, '760', 11521, 11520, '2018-06-03 10:30:16'),
(11, '44', 10089, 10088, '2018-06-03 23:58:04'),
(12, '578', 11157, 11156, '2018-06-04 08:51:34');

-- --------------------------------------------------------

--
-- 表的结构 `tb_relation`
--

CREATE TABLE `tb_relation` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `device_id` int(11) DEFAULT NULL COMMENT '设备id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tb_relation`
--

INSERT INTO `tb_relation` (`id`, `user_id`, `device_id`) VALUES
(6, 9, 2),
(9, 9, 10),
(10, 9, 9),
(11, 9, 11),
(12, 9, 12);

-- --------------------------------------------------------

--
-- 表的结构 `tb_resource`
--

CREATE TABLE `tb_resource` (
  `id` int(11) NOT NULL,
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
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tb_resource`
--

INSERT INTO `tb_resource` (`id`, `create_time`, `description`, `icon`, `is_hide`, `level`, `name`, `sort`, `source_key`, `source_url`, `type`, `update_time`, `parent_id`) VALUES
(0, '2017-01-10 13:56:51', '系统管理', NULL, 0, 1, '系统管理', 1, 'system', 'javascript:void(0);', 1, '2017-01-10 13:59:01', NULL),
(1, '2017-01-10 13:56:51', '用户管理', NULL, 0, 2, '用户管理', 1, 'system:user:index', '/admin/user/index', 1, '2017-01-10 13:59:01', 0),
(2, '2017-01-10 13:56:51', '用户编辑', NULL, 0, 3, '用户编辑', 1, 'system:user:edit', '/admin/user/edit*', 2, '2017-01-10 16:26:42', 1),
(3, '2017-01-11 16:48:48', '用户添加', NULL, 0, 3, '用户添加', 2, 'system:user:add', '/admin/user/add', 2, '2017-01-11 16:49:26', 1),
(4, '2017-01-11 16:48:48', '用户删除', NULL, 0, 3, '用户删除', 3, 'system:user:deleteBatch', '/admin/user/deleteBatch', 2, '2017-01-18 14:11:41', 1),
(5, '2017-01-11 16:48:48', '角色分配', NULL, 0, 3, '角色分配', 4, 'system:user:grant', '/admin/user/grant/**', 2, '2017-01-18 14:11:51', 1),
(6, '2017-01-12 16:45:10', '角色管理', NULL, 0, 2, '角色管理', 2, 'system:role:index', '/admin/role/index', 1, '2017-01-12 16:46:52', 0),
(7, '2017-01-12 16:47:02', '角色编辑', NULL, 0, 3, '角色编辑', 1, 'system:role:edit', '/admin/role/edit*', 2, '2017-01-18 10:24:06', 1),
(8, '2017-01-12 16:47:23', '角色添加', NULL, 0, 3, '角色添加', 2, 'system:role:add', '/admin/role/add', 2, '2017-01-12 16:49:16', 6),
(9, '2017-01-12 16:47:23', '角色删除', NULL, 0, 3, '角色删除', 3, 'system:role:deleteBatch', '/admin/role/deleteBatch', 2, '2017-01-18 14:12:03', 6),
(10, '2017-01-12 16:47:23', '资源分配', NULL, 0, 3, '资源分配', 4, 'system:role:grant', '/admin/role/grant/**', 2, '2017-01-18 14:12:11', 6),
(11, '2017-01-17 11:21:12', '资源管理', NULL, 0, 2, '资源管理', 3, 'system:resource:index', '/admin/resource/index', 1, '2017-01-17 11:21:42', 0),
(12, '2017-01-17 11:21:52', '资源编辑', NULL, 0, 3, '资源编辑', 1, 'system:resource:edit', '/admin/resource/edit*', 2, '2017-01-17 11:22:36', 11),
(13, '2017-01-17 11:21:54', '资源添加', NULL, 0, 3, '资源添加', 2, 'system:resource:add', '/admin/resource/add', 2, '2017-01-17 11:22:39', 11),
(14, '2017-01-17 11:21:54', '资源删除', NULL, 0, 3, '资源删除', 3, 'system:resource:deleteBatch', '/admin/resource/deleteBatch', 2, '2017-01-18 14:12:31', 11);

-- --------------------------------------------------------

--
-- 表的结构 `tb_role`
--

CREATE TABLE `tb_role` (
  `id` int(11) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role_key` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tb_role`
--

INSERT INTO `tb_role` (`id`, `create_time`, `description`, `name`, `role_key`, `status`, `update_time`) VALUES
(1, '2017-01-09 17:25:30', '超级管理员', 'administrator', 'administrator', 0, '2018-04-09 17:26:25');

-- --------------------------------------------------------

--
-- 表的结构 `tb_role_resource`
--

CREATE TABLE `tb_role_resource` (
  `role_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tb_role_resource`
--

INSERT INTO `tb_role_resource` (`role_id`, `resource_id`) VALUES
(1, 0),
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14);

-- --------------------------------------------------------

--
-- 表的结构 `tb_user`
--

CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nick_name` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `delete_status` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `locked` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tb_user`
--

INSERT INTO `tb_user` (`id`, `user_name`, `password`, `nick_name`, `avatar`, `delete_status`, `description`, `email`, `locked`, `create_time`, `update_time`) VALUES
(1, 'admin', '114CNIIUINKMJK72AA1P5807U3', 'admin', '/assets/img/touxiang.PNG', 0, '超级管理员', '1164712029@qq.com', 0, '2018-04-09 17:26:41', '2018-04-13 16:52:27'),
(2, 'xuezhen', '3931MUEQD1939MQMLM4AISPVNE', 'Jerry', NULL, 0, NULL, NULL, 0, '2018-04-19 17:05:31', '2018-04-19 17:05:31'),
(7, 'test', 'UUKHSDDI5KPA43A8VL06V0TU2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'test123', 'UUKHSDDI5KPA43A8VL06V0TU2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'lbb', '4297f44b13955235245b2497399d7a93', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'test1', 'cc03e747a6afbbcbf8be7668acfebee5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'test2', '4297f44b13955235245b2497399d7a93', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `tb_user_role`
--

CREATE TABLE `tb_user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `tb_user_role`
--

INSERT INTO `tb_user_role` (`user_id`, `role_id`) VALUES
(1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_device`
--
ALTER TABLE `tb_device`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_relation`
--
ALTER TABLE `tb_relation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_resource`
--
ALTER TABLE `tb_resource`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKf5ra2gn0xedeida2op8097sr5` (`parent_id`);

--
-- Indexes for table `tb_role`
--
ALTER TABLE `tb_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_role_resource`
--
ALTER TABLE `tb_role_resource`
  ADD PRIMARY KEY (`role_id`,`resource_id`),
  ADD KEY `FK868kc8iic48ilv5npa80ut6qo` (`resource_id`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_user_role`
--
ALTER TABLE `tb_user_role`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `FKea2ootw6b6bb0xt3ptl28bymv` (`role_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `tb_device`
--
ALTER TABLE `tb_device`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- 使用表AUTO_INCREMENT `tb_relation`
--
ALTER TABLE `tb_relation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- 使用表AUTO_INCREMENT `tb_resource`
--
ALTER TABLE `tb_resource`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- 使用表AUTO_INCREMENT `tb_role`
--
ALTER TABLE `tb_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 限制导出的表
--

--
-- 限制表 `tb_resource`
--
ALTER TABLE `tb_resource`
  ADD CONSTRAINT `FKf5ra2gn0xedeida2op8097sr5` FOREIGN KEY (`parent_id`) REFERENCES `tb_resource` (`id`);

--
-- 限制表 `tb_role_resource`
--
ALTER TABLE `tb_role_resource`
  ADD CONSTRAINT `FK7ffc7h6obqxflhj1aq1mk20jk` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`),
  ADD CONSTRAINT `FK868kc8iic48ilv5npa80ut6qo` FOREIGN KEY (`resource_id`) REFERENCES `tb_resource` (`id`);

--
-- 限制表 `tb_user_role`
--
ALTER TABLE `tb_user_role`
  ADD CONSTRAINT `FK7vn3h53d0tqdimm8cp45gc0kl` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`),
  ADD CONSTRAINT `FKea2ootw6b6bb0xt3ptl28bymv` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
