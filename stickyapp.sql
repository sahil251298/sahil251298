/*
MySQL Backup
Source Server Version: 5.1.31
Source Database: stickyapp
Date: 11/06/2017 03:24:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `filedetails`
-- ----------------------------
DROP TABLE IF EXISTS `filedetails`;
CREATE TABLE `filedetails` (
  `filename` varchar(100) DEFAULT NULL,
  `filecontent` varchar(4000) DEFAULT NULL,
  `createddate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records 
-- ----------------------------
