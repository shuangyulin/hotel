-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `cardNumber` varchar(30)  NOT NULL COMMENT '身份证号',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_roomType` (
  `roomTypeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '类型id',
  `roomTypeName` varchar(20)  NOT NULL COMMENT '房间类型',
  `price` float NOT NULL COMMENT '价格(每天)',
  PRIMARY KEY (`roomTypeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_room` (
  `roomNo` varchar(20)  NOT NULL COMMENT 'roomNo',
  `roomTypeObj` int(11) NOT NULL COMMENT '房间类型',
  `roomPhoto` varchar(60)  NOT NULL COMMENT '房间图片',
  `roomPrice` float NOT NULL COMMENT '价格(每天)',
  `floorNum` varchar(20)  NOT NULL COMMENT '楼层',
  `roomState` varchar(20)  NOT NULL COMMENT '占用状态',
  `roomDesc` varchar(5000)  NOT NULL COMMENT '房间描述',
  PRIMARY KEY (`roomNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_bookOrder` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `roomObj` varchar(20)  NOT NULL COMMENT '预订房间',
  `roomTypeObj` int(11) NOT NULL COMMENT '房间类型',
  `userObj` varchar(30)  NOT NULL COMMENT '预订人',
  `liveDate` varchar(20)  NULL COMMENT '入住日期',
  `days` int(11) NOT NULL COMMENT '预订天数',
  `totalMoney` float NOT NULL COMMENT '总价',
  `orderMemo` varchar(500)  NULL COMMENT '订单备注',
  `orderState` varchar(20)  NOT NULL COMMENT '订单状态',
  `orderTime` varchar(20)  NULL COMMENT '预订时间',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80)  NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000)  NOT NULL COMMENT '留言内容',
  `userObj` varchar(30)  NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20)  NULL COMMENT '留言时间',
  `replyContent` varchar(1000)  NULL COMMENT '管理回复',
  `replyTime` varchar(20)  NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80)  NOT NULL COMMENT '标题',
  `content` varchar(5000)  NOT NULL COMMENT '公告内容',
  `hitNum` int(11) NOT NULL COMMENT '点击率',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_room ADD CONSTRAINT FOREIGN KEY (roomTypeObj) REFERENCES t_roomType(roomTypeId);
ALTER TABLE t_bookOrder ADD CONSTRAINT FOREIGN KEY (roomObj) REFERENCES t_room(roomNo);
ALTER TABLE t_bookOrder ADD CONSTRAINT FOREIGN KEY (roomTypeObj) REFERENCES t_roomType(roomTypeId);
ALTER TABLE t_bookOrder ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_leaveword ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);


