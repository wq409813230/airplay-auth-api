/*
Navicat MySQL Data Transfer

Source Server         : avtiviti
Source Server Version : 50624
Source Host           : 192.168.2.91:3306
Source Database       : auth

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2019-02-25 18:41:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for agency
-- ----------------------------
DROP TABLE IF EXISTS `agency`;
CREATE TABLE `agency` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '商家编码',
  `AGENCY_NAME` varchar(50) NOT NULL COMMENT '商家名称',
  `AGENCY_ALIAS` varchar(50) DEFAULT NULL COMMENT '商家别名',
  `AGENCY_DESC` varchar(255) DEFAULT NULL COMMENT '商家描述',
  `AVATAR` varchar(255) DEFAULT NULL COMMENT '机构头像',
  `BANNER` varchar(255) DEFAULT NULL COMMENT '店招横幅',
  `AGENCY_LEVEL` varchar(16) DEFAULT NULL COMMENT '商家级别',
  `PARENT_CODE` varchar(32) DEFAULT NULL COMMENT '父商家编码',
  `COORDINATE` varchar(64) DEFAULT NULL COMMENT '坐标',
  `COUNTRY` varchar(8) DEFAULT NULL COMMENT '国家代码',
  `PROVINCE` varchar(8) DEFAULT NULL COMMENT '省自治区代码',
  `CITY` varchar(8) DEFAULT NULL COMMENT '市代码',
  `REGION` varchar(8) DEFAULT NULL COMMENT '地区代码',
  `ADDRESS_DETAIL` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `AGENCY_ADDRESS` varchar(200) DEFAULT NULL COMMENT '完整商家地址',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `AGENCY_FAX` varchar(32) DEFAULT NULL COMMENT '传真',
  `LEGAL_PERSON` varchar(20) DEFAULT NULL COMMENT '机构法人',
  `LEGAL_MOBIL` varchar(32) DEFAULT NULL COMMENT '法人联系手机',
  `BUSINESS_HOURS_START` varchar(32) DEFAULT NULL COMMENT '营业时间开始',
  `BUSINESS_HOURS_END` varchar(32) DEFAULT NULL COMMENT '营业时间结束',
  `AGENCY_LICENSE` varchar(100) DEFAULT NULL COMMENT '机构执照号',
  `IS_APPROVED` varchar(1) DEFAULT NULL COMMENT '是否审核通过',
  `IS_PUBLISHED` varchar(1) DEFAULT NULL COMMENT '是否对外开放',
  `IS_LOGINABLE` varchar(1) DEFAULT NULL COMMENT '是否可登录',
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL DEFAULT 'A' COMMENT '数据状态 :I 非激活 /A  激活',
  `LOCK_STATUS` varchar(1) NOT NULL DEFAULT 'N' COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  UNIQUE KEY `INDEX_AGENCY_CODE` (`AGENCY_CODE`) USING BTREE,
  UNIQUE KEY `INDEX_AGENCY_NAME` (`AGENCY_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家基本信息表';

-- ----------------------------
-- Records of agency
-- ----------------------------
INSERT INTO `agency` VALUES ('1', 'SUPER_ADMIN', '智英实业', '智英实业', '智英实业', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016-07-19 19:06:03', 'A', 'A', 'N', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for agency_department
-- ----------------------------
DROP TABLE IF EXISTS `agency_department`;
CREATE TABLE `agency_department` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `DEPARTMENT_CODE` varchar(32) DEFAULT NULL COMMENT '部门编码',
  `DEPARTMENT_NAME` varchar(32) NOT NULL COMMENT '部门名称',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '机构编码',
  `PARENT_CODE` varchar(32) NOT NULL COMMENT '父部门UID',
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态 :I 非激活 /A  激活',
  `LOCK_STATUS` varchar(1) NOT NULL COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  KEY `INDEX_AGENCY_CODE` (`AGENCY_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家部门关系表';

-- ----------------------------
-- Records of agency_department
-- ----------------------------
INSERT INTO `agency_department` VALUES ('1099952308927660032', 'DEV', '研发部', 'SUPER_ADMIN', '-1', '2019-02-25 16:40:41', '9527', 'A', 'N', null, null, null, null, null, '');

-- ----------------------------
-- Table structure for agency_employee
-- ----------------------------
DROP TABLE IF EXISTS `agency_employee`;
CREATE TABLE `agency_employee` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '商家编码',
  `DEPARTMENT_CODE` varchar(32) NOT NULL COMMENT '部门外键',
  `USER_ID` bigint(20) NOT NULL COMMENT '系统内置用户ID,作为业务数据的关联外键',
  `EMPLOYEE_CODE` varchar(16) NOT NULL COMMENT '工号',
  `NEED_CHANGE_PASS` varchar(1) DEFAULT NULL COMMENT '是否需要修改密码',
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL DEFAULT 'A' COMMENT '数据状态 :I 非激活 /A  激活',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  UNIQUE KEY `INDEX_USERID` (`USER_ID`) USING BTREE,
  UNIQUE KEY `INDEX_AGENCY_CODE_EMPLOYEE_CODE` (`AGENCY_CODE`,`EMPLOYEE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家员工关系表';

-- ----------------------------
-- Records of agency_employee
-- ----------------------------
INSERT INTO `agency_employee` VALUES ('1099952418356989952', 'SUPER_ADMIN', 'DEV', '1099952418356989952', '10086', 'Y', '2019-02-25 18:26:52', '9527', 'A', '', '', '', '');

-- ----------------------------
-- Table structure for agency_snpt
-- ----------------------------
DROP TABLE IF EXISTS `agency_snpt`;
CREATE TABLE `agency_snpt` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '商家编码',
  `AGENCY_NAME` varchar(50) NOT NULL COMMENT '商家名称',
  `AGENCY_ALIAS` varchar(50) DEFAULT NULL COMMENT '商家别名',
  `AGENCY_DESC` varchar(255) DEFAULT NULL COMMENT '商家描述',
  `AVATAR` varchar(255) DEFAULT NULL COMMENT '机构头像',
  `BANNER` varchar(255) DEFAULT NULL COMMENT '店招横幅',
  `AGENCY_LEVEL` varchar(16) DEFAULT NULL COMMENT '商家级别',
  `PARENT_CODE` varchar(32) DEFAULT NULL COMMENT '父商家编码',
  `COORDINATE` varchar(64) DEFAULT NULL COMMENT '坐标',
  `COUNTRY` varchar(8) DEFAULT NULL COMMENT '国家代码',
  `PROVINCE` varchar(8) DEFAULT NULL COMMENT '省自治区代码',
  `CITY` varchar(8) DEFAULT NULL COMMENT '市代码',
  `REGION` varchar(8) DEFAULT NULL COMMENT '地区代码',
  `ADDRESS_DETAIL` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `AGENCY_ADDRESS` varchar(200) DEFAULT NULL COMMENT '完整商家地址',
  `PHONE` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `AGENCY_FAX` varchar(32) DEFAULT NULL COMMENT '传真',
  `LEGAL_PERSON` varchar(20) DEFAULT NULL COMMENT '机构法人',
  `LEGAL_MOBIL` varchar(32) DEFAULT NULL COMMENT '法人联系手机',
  `BUSINESS_HOURS_START` varchar(32) DEFAULT NULL COMMENT '营业时间开始',
  `BUSINESS_HOURS_END` varchar(32) DEFAULT NULL COMMENT '营业时间结束',
  `AGENCY_LICENSE` varchar(100) DEFAULT NULL COMMENT '机构执照号',
  `IS_APPROVED` varchar(1) DEFAULT NULL COMMENT '是否审核通过',
  `IS_PUBLISHED` varchar(1) DEFAULT NULL COMMENT '是否对外开放',
  `IS_LOGINABLE` varchar(1) DEFAULT NULL COMMENT '是否可登录',
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL DEFAULT 'A' COMMENT '数据状态 :I 非激活 /A  激活',
  `LOCK_STATUS` varchar(1) NOT NULL DEFAULT 'N' COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  `MASTER_SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '快照表主键',
  `MASTER_REC_DATE` datetime NOT NULL COMMENT '主记录创建时间',
  PRIMARY KEY (`SEQUENCE_NBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商家基本信息快照表';

-- ----------------------------
-- Records of agency_snpt
-- ----------------------------

-- ----------------------------
-- Table structure for asi_biz
-- ----------------------------
DROP TABLE IF EXISTS `asi_biz`;
CREATE TABLE `asi_biz` (
  `AGENCY_CODE` varchar(32) NOT NULL,
  `ENTITY_TYPE` varchar(32) NOT NULL,
  `GROUP_CODE` varchar(255) NOT NULL,
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态',
  `REC_USER_ID` varchar(16) NOT NULL COMMENT '创建者',
  PRIMARY KEY (`AGENCY_CODE`,`ENTITY_TYPE`,`GROUP_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asi_biz
-- ----------------------------

-- ----------------------------
-- Table structure for asi_column_template
-- ----------------------------
DROP TABLE IF EXISTS `asi_column_template`;
CREATE TABLE `asi_column_template` (
  `AGENCY_CODE` varchar(32) NOT NULL,
  `COLUMN_CODE` varchar(255) NOT NULL,
  `COLUMN_NAME` varchar(255) DEFAULT NULL,
  `DATA_TYPE` varchar(16) NOT NULL,
  `MAX_LENGTH` int(11) DEFAULT NULL,
  `IS_REQUIRED` varchar(1) NOT NULL,
  `DISPLAY_ORDER` int(11) NOT NULL,
  `DEFAULT_VALUE` varchar(255) DEFAULT NULL,
  `REC_DATE` datetime DEFAULT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) DEFAULT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) DEFAULT NULL COMMENT '数据状态',
  PRIMARY KEY (`AGENCY_CODE`,`COLUMN_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asi_column_template
-- ----------------------------

-- ----------------------------
-- Table structure for asi_group
-- ----------------------------
DROP TABLE IF EXISTS `asi_group`;
CREATE TABLE `asi_group` (
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '商家编码',
  `GROUP_CODE` varchar(32) NOT NULL COMMENT '分组编码',
  `PARENT_GROUP_CODE` varchar(32) NOT NULL COMMENT '父分组编码',
  `GROUP_TYPE` varchar(32) NOT NULL COMMENT '分组内容类型(表格、表单)',
  `GROUP_ORDER` int(11) NOT NULL COMMENT '分组展示顺序',
  `GROUP_NAME` varchar(255) NOT NULL COMMENT '分组名称',
  `DATA_SORT` varchar(20) DEFAULT NULL COMMENT '数据排序',
  `NODE_LEVEL` int(10) NOT NULL COMMENT '节点级别，表示树形结构中叶子节点的层级',
  `DISPLAY_META` varchar(1) DEFAULT NULL COMMENT '是否显示分组包含的字段的元数据',
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  `LOCK_STATUS` varchar(1) NOT NULL DEFAULT 'N' COMMENT '锁定状态 :N 未锁定 /Y  锁定',
  PRIMARY KEY (`AGENCY_CODE`,`GROUP_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asi_group
-- ----------------------------

-- ----------------------------
-- Table structure for asi_group_column
-- ----------------------------
DROP TABLE IF EXISTS `asi_group_column`;
CREATE TABLE `asi_group_column` (
  `AGENCY_CODE` varchar(32) NOT NULL,
  `GROUP_CODE` varchar(32) NOT NULL,
  `COLUMN_CODE` varchar(32) NOT NULL,
  `COLUMN_NAME` varchar(255) NOT NULL,
  `DATA_TYPE` varchar(16) NOT NULL,
  `MAX_LENGTH` int(11) DEFAULT NULL,
  `IS_REQUIRED` varchar(1) NOT NULL,
  `DISPLAY_ORDER` int(11) NOT NULL,
  `DEFAULT_VALUE` varchar(255) DEFAULT NULL,
  `DISPLAY_LENGTH` int(11) DEFAULT NULL,
  `IS_DISPLAY` varchar(1) DEFAULT NULL,
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态',
  PRIMARY KEY (`AGENCY_CODE`,`GROUP_CODE`,`COLUMN_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asi_group_column
-- ----------------------------

-- ----------------------------
-- Table structure for security_login_history
-- ----------------------------
DROP TABLE IF EXISTS `security_login_history`;
CREATE TABLE `security_login_history` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `SESSION_ID` varchar(50) NOT NULL COMMENT '会话ID',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '商家编码',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `USER_NAME` varchar(32) DEFAULT NULL COMMENT '会话名称',
  `LOGIN_ID` varchar(64) NOT NULL COMMENT '登录账户ID',
  `USER_TYPE` int(11) NOT NULL COMMENT '用户类型',
  `PRODUCT` varchar(32) NOT NULL COMMENT '登录设备',
  `REMOTE_IP` varchar(255) DEFAULT NULL COMMENT '远端IP地址',
  `EXPIRATION` varchar(32) NOT NULL COMMENT 'session存活时间',
  `STATUS` varchar(1) NOT NULL COMMENT 'session状态',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建或修改时间',
  `USER_AGENT` varchar(255) DEFAULT NULL COMMENT '远端请求代理',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态:I 非激活 /A  激活',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '修改者',
  PRIMARY KEY (`SEQUENCE_NBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录信息历史记录';

-- ----------------------------
-- Records of security_login_history
-- ----------------------------
INSERT INTO `security_login_history` VALUES ('1099923017963683840', 'f11a2c84-c4f7-435e-aac0-4897595ca241', 'SUPER_ADMIN', '9527', '管理员', 'super', '300', 'UNKNOWN', '127.0.0.1', '2592000', 'N', '2019-02-25 14:44:18', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36', '2019-02-25 14:44:18', 'A', '9527');
INSERT INTO `security_login_history` VALUES ('1099923032698273792', '26936c69-d471-474f-8fdf-f791c0275663', 'SUPER_ADMIN', '9527', '管理员', 'super', '300', 'UNKNOWN', '127.0.0.1', '2592000', 'N', '2019-02-25 14:44:21', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36', '2019-02-25 14:44:21', 'A', '9527');
INSERT INTO `security_login_history` VALUES ('1099923033176424448', '9bb60255-2382-46c5-b7cc-2843e725fe40', 'SUPER_ADMIN', '9527', '管理员', 'super', '300', 'UNKNOWN', '127.0.0.1', '2592000', 'N', '2019-02-25 14:44:21', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36', '2019-02-25 14:44:21', 'A', '9527');
INSERT INTO `security_login_history` VALUES ('1099942376324993024', '42feb780-1e47-44a0-9006-312e202850b5', 'SUPER_ADMIN', '1099942374290755584', '匿名用户', 'ANONYMOUS1099942374290755585', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 16:01:13', 'request', '2019-02-25 16:01:13', 'A', '1099942374290755584');
INSERT INTO `security_login_history` VALUES ('1099942377847525376', '16b6860c-0e2e-4bc7-baec-9eadd1274d2c', 'SUPER_ADMIN', '9527', '管理员', 'super', '300', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 16:01:13', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36', '2019-02-25 16:01:13', 'A', '9527');
INSERT INTO `security_login_history` VALUES ('1099978329961873408', 'e7997b14-483c-4e26-8820-15c25d6abdd8', 'SUPER_ADMIN', '1099978329701826560', '匿名用户', 'ANONYMOUS1099978329701826561', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:24:05', 'request', '2019-02-25 18:24:05', 'A', '1099978329701826560');
INSERT INTO `security_login_history` VALUES ('1099978347548590081', 'b3385a0f-d0d5-43ce-8557-cefc61c1c790', 'SUPER_ADMIN', '1099978347510841344', '匿名用户', 'ANONYMOUS1099978347510841345', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:24:09', 'request', '2019-02-25 18:24:09', 'A', '1099978347510841344');
INSERT INTO `security_login_history` VALUES ('1099978347787665408', '4df79830-969c-40ea-b10d-b0c24a89d95c', 'SUPER_ADMIN', '9527', '管理员', 'super', '300', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:24:09', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36', '2019-02-25 18:24:09', 'A', '9527');
INSERT INTO `security_login_history` VALUES ('1099979062618701824', 'bdf929b3-d384-4be3-9add-c3160919f530', 'SUPER_ADMIN', '1099979062580953088', '匿名用户', 'ANONYMOUS1099979062580953089', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:27:00', 'request', '2019-02-25 18:27:00', 'A', '1099979062580953088');
INSERT INTO `security_login_history` VALUES ('1099979062853582849', '92bd1b32-1685-4dc7-ad61-071ebebf67d2', 'SUPER_ADMIN', '1099952418356989952', '吴强', '10086', '300', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:27:00', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36', '2019-02-25 18:27:00', 'A', '1099952418356989952');
INSERT INTO `security_login_history` VALUES ('1099979334904528897', 'd6cb6930-dc4d-46e4-ab3a-08d8430af46e', 'SUPER_ADMIN', '1099979334875168768', '匿名用户', 'ANONYMOUS1099979334875168769', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:28:05', 'request', '2019-02-25 18:28:05', 'A', '1099979334875168768');
INSERT INTO `security_login_history` VALUES ('1099979335181352961', '9a4ea7f2-9cc8-4b6e-aacc-6c7d9ef7cf7d', 'SUPER_ADMIN', '9527', '管理员', 'super', '300', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:28:05', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36', '2019-02-25 18:28:05', 'A', '9527');

-- ----------------------------
-- Table structure for security_login_info
-- ----------------------------
DROP TABLE IF EXISTS `security_login_info`;
CREATE TABLE `security_login_info` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '商家编码',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `LOGIN_ID` varchar(64) NOT NULL COMMENT '登录账户ID',
  `ID_TYPE` varchar(16) NOT NULL COMMENT '登录账号类型,(手机号/用户名/邮箱/第三方微信，微博，qq等)',
  `LOCK_STATUS` varchar(1) NOT NULL DEFAULT 'N' COMMENT '数据锁定状态: N :非锁定 / Y: 锁定',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_STATUS` char(1) NOT NULL COMMENT '数据状态:I 非激活 /A  激活',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '修改者',
  PRIMARY KEY (`SEQUENCE_NBR`),
  UNIQUE KEY `INDEX_LOGIN_ID` (`USER_ID`,`ID_TYPE`,`LOGIN_ID`) USING BTREE,
  KEY `INDEX_USER_ID` (`USER_ID`) USING BTREE,
  KEY `INDEX_ID_TYPE` (`ID_TYPE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户登录信息';

-- ----------------------------
-- Records of security_login_info
-- ----------------------------
INSERT INTO `security_login_info` VALUES ('1', 'SUPER_ADMIN', '9527', 'SUPER', 'employeeCode', 'N', '2018-05-16 11:30:36', null, '2018-05-16 11:30:43', 'A', '9527');
INSERT INTO `security_login_info` VALUES ('1099952418356989953', 'SUPER_ADMIN', '1099952418356989952', '10086', 'employeeCode', 'N', null, null, '2019-02-25 16:41:07', 'A', '0');

-- ----------------------------
-- Table structure for security_module
-- ----------------------------
DROP TABLE IF EXISTS `security_module`;
CREATE TABLE `security_module` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '商家编码',
  `MODULE_TYPE` varchar(32) NOT NULL DEFAULT 'menu' COMMENT '模块类型（menu：菜单、tab：TAB页）',
  `MODULE_CODE` varchar(32) NOT NULL COMMENT '模块代码',
  `MODULE_NAME` varchar(32) NOT NULL COMMENT '模块名称',
  `PARENT_CODE` varchar(32) NOT NULL COMMENT '父模块代码',
  `CHILD_CONTENT_TYPE` varchar(16) NOT NULL COMMENT '模块下存放内容类型（模块或者fid）',
  `DIRECTION` varchar(255) DEFAULT NULL COMMENT '前端跳转地址',
  `ORDER_NUM` int(11) DEFAULT '0' COMMENT '排序',
  `LEVEL_NUM` int(11) NOT NULL COMMENT '模块级别',
  `IS_AGENCY_TEMPLATE` varchar(1) NOT NULL DEFAULT 'N' COMMENT '是否可以作为商家模板模块',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '修改者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态 :I 非激活 /A  激活',
  `LOCK_STATUS` varchar(1) NOT NULL COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  KEY `INDEX_MODULE_CODE` (`MODULE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统模块信息';

-- ----------------------------
-- Records of security_module
-- ----------------------------
INSERT INTO `security_module` VALUES ('1057202589038399488', 'SUPER_ADMIN', 'menu', 'backStage', '后台管理', 'root', 'module', '', '1', '1', 'Y', '2018-10-30 17:28:34', '1000996200205328384', 'A', 'N', '2018-10-30 17:28:34', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057202668260413440', 'SUPER_ADMIN', 'menu', 'system', '系统管理', 'backStage', 'module', '', '1', '2', 'Y', '2018-10-30 17:28:53', '1000996200205328384', 'A', 'N', '2018-10-30 17:28:53', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057203014550540288', 'SUPER_ADMIN', 'menu', 'deviceAuth', '设备授权', 'root', 'module', '', '2', '1', 'Y', '2018-10-30 17:30:15', '1000996200205328384', 'A', 'N', '2018-10-30 17:30:15', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057207201791332352', 'SUPER_ADMIN', 'menu', 'organization', '组织管理', 'backStage', 'module', '', '2', '2', 'Y', '2018-10-30 17:46:54', '1000996200205328384', 'A', 'N', '2018-10-30 17:46:54', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057461658789728256', 'SUPER_ADMIN', 'menu', 'dictionary', '字典管理', 'system', 'button', 'dictionary/index', '3', '3', 'Y', '2018-11-01 15:56:08', '1000996200205328384', 'A', 'N', '2018-10-31 10:38:01', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057462405015130112', 'SUPER_ADMIN', 'menu', 'column', '字段管理', 'system', 'button', 'asi/column', '5', '3', 'Y', '2018-10-31 10:40:59', '1000996200205328384', 'A', 'N', '2018-10-31 10:40:59', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057462481888333824', 'SUPER_ADMIN', 'menu', 'group', '分组管理', 'system', 'button', 'asi/group', '6', '3', 'Y', '2018-10-31 10:41:17', '1000996200205328384', 'A', 'N', '2018-10-31 10:41:17', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057462614155710464', 'SUPER_ADMIN', 'menu', 'sysmoudle', '模块管理', 'system', 'button', 'sysmoudle/index', '7', '3', 'Y', '2018-10-31 10:41:49', '1000996200205328384', 'A', 'N', '2018-10-31 10:41:49', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057463898283823104', 'SUPER_ADMIN', 'menu', 'privilegeMg', '权限管理', 'backStage', 'module', '', '2', '2', 'Y', '2018-10-31 10:46:55', '1000996200205328384', 'A', 'N', '2018-10-31 10:46:55', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057464222037954560', 'SUPER_ADMIN', 'menu', 'role', '角色管理', 'privilegeMg', 'button', 'role/index', '3', '3', 'Y', '2018-10-31 10:48:12', '1000996200205328384', 'A', 'N', '2018-10-31 10:48:12', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1057464332125851648', 'SUPER_ADMIN', 'menu', 'privilege', '权限管理', 'privilegeMg', 'button', 'privilege/index', '4', '3', 'Y', '2018-10-31 10:48:38', '1000996200205328384', 'A', 'N', '2018-10-31 10:48:38', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1058300273388187648', 'SUPER_ADMIN', 'menu', 'dept', '部门管理', 'organization', 'button', 'dept/index', '1', '3', 'Y', '2018-11-02 18:10:22', '1000996200205328384', 'A', 'N', '2018-11-02 18:10:22', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1058300343550504960', 'SUPER_ADMIN', 'menu', 'user', '员工管理', 'organization', 'button', 'user/index', '2', '3', 'Y', '2018-11-02 18:10:39', '1000996200205328384', 'A', 'N', '2018-11-02 18:10:39', '1000996200205328384', null, null, null, null);
INSERT INTO `security_module` VALUES ('1099950664320028672', 'SUPER_ADMIN', 'menu', 'baseInfo', '基础信息', 'deviceAuth', 'module', '', '1', '2', 'Y', '2019-02-25 16:34:09', '9527', 'A', 'N', '2019-02-25 16:34:09', '9527', null, null, null, null);
INSERT INTO `security_module` VALUES ('1099950746914263040', 'SUPER_ADMIN', 'menu', 'authManage', '授权管理', 'deviceAuth', 'module', '', '2', '2', 'Y', '2019-02-25 16:34:29', '9527', 'A', 'N', '2019-02-25 16:34:29', '9527', null, null, null, null);
INSERT INTO `security_module` VALUES ('1099950924689838080', 'SUPER_ADMIN', 'menu', 'deviceManage', '设备管理', 'baseInfo', 'button', 'airplayauth/device', '1', '3', 'Y', '2019-02-25 16:35:11', '9527', 'A', 'N', '2019-02-25 16:35:11', '9527', null, null, null, null);
INSERT INTO `security_module` VALUES ('1099951060769837056', 'SUPER_ADMIN', 'menu', 'companyManage', '客户公司管理', 'baseInfo', 'button', 'airplayauth/company', '1', '3', 'Y', '2019-02-25 16:35:44', '9527', 'A', 'N', '2019-02-25 16:35:44', '9527', null, null, null, null);
INSERT INTO `security_module` VALUES ('1099951266261372928', 'SUPER_ADMIN', 'menu', 'deviceAuthManage', '设备授权管理', 'authManage', 'button', 'airplayauth/auth', '1', '3', 'Y', '2019-02-25 16:37:54', '9527', 'A', 'N', '2019-02-25 16:36:33', '9527', null, null, null, null);
INSERT INTO `security_module` VALUES ('1099951763542249472', 'SUPER_ADMIN', 'menu', 'authHistoryManage', '设备认证记录', 'authManage', 'button', 'airplayauth/history', '3', '3', 'Y', '2019-02-25 16:38:31', '9527', 'A', 'N', '2019-02-25 16:38:31', '9527', null, null, null, null);

-- ----------------------------
-- Table structure for security_module_operation
-- ----------------------------
DROP TABLE IF EXISTS `security_module_operation`;
CREATE TABLE `security_module_operation` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '商家编码',
  `MODULE_CODE` varchar(32) NOT NULL COMMENT '模块编码',
  `FUNC_ID` varchar(32) DEFAULT NULL COMMENT '按钮对应的API接口资源',
  `REQ_MODE` varchar(16) DEFAULT NULL COMMENT '请求方式get,post,put,delete',
  `BUTTON_CODE` varchar(32) NOT NULL COMMENT '按钮编码',
  `BUTTON_STYLE` varchar(32) NOT NULL COMMENT '按钮样式（button|link|tab|...）',
  `BUTTON_TYPE` varchar(32) NOT NULL COMMENT '按钮关联的资源类型（API|第三方资源|自定义资源|...）',
  `BUTTON_NAME` varchar(64) NOT NULL COMMENT '按钮名称',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '修改者',
  `REC_STATUS` varchar(1) NOT NULL DEFAULT 'A' COMMENT '数据状态 :I 非激活 /A  激活',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  KEY `INDEX_FUNC_ID` (`FUNC_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统模块关联权限信息';

-- ----------------------------
-- Records of security_module_operation
-- ----------------------------
INSERT INTO `security_module_operation` VALUES ('1057469025476530176', 'SUPER_ADMIN', 'dictionary', '1158CF800826DF2BB9D914B158B4C7FC', null, 'queryDict', 'button', 'API', '查询', '2018-10-31 11:07:17', '1000996200205328384', 'A', 'dictionaryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057469766161256448', 'SUPER_ADMIN', 'eventManage', '949850B5A1BC8CF1426A3B04B266CD10', null, 'queryEvent', 'button', 'API', '查询', '2018-10-31 11:10:14', '1000996200205328384', 'A', 'eventconfigresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057470205195833344', 'SUPER_ADMIN', 'column', '90D8BC2A8A72E810EC3BAE375D6671A1', null, 'queryColumn', 'button', 'API', '查询', '2018-10-31 11:11:58', '1000996200205328384', 'A', 'asicolumnresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057470326323138560', 'SUPER_ADMIN', 'group', 'C462841232C727C92C2BE976A124E691', null, 'queryGroup', 'button', 'API', '查询', '2018-10-31 11:12:27', '1000996200205328384', 'A', 'asigroupresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057470580984500224', 'SUPER_ADMIN', 'sysmoudle', 'B0F06A9F0A0725794047DED930486C18', null, 'queryModules', 'button', 'API', '查询', '2018-10-31 11:13:28', '1000996200205328384', 'A', 'moduleresourcesv1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057471089061515264', 'SUPER_ADMIN', 'role', 'D9AFB10EAE9C860F9662B2B579F7D96F', null, 'queryRole', 'button', 'API', '查询', '2018-10-31 11:15:29', '1000996200205328384', 'A', 'roleresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057471290019008512', 'SUPER_ADMIN', 'privilege', 'C8C2D8E88F93F0998A00C5FFD058E4F4', null, 'queryPrivilege', 'button', 'API', '查询', '2018-10-31 11:16:17', '1000996200205328384', 'A', 'permissionresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057471530923053056', 'SUPER_ADMIN', 'messageEvent', 'B6095730E99E2746891F4941B3A76968', null, 'queryMsgEvent', 'button', 'API', '查询', '2018-10-31 11:17:15', '1000996200205328384', 'A', 'messageconfigresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057471709143224320', 'SUPER_ADMIN', 'tags', 'BC185D16E8BE6C3FC2D22F8293753121', null, 'queryLabel', 'button', 'API', '查询', '2018-10-31 11:17:57', '1000996200205328384', 'A', 'tagresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057471971161395200', 'SUPER_ADMIN', 'category', 'F58BEA3FA3C3DA0A39BC6E6DF5D39975', null, 'queryCategoryProps', 'button', 'API', '查询', '2018-10-31 11:18:59', '1000996200205328384', 'A', 'categorypropertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057472182189412352', 'SUPER_ADMIN', 'properties', 'FFE6E0F70CA55D2BBA3D087E36EE10E9', null, 'queryProps', 'button', 'API', '查询', '2018-10-31 11:19:50', '1000996200205328384', 'A', 'propertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602579686526976', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test1', 'button', 'WEB', 'test1', '2018-10-31 19:57:59', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602612284657664', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test2', 'button', 'WEB', 'test2', '2018-10-31 19:58:07', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602643800657920', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test3', 'button', 'WEB', 'test3', '2018-10-31 19:58:14', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602677376061440', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test4', 'button', 'WEB', 'test4', '2018-10-31 19:58:22', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602718480240640', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test5', 'button', 'WEB', 'test5', '2018-10-31 19:58:32', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602746993119232', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test6', 'button', 'WEB', 'test6', '2018-10-31 19:58:39', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602779213762560', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test7', 'button', 'WEB', 'test7', '2018-10-31 19:58:47', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602809014292480', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test8', 'button', 'WEB', 'test8', '2018-10-31 19:58:54', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057602844749762560', 'SUPER_ADMIN', 'dictionary', 'WEB0001', null, 'test9', 'button', 'WEB', 'test9', '2018-10-31 19:59:02', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1057941436634234880', 'SUPER_ADMIN', 'productmg', '6B801B369A7B1CA717B5AC6B95E952D9', null, 'queryMsProducts', 'button', 'API', '查询', '2018-11-01 18:24:29', '1000996200205328384', 'A', 'spumsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058238269235507200', 'SUPER_ADMIN', 'myOfferList', '3EEC23F253600994AFF8A2F1093558D0', null, 'queryMyOffer', 'button', 'API', '查询', '2018-11-02 14:03:59', '1000996200205328384', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058238532570689536', 'SUPER_ADMIN', 'rcMyOfferList', '3EEC23F253600994AFF8A2F1093558D0', null, 'queryMyRcOffer', 'button', 'API', '查询', '2018-11-02 14:05:02', '1000996200205328384', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058252889279016960', 'SUPER_ADMIN', 'rcProduct', '8619115F3B840DBCF2A2FAF48BCB0305', null, 'queryRcProduct', 'button', 'API', '查询', '2018-11-02 15:02:05', '1000996200205328384', 'A', 'spurcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058253177998127104', 'SUPER_ADMIN', 'publishOrder', '3E78E3661E0AB5DE2A110BC3207B0D07', null, 'queryPublishOrder', 'button', 'API', '查询', '2018-11-02 15:03:14', '1000996200205328384', 'A', 'productpublishandpushresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058253322571591680', 'SUPER_ADMIN', 'pushOrder', '42E760B24C4814ACC532B1E37545BCC1', null, 'queryPushOrder', 'button', 'API', '查询', '2018-11-02 15:03:48', '1000996200205328384', 'A', 'productpublishandpushresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058253514838487040', 'SUPER_ADMIN', 'taskOrder', '9C72F5D45E8FF375557A86E157F74BEE', null, 'queryTask', 'button', 'API', '查询', '2018-11-02 15:04:34', '1000996200205328384', 'A', 'taskresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058253613270413312', 'SUPER_ADMIN', 'taskOrder', 'C1084E0B4692A296B89F36C183A28EE0', null, 'createTask', 'button', 'API', '新增', '2018-11-02 15:04:57', '1000996200205328384', 'A', 'taskresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058253750981996544', 'SUPER_ADMIN', 'myTaskOrder', '9C3168D4CE97B697D342CB23C0959DF6', null, 'queryMyTask', 'button', 'API', '查询', '2018-11-02 15:05:30', '1000996200205328384', 'A', 'taskresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058254045652824064', 'SUPER_ADMIN', 'quotation', '9C947DC7612538D53EB85E4D7FDA782E', null, 'queryQuotation', 'button', 'API', '查询', '2018-11-02 15:06:41', '1000996200205328384', 'A', 'offercustomerdetailresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058254287253123072', 'SUPER_ADMIN', 'quotation', '4BC8039FD0F69F76C32312E2984B7F34', null, 'createOrder', 'button', 'API', '下单', '2018-11-02 15:07:38', '1000996200205328384', 'A', 'produceorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058254884719144960', 'SUPER_ADMIN', 'quotation', 'F379ABCA996E2F67B86228FCE44E20C8', null, 'rejectOfferRecord', 'button', 'API', '作废报价记录', '2018-11-02 15:10:01', '1000996200205328384', 'A', 'costaccountingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058254988360396800', 'SUPER_ADMIN', 'quotation', 'WEB0001', null, 'finishQuotationOrder', 'button', 'WEB', '完成', '2018-11-02 15:10:25', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058255157126606848', 'SUPER_ADMIN', 'quotation', '27F565C7EB883F6A038FE70438161EED', null, 'updateOfferRecord', 'button', 'API', '编辑', '2018-11-02 15:11:06', '1000996200205328384', 'A', 'offercustomerdetailresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058255786435784704', 'SUPER_ADMIN', 'rcQuotation', '7F9FFE3A39F409AF707192C7390291A3', null, 'queryRcQuotation', 'button', 'API', '查询', '2018-11-02 15:13:36', '1000996200205328384', 'A', 'offerrccustomerdetailresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058256540559060992', 'SUPER_ADMIN', 'rcQuotation', '558A9E3B88CCC76B4C73B2B1988724E8', null, 'createOrder', 'button', 'API', '下单', '2018-11-02 15:19:58', '1000996200205328384', 'A', 'producercorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058256609534390272', 'SUPER_ADMIN', 'rcQuotation', 'WEB0001', null, 'finishOrder', 'button', 'WEB', '完成', '2018-11-02 15:16:52', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058256804829573120', 'SUPER_ADMIN', 'rcQuotation', 'F379ABCA996E2F67B86228FCE44E20C8', null, 'rejectOrder', 'button', 'API', '作废', '2018-11-02 15:17:38', '1000996200205328384', 'A', 'costaccountingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058257118123110400', 'SUPER_ADMIN', 'rcQuotation', 'ABC4A911771A4993E97C51E4A6E0C004', null, 'updateOfferRecord', 'button', 'API', '编辑报价记录', '2018-11-02 15:18:53', '1000996200205328384', 'A', 'offerrccustomerdetailresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058257557593894912', 'SUPER_ADMIN', 'produceOrder', '364C076296BBED8B32490131693DE5BD', null, 'queryProduceOrder', 'button', 'API', '查询', '2018-11-02 15:20:38', '1000996200205328384', 'A', 'produceorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058257670022213632', 'SUPER_ADMIN', 'produceOrder', 'E9B9FA4FCFAD13B09753F68F59C4A6A0', null, 'deleteProduceOrder', 'button', 'API', '删除', '2018-11-02 15:21:05', '1000996200205328384', 'A', 'produceorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058257768005349376', 'SUPER_ADMIN', 'myProduceOrder', '4EC3E056E1D36AFC8FE99EAAB838C623', null, 'queryMyManuOrder', 'button', 'API', '查询', '2018-11-02 15:21:28', '1000996200205328384', 'A', 'produceorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058257984104280064', 'SUPER_ADMIN', 'sampleRecord', '13ED5486980B44BA164A066A2D92532F', null, 'querySampleRecord', 'button', 'API', '查询', '2018-11-02 15:22:20', '1000996200205328384', 'A', 'samplerecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058258051687100416', 'SUPER_ADMIN', 'mySampleRecord', '1C80366A5F00CFFD61D18AFCCA986C85', null, 'queryMySampleRecord', 'button', 'API', '查询', '2018-11-02 15:22:36', '1000996200205328384', 'A', 'samplerecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058258303777353728', 'SUPER_ADMIN', 'myProduceRecord', 'DFFBFFC896298B50F25F8349E1DC3C22', null, 'queryMyProduceRecord', 'button', 'API', '查询', '2018-11-02 15:23:36', '1000996200205328384', 'A', 'producerecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058258508102873088', 'SUPER_ADMIN', 'purchaseOrder', '3C3DAE45F8AD56F16FBD21B00143769A', null, 'queryPurchaseOrder', 'button', 'API', '查询', '2018-11-02 15:24:24', '1000996200205328384', 'A', 'producercorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058258595742855168', 'SUPER_ADMIN', 'purchaseOrder', 'E67DE1146715103B3080363860AFBD93', null, 'deletePurchaseOrder', 'button', 'API', '删除', '2018-11-02 15:24:45', '1000996200205328384', 'A', 'producercorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058258766505553920', 'SUPER_ADMIN', 'myPurchaseOrder', 'A58ADEE6A3D0941CB8810276FF6C4E2D', null, 'queryMyPurchaseOrder', 'button', 'API', '查询', '2018-11-02 15:25:26', '1000996200205328384', 'A', 'producercrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058258854325891072', 'SUPER_ADMIN', 'myPurchaseRecord', 'A58ADEE6A3D0941CB8810276FF6C4E2D', null, 'queryMyPurchaseOrder', 'button', 'API', '查询', '2018-11-02 15:25:47', '1000996200205328384', 'A', 'producercrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058258935204655104', 'SUPER_ADMIN', 'purchaseRecord', 'A58ADEE6A3D0941CB8810276FF6C4E2D', null, 'queryPurchaseOrder', 'button', 'API', '查询', '2018-11-02 15:26:06', '1000996200205328384', 'A', 'producercrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058294562105094144', 'SUPER_ADMIN', 'notice', '2910F765380EA0B4F35338AD5646DD5C', null, 'noticeQuery', 'button', 'API', '查询', '2018-11-02 17:47:40', '1003812731201028096', 'A', 'noticeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058295579282628608', 'SUPER_ADMIN', 'businessList', '28022DA05F01E8E094BCF253400897D3', null, 'createBusiness', 'button', 'API', '创建', '2018-11-02 17:51:43', '998461184120242176', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058295942689710080', 'SUPER_ADMIN', 'businessList', '1CF84B3A057194F1035D4CFB5A9C080B', null, 'queryBusiness', 'button', 'API', '查询', '2018-11-02 17:53:10', '998461184120242176', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058296129290100736', 'SUPER_ADMIN', 'businessList', 'B78D2A360468DA77D46B3B6B55ADDBE7', null, 'refusedForm', 'button', 'API', '拒绝', '2018-11-02 17:53:54', '998461184120242176', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058296378305929216', 'SUPER_ADMIN', 'businessList', 'E7B70BC32871607F1284D9E0F0B7FA40', null, 'approvedForm', 'button', 'API', '确认', '2018-11-02 17:54:53', '998461184120242176', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058296613509914624', 'SUPER_ADMIN', 'businessList', '3FBCEA68C2F6E56043CEC5E8D41A5CFF', null, 'createSubForm', 'button', 'API', '指派', '2018-11-02 17:55:50', '998461184120242176', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058297042780151808', 'SUPER_ADMIN', 'businessList', '28022DA05F01E8E094BCF253400897D3', null, 'completeForm', 'button', 'API', '完成', '2018-11-02 17:57:32', '998461184120242176', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058298323770925056', 'SUPER_ADMIN', 'offerList', 'D1A14ABC4911614D83FFA8A9C9D623DB', null, 'queryOffer', 'button', 'API', '查询', '2018-11-02 18:02:37', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058298621516177408', 'SUPER_ADMIN', 'offerList', 'F15EB5E6B699BA5237C52A5697E14565', null, 'createOffer', 'button', 'API', '新增', '2018-11-02 18:03:48', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058299378302836736', 'SUPER_ADMIN', 'offerList', '1A3BA33F160E1CB2E9238F447291DE47', null, 'archivedOffer', 'button', 'API', '归档', '2018-11-02 18:06:49', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058300505144455168', 'SUPER_ADMIN', 'dept', '3B08E11D93B2D514ED8F1AAA4B4CC28E', null, 'queryDept', 'button', 'API', '查询', '2018-11-02 18:11:17', '1000996200205328384', 'A', 'departmentresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058300576221130752', 'SUPER_ADMIN', 'user', '97395F2B960B1920E3FB8C5564811470', null, 'queryUser', 'button', 'API', '查询', '2018-11-02 18:11:34', '1000996200205328384', 'A', 'employeeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058302049730457600', 'SUPER_ADMIN', 'offerList', '35351A3A16086E50B259CFCBD788D004', null, 'deleteOffer', 'button', 'API', '删除', '2018-11-02 18:17:26', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058302692985696256', 'SUPER_ADMIN', 'allOfferRecord', '843A75EFFD0E52877225105ACF5BC8E6', null, 'queryRcOffer', 'button', 'API', '查询', '2018-11-02 18:25:33', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058304519718334464', 'SUPER_ADMIN', 'rcOfferList', '00B61EC11905C8A1A08D038F12D7261B', null, 'queryRcOffer', 'button', 'API', '查询', '2019-01-17 11:26:45', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058304665160019968', 'SUPER_ADMIN', 'rcOfferList', 'C344A9D5A7272E73A8FA843415C5B3E8', null, 'createOffer', 'button', 'API', '新增', '2018-11-02 18:27:49', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058304785154863104', 'SUPER_ADMIN', 'rcOfferList', 'CBBEE09F7CEBE5AEFF89A5F36C56C6D8', null, 'archivedOffer', 'button', 'API', '归档', '2018-11-02 18:28:18', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058304867950424064', 'SUPER_ADMIN', 'rcOfferList', '3C3656E2D37F62C40C5612923434697D', null, 'deleteOffer', 'button', 'API', '删除', '2018-11-02 18:28:38', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058305370449014784', 'SUPER_ADMIN', 'rcAllOfferRecord', 'D651437C18FECF6B5467A8A9D83DB14C', null, 'queryRcOfferRecord', 'button', 'API', '查询', '2018-11-02 18:30:37', '998461184120242176', 'A', 'offerrcrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058305513156014080', 'SUPER_ADMIN', 'rcAllOfferRecord', '7A1DE4E1B0486A72D2A0519828893C40', null, 'deleteRcOfferRecord', 'button', 'API', '删除', '2018-11-02 18:31:11', '998461184120242176', 'A', 'offerrcrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058306764950237184', 'SUPER_ADMIN', 'dataLogging', 'A66F921A69D517925DC403228B2F7E29', null, 'queryButton', 'button', 'API', '查询', '2018-11-02 18:36:10', '1000947851343175680', 'A', 'logresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058306987042828288', 'SUPER_ADMIN', 'operationLog', '637106C4C60459D67A416FBE372B5305', null, 'queryButton', 'button', 'API', '查询', '2018-11-02 18:37:03', '1000947851343175680', 'A', 'logresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058308242356072448', 'SUPER_ADMIN', 'supplierList', '6818CBCDFA68D37C5A63799B624A73F4', null, 'queryMsSupplier', 'button', 'API', '查询', '2019-01-17 11:01:10', '998461184120242176', 'A', 'suppliermsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058308488687546368', 'SUPER_ADMIN', 'rcSupplier', '8D79952297E50F66576F32F088631B58', null, 'queryRcSupplier', 'button', 'API', '查询', '2018-11-02 18:43:01', '998461184120242176', 'A', 'supplierrcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058308493825568768', 'SUPER_ADMIN', 'repository', '022AB55846FFD6ADFBC4A0FE15E2097C', null, 'repositoryAdd', 'button', 'API', '新增知识库', '2018-11-02 18:43:02', '1000947851343175680', 'A', 'repositoryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058308689556959232', 'SUPER_ADMIN', 'repository', 'EAB83FB098676A0562D0F68353B5F7F9', null, 'repositoryEdit', 'button', 'API', '知识库编辑', '2018-11-02 18:43:49', '1000947851343175680', 'A', 'repositoryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058308761560576000', 'SUPER_ADMIN', 'repository', '29651E0CCB854A138D2BEADE4F747E69', null, 'repositoryDelete', 'button', 'API', '知识库删除', '2018-11-02 18:44:06', '1000947851343175680', 'A', 'repositoryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058308893702123520', 'SUPER_ADMIN', 'repository', 'EB054275EBCC3589AD46DD246426A0A2', null, 'repositoryListQuery', 'button', 'API', '知识库列表查询', '2018-11-02 18:44:37', '1000947851343175680', 'A', 'repositoryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058311115869548544', 'SUPER_ADMIN', 'productCatalog', 'F7288E9AA2315F1C9740BE064AC3CE5A', null, 'querySpuCatalog', 'button', 'API', '查询', '2018-11-02 18:53:27', '998461184120242176', 'A', 'spuresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058311877475463168', 'SUPER_ADMIN', 'channelManage', '34623634037E344324EA0EE92546B0FF', null, 'queryChannel', 'button', 'API', '查询', '2018-11-09 17:50:54', '1004905673378619392', 'A', 'businessinforesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058312722959069184', 'SUPER_ADMIN', 'accountApply', 'E57CB29F3E223AF76934B722F101B0B4', null, 'queryCostAccount', 'button', 'API', '查询', '2018-11-02 18:59:50', '998461184120242176', 'A', 'costaccountingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058314538069291008', 'SUPER_ADMIN', 'allOfferRecord', '4B0F7E413B0ED618C34C63EF67218035', null, 'deleteOfferRecord', 'button', 'API', '删除', '2018-11-02 19:07:03', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058315305878581248', 'SUPER_ADMIN', 'mainWarehouse', '698C87ADD37943DDEB0AC0A68D8DB84D', null, 'queryWarehouse', 'button', 'API', '查询', '2018-11-02 19:10:06', '1003812731201028096', 'A', 'storeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058315712637988864', 'SUPER_ADMIN', 'mainWarehouse', 'E598498152A4FEB74206AC893A4CB4AE', null, 'deleteWarehouse', 'button', 'API', '删除', '2018-11-02 19:11:43', '1003812731201028096', 'A', 'storeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058315850970329088', 'SUPER_ADMIN', 'myWarehouse', '9AB87AE8587A4AE7E8A00BD7AF4CDB38', null, 'queryMyWarehouse', 'button', 'API', '查询', '2018-11-02 19:12:16', '1003812731201028096', 'A', 'storeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058316435022966784', 'SUPER_ADMIN', 'inventoryList', '6241570BB7F3282D31A439BFC0803E5A', null, 'queryInventory', 'button', 'API', '查询', '2018-11-02 19:14:35', '1003812731201028096', 'A', 'stockresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058316585334239232', 'SUPER_ADMIN', 'myInventory', 'D4FADD2665D65D7023A9362045AA7F6D', null, 'queryMyInventory', 'button', 'API', '查询', '2018-11-02 19:15:11', '1003812731201028096', 'A', 'stockresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058317095793618944', 'SUPER_ADMIN', 'outStore', 'E835A284AB46B269D6F28482C2146F68', null, 'queryAllOutStock', 'button', 'API', '查询', '2018-11-02 19:17:13', '1003812731201028096', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058317374496731136', 'SUPER_ADMIN', 'outStoreList', '83233D1D47638DCB8627E869F1F4EC92', null, 'queryMyOutStock', 'button', 'API', '查询', '2018-11-02 19:18:19', '1003812731201028096', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1058317699983110144', 'SUPER_ADMIN', 'storePicking', 'FC023770D72E0194050097C9B3731175', null, 'queryPickList', 'button', 'API', '查询', '2018-11-02 19:19:37', '1003812731201028096', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059258307908235264', 'SUPER_ADMIN', 'inStoreList', '83233D1D47638DCB8627E869F1F4EC92', null, 'queryInstock', 'button', 'API', '查询', '2018-11-05 09:37:15', '1000947793512112128', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059258589601886208', 'SUPER_ADMIN', 'inStoreList', 'F3F8767F373EF44FEEFD9A5575DD98AC', null, 'inStockApply', 'button', 'API', '申请入库', '2018-11-05 09:38:22', '1000947793512112128', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059258936550518784', 'SUPER_ADMIN', 'outStore', '4908F9F5BD485D2F5207336384D77808', null, 'outStockApply', 'button', 'API', '申请出库', '2018-11-05 09:39:45', '1000947793512112128', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059259458359685120', 'SUPER_ADMIN', 'outStoreBill', 'FC023770D72E0194050097C9B3731175', null, 'queryOutStockBill', 'button', 'API', '查询', '2018-11-05 09:41:50', '1000947793512112128', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059259779127472128', 'SUPER_ADMIN', 'storeEncasementBill', 'FC023770D72E0194050097C9B3731175', null, 'queryStockEncasementBill', 'button', 'API', '查询', '2018-11-05 09:43:06', '1000947793512112128', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059259995448700928', 'SUPER_ADMIN', 'storeCheckEncasement', 'FC023770D72E0194050097C9B3731175', null, 'queryStockCheckEncasement', 'button', 'API', '查询', '2018-11-05 09:43:58', '1000947793512112128', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059260487990013952', 'SUPER_ADMIN', 'storeDelivery', 'C213636C1EDE362253E47E18CAB57A9B', null, 'queryStockDelivery', 'button', 'API', '查询', '2018-11-05 09:45:55', '1000947793512112128', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059260895680557056', 'SUPER_ADMIN', 'waveList', '5623096F5899EB1B82DB4306EC5F7FB8', null, 'queryWave', 'button', 'API', '查询', '2018-11-05 09:47:32', '1000947793512112128', 'A', 'storepackingfrequencyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059261537983688704', 'SUPER_ADMIN', 'materialList', 'D4603F801CCF9525661CE03741596867', null, 'queryMaterialList', 'button', 'API', '查询', '2018-11-05 09:50:05', '1000947793512112128', 'A', 'storematerialresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059632173901950976', 'SUPER_ADMIN', 'contractTemplate', 'WEB0001', null, 'queryContractTemp', 'button', 'WEB', '查询', '2018-11-06 10:22:52', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059635344208572416', 'SUPER_ADMIN', 'clientInfo', '677D9DC094A1F90D12BD1E70B6141F13', null, 'queryClientInfo', 'button', 'API', '查询', '2018-12-07 11:45:39', '1000996200205328384', 'A', 'customerresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059643051124731904', 'SUPER_ADMIN', 'contractMessage', '30F97A3428A10BA216B650860784B43B', null, 'queryContractInfo', 'button', 'API', '查询', '2018-11-06 11:06:05', '998461184120242176', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059644481483059200', 'SUPER_ADMIN', 'customerVisitRecord', '677D9DC094A1F90D12BD1E70B6141F13', null, 'queryCustomerVisitRecord', 'button', 'API', '查询', '2018-11-09 09:33:05', '1003812731201028096', 'A', 'customerresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059645265264259072', 'SUPER_ADMIN', 'businessVisitRecord', '190DF06C82BA2760750FE60F06930A36', null, 'queryBusinessVisitRecord', 'button', 'API', '查询', '2018-11-09 10:08:33', '1003812731201028096', 'A', 'visitrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1059742724753731584', 'SUPER_ADMIN', 'role', 'WEB0001', null, 'addRole', 'button', 'WEB', '新增', '2018-11-06 17:42:09', '9527', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060438292442451968', 'SUPER_ADMIN', 'messageList', 'FFF07047E9F76CEBEA4E8B985D93A284', null, 'queryMessage', 'button', 'API', '查询', '2018-11-08 15:46:06', '1000996200205328384', 'A', 'usermessageresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060782705219833856', 'SUPER_ADMIN', 'clientInfo', '39CB799EDF295EA51F8CD80628CB8395', null, 'deleteClientInfo', 'button', 'API', '删除', '2018-12-07 11:45:34', '1000996200205328384', 'A', 'customerresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060782880562712576', 'SUPER_ADMIN', 'clientInfo', 'ED67BF6060759AF900737D9ED460EA28', null, 'saveClientInfo', 'button', 'API', '保存', '2018-12-07 11:45:30', '1000996200205328384', 'A', 'customerresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060782970127880192', 'SUPER_ADMIN', 'clientInfo', 'E099191EC3FAAFBBDDC00439B2EC4C6E', null, 'updateClientInfo', 'button', 'API', '更新', '2018-12-07 11:45:27', '1000996200205328384', 'A', 'customerresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060783080748453888', 'SUPER_ADMIN', 'clientInfo', '4F60CB704CC5B01CCE03CD17EACDE8FF', null, 'SubmitClientInfo', 'button', 'API', '提交', '2019-01-17 10:47:57', '1000947851343175680', 'A', 'customerresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060783190232371200', 'SUPER_ADMIN', 'clientInfo', '955C88434658D7B11C793EC7393C6970', null, 'changeChargeUser', 'button', 'API', '修改负责人', '2018-11-09 14:36:36', '1000947851343175680', 'A', 'customerresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060783272595918848', 'SUPER_ADMIN', 'clientInfo', '6B1655DF59BDC190D21FF241ADA33005', null, 'rejectClientInfo', 'button', 'API', '驳回', '2018-12-07 11:45:17', '1000996200205328384', 'A', 'customerresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060784262598426624', 'SUPER_ADMIN', 'contractMessage', '65FE17A7E3B9841DD83FB069BF14FE61', null, 'createContractInfo', 'button', 'API', '新增', '2018-11-09 14:40:51', '998461184120242176', 'A', 'contractresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060784564911276032', 'SUPER_ADMIN', 'contractMessage', 'BB00F7ACBFED559D9150C7D2CDB34C2B', null, 'deleteContractInfo', 'button', 'API', '删除', '2018-11-09 14:42:03', '998461184120242176', 'A', 'contractresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1060784767374524416', 'SUPER_ADMIN', 'contractMessage', '7095FBAADBEA1851A7C37C8AAC3A0D0E', null, 'cancelContractInfo', 'button', 'API', '撤销', '2018-11-09 14:42:52', '998461184120242176', 'A', 'contractresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1062981034456498176', 'SUPER_ADMIN', 'productmg', '47072C8CF52046120AACF9C281F63FE4', null, 'deleteCategoryProp', 'button', 'API', '删除类目属性', '2018-11-15 16:10:03', '1000996200205328384', 'A', 'categorypropertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1062981154040299520', 'SUPER_ADMIN', 'rcProduct', '47072C8CF52046120AACF9C281F63FE4', null, 'deleteCategoryProp', 'button', 'API', '删除类目属性', '2018-11-15 16:10:31', '1000996200205328384', 'A', 'categorypropertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1065784828621762560', 'SUPER_ADMIN', 'type', '68C54FF6EA33D5C0CCC7E8A2C520B0B8', null, 'queryType', 'button', 'API', '查询', '2018-11-29 10:09:41', '1000947793512112128', 'A', 'typecategoryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1065805029354549248', 'SUPER_ADMIN', 'brand', '48657D961A405930F121312CDCDF34D7', null, 'brandQuery', 'button', 'API', '查询', '2018-12-07 10:21:02', '1000947851343175680', 'A', 'brandresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1065805168144068608', 'SUPER_ADMIN', 'service', '6D15C956F22B3AEAF733BBED2EC34A46', null, 'serviceQuery', 'button', 'API', '查询', '2018-12-07 10:20:36', '1000947851343175680', 'A', 'solutionresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1066964229090750464', 'SUPER_ADMIN', 'workflowOption', '30F97A3428A10BA216B650860784B43B', null, 'queryWorkflowOption', 'button', 'API', '查询', '2018-11-26 15:57:50', '1003812731201028096', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1066964309235511296', 'SUPER_ADMIN', 'workflowInstance', '30F97A3428A10BA216B650860784B43B', null, 'queryInstanceInfo', 'button', 'API', '查询', '2018-11-26 15:58:09', '1003812731201028096', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1066964377623638016', 'SUPER_ADMIN', 'workflowHandle', '30F97A3428A10BA216B650860784B43B', null, 'queryHandleInfo', 'button', 'API', '查询', '2018-11-26 15:58:26', '1003812731201028096', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1070865860794519552', 'SUPER_ADMIN', 'project', '5157E62F197F5CEDD613C8311D9EB172', null, 'projectQuery', 'button', 'API', '查询', '2019-01-17 11:10:43', '1000947851343175680', 'A', 'projectresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1070889335621947392', 'SUPER_ADMIN', 'productionRecord', 'WEB0001', null, 'queryProductionRecord', 'button', 'WEB', '查询', '2018-12-07 11:54:48', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1070939057409769472', 'SUPER_ADMIN', 'produceRecordConfig', 'WEB0001', null, 'queryRecordConfig', 'button', 'WEB', '查询', '2018-12-07 15:12:23', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1072055512813654016', 'SUPER_ADMIN', 'productmg', '01A33494715BA46001EACCBE893E2E60', null, 'revocationMsProduct', 'button', 'API', '撤销', '2018-12-10 17:08:47', '1000947793512112128', 'A', 'spumsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1072055935733714944', 'SUPER_ADMIN', 'rcProduct', '5D3D0A48E03E008B7FC9BE6F01FB2B65', null, 'revocationRcProduct', 'button', 'API', '撤销', '2018-12-10 17:10:28', '1000947793512112128', 'A', 'spurcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1072056092546158592', 'SUPER_ADMIN', 'productmg', 'E0CFB5E017853D5A2B815148C7DA4F11', null, 'copyMsProduct', 'button', 'API', '复制', '2018-12-10 17:11:05', '1000947793512112128', 'A', 'spumsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1072056206845136896', 'SUPER_ADMIN', 'rcProduct', 'BB2B72268025F7B6B87BC2CB92059697', null, 'copyRcProduct', 'button', 'API', '复制', '2018-12-10 17:11:32', '1000947793512112128', 'A', 'spurcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1072056776481951744', 'SUPER_ADMIN', 'productmg', '82997D7BCE1F1E56FD9970932AF2032B', null, 'cancellationMsProduct', 'button', 'API', '作废', '2018-12-10 17:13:48', '1000947793512112128', 'A', 'spumsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1072056875819847680', 'SUPER_ADMIN', 'rcProduct', 'FFE32F8E92B1D64F080E69029D9C39F5', null, 'cancellationRcProduct', 'button', 'API', '作废', '2018-12-10 17:14:12', '1000947793512112128', 'A', 'spurcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1072057152870404096', 'SUPER_ADMIN', 'rcProduct', '3B1D89CDEA160E99659E2815AFD15097', null, 'deleteRcProduct', 'button', 'API', '删除', '2018-12-10 17:15:18', '1000947793512112128', 'A', 'spurcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1072057330591453184', 'SUPER_ADMIN', 'productmg', '407D4F63745CE051EDBCB19DD83D845A', null, 'deleteMsProduct', 'button', 'API', '删除', '2018-12-10 17:16:00', '1000947793512112128', 'A', 'spumsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1082453577835741184', 'SUPER_ADMIN', 'summaryForm', 'WEB0001', null, 'querySummaryForm', 'button', 'WEB', '查看', '2019-01-08 09:46:59', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1082453610660364288', 'SUPER_ADMIN', 'supplierForm', '30F97A3428A10BA216B650860784B43B', null, 'querySupplierForm', 'button', 'API', '查询', '2019-01-08 09:47:06', '1000947851343175680', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1082453643732451328', 'SUPER_ADMIN', 'productForm', 'WEB0001', null, 'queryProductForm', 'button', 'WEB', '查看', '2019-01-11 09:41:35', '1004905673378619392', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1082453788003926016', 'SUPER_ADMIN', 'clientForm', '30F97A3428A10BA216B650860784B43B', null, 'queryClientForm', 'button', 'API', '查询', '2019-01-08 09:47:49', '1000947851343175680', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1084648738904956928', 'SUPER_ADMIN', 'workflowFormMg', 'WEB0001', null, 'queryWorkFlowForm', 'button', 'WEB', '查询', '2019-01-14 11:09:46', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085093350664679424', 'SUPER_ADMIN', 'notice', '4FFD6767391CBA03E4B8888601E741E9', null, 'addNotice', 'button', 'API', '新增', '2019-01-15 16:36:30', '1000947793512112128', 'A', 'noticeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085093530814230528', 'SUPER_ADMIN', 'notice', 'CEA16F472E9179F024AE542510920FBC', null, 'editNotice', 'button', 'API', '编辑', '2019-01-15 16:37:12', '1000947793512112128', 'A', 'noticeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085094019962351616', 'SUPER_ADMIN', 'notice', '904A12CDB7ACD15E1D5ADD5AC89B178E', null, 'deleteNotice', 'button', 'API', '删除', '2019-01-15 16:39:09', '1000947793512112128', 'A', 'noticeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085094353900253184', 'SUPER_ADMIN', 'notice', '904A12CDB7ACD15E1D5ADD5AC89B178E', null, 'batchDeleteNotice', 'button', 'API', '批量删除', '2019-01-15 16:40:29', '1000947793512112128', 'A', 'noticeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085346714333851648', 'SUPER_ADMIN', 'businessList', '309BB4D009BCE0E4F7538CC297AE1804', null, 'deleteDemand', 'button', 'API', '删除', '2019-01-16 09:23:16', '998461184120242176', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085730193651298304', 'SUPER_ADMIN', 'supplierList', '6596EA4BA45C0EF7D7573F3EBDDF8E8C', null, 'create', 'button', 'API', '新增', '2019-01-17 10:48:23', '998461184120242176', 'A', 'suppliermsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085730469569392640', 'SUPER_ADMIN', 'supplierList', 'E580BB3D359313CEB70320920397B2E0', null, 'edit', 'button', 'API', '编辑', '2019-01-17 10:48:10', '998461184120242176', 'A', 'suppliermsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085730638104915968', 'SUPER_ADMIN', 'supplierList', 'F0066449AB33F7F6D1BA0C4855DE835B', null, 'delete', 'button', 'API', '删除', '2019-01-17 10:48:51', '998461184120242176', 'A', 'suppliermsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085731065198309376', 'SUPER_ADMIN', 'supplierList', '1A9ADF06AB3A19B9826273F165500DB8', null, 'copy', 'button', 'API', '复制', '2019-01-17 10:50:33', '998461184120242176', 'A', 'suppliermsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085731289853620224', 'SUPER_ADMIN', 'supplierList', '5727D33E929F0C453D3497E054971657', null, 'revoke', 'button', 'API', '撤销', '2019-01-17 10:51:26', '998461184120242176', 'A', 'suppliermsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085731386796568576', 'SUPER_ADMIN', 'supplierList', 'BB2D99840A98458CA37FC0FB03033DE4', null, 'cancel', 'button', 'API', '作废', '2019-01-17 10:51:49', '998461184120242176', 'A', 'suppliermsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085731768234962944', 'SUPER_ADMIN', 'supplierList', '95F7E7B6308B95F6758A4C724033DB15', null, 'alloc', 'button', 'API', '分配', '2019-01-17 10:53:20', '998461184120242176', 'A', 'suppliermsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085731881422450688', 'SUPER_ADMIN', 'rcSupplier', '78764DF46C7B72E1AFBB8EC89A628359', null, 'create', 'button', 'API', '新增', '2019-01-17 10:53:47', '998461184120242176', 'A', 'supplierrcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732059621650432', 'SUPER_ADMIN', 'rcSupplier', '2C456C94A3FE739D12D32FC8DD1E10B2', null, 'edit', 'button', 'API', '编辑', '2019-01-17 10:54:30', '998461184120242176', 'A', 'supplierrcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732217465892864', 'SUPER_ADMIN', 'rcSupplier', '2CF2B8DC3F72F7040CE2DCFA9B4A8866', null, 'delete', 'button', 'API', '删除', '2019-01-17 10:55:07', '998461184120242176', 'A', 'supplierrcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732331844562944', 'SUPER_ADMIN', 'brand', '91E4ACF75A621F9D462A261B32235FFE', null, 'createBrand', 'button', 'API', '新增品牌', '2019-01-17 10:55:35', '1000947851343175680', 'A', 'brandresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732413004345344', 'SUPER_ADMIN', 'brand', 'A7122A5569C45C7E32A6DADE4D3A1598', null, 'editBrand', 'button', 'API', '编辑品牌', '2019-01-17 10:55:54', '1000947851343175680', 'A', 'brandresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732439990497280', 'SUPER_ADMIN', 'rcSupplier', '46E98C32772A33FB59D5108176BBD955', null, 'copy', 'button', 'API', '复制', '2019-01-17 10:56:00', '998461184120242176', 'A', 'supplierrcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732494952656896', 'SUPER_ADMIN', 'brand', 'E837F880F7E934172B8B0CA952C4E758', null, 'deleteBrand', 'button', 'API', '删除品牌', '2019-01-17 10:56:13', '1000947851343175680', 'A', 'brandresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732588695351296', 'SUPER_ADMIN', 'rcSupplier', 'C68366E4A60F7F8E1CD42FDED3FB5A55', null, 'revoke', 'button', 'API', '撤销', '2019-01-17 10:56:36', '998461184120242176', 'A', 'supplierrcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732801635971072', 'SUPER_ADMIN', 'rcSupplier', 'CFDC9E8B7AE68B40133432CFD5D7F6D2', null, 'cancel', 'button', 'API', '作废', '2019-01-17 10:57:27', '998461184120242176', 'A', 'supplierrcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732964387549184', 'SUPER_ADMIN', 'rcSupplier', 'C793757B84DB4A1131D03753591E64FB', null, 'alloc', 'button', 'API', '分配', '2019-01-17 10:58:05', '998461184120242176', 'A', 'supplierrcresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085732975062052864', 'SUPER_ADMIN', 'brand', '2BB29BD9D8676578EC698FDAA46DD970', null, 'lockBrand', 'button', 'API', '禁用启用品牌', '2019-01-17 10:58:08', '1000947851343175680', 'A', 'brandresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085733227643039744', 'SUPER_ADMIN', 'rcSupplier', '0F882929DF94AA3BD693822EC22BC385', null, 'check', 'button', 'API', '查看', '2019-01-17 10:59:08', '998461184120242176', 'A', 'spuresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085733774303457280', 'SUPER_ADMIN', 'service', '1723A3589A666C2254CDBC53BA584BAC', null, 'createServer', 'button', 'API', '新增服务', '2019-01-17 11:01:18', '1000947851343175680', 'A', 'solutionresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085733856054636544', 'SUPER_ADMIN', 'service', '1723A3589A666C2254CDBC53BA584BAC', null, 'editServer', 'button', 'API', '编辑服务', '2019-01-17 11:01:38', '1000947851343175680', 'A', 'solutionresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085734056089382912', 'SUPER_ADMIN', 'service', 'F4D56383F25173C020653E6744FEC3C2', null, 'cancelServer', 'button', 'API', '撤销服务', '2019-01-17 11:02:26', '1000947851343175680', 'A', 'solutionresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085734256115740672', 'SUPER_ADMIN', 'properties', 'C2201E9F558ED4259426FDF83D6BB11D', null, 'editProps', 'button', 'API', '编辑', '2019-01-17 11:03:13', '1000996200205328384', 'A', 'propertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085734345601216512', 'SUPER_ADMIN', 'properties', 'E31269AF42BCF16A29512FF87DD63EB4', null, 'createProps', 'button', 'API', '新增', '2019-01-17 11:03:35', '1000996200205328384', 'A', 'propertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085734371698176000', 'SUPER_ADMIN', 'service', '8AED29A8ABD4CFB61F61E43F677C9F8D', null, 'bolishServer', 'button', 'API', '作废服务', '2019-01-17 11:03:41', '1000947851343175680', 'A', 'solutionresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085734463830257664', 'SUPER_ADMIN', 'service', '8DE759FF2C38FCDAA687745500C22329', null, 'getServerDetail', 'button', 'API', '查看详情', '2019-01-17 11:04:03', '1000947851343175680', 'A', 'solutionresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085735014890500096', 'SUPER_ADMIN', 'service', 'EDFD1A84C31C62932819A38878AC38F9', null, 'deleteServer', 'button', 'API', '删除服务', '2019-01-17 11:06:14', '1000947851343175680', 'A', 'solutionresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085736249408385024', 'SUPER_ADMIN', 'project', '3B77525136709AE46F028442FE9D7185', null, 'createProject', 'button', 'API', '新增项目', '2019-01-17 11:11:09', '1000947851343175680', 'A', 'projectresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085736323232329728', 'SUPER_ADMIN', 'project', '576F349A6F6C205203DF9B0523A3B2D3', null, 'editProject', 'button', 'API', '编辑项目', '2019-01-17 11:11:26', '1000947851343175680', 'A', 'projectresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085736391112945664', 'SUPER_ADMIN', 'project', '52E99C7F9F4971A9E91AFF74B7314A6D', null, 'deleteProject', 'button', 'API', '删除项目', '2019-01-17 11:11:42', '1000947851343175680', 'A', 'projectresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085737044933636096', 'SUPER_ADMIN', 'contractMessage', '65FE17A7E3B9841DD83FB069BF14FE61', null, 'edit', 'button', 'API', '编辑', '2019-01-17 11:14:18', '998461184120242176', 'A', 'contractresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085737202714963968', 'SUPER_ADMIN', 'contractMessage', 'CACC90E322EC43D04091A0E0F12CB4B0', null, 'check', 'button', 'API', '详情', '2019-01-17 11:14:56', '998461184120242176', 'A', 'contractresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085738709308960768', 'SUPER_ADMIN', 'productCatalog', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'export', 'button', 'API', '导出', '2019-01-17 11:20:55', '998461184120242176', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085739569535545344', 'SUPER_ADMIN', 'storeShip', 'FC023770D72E0194050097C9B3731175', null, 'queryStockShip', 'button', 'API', '查询', '2019-01-17 11:24:20', '1000947793512112128', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085742648083378176', 'SUPER_ADMIN', 'rcProduct', 'F5A48E6EA9B744C207A4CEE3D2DFD746', null, 'createRcProduct', 'button', 'API', '新增', '2019-01-17 11:36:34', '1000996200205328384', 'A', 'spuresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085742775376310272', 'SUPER_ADMIN', 'rcProduct', '01AE0413ED6F1D5D9DFA1F46024F8DAF', null, 'distriRcProduct', 'button', 'API', '分配负责人', '2019-01-17 11:37:04', '1000996200205328384', 'A', 'spuresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085742965449584640', 'SUPER_ADMIN', 'rcProduct', '16746ADC540B71AF3E3A848D4BDBB165', null, 'editRcProduct', 'button', 'API', '编辑', '2019-01-17 11:37:50', '1000996200205328384', 'A', 'spuresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085743569710379008', 'SUPER_ADMIN', 'offerList', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'export', 'button', 'API', '导出', '2019-01-17 11:40:14', '998461184120242176', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085743615898054656', 'SUPER_ADMIN', 'myTaskOrder', 'C1084E0B4692A296B89F36C183A28EE0', null, 'createTask', 'button', 'API', '新增', '2019-01-17 11:40:25', '1000996200205328384', 'A', 'taskresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085743844357599232', 'SUPER_ADMIN', 'offerList', '54DA5061E618B2111BFEE12D030B9893', null, 'startOffer', 'button', 'API', '开始报价', '2019-01-17 11:41:19', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085744153586855936', 'SUPER_ADMIN', 'offerList', '843A75EFFD0E52877225105ACF5BC8E6', null, 'checkOfferRecord', 'button', 'API', '查看报价记录', '2019-01-17 11:42:33', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085744474992177152', 'SUPER_ADMIN', 'offerList', '58066A72181069D1154A4174D9BD3AD2', null, 'check', 'button', 'API', '查看', '2019-01-17 11:43:50', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085744689748930560', 'SUPER_ADMIN', 'offerList', '58066A72181069D1154A4174D9BD3AD2', null, 'handle', 'button', 'API', '处理', '2019-01-17 11:44:41', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085744983857721344', 'SUPER_ADMIN', 'offerList', '08B7E10D12E18C9425EDCB6A06FC2A0B', null, 'edit', 'button', 'API', '编辑', '2019-01-17 11:45:51', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085745408988180480', 'SUPER_ADMIN', 'rcOfferList', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'export', 'button', 'API', '导出', '2019-01-17 11:47:32', '998461184120242176', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085745885234622464', 'SUPER_ADMIN', 'rcOfferList', '54DA5061E618B2111BFEE12D030B9893', null, 'startOffer', 'button', 'API', '开始报价', '2019-01-17 11:49:26', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085746066730545152', 'SUPER_ADMIN', 'rcOfferList', '37F9C7E17B8EB69E11A61C62A3C4C9E8', null, 'checkOfferRecord', 'button', 'API', '查看报价记录', '2019-01-17 11:50:09', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085746223358439424', 'SUPER_ADMIN', 'rcOfferList', '37F9C7E17B8EB69E11A61C62A3C4C9E8', null, 'check', 'button', 'API', '查看', '2019-01-17 11:50:46', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085746422067785728', 'SUPER_ADMIN', 'rcOfferList', '37F9C7E17B8EB69E11A61C62A3C4C9E8', null, 'handle', 'button', 'API', '处理', '2019-01-17 11:51:34', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085746584861306880', 'SUPER_ADMIN', 'rcOfferList', 'B1B36BEAC1EB03D55A0B2E7939721197', null, 'edit', 'button', 'API', '编辑', '2019-01-17 11:52:13', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085747073191538688', 'SUPER_ADMIN', 'quotation', 'WEB0001', null, 'exportRecord', 'button', 'WEB', '导出', '2019-01-17 11:54:09', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085747196265000960', 'SUPER_ADMIN', 'quotation', 'WEB0001', null, 'importRecord', 'button', 'WEB', '导入', '2019-01-17 11:54:38', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085747471860133888', 'SUPER_ADMIN', 'quotation', '843A75EFFD0E52877225105ACF5BC8E6', null, 'checkOfferRecord', 'button', 'API', '查看报价记录', '2019-01-17 11:55:44', '1000996200205328384', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085747918167633920', 'SUPER_ADMIN', 'rcQuotation', 'WEB0001', null, 'exportRecord', 'button', 'WEB', '导出', '2019-01-17 11:57:31', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085747959129206784', 'SUPER_ADMIN', 'rcQuotation', 'WEB0001', null, ' importRecord', 'button', 'WEB', '导入', '2019-01-17 11:57:40', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085748118416289792', 'SUPER_ADMIN', 'rcQuotation', 'D651437C18FECF6B5467A8A9D83DB14C', null, 'checkOfferRecord', 'button', 'API', '查看报价记录', '2019-01-17 11:58:18', '1000996200205328384', 'A', 'offerrcrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085748303804526592', 'SUPER_ADMIN', 'myTaskOrder', 'WEB0001', null, 'handleMyTask', 'button', 'WEB', '处理', '2019-01-17 11:59:03', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085748395798196224', 'SUPER_ADMIN', 'myTaskOrder', 'A0878D61C57169F381FAEF5ADE97A0CD', null, 'distriMyTask', 'button', 'API', '指派负责人', '2019-01-17 11:59:24', '1000996200205328384', 'A', 'taskresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085748475049570304', 'SUPER_ADMIN', 'myTaskOrder', 'C379356E7982276732B7A9494924B965', null, 'editMyTask', 'button', 'API', '编辑', '2019-01-17 11:59:43', '1000996200205328384', 'A', 'taskresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085748574542655488', 'SUPER_ADMIN', 'myTaskOrder', 'C0897B32DEA73DF930C7826FB652BB40', null, 'checkDetailMyTask', 'button', 'API', '查看', '2019-01-17 12:00:07', '1000996200205328384', 'A', 'taskresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085748749541601280', 'SUPER_ADMIN', 'taskOrder', 'WEB0001', null, 'exportTask', 'button', 'WEB', '导出', '2019-01-17 12:00:49', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085782661932281856', 'SUPER_ADMIN', 'offerList', '26364FA6FD4E5EF95AA83F858142AB33', null, 'addProducts', 'button', 'API', '新增商品', '2019-01-17 14:15:34', '998461184120242176', 'A', 'spuresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085782894296723456', 'SUPER_ADMIN', 'offerList', '2473206A54ADC31013893ED8C97B5724', null, 'deleteProducts', 'button', 'API', '删除商品', '2019-01-17 14:17:53', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085783161738129408', 'SUPER_ADMIN', 'offerList', '5617BF55F5E953F038138C99BAB99CCD', null, 'allocProducts', 'button', 'API', '分配商品', '2019-01-17 14:17:33', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085783694553149440', 'SUPER_ADMIN', 'rcOfferList', 'D2936DE80331C0A057AEC0C162173426', null, 'addProducts', 'button', 'API', '新增商品', '2019-01-17 14:19:40', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085783876833406976', 'SUPER_ADMIN', 'rcOfferList', '2473206A54ADC31013893ED8C97B5724', null, 'deleteProducts', 'button', 'API', '删除商品', '2019-01-17 14:20:24', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085784083629371392', 'SUPER_ADMIN', 'rcOfferList', '25FD3F54AA28C0112BC1FCC18906F9C7', null, 'allocProducts', 'button', 'API', '分配商品', '2019-01-17 14:21:13', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085787972248301568', 'SUPER_ADMIN', 'myOfferList', '3EEC23F253600994AFF8A2F1093558D0', null, 'offer', 'button', 'API', '报价', '2019-01-17 14:36:40', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085788313438154752', 'SUPER_ADMIN', 'myOfferList', 'A9156AF21A2A232AF12913244CBF0881', null, 'check', 'button', 'API', '查看', '2019-01-17 14:38:02', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085788425325408256', 'SUPER_ADMIN', 'myOfferList', 'A6510A83D8E00BB6B7C94BE140883F3F', null, 'edit', 'button', 'API', '编辑', '2019-01-17 14:38:28', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085788525640577024', 'SUPER_ADMIN', 'myOfferList', '4B0F7E413B0ED618C34C63EF67218035', null, 'delete', 'button', 'API', '删除', '2019-01-17 14:38:52', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085788735930396672', 'SUPER_ADMIN', 'rcMyOfferList', 'A9156AF21A2A232AF12913244CBF0881', null, 'offer', 'button', 'API', '报价', '2019-01-17 14:39:42', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085788876577992704', 'SUPER_ADMIN', 'rcMyOfferList', 'D651437C18FECF6B5467A8A9D83DB14C', null, 'check', 'button', 'API', '查看', '2019-01-17 14:40:16', '998461184120242176', 'A', 'offerrcrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085788955502211072', 'SUPER_ADMIN', 'rcMyOfferList', '33C358D0372DE955162CA5D762A81D7A', null, 'edit', 'button', 'API', '编辑', '2019-01-17 14:40:35', '998461184120242176', 'A', 'offerrcrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085789030353760256', 'SUPER_ADMIN', 'rcMyOfferList', '7A1DE4E1B0486A72D2A0519828893C40', null, 'delete', 'button', 'API', '删除', '2019-01-17 14:40:52', '998461184120242176', 'A', 'offerrcrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085789918392774656', 'SUPER_ADMIN', 'myOfferList', 'BE2528BDC9C816BBB17C356013F13194', null, 'checkProduct', 'button', 'API', '查看商品', '2019-01-17 14:44:24', '998461184120242176', 'A', 'offerformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085790229937287168', 'SUPER_ADMIN', 'rcMyOfferList', '899EBAAF562C22261CE74C859BB6AC3A', null, 'checkProduct', 'button', 'API', '查看商品', '2019-01-17 14:45:38', '998461184120242176', 'A', 'offerrcformresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085791036652941312', 'SUPER_ADMIN', 'allOfferRecord', '3A852B7BA23BD196D58394EB60BD9064', null, 'submit', 'button', 'API', '提交', '2019-01-17 14:48:51', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085791149211283456', 'SUPER_ADMIN', 'allOfferRecord', 'A6510A83D8E00BB6B7C94BE140883F3F', null, 'edit', 'button', 'API', '编辑', '2019-01-17 14:49:18', '998461184120242176', 'A', 'offerrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085791246028402688', 'SUPER_ADMIN', 'rcAllOfferRecord', 'E5F8B66AA93CCB13463A6A31D02E8917', null, 'submit', 'button', 'API', '提交', '2019-01-17 14:49:41', '998461184120242176', 'A', 'offerrcrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085791318547918848', 'SUPER_ADMIN', 'rcAllOfferRecord', '33C358D0372DE955162CA5D762A81D7A', null, 'edit', 'button', 'API', '编辑', '2019-01-17 14:49:58', '998461184120242176', 'A', 'offerrcrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085796892446584832', 'SUPER_ADMIN', 'accountApply', '0CB9ED8E0D859643FC33AB0B14BDF4D8', null, 'check', 'button', 'API', '查看', '2019-01-17 15:12:07', '998461184120242176', 'A', 'costaccountingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085797030216888320', 'SUPER_ADMIN', 'accountApply', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'export', 'button', 'API', '导出', '2019-01-17 15:12:40', '998461184120242176', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085797225193304064', 'SUPER_ADMIN', 'accountApply', 'F379ABCA996E2F67B86228FCE44E20C8', null, 'cancel', 'button', 'API', '作废', '2019-01-17 15:13:26', '998461184120242176', 'A', 'costaccountingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085797317308608512', 'SUPER_ADMIN', 'accountApply', 'ECE2D091846CF3EEB32437542B6F349E', null, 'reject', 'button', 'API', '驳回', '2019-01-17 15:13:48', '998461184120242176', 'A', 'costaccountingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085797519260151808', 'SUPER_ADMIN', 'accountApply', 'CE6B59FF5B8A1F31A365D5610F23F9A7', null, 'submit', 'button', 'API', '提交', '2019-01-17 15:14:36', '998461184120242176', 'A', 'costaccountingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085797605503430656', 'SUPER_ADMIN', 'accountApply', '38AE888538102798164ECB1508D7AACB', null, 'edit', 'button', 'API', '编辑', '2019-01-17 15:14:57', '998461184120242176', 'A', 'costaccountingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085814764916994048', 'SUPER_ADMIN', 'type', 'E2B863B64DE0DAC2DCC6E723047F641F', null, 'addType', 'button', 'API', '新增', '2019-01-17 16:23:08', '1085017925850607616', 'A', 'typecategoryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085814879933198336', 'SUPER_ADMIN', 'type', '73A2F2100A2016FA59F497D3B8D63A44', null, 'editType', 'button', 'API', '编辑', '2019-01-17 16:23:35', '1085017925850607616', 'A', 'typecategoryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085815122028425216', 'SUPER_ADMIN', 'customerVisitRecord', '3B3C6C14769E192658532BBC1958683F', null, 'addCustomerVisitRecord', 'button', 'API', '新增', '2019-01-17 16:24:33', '1085017925850607616', 'A', 'visitrecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085815576217022464', 'SUPER_ADMIN', 'produceOrder', 'B14F2260132730BAB7C1DAF45F0F83B5', null, 'showProduceOrderPros', 'button', 'API', '查看商品', '2019-01-17 17:19:20', '1085017925850607616', 'A', 'produceorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085815782086045696', 'SUPER_ADMIN', 'produceOrder', '60350F1435F5EEE505DFB9F00F4528F2', null, 'queryProduceOrderApply', 'button', 'API', '查询申请单', '2019-01-17 17:19:13', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085815971836358656', 'SUPER_ADMIN', 'produceOrder', 'DE6E0980A85FF43B2EE6592A96238D79', null, 'allotProduceOrderOperator', 'button', 'API', '分配操作人', '2019-01-17 16:27:56', '1085017925850607616', 'A', 'produceorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085816324912869376', 'SUPER_ADMIN', 'produceOrder', '60350F1435F5EEE505DFB9F00F4528F2', null, 'showProduceOrderApply', 'button', 'API', '查看申请单', '2019-01-17 16:29:20', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085816445046124544', 'SUPER_ADMIN', 'produceOrder', '8915234083264E031A96B862B9B0FD7B', null, 'checkProduceOrderApply', 'button', 'API', '审核申请单', '2019-01-17 16:29:49', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085816653016494080', 'SUPER_ADMIN', 'produceOrder', 'D5F899408C1B07116E068B837CA7B897', null, 'affirmProduceOrder', 'button', 'API', '确认', '2019-01-17 16:30:38', '1085017925850607616', 'A', 'produceorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085816848198430720', 'SUPER_ADMIN', 'myProduceOrder', 'B14F2260132730BAB7C1DAF45F0F83B5', null, 'showMyProduceOrderPros', 'button', 'API', '查看商品', '2019-01-17 16:36:29', '1085017925850607616', 'A', 'produceorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085817018180988928', 'SUPER_ADMIN', 'myProduceOrder', '3391E213CAA7DFA6F1B08BEA9C1576A3', null, 'queryMyProduceOrderApply', 'button', 'API', '查询申请单', '2019-01-17 16:36:23', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085817344648835072', 'SUPER_ADMIN', 'myProduceOrder', 'D07ADE829A96AE67503F9DBF3E842B35', null, 'fillProduceOrderApply', 'button', 'API', '填写申请信息', '2019-01-17 16:38:03', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085817468124950528', 'SUPER_ADMIN', 'myProduceOrder', '30F97A3428A10BA216B650860784B43B', null, 'addProduceOrderApply', 'button', 'API', '创建申请单', '2019-01-17 16:36:39', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085817653672570880', 'SUPER_ADMIN', 'myProduceOrder', '7B3482A7211DB82BBACBC7B65F73585D', null, 'batchAddProduceOrderApply', 'button', 'API', '批量创建申请单', '2019-01-17 16:36:17', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085817999576821760', 'SUPER_ADMIN', 'myProduceOrder', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'exportProduceOrderApply', 'button', 'API', '导出申请单', '2019-01-17 16:35:59', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085818260387033088', 'SUPER_ADMIN', 'myProduceOrder', '9EE7C66DE38E2491C533A32D90D2D1B3', null, 'submitProduceOrderApply', 'button', 'API', '提交申请单', '2019-01-17 16:37:01', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085818385431818240', 'SUPER_ADMIN', 'myProduceOrder', '1724CDC47F9AEEF66B5A273B315060CD', null, 'showMyProduceOrderApply', 'button', 'API', '查看申请单', '2019-01-17 17:16:32', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085818470894956544', 'SUPER_ADMIN', 'myProduceOrder', '4F9E1FB021204033DB0ECE7847AEA23C', null, 'deleteProduceOrderApply', 'button', 'API', '删除申请单', '2019-01-17 16:37:52', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085818632954474496', 'SUPER_ADMIN', 'myProduceOrder', '31CD03A8E84D3F83F0CD4F1C9A97B5FA', null, 'goProduce', 'button', 'API', '去生产', '2019-01-17 16:38:30', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085820027921264640', 'SUPER_ADMIN', 'purchaseOrder', 'DF8696906D5D092AA3DD1E8C55987B84', null, 'showPurchaseOrderPros', 'button', 'API', '查看商品', '2019-01-17 16:44:03', '1085017925850607616', 'A', 'producercorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085823410182844416', 'SUPER_ADMIN', 'purchaseOrder', 'D47A29D85507A0ED9CCBE92471AC5081', null, 'queryPurchaseOrderApply', 'button', 'API', '查询申请单', '2019-01-17 16:57:29', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085825916690526208', 'SUPER_ADMIN', 'purchaseOrder', '00DBCB21382B715783E9934BA86BE307', null, 'allotPurchaseOrderOperator', 'button', 'API', '分配操作人', '2019-01-17 17:07:27', '1085017925850607616', 'A', 'producercorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085826212120522752', 'SUPER_ADMIN', 'purchaseOrder', 'D1E147B248D1A666F32391A488AB2674', null, 'showPurchaseOrderApply', 'button', 'API', '查看申请单', '2019-01-17 17:08:37', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085826340277481472', 'SUPER_ADMIN', 'purchaseOrder', '29D57734F465F8F5A45E9B9639C476F5', null, 'checkPurchaseOrderApply', 'button', 'API', '审核申请单', '2019-01-17 17:09:08', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085826455046221824', 'SUPER_ADMIN', 'purchaseOrder', 'ED430A69AA79C16243B32CA90A706848', null, 'affirmPurchaseOrder', 'button', 'API', '确认', '2019-01-17 17:09:35', '1085017925850607616', 'A', 'producercorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085826603730104320', 'SUPER_ADMIN', 'purchaseOrder', 'F721F71A9B415EFC97A00E1C545946BE', null, 'purchaseOrderDemandDetail', 'button', 'API', '需求详情', '2019-01-17 17:10:11', '1085017925850607616', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085826898551926784', 'SUPER_ADMIN', 'myPurchaseOrder', 'DF8696906D5D092AA3DD1E8C55987B84', null, 'showMyPurchaseOrderPros', 'button', 'API', '查看商品', '2019-01-17 17:11:21', '1085017925850607616', 'A', 'producercorderresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085827042844372992', 'SUPER_ADMIN', 'myPurchaseOrder', 'D47A29D85507A0ED9CCBE92471AC5081', null, 'queryMyPurchaseOrderApply', 'button', 'API', '查询申请单', '2019-01-17 17:11:55', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085827136029224960', 'SUPER_ADMIN', 'myPurchaseOrder', 'E9B6924A51F59759238911677CD2DC46', null, 'fillPurchaseOrderApply', 'button', 'API', '填写申请信息', '2019-01-17 17:12:18', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085827212621410304', 'SUPER_ADMIN', 'myPurchaseOrder', 'B422F0DE9D20EBC2EAF6AA31901E5B13', null, 'addPurchaseOrderApply', 'button', 'API', '创建申请单', '2019-01-17 17:12:36', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085827390824804352', 'SUPER_ADMIN', 'myPurchaseOrder', 'C12130CCBC606D45FEEE7A57DB092EBD', null, 'batchAddPurchaseOrderApply', 'button', 'API', '批量创建申请单', '2019-01-17 17:13:18', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085827505086033920', 'SUPER_ADMIN', 'myPurchaseOrder', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'exportPurchaseOrderApply', 'button', 'API', '导出申请单', '2019-01-17 17:13:46', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085827604474261504', 'SUPER_ADMIN', 'myPurchaseOrder', '797AE26D2A9D446EFC7F2D53D8E7D10C', null, 'submitPurchaseOrderApply', 'button', 'API', '提交申请单', '2019-01-17 17:14:09', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085827706467151872', 'SUPER_ADMIN', 'myPurchaseOrder', '7C03F4C317FBBC9972984A90ADDFCF5B', null, 'editPurchaseOrderApply', 'button', 'API', '编辑申请单', '2019-01-17 17:14:34', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085827898276868096', 'SUPER_ADMIN', 'myPurchaseOrder', 'D1E147B248D1A666F32391A488AB2674', null, 'showMyPurchaseOrderApply', 'button', 'API', '查看申请单', '2019-01-17 17:15:19', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085828325131186176', 'SUPER_ADMIN', 'myProduceOrder', 'BF276B8654DB78BE188DC76817863E19', null, 'editProduceOrderApply', 'button', 'API', '编辑申请单', '2019-01-17 17:17:01', '1085017925850607616', 'A', 'produceapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085829108681699328', 'SUPER_ADMIN', 'myPurchaseOrder', '5FB1912F3F78ECAB9730E62ED829EC3F', null, 'deletePurchaseOrderApply', 'button', 'API', '删除申请单', '2019-01-17 17:20:08', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085829220107579392', 'SUPER_ADMIN', 'myPurchaseOrder', '53A5FE0777C229E373F7AC206568FEBA', null, 'goPurchase', 'button', 'API', '去采购', '2019-01-17 17:20:34', '1085017925850607616', 'A', 'producercapplyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085829369395441664', 'SUPER_ADMIN', 'myPurchaseOrder', 'F721F71A9B415EFC97A00E1C545946BE', null, 'myPurchaseOrderDemandDetail', 'button', 'API', '需求详情', '2019-01-17 17:21:10', '1085017925850607616', 'A', 'businesssheetresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085829577269342208', 'SUPER_ADMIN', 'mainWarehouse', 'C7D8E38AFDD10F9725982EAA7C1E49F4', null, 'allotWarehouse', 'button', 'API', '分配', '2019-01-17 17:22:00', '1085017925850607616', 'A', 'storeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085829718512529408', 'SUPER_ADMIN', 'mainWarehouse', '1AFF2B237FC808F457F060311422D0A0', null, 'editWarehouse', 'button', 'API', '编辑', '2019-01-17 17:22:33', '1085017925850607616', 'A', 'storeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085831068998725632', 'SUPER_ADMIN', 'mainWarehouse', '04BFAD67D0A2CCBF93AD1B332A7AA3DF', null, 'shelfManage', 'button', 'API', '货架管理', '2019-01-17 17:27:55', '1085017925850607616', 'A', 'storeshelfresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085831191006834688', 'SUPER_ADMIN', 'mainWarehouse', 'DB352C008F8E04C8F9DCA8AE6C44DFAE', null, 'addShelf', 'button', 'API', '新增货架', '2019-01-17 17:28:24', '1085017925850607616', 'A', 'storeshelfresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085831841887318016', 'SUPER_ADMIN', 'mainWarehouse', 'D26FA00CF70F74FB1A70BEE273EA9FE3', null, 'deleteShelf', 'button', 'API', '删除货架', '2019-01-17 17:31:00', '1085017925850607616', 'A', 'storeshelfresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085831963060760576', 'SUPER_ADMIN', 'mainWarehouse', 'D26FA00CF70F74FB1A70BEE273EA9FE3', null, 'batchDeleteShelf', 'button', 'API', '批量删除货架', '2019-01-17 17:31:28', '1085017925850607616', 'A', 'storeshelfresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085834196779298816', 'SUPER_ADMIN', 'mainWarehouse', 'A038FBFBA227CB117FD60F1491FB6378', null, 'addWarehouse', 'button', 'API', '新增', '2019-01-17 17:40:21', '1085017925850607616', 'A', 'storeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085834385351012352', 'SUPER_ADMIN', 'myWarehouse', 'C7D8E38AFDD10F9725982EAA7C1E49F4', null, 'allotMyWarehouse', 'button', 'API', '分配', '2019-01-17 17:41:06', '1085017925850607616', 'A', 'storeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085834469857849344', 'SUPER_ADMIN', 'myWarehouse', '1AFF2B237FC808F457F060311422D0A0', null, 'editMyWarehouse', 'button', 'API', '编辑', '2019-01-17 17:41:26', '1085017925850607616', 'A', 'storeresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085834589382930432', 'SUPER_ADMIN', 'myWarehouse', '04BFAD67D0A2CCBF93AD1B332A7AA3DF', null, 'myShelfManage', 'button', 'API', '货架管理', '2019-01-17 17:41:55', '1085017925850607616', 'A', 'storeshelfresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085834697709219840', 'SUPER_ADMIN', 'myWarehouse', 'DB352C008F8E04C8F9DCA8AE6C44DFAE', null, 'addShelf', 'button', 'API', '新增货架', '2019-01-17 17:42:20', '1085017925850607616', 'A', 'storeshelfresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085834765006827520', 'SUPER_ADMIN', 'myWarehouse', 'D26FA00CF70F74FB1A70BEE273EA9FE3', null, 'deleteShelf', 'button', 'API', '删除货架', '2019-01-17 17:42:36', '1085017925850607616', 'A', 'storeshelfresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085834845197725696', 'SUPER_ADMIN', 'myWarehouse', 'D26FA00CF70F74FB1A70BEE273EA9FE3', null, 'batchDeleteShelf', 'button', 'API', '批量删除货架', '2019-01-17 17:42:56', '1085017925850607616', 'A', 'storeshelfresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085835620300910592', 'SUPER_ADMIN', 'inventoryList', '6241570BB7F3282D31A439BFC0803E5A', null, 'showInventory', 'button', 'API', '查看商品', '2019-01-17 17:46:00', '1085017925850607616', 'A', 'stockresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085835769391640576', 'SUPER_ADMIN', 'inventoryList', '1B62B03962CB4460E002A015B55BB368', null, 'showProsOutAndIn', 'button', 'API', '出入库记录', '2019-01-17 17:46:36', '1085017925850607616', 'A', 'stockchangerecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085835880905601024', 'SUPER_ADMIN', 'inventoryList', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'exportInventory', 'button', 'API', '导出', '2019-01-17 17:47:34', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085835988049096704', 'SUPER_ADMIN', 'inventoryList', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'exportProsOutAndIn', 'button', 'API', '导出出入库记录', '2019-01-17 17:47:28', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085836208774344704', 'SUPER_ADMIN', 'myInventory', 'D4FADD2665D65D7023A9362045AA7F6D', null, 'showMyInventory', 'button', 'API', '查看商品', '2019-01-17 17:48:21', '1085017925850607616', 'A', 'stockresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085836306304495616', 'SUPER_ADMIN', 'myInventory', '77874BB71CB825D47B727DE9007CD034', null, 'showMyProsOutAndIn', 'button', 'API', '出入库记录', '2019-01-17 17:48:44', '1085017925850607616', 'A', 'stockchangerecordresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085836405998907392', 'SUPER_ADMIN', 'myInventory', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'exportMyInventory', 'button', 'API', '导出', '2019-01-17 17:49:08', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085836515004674048', 'SUPER_ADMIN', 'myInventory', '662FDB3DAA5411C6C2DE877AC8D8929F', null, 'exportMyProsOutAndIn', 'button', 'API', '导出出入库记录', '2019-01-17 17:49:34', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085836867095523328', 'SUPER_ADMIN', 'inStoreList', '674415A3D06BDEF11E947C0D329213F3', null, 'disposeInStock', 'button', 'API', '处理', '2019-01-17 17:50:58', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085837085442600960', 'SUPER_ADMIN', 'inStoreList', '57791B243E3000FC63C30877C321DC8A', null, 'showInStock', 'button', 'API', '详情', '2019-01-17 17:51:50', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085837307912679424', 'SUPER_ADMIN', 'outStore', 'BAAD4B189472F85EA4FC0C4BF16A2100', null, 'allOutStockAllotStock', 'button', 'API', '分配仓库', '2019-01-17 17:52:43', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085837411574902784', 'SUPER_ADMIN', 'outStore', '0C69E473CDC940C3249D584043A13E9A', null, 'allOutStockAllotBox', 'button', 'API', '分配箱子', '2019-01-17 17:53:07', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085837492088762368', 'SUPER_ADMIN', 'outStore', 'FB5C92E39057D1D6543A66184C617A14', null, 'showAllOutStock', 'button', 'API', '详情', '2019-01-17 17:53:27', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085837596908613632', 'SUPER_ADMIN', 'outStore', '622DE409DD8893754C93AF5ED510F8A0', null, 'exportAllOutStock', 'button', 'API', '导出', '2019-01-17 17:53:52', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085837736943841280', 'SUPER_ADMIN', 'outStoreList', 'E5B13DDEDFCEB67C7A0349CFE52D587C', null, 'disposeMyOutStock', 'button', 'API', '处理', '2019-01-17 17:54:25', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085837884012916736', 'SUPER_ADMIN', 'outStoreList', 'FB5C92E39057D1D6543A66184C617A14', null, 'showMyOutStock', 'button', 'API', '详情', '2019-01-17 17:55:00', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085837977055162368', 'SUPER_ADMIN', 'outStoreList', '622DE409DD8893754C93AF5ED510F8A0', null, 'exportMyOutStock', 'button', 'API', '导出', '2019-01-17 17:55:22', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085838136082198528', 'SUPER_ADMIN', 'storePicking', '5EA452C9EDED54D1F281EC6C7572C565', null, 'disposePickList', 'button', 'API', '拣货完成', '2019-01-17 17:56:00', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085838295818072064', 'SUPER_ADMIN', 'storePicking', 'D1FC2E9FB788C35E85760766DEC3CD61', null, 'showPickList', 'button', 'API', '详情', '2019-01-17 17:56:38', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085838390596759552', 'SUPER_ADMIN', 'storePicking', '622DE409DD8893754C93AF5ED510F8A0', null, 'exportPickList', 'button', 'API', '导出', '2019-01-17 17:57:01', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085838520402079744', 'SUPER_ADMIN', 'outStoreBill', 'DD4AA94025AFD3461858F9BEC13DEA2B', null, 'disposeOutStockBill', 'button', 'API', '装箱完成', '2019-01-17 17:57:32', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085838634743001088', 'SUPER_ADMIN', 'outStoreBill', 'D15F1411DA55498385F93E2A9DD86B19', null, 'showOutStockBill', 'button', 'API', '详情', '2019-01-17 17:57:59', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085838762052710400', 'SUPER_ADMIN', 'storeEncasementBill', 'DC45161825ACA033B0F2F3BD2ADB7404', null, 'disposeStockEncasementBill', 'button', 'API', '复核完成', '2019-01-17 17:58:29', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085838869649190912', 'SUPER_ADMIN', 'storeEncasementBill', 'B3979031E9AAEF1754B8C98496B275E7', null, 'showStockEncasementBill', 'button', 'API', '详情', '2019-01-17 17:58:55', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085838941912854528', 'SUPER_ADMIN', 'storeEncasementBill', '622DE409DD8893754C93AF5ED510F8A0', null, 'exportStockEncasementBill', 'button', 'API', '导出', '2019-01-17 17:59:12', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085839053208711168', 'SUPER_ADMIN', 'storeCheckEncasement', 'D3C16A549A2354FA426345E0A12C5352', null, 'disposeStockCheckEncasement', 'button', 'API', '核对完成', '2019-01-17 17:59:39', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085839120007196672', 'SUPER_ADMIN', 'storeCheckEncasement', '7490504B4AE373577944EC69B173A4DB', null, 'showStockCheckEncasement', 'button', 'API', '详情', '2019-01-17 17:59:55', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085839193483014144', 'SUPER_ADMIN', 'storeCheckEncasement', '622DE409DD8893754C93AF5ED510F8A0', null, 'exportStockCheckEncasement', 'button', 'API', '导出', '2019-01-17 18:00:12', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085839297166209024', 'SUPER_ADMIN', 'storeShip', 'FA95DD89025E7CA9A330550C018EC150', null, 'disposeStockShip', 'button', 'API', '发运完成', '2019-01-17 18:00:37', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085839469380136960', 'SUPER_ADMIN', 'storeShip', '8C8341583414285542D3FFD51FDB22BA', null, 'singleStockShip', 'button', 'API', '发运', '2019-01-17 18:01:18', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085839904044249088', 'SUPER_ADMIN', 'storeShip', 'FB5C92E39057D1D6543A66184C617A14', null, 'showStockShip', 'button', 'API', '详情', '2019-01-17 18:03:02', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085839981743730688', 'SUPER_ADMIN', 'storeShip', '622DE409DD8893754C93AF5ED510F8A0', null, 'exportStockShip', 'button', 'API', '导出', '2019-01-17 18:03:20', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085840207300816896', 'SUPER_ADMIN', 'materialList', 'DCCC687D387B167632436D41362B13B8', null, 'addMaterial', 'button', 'API', '新增', '2019-01-17 18:04:14', '1085017925850607616', 'A', 'storematerialresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085840285843353600', 'SUPER_ADMIN', 'materialList', '1284145D641727B0C3ABA20468711A0A', null, 'replenishmentMaterial', 'button', 'API', '补货', '2019-01-17 18:04:33', '1085017925850607616', 'A', 'storematerialresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085840348887937024', 'SUPER_ADMIN', 'materialList', 'FF5F8A977F936BEF5A4239B2BBE2FFC3', null, 'allotMaterial', 'button', 'API', '分配', '2019-01-17 18:04:48', '1085017925850607616', 'A', 'storematerialrelationresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085840418945396736', 'SUPER_ADMIN', 'materialList', '599915293FF91F96CA6B6AC15E4864F4', null, 'showMaterial', 'button', 'API', '详情', '2019-01-17 18:05:04', '1085017925850607616', 'A', 'storematerialresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085840907665698816', 'SUPER_ADMIN', 'storeDelivery', '7573D3CFD3BF17F79B498E55914960F6', null, 'disposeStockDelivery', 'button', 'API', '交接完成', '2019-01-17 18:07:01', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085841241305804800', 'SUPER_ADMIN', 'storeDelivery', '57791B243E3000FC63C30877C321DC8A', null, 'showStockDelivery', 'button', 'API', '详情', '2019-01-17 18:08:21', '1085017925850607616', 'A', 'stockoutputresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085841313577857024', 'SUPER_ADMIN', 'storeDelivery', '622DE409DD8893754C93AF5ED510F8A0', null, 'exportStockDelivery', 'button', 'API', '导出', '2019-01-17 18:08:38', '1085017925850607616', 'A', 'exportingresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085841408755003392', 'SUPER_ADMIN', 'waveList', '88A2071A0BD79A9A74C7413662458B4A', null, 'addWave', 'button', 'API', '新增', '2019-01-17 18:09:00', '1085017925850607616', 'A', 'storepackingfrequencyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085841480536322048', 'SUPER_ADMIN', 'waveList', '98CE7506127FE7F6237A5C76F6B2A164', null, 'editWave', 'button', 'API', '编辑', '2019-01-17 18:09:18', '1085017925850607616', 'A', 'storepackingfrequencyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1085841556151234560', 'SUPER_ADMIN', 'waveList', '76A91F5088239001D9E7416B535771BA', null, 'deleteWave', 'button', 'API', '删除', '2019-01-17 18:09:36', '1085017925850607616', 'A', 'storepackingfrequencyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086085149981933568', 'SUPER_ADMIN', 'productmg', '1B116F16B05661A6E3514E7B66C8A954', null, 'createMsProduct', 'button', 'API', '新增', '2019-01-18 10:17:33', '1004905673378619392', 'A', 'spumsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086085334212542464', 'SUPER_ADMIN', 'productmg', 'DF38B402C403DA6DF096FC7C841C80F8', null, 'distriMsProduct', 'button', 'API', '分配负责人', '2019-01-18 10:18:17', '1004905673378619392', 'A', 'spumsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086085648886005760', 'SUPER_ADMIN', 'productmg', 'E0CFB5E017853D5A2B815148C7DA4F11', null, 'editMsProduct', 'button', 'API', '编辑', '2019-01-18 10:19:32', '1004905673378619392', 'A', 'spumsresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086086086511296512', 'SUPER_ADMIN', 'category', '58A5EE8EC55647FD284F9AC91EDFCE2A', null, 'editCategoryProps', 'button', 'API', '编辑', '2019-01-18 10:21:16', '1004905673378619392', 'A', 'categorypropertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086086433141161984', 'SUPER_ADMIN', 'category', 'F58BEA3FA3C3DA0A39BC6E6DF5D39975', null, 'configCategoryProps', 'button', 'API', '配置属性', '2019-01-18 10:24:27', '1000996200205328384', 'A', 'categorypropertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086087433667215360', 'SUPER_ADMIN', 'category', '4F5D04B4C5E73571CB3F663DBF1CC0F8', null, 'createCategoryProps', 'button', 'API', '新增', '2019-01-18 10:26:37', '1000996200205328384', 'A', 'categorypropertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086087645957718016', 'SUPER_ADMIN', 'properties', '1C7CD3D16D6A8843BDBF57997E920A30', null, 'deleteProps', 'button', 'API', '删除', '2019-01-18 10:27:28', '1000996200205328384', 'A', 'propertytyperesourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086087782981435392', 'SUPER_ADMIN', 'category', '5078320ADFA299F202D1347B1B11F383', null, 'deleteCategoryProps', 'button', 'API', '删除', '2019-01-18 10:28:01', '1000996200205328384', 'A', 'categorypropertyresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086088050225709056', 'SUPER_ADMIN', 'contractTemplate', 'ED62C8390D1D32EDEA432393E9EB2608', null, 'createContractTemp', 'button', 'API', '新增 ', '2019-01-18 10:29:04', '1004905673378619392', 'A', 'contracttemplateresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086088205544980480', 'SUPER_ADMIN', 'contractTemplate', 'AB299B83A1D9EBD980595752653CFDBF', null, 'deleteContractTemp', 'button', 'API', '删除', '2019-01-18 10:29:41', '1004905673378619392', 'A', 'contracttemplateresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086088284561473536', 'SUPER_ADMIN', 'contractTemplate', '78D72146BD832E07CF0436713715F50B', null, 'editContractTemp', 'button', 'API', '编辑', '2019-01-18 10:30:00', '1004905673378619392', 'A', 'contracttemplateresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086089928544092160', 'SUPER_ADMIN', 'tags', '9425D6530B855D633F01A6809A42DC6F', null, 'addCategory', 'button', 'API', '新增分类', '2019-01-18 10:36:32', '998461184120242176', 'A', 'tagcategoryresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086090380732006400', 'SUPER_ADMIN', 'tags', 'B9D8F2183026553A63417DE65169356A', null, 'addTag', 'button', 'API', '新增标签', '2019-01-18 10:38:20', '998461184120242176', 'A', 'tagresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086090539209588736', 'SUPER_ADMIN', 'tags', 'ECB9D58C70E28740B422DFD43B98C604', null, 'edit', 'button', 'API', '编辑', '2019-01-18 10:38:58', '998461184120242176', 'A', 'tagresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086090630494420992', 'SUPER_ADMIN', 'tags', '861042C19F748FC3F000E0176F33C581', null, 'delete', 'button', 'API', '删除', '2019-01-18 10:39:20', '998461184120242176', 'A', 'tagresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1086106817840283648', 'SUPER_ADMIN', 'taskOrder', 'C0897B32DEA73DF930C7826FB652BB40', null, 'checkDetailTask', 'button', 'API', '查看', '2019-01-18 11:43:39', '1000996200205328384', 'A', 'taskresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090541688075702272', 'SUPER_ADMIN', 'workflowOption', 'D36EF482AF7CD6B898EF6AA0E5870F9E', null, 'queryWorkflowNode', 'button', 'API', '查看任务', '2019-01-30 17:26:14', '1000996200205328384', 'A', 'processconfigresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090541879377907712', 'SUPER_ADMIN', 'workflowOption', 'WEB0001', null, 'workflowBtnConfig', 'button', 'WEB', '按钮配置', '2019-01-30 17:27:00', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090541934281347072', 'SUPER_ADMIN', 'workflowOption', 'WEB0001', null, 'workflowFormConfig', 'button', 'WEB', '表单配置', '2019-01-30 17:27:13', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090544066178961408', 'SUPER_ADMIN', 'workflowInstance', '03FBDC7CF1B5C0A20AC16C936F12EF99', null, 'handleStartProcess', 'button', 'API', '启动/暂停', '2019-01-30 17:35:41', '1000996200205328384', 'A', 'processinstanceresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090544186488377344', 'SUPER_ADMIN', 'workflowInstance', 'C51100F233B2A8C0390CE79745A69DB3', null, 'workflowInsTerm', 'button', 'API', '终止', '2019-01-30 17:36:10', '1000996200205328384', 'A', 'processinstanceresourcev1', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090544292478439424', 'SUPER_ADMIN', 'workflowInstance', 'WEB0001', null, 'queryWorkflowHistory', 'button', 'WEB', '历史', '2019-01-30 17:36:35', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090545488228372480', 'SUPER_ADMIN', 'workflowHandle', 'WEB0001', null, 'workflowHandleBtn', 'button', 'WEB', '处理', '2019-01-30 17:41:20', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090545544293634048', 'SUPER_ADMIN', 'workflowHandle', 'WEB0001', null, 'workflowTermBtn', 'button', 'WEB', '终止', '2019-01-30 17:41:34', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090545594293932032', 'SUPER_ADMIN', 'workflowHandle', 'WEB0001', null, 'workflowDelegateBtn', 'button', 'WEB', '委派', '2019-01-30 17:41:46', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090546467124400128', 'SUPER_ADMIN', 'workflowFormMg', 'WEB0001', null, 'createWorkflowForm', 'button', 'WEB', '新增', '2019-01-30 17:45:14', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090546509507842048', 'SUPER_ADMIN', 'workflowFormMg', 'WEB0001', null, 'editWorkflowForm', 'button', 'WEB', '编辑', '2019-01-30 17:45:24', '1000996200205328384', 'A', '', null, null, null);
INSERT INTO `security_module_operation` VALUES ('1090546546837147648', 'SUPER_ADMIN', 'workflowFormMg', 'WEB0001', null, 'deleteWorkflowForm', 'button', 'WEB', '删除', '2019-01-30 17:45:33', '1000996200205328384', 'A', '', null, null, null);

-- ----------------------------
-- Table structure for security_module_primary
-- ----------------------------
DROP TABLE IF EXISTS `security_module_primary`;
CREATE TABLE `security_module_primary` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `PRIMARY_TYPE` varchar(16) NOT NULL COMMENT '模块主体类型（USER用户|ROLE角色）',
  `PRIMARY_CODE` varchar(32) NOT NULL COMMENT '主体权限编码',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '机构编码',
  `MODULE_CODE` varchar(32) NOT NULL COMMENT '模块代码',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态 :I 非激活 /A  激活',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  KEY `INDEX_MODULE_CODE` (`MODULE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='（用户|角色）与模块关联关系表';

-- ----------------------------
-- Records of security_module_primary
-- ----------------------------

-- ----------------------------
-- Table structure for security_operation
-- ----------------------------
DROP TABLE IF EXISTS `security_operation`;
CREATE TABLE `security_operation` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `RESOURCE_CODE` varchar(50) NOT NULL COMMENT '资源编码',
  `RESOURCE_NAME` varchar(50) NOT NULL COMMENT '资源名称',
  `RES_TYPE` varchar(16) DEFAULT 'API' COMMENT '资源类型(接口资源（API）|前端资源（WEB）)',
  `OPRATE_CODE` varchar(50) DEFAULT NULL COMMENT '接口方法名称',
  `OPRATE_DESCRIPTION` varchar(64) DEFAULT NULL COMMENT '接口方法描述',
  `LEVEL_CODE` varchar(32) DEFAULT NULL COMMENT '资源操作级别（ALL|PUBLIC|AGENCY|SUPERADMIN）',
  `REQ_URL` varchar(255) DEFAULT NULL COMMENT '请求地址',
  `REQ_MODE` varchar(16) DEFAULT NULL COMMENT '请求方式get,post,put,delete',
  `FUNC_ID` varchar(32) NOT NULL COMMENT '资源操作的唯一标识',
  `IGNORE_AUTH` varchar(1) DEFAULT NULL COMMENT '接口方法是否需要验证（Y需要|N不需要）',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL DEFAULT 'A' COMMENT '数据状态 :I 非激活 /A  激活',
  `LOCK_STATUS` varchar(1) NOT NULL DEFAULT 'N' COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  KEY `INDEX_FUNC_ID` (`FUNC_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统资源信息表';

-- ----------------------------
-- Records of security_operation
-- ----------------------------
INSERT INTO `security_operation` VALUES ('1099922199554310144', 'authresourcesv1', '系统用户认证', 'API', 'authAnonymous', '匿名用户登录', 'ALL', '/1/authentication/anonymous', 'POST', 'CB64F1E65C990355966E53D284AF5EC5', 'Y', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199592058880', 'authresourcesv1', '系统用户认证', 'API', 'authSuperAdmin', '超级管理员登录。', 'SUPERADMIN', '/1/authentication/superadmin', 'POST', 'AE7B7DFC22F89671D547A4EDB411FAD1', 'Y', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199613030400', 'employeeresourcev1', '员工管理', 'API', 'createEmployee', '新增员工信息', 'AGENCY', '/1/employees', 'POST', '0A6072BB9ED2491D5D9BD417A968D870', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199638196224', 'employeeresourcev1', '员工管理', 'API', 'isEmployeeCodeUnique', '验证工号是否可用', 'AGENCY', '/1/employees/available', 'GET', '48B82F07EB2CF12DBDDAD769A76921AD', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199734665216', 'employeeresourcev1', '员工管理', 'API', 'getEmployeeForPage', '获取员工简要信息', 'SUPERADMIN', '/1/employees/brieflyEmployee', 'GET', '43688187C7E60442D26C67DC9E309B6A', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199755636736', 'employeeresourcev1', '员工管理', 'API', 'getBrieflyEmployeeByParam', '获取员工简要信息(条件查询)', 'AGENCY', '/1/employees/brieflyEmployee/by/param', 'GET', '26BF8DCF35A010BF27CA63372C320F0C', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199780802560', 'employeeresourcev1', '员工管理', 'API', 'getEmployeeForPage', '分页获取员工信息', 'AGENCY', '/1/employees/page', 'GET', '97395F2B960B1920E3FB8C5564811470', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199805968384', 'employeeresourcev1', '员工管理', 'API', 'updateEmployeePassword', '重置员工密码', 'SUPERADMIN', '/1/employees/reset/{userId}', 'PUT', 'FE62E3FE57D206D17105991C692ED527', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199864688640', 'employeeresourcev1', '员工管理', 'API', 'getEmployeeDetail', '获取员工信息详情', 'AGENCY', '/1/employees/{id}', 'GET', 'AFFA5B90EFAABCEB620D138008C664D7', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199885660160', 'employeeresourcev1', '员工管理', 'API', 'updateEmployee', '编辑员工信息', 'AGENCY', '/1/employees/{userId}', 'PUT', '81E3703E5BAB8FB9BF0197BECAC0DBD9', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199919214592', 'employeeresourcev1', '员工管理', 'API', 'updateLockStatus', '启用/禁用员工', 'AGENCY', '/1/employees/{userId}/lockStatus', 'PUT', '779770C2413FBFA27E29107117137545', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199940186112', 'moduleresourcesv1', '业务模块管理', 'API', 'createModule', '创建模块', 'SUPERADMIN', '/1/modules', 'POST', '85E0ABE745983B20BEB170660032D68A', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199965351936', 'moduleresourcesv1', '业务模块管理', 'API', 'createAgencyModuleOperation', '给商家端分配模块操作', 'SUPERADMIN', '/1/modules/agencyModuleOperation', 'POST', '1694805F4771CD2A91602D885BFA557D', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922199986323456', 'moduleresourcesv1', '业务模块管理', 'API', 'getAgencyTemplateModuleTree', '获取商家模板业务模块树', 'AGENCY', '/1/modules/agencyTemplate/tree', 'GET', 'E5BC800B9EC20E54F00B1F414910E692', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200011489280', 'moduleresourcesv1', '业务模块管理', 'API', 'getAllChildrenModule', '根据父业务模块编码获取子业务模块', 'SUPERADMIN', '/1/modules/children', 'GET', '607D93266CB265C3383043BF7962B2D2', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200032460800', 'moduleresourcesv1', '业务模块管理', 'API', 'isModuleCodeAvailable', '判断模块code是否唯一', 'SUPERADMIN', '/1/modules/moduleCode/available', 'GET', '839AECDB4845FD7A38E186CCB89745D3', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200057626624', 'moduleresourcesv1', '业务模块管理', 'API', 'createModuleOperation', '创建模块按钮', 'SUPERADMIN', '/1/modules/moduleOperation', 'POST', 'E1CF79871BD87D5001634F534F1AA675', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200078598144', 'moduleresourcesv1', '业务模块管理', 'API', 'isOperationButtonCodeAvailable', '判断模块关联的按钮编码是否唯一', 'SUPERADMIN', '/1/modules/moduleOperation/buttonCode/available', 'GET', '4848611CDE18F91E89CF2473EA17AB5D', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200103763968', 'moduleresourcesv1', '业务模块管理', 'API', 'getModuleButtonsByPage', '分页查询模块按钮', 'SUPERADMIN', '/1/modules/moduleOperation/page', 'GET', 'C64AD1CFB543034A4A10BB0DD2528C5B', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200128929792', 'moduleresourcesv1', '业务模块管理', 'API', 'updateModuleOperation', '修改模块按钮', 'SUPERADMIN', '/1/modules/moduleOperation/{moduleOperationId}', 'PUT', 'D7C96908BB620EFAC8F241CD155CF5C6', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200149901312', 'moduleresourcesv1', '业务模块管理', 'API', 'deleteModuleOperation', '删除模块按钮', 'SUPERADMIN', '/1/modules/moduleOperation/{moduleOperationId}', 'DELETE', '29B917ED3D568E7E053B51C5E86DC344', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200170872832', 'moduleresourcesv1', '业务模块管理', 'API', 'deleteModule', '删除模块', 'SUPERADMIN', '/1/modules/{agencyCode}', 'DELETE', 'AC2E121B259DF984AA9AC1EFC08457F9', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200196038656', 'moduleresourcesv1', '业务模块管理', 'API', 'getModuleTree', '根据商家编码获取业务模块树', 'SUPERADMIN', '/1/modules/{agencyCode}/tree', 'GET', 'B0F06A9F0A0725794047DED930486C18', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200217010176', 'moduleresourcesv1', '业务模块管理', 'API', 'getByModule', '根据模块编码获取模块详细信息', 'SUPERADMIN', '/1/modules/{agencyCode}/{moduleCode}', 'GET', 'F232C9C5616486F8B0C62A86275530F0', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200237981696', 'moduleresourcesv1', '业务模块管理', 'API', 'updateModule', '更新模块信息', 'SUPERADMIN', '/1/modules/{agencyCode}/{moduleCode}', 'PUT', '7B201035E1B35F7701275D4F9DA42CB4', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200263147520', 'operationresourcev1', '平台资源操作管理', 'API', 'getAllOperations', '获取系统所有资源操作', 'SUPERADMIN', '/1/operations', 'GET', 'DA4E658C1DAF29C8B5491178613841FE', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200284119040', 'operationresourcev1', '平台资源操作管理', 'API', 'createResource', '创建单个的资源操作信息', 'SUPERADMIN', '/1/operations', 'POST', '6E2C5EB4636C7546828CE6986198BAAB', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200309284864', 'operationresourcev1', '平台资源操作管理', 'API', 'deleteResources', '删除系统资源操作', 'SUPERADMIN', '/1/operations', 'DELETE', '396363F6B48DAAAEC48E1BBA0ACD222A', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200330256384', 'operationresourcev1', '平台资源操作管理', 'API', 'isFuncIdAvailable', '判断资源FID否唯一', 'AGENCY', '/1/operations/funcId/available', 'GET', '6C57988FAD7514C88A9E0E7DEF67E452', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200355422208', 'operationresourcev1', '平台资源操作管理', 'API', 'getForPage', '分页获取资源列表', 'AGENCY', '/1/operations/page', 'GET', '8B33278C2A3DA7A828C698C4CAFF1286', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200376393728', 'operationresourcev1', '平台资源操作管理', 'API', 'updateOperation', '根据ID查询系统资源操作', 'SUPERADMIN', '/1/operations/{id}', 'GET', 'FC85EBD33C5382BBB758404368CECE9F', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200426725376', 'permissionresourcev1', '系统权限管理', 'API', 'createOrUpdatePermission', '创建主体权限信息', 'AGENCY', '/1/permissions', 'POST', '0AEE9F0F1E4B0244A52E3E5D844BF7A1', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200451891200', 'permissionresourcev1', '系统权限管理', 'API', 'getSysPrivilegeTree', '获取当前商家所有模块按钮资源', 'AGENCY', '/1/permissions', 'GET', 'C8C2D8E88F93F0998A00C5FFD058E4F4', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200472862720', 'permissionresourcev1', '系统权限管理', 'API', 'getCurrentUserModuleButtons', '获取当前登录用户所有模块的按钮信息', 'AGENCY', '/1/permissions/module/operations', 'GET', 'F69ACE03E3738B67A5CB6E3FAEFBDC42', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200498028544', 'permissionresourcev1', '系统权限管理', 'API', 'getUserModuleTree', '获取用户模块树', 'AGENCY', '/1/permissions/userModuleTree', 'GET', 'C9D206073D1CF0E6ABE0FDDD12373426', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200523194368', 'permissionresourcev1', '系统权限管理', 'API', 'getPrimaryPermissions', '获取权限主体模块资源树', 'AGENCY', '/1/permissions/{primaryType}/{primaryCode}', 'GET', '66BA60EE674D6A1FCED5593C42684CC5', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200544165888', 'roleresourcev1', '角色管理', 'API', 'deleteRole', '刪除角色', 'AGENCY', '/1/roles', 'DELETE', 'D08575563CC781EDE2A537081F22A20D', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200569331712', 'roleresourcev1', '角色管理', 'API', 'getRoles', '条件查询角色列表。', 'AGENCY', '/1/roles', 'GET', 'D9AFB10EAE9C860F9662B2B579F7D96F', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200598691840', 'roleresourcev1', '角色管理', 'API', 'createRole', '创建系统角色。', 'AGENCY', '/1/roles', 'POST', 'D68AA7F2CC51161BD314B994E92FC297', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200619663360', 'roleresourcev1', '角色管理', 'API', 'queryForPage', '分頁查询角色列表。', 'AGENCY', '/1/roles/page', 'GET', 'FD5FBCEDFA3E2E636180CEA5EC328603', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200640634880', 'roleresourcev1', '角色管理', 'API', 'isRoleCodeAvailable', '检查角色编号是否可用。', 'AGENCY', '/1/roles/roleCode/available', 'GET', 'D5A7C18497EBF7541D858CE6E7E99C38', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200661606400', 'roleresourcev1', '角色管理', 'API', 'isRoleNameAvailable', '检查角色名称是否可用。', 'AGENCY', '/1/roles/roleName/available', 'GET', '83D23D9755766C6E44304ADE518B3C67', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200686772224', 'roleresourcev1', '角色管理', 'API', 'updateRole', '更新系统角色。', 'AGENCY', '/1/roles/{roleCode}', 'PUT', 'D135C69A74FDB8A958132350430FA5FC', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200711938048', 'roleresourcev1', '角色管理', 'API', 'getRole', '通过Code查找角色。', 'AGENCY', '/1/roles/{roleCode}', 'GET', 'E2401D67E5D18FA239CC4E04831FFFBB', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099922200732909568', 'roleresourcev1', '角色管理', 'API', 'updateLockStatus', '启用/禁用角色', 'AGENCY', '/1/roles/{roleCode}/lockStatus', 'PUT', 'DA065838AE775D9C36CC87FDAF526051', 'N', '2019-02-25 16:46:52', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923260734181376', 'departmentresourcev1', '部门信息管理', 'API', 'deleteDepartment', '删除部门。', 'AGENCY', '/1/departments', 'DELETE', 'CE447D3164181E021FD5EE4BD71C06D4', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923260776124416', 'departmentresourcev1', '部门信息管理', 'API', 'createDepartment', '创建部门信息。', 'AGENCY', '/1/departments', 'POST', '3F62EFB2DD20A1855E7FF8BA8FAC67CB', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923260801290240', 'departmentresourcev1', '部门信息管理', 'API', 'isDepartmentNameAvailable', '判断部门名称是否可用。', 'AGENCY', '/1/departments/departmentName/available', 'GET', '782E8837C01945F8132C00B4B4CB4F2D', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923260910342144', 'departmentresourcev1', '部门信息管理', 'API', 'getDepartments', '分页查询部门信息(列表结构)。', 'AGENCY', '/1/departments/page', 'GET', '3B08E11D93B2D514ED8F1AAA4B4CC28E', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923260935507968', 'departmentresourcev1', '部门信息管理', 'API', 'getDepartmentTree', '获取当前机构部门树。', 'AGENCY', '/1/departments/tree', 'GET', '9395419D19E94E7B07B0AABC2AB49CB5', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923260960673792', 'departmentresourcev1', '部门信息管理', 'API', 'getByEmployees', '根据一级部门获取员工信息', 'AGENCY', '/1/departments/withEmployee', 'GET', '5EF37113FB389842EBC8AD415C8C5B21', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923260985839616', 'departmentresourcev1', '部门信息管理', 'API', 'getDepartment', '根据code获取部门信息。', 'AGENCY', '/1/departments/{departmentCode}', 'GET', 'F8B11101AED6592020536B8E02799F05', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923261011005440', 'departmentresourcev1', '部门信息管理', 'API', 'updateDepartment', '更新部门信息。', 'AGENCY', '/1/departments/{departmentCode}', 'PUT', '3A92CA9D43BBF96829C2973541902EB6', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923261036171264', 'departmentresourcev1', '部门信息管理', 'API', 'getAllChildrenDepartments', '获取所有的子部门。', 'AGENCY', '/1/departments/{departmentCode}/children', 'GET', '9B118BE14192F00B977DD7AC2FB616B3', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923261103280128', 'departmentresourcev1', '部门信息管理', 'API', 'updatelockStatus', '修改锁定状态。', 'AGENCY', '/1/departments/{departmentCode}/lockstatus', 'PUT', '37147529CB2D4EA97FF4F24D61F8B9D2', 'N', '2019-02-25 15:32:28', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535117266944', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'copyASIColumns', '将列定义模板复制到子分组中', 'AGENCY', '/1/asi/columns/custom/replication/{agencyCode}/{groupCode}', 'POST', 'CBDDCAC6058FC3A5BC7277236B7186C4', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535146627072', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'getGroupColumns', '根据子分组获取列定义列表', 'AGENCY', '/1/asi/columns/custom/{agencyCode}/{groupCode}', 'GET', '4911AD58865118C8DE5378CEF58673C0', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535175987200', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'upsertGroupColumn', '创建/更新子分组的自定义列', 'AGENCY', '/1/asi/columns/custom/{agencyCode}/{groupCode}', 'POST', '42C60C19A76980A75D2DD637E9DAAC79', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535201153024', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'getGroupColumn', '获取自定义列详情', 'AGENCY', '/1/asi/columns/custom/{agencyCode}/{groupCode}/{columnCode}', 'GET', '90D8BC2A8A72E810EC3BAE375D6671A1', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535259873280', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'deleteGroupColumn', '删除子分组的自定义列', 'AGENCY', '/1/asi/columns/custom/{agencyCode}/{groupCode}/{columnCode}', 'DELETE', 'C4EA9797FE804F19E6D5A579B7DE349D', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535285039104', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'isGroupColumnCodeAvailable', '判断自定义列编码是否可用', 'AGENCY', '/1/asi/columns/custom/{agencyCode}/{groupCode}/{columnCode}/available', 'GET', 'C4B629321E0D8DE20EEE01AA0EB32F16', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535326982144', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'getAllDataTypes', '获取所有定义的数据类型', 'SUPERADMIN', '/1/asi/columns/datatypes', 'GET', '2CE1526CE45753933EE465624ED73B9A', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535352147968', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'createColumnTemplate', '创建列定义模板', 'SUPERADMIN', '/1/asi/columns/template/{agencyCode}', 'POST', '61F02821A115E9446F479541224AB760', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535381508096', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'updateASIColulnMeta', '更新列定义模板', 'SUPERADMIN', '/1/asi/columns/template/{agencyCode}', 'PUT', '738B1AD2F05ABE9035F041F6C67B6B9D', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535406673920', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'getASIColulnMetas', '分页获取列定义模板列表', 'SUPERADMIN', '/1/asi/columns/template/{agencyCode}/page', 'GET', '756BB483775A8E81BCA82BCED5781DAF', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535440228352', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'deleteColumnTemplate', '删除列定义模板', 'SUPERADMIN', '/1/asi/columns/template/{agencyCode}/{columnCode}', 'DELETE', '47307CA6D21AD662D6601A2E2C8DCD57', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535469588480', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'getColumnTemplate', '获取列定义模板详情', 'SUPERADMIN', '/1/asi/columns/template/{agencyCode}/{columnCode}', 'GET', '56E66E5D96CA5E5B960A6B6C255D8D65', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535494754304', 'asicolumnresourcev1', '动态表单列定义管理', 'API', 'isColumnTemplateCodeAvailable', '判断模板列的编码是否可用', 'SUPERADMIN', '/1/asi/columns/template/{agencyCode}/{columnCode}/available', 'GET', '4572BCF6CCC000DEDE198B8C311DE05F', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535515725824', 'asigroupresourcev1', '动态表单组管理', 'API', 'updateGroup', '更新组定义', 'AGENCY', '/1/asi/groups/{agencyCode}', 'PUT', 'F0539BCCE3F14A5ED5C4A19D5B0A8FF2', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535540891648', 'asigroupresourcev1', '动态表单组管理', 'API', 'createGroup', '创建组定义', 'AGENCY', '/1/asi/groups/{agencyCode}', 'POST', '4E53C5E9B0AFA29F2F1DCAC40C776DBA', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535566057472', 'asigroupresourcev1', '动态表单组管理', 'API', 'isGroupCodeAvailable', '判断分组编码是否可用', 'AGENCY', '/1/asi/groups/{agencyCode}/available', 'GET', '331809704A4F0A93A480C7F07393429B', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535595417600', 'asigroupresourcev1', '动态表单组管理', 'API', 'getGroupList', '根据父分组编码获取分组列表', 'ALL', '/1/asi/groups/{agencyCode}/list', 'GET', 'C462841232C727C92C2BE976A124E691', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535620583424', 'asigroupresourcev1', '动态表单组管理', 'API', 'syncGroupTree', '同步获取分组树', 'ALL', '/1/asi/groups/{agencyCode}/tree', 'GET', '4C37F640785A56701A72F3362D44637C', 'Y', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535645749248', 'asigroupresourcev1', '动态表单组管理', 'API', 'getGroup', '获取组定义详情', 'AGENCY', '/1/asi/groups/{agencyCode}/{groupCode}', 'GET', '08866B01F7B243689B33BABE1819B04B', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535675109376', 'asigroupresourcev1', '动态表单组管理', 'API', 'deleteGroup', '删除组定义', 'AGENCY', '/1/asi/groups/{agencyCode}/{groupCode}', 'DELETE', 'E9F3D981A90F5EC1270617E8F8CFF179', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535700275200', 'asiresourcesv1', '动态表单', 'API', 'upsertASIBiz', '将具体的业务类型和动态表单关联', 'AGENCY', '/1/asi', 'PUT', 'AD46AFC565A9C19EED9664525B6AB745', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535721246720', 'asiresourcesv1', '动态表单', 'API', 'getByLatest', '获取APP版本更新信息', 'ALL', '/1/asi/support/app/isNeedForceUpdate/{vnumber}/{vtype}', 'GET', '47451C7A6CC25F15BAADEBB4C747336C', 'Y', '2019-02-25 14:46:21', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535746412544', 'asiresourcesv1', '动态表单', 'API', 'updateASIForm', '更新表单类型数据', 'AGENCY', '/1/asi/{agencyCode}/{entityType}/{entityId}/form', 'PUT', 'D3DA691C6C0118E89A4C18E94BFACAA2', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535771578368', 'asiresourcesv1', '动态表单', 'API', 'updateASITable', '更新表格类型数据', 'AGENCY', '/1/asi/{agencyCode}/{entityType}/{entityId}/table', 'PUT', '03A325871858C28E5D30F9E577C6ACAC', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535792549888', 'asiresourcesv1', '动态表单', 'API', 'getASIMeta', '获取实体的元数据定义', 'ALL', '/1/asi/{agencyCode}/{groupCode}/{entityType}/meta', 'GET', '190B7E042A4683FDF0BD4FAFBD2F4114', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535813521408', 'asiresourcesv1', '动态表单', 'API', 'getValues', '获取实体的动态表单数据(同步获取所有数据)', 'ALL', '/1/asi/{agencyCode}/{groupCode}/{entityType}/{entityId}/allvalues', 'GET', 'BCEC9F61131630B62EE44DFD5D18C76F', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535838687232', 'asiresourcesv1', '动态表单', 'API', 'isValueAvailable', '判断值是否可用', 'ALL', '/1/asi/{agencyCode}/{groupCode}/{entityType}/{entityId}/available', 'GET', 'E5077AA2AD9BC2C3D5F7E5972C500478', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535859658752', 'asiresourcesv1', '动态表单', 'API', 'getByPage', '分页获取数据', 'ALL', '/1/asi/{agencyCode}/{groupCode}/{entityType}/{entityId}/conditionPage', 'GET', '7A23C17ACC5910FA3D7F07A6270309A1', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535889018880', 'asiresourcesv1', '动态表单', 'API', 'getByList', '获取数据信息', 'ALL', '/1/asi/{agencyCode}/{groupCode}/{entityType}/{entityId}/list', 'GET', '8B14BAD45DDD5A762B85BD7CC9BBB46C', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535909990400', 'asiresourcesv1', '动态表单', 'API', 'getDataByPage', '分页获取表格数据', 'ALL', '/1/asi/{agencyCode}/{groupCode}/{entityType}/{entityId}/page', 'GET', 'CB86A69680F58D5DB8F81068BA0A3E53', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535935156224', 'asiresourcesv1', '动态表单', 'API', 'getValuesForGroup', '获取某个具体的子分组的元数据和数据(异步根据子分组获取)', 'ALL', '/1/asi/{agencyCode}/{groupCode}/{entityType}/{entityId}/values', 'GET', '31CB3D746375AEA1A42B39BBE1DEC6B5', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923535960322048', 'asiresourcesv1', '动态表单', 'API', 'getDataById', '根据ID获取实体数据', 'ALL', '/1/asi/{agencyCode}/{groupCode}/{entityType}/{entityId}/{mongoId}', 'GET', '5D0D50C36BAAD5BD5B5C689B14964283', 'N', '2019-02-25 15:32:58', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902311731200', 'dictionaryresourcev1', '字典信息', 'API', 'createDictionary', '创建字典', 'AGENCY', '/1/dictionary', 'POST', 'AFCA52A3C0DC85657DB8121864D39C1D', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902353674240', 'dictionaryresourcev1', '字典信息', 'API', 'deleteDictionary', '删除字典', 'AGENCY', '/1/dictionary', 'DELETE', 'F0F18D60475E04F6AF4F5742F718EA5C', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902383034368', 'dictionaryresourcev1', '字典信息', 'API', 'queryForPage', '分页查询字典信息', 'ALL', '/1/dictionary/page', 'GET', '1158CF800826DF2BB9D914B158B4C7FC', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902404005888', 'dictionaryresourcev1', '字典信息', 'API', 'queryByCode', '通过字典编码获取字典', 'ALL', '/1/dictionary/{dictCode}', 'GET', '3CFD02A49570A8B46F468526397B352D', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902429171712', 'dictionaryresourcev1', '字典信息', 'API', 'updateDictionary', '更新字典', 'AGENCY', '/1/dictionary/{dictCode}', 'PUT', '4DC8476C9174E31436B2603317C01371', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902454337536', 'dictionaryresourcev1', '字典信息', 'API', 'isDictionaryCodeAvailable', '检查字典编号是否可用', 'ALL', '/1/dictionary/{dictCode}/available', 'GET', '595CE802FBF3745A1B0C0859B65B7029', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902483697664', 'dictionaryresourcev1', '字典信息', 'API', 'deleteStandardChoicesValue', '删除字典值', 'AGENCY', '/1/dictionary/{dictCode}/entries', 'DELETE', '1F58C9E6201DAF0B217CD5B16DB9622C', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902504669184', 'dictionaryresourcev1', '字典信息', 'API', 'queryList', '根据字典编码获取当前商家字典的所有值', 'ALL', '/1/dictionary/{dictCode}/entries', 'GET', '5CB624AE1703FF924D8DD7736DB556DC', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902643081216', 'dictionaryresourcev1', '字典信息', 'API', 'queryForValuePage', '根据字典编码分页条件查询字典值', 'ALL', '/1/dictionary/{dictCode}/entries/page', 'GET', '98CAEF281B86161ACEAD5FD2FD50A807', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902668247040', 'dictionaryresourcev1', '字典信息', 'API', 'createStandardChoicesValue', '创建字典值', 'AGENCY', '/1/dictionary/{dictCode}/entry', 'POST', 'D2A8BD59EB26A9AC0520D1626DA2B960', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902697607168', 'dictionaryresourcev1', '字典信息', 'API', 'updateStandardChoicesValue', '更新字典值', 'AGENCY', '/1/dictionary/{dictCode}/entry/{entryKey}', 'PUT', 'B8475FC1047C674EF2D5A7A2A693DEE7', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902722772992', 'dictionaryresourcev1', '字典信息', 'API', 'queryValue', '获取指定字典值', 'ALL', '/1/dictionary/{dictCode}/entry/{key}', 'GET', '9EA5005F07E123895E2C730A271DF69B', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902743744512', 'dictionaryresourcev1', '字典信息', 'API', 'isEntryKeyAvailable', '字典值key是否可用', 'ALL', '/1/dictionary/{dictCode}/entry/{key}/available', 'GET', '53E8CF085840907142BEF219D15E3627', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902781493248', 'dictionaryresourcev1', '字典信息', 'API', 'updateLockStatus', '启用/禁用字典值。', 'AGENCY', '/1/dictionary/{dictCode}/entry/{key}/lockStatus', 'PUT', '1721A18063F430C31225647E03F8666F', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902802464768', 'locationinforesourcev1', '位置信息管理', 'API', 'getAllLocations', '同步获取所有位置信息(树形结构)', 'ALL', '/1/location/all', 'GET', '7BD496738336FAD1891771974C52179C', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902823436288', 'locationinforesourcev1', '位置信息管理', 'API', 'getProvince', '获取所有省份列表', 'ALL', '/1/location/provinces', 'GET', '970BBA97CD016A836E9A26CDA575DD9C', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902848602112', 'locationinforesourcev1', '位置信息管理', 'API', 'getRegionsByCity', '根据市获取县/区列表', 'ALL', '/1/location/{cityCode}/regions', 'GET', '9FAFE56942881EEB97625D28DD930DDD', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902869573632', 'locationinforesourcev1', '位置信息管理', 'API', 'getByCode', '根据位置编码获取位置信息', 'ALL', '/1/location/{locationCode}', 'GET', '2F08E56D9400C6B2AD65592ED492234D', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);
INSERT INTO `security_operation` VALUES ('1099923902890545152', 'locationinforesourcev1', '位置信息管理', 'API', 'getCitiesByProvince', '根据省份获取城市列表', 'ALL', '/1/location/{provinceCode}/cities', 'GET', '4D1FB3A65E4C37559A56DC126BC84608', 'N', '2019-02-25 15:33:48', '0', 'A', 'N', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for security_permission
-- ----------------------------
DROP TABLE IF EXISTS `security_permission`;
CREATE TABLE `security_permission` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '机构编码',
  `PRIMARY_TYPE` varchar(16) NOT NULL COMMENT '模块主体类型（USER用户|ROLE角色）',
  `PRIMARY_CODE` varchar(32) NOT NULL COMMENT '权限主体编号',
  `BUTTON_CODE` varchar(32) NOT NULL COMMENT '按钮编码',
  `MODULE_CODE` varchar(32) NOT NULL COMMENT '模块代码',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态 :I 非激活 /A  激活',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  KEY `INDEX_FUNC_ID` (`BUTTON_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='（用户|角色）与权限关联关系表';

-- ----------------------------
-- Records of security_permission
-- ----------------------------
INSERT INTO `security_permission` VALUES ('1099978951289290752', 'SUPER_ADMIN', 'role', 'ADMIN', 'addRole', 'role', '2019-02-25 18:26:33', '9527', 'Y', null, null, null, null);
INSERT INTO `security_permission` VALUES ('1099978951301873664', 'SUPER_ADMIN', 'role', 'ADMIN', 'queryRole', 'role', '2019-02-25 18:26:33', '9527', 'Y', null, null, null, null);

-- ----------------------------
-- Table structure for security_principal
-- ----------------------------
DROP TABLE IF EXISTS `security_principal`;
CREATE TABLE `security_principal` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '商家编码',
  `USER_TYPE` int(11) NOT NULL COMMENT '用户类型',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `USER_NAME` varchar(32) DEFAULT NULL COMMENT '用户名',
  `NICK_NAME` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '昵称',
  `REAL_NAME` varchar(32) DEFAULT NULL COMMENT '真实姓名',
  `GENDER` varchar(1) DEFAULT NULL COMMENT '性别',
  `BIRTH_DATE` date DEFAULT NULL COMMENT '生日',
  `AVATAR` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `REGISTER_DATE` datetime NOT NULL COMMENT '注册日期',
  `PASSWORD` varchar(64) NOT NULL COMMENT '密码',
  `SALT` varchar(16) NOT NULL COMMENT '盐值',
  `MOBILE` varchar(255) NOT NULL COMMENT '手机号',
  `LOCK_STATUS` varchar(1) NOT NULL DEFAULT 'N' COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` char(1) NOT NULL COMMENT '数据状态',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  UNIQUE KEY `INDEX_USER_ID` (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户主体信息';

-- ----------------------------
-- Records of security_principal
-- ----------------------------
INSERT INTO `security_principal` VALUES ('9527', 'SUPER_ADMIN', '300', '9527', '管理员', '管理员', '管理员', '1', null, null, '2016-09-12 13:48:10', 'B6BB2861B3BB99E179D356963326F8CA', 'DKZEBXOPK8', '9527', 'N', null, null, '9527', 'A', '2016-12-08 10:42:27', null, null, null, null);
INSERT INTO `security_principal` VALUES ('1099952418356989952', 'SUPER_ADMIN', '300', '1099952418356989952', '吴强', '', '', '1', null, '', '2019-02-25 16:41:07', '1DC04768094F5A8ADB1328C705F3D9FE', 'qQ8Hxx_d1B', '18191973206', 'N', null, '', '0', 'A', '2019-02-25 16:41:07', '', '', '', '');

-- ----------------------------
-- Table structure for security_principal_snpt
-- ----------------------------
DROP TABLE IF EXISTS `security_principal_snpt`;
CREATE TABLE `security_principal_snpt` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '商家编码',
  `USER_TYPE` int(11) NOT NULL COMMENT '用户类型',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `USER_NAME` varchar(32) DEFAULT NULL COMMENT '用户名',
  `NICK_NAME` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '昵称',
  `REAL_NAME` varchar(32) DEFAULT NULL COMMENT '真实姓名',
  `GENDER` varchar(1) DEFAULT NULL COMMENT '性别',
  `BIRTH_DATE` date DEFAULT NULL COMMENT '生日',
  `AVATAR` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `REGISTER_DATE` datetime NOT NULL COMMENT '注册日期',
  `PASSWORD` varchar(64) NOT NULL COMMENT '密码',
  `SALT` varchar(16) NOT NULL COMMENT '盐值',
  `MOBILE` varchar(255) DEFAULT NULL COMMENT '手机号',
  `LOCK_STATUS` varchar(1) NOT NULL DEFAULT 'N' COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` char(1) NOT NULL COMMENT '数据状态',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  `MASTER_REC_DATE` datetime NOT NULL COMMENT '主记录修改时间',
  `MASTER_SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '主表物理主键',
  PRIMARY KEY (`SEQUENCE_NBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户主体信息快照表';

-- ----------------------------
-- Records of security_principal_snpt
-- ----------------------------
INSERT INTO `security_principal_snpt` VALUES ('1099952418457653248', 'SUPER_ADMIN', '300', '1099952418356989952', '吴强', null, null, '1', null, null, '2019-02-25 16:41:07', '1DC04768094F5A8ADB1328C705F3D9FE', 'qQ8Hxx_d1B', '18191973206', 'N', null, null, '0', 'A', '2019-02-25 16:41:07', null, null, null, null, '2019-02-25 16:41:07', '1099952418356989952');
INSERT INTO `security_principal_snpt` VALUES ('1099979028745502720', 'SUPER_ADMIN', '300', '1099952418356989952', '吴强', '', '', '1', null, '', '2019-02-25 16:41:07', '1DC04768094F5A8ADB1328C705F3D9FE', 'qQ8Hxx_d1B', '18191973206', 'N', null, '', '0', 'A', '2019-02-25 18:26:52', '', '', '', '', '2019-02-25 16:41:07', '1099952418356989952');

-- ----------------------------
-- Table structure for security_role
-- ----------------------------
DROP TABLE IF EXISTS `security_role`;
CREATE TABLE `security_role` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `ROLE_CODE` varchar(32) DEFAULT NULL COMMENT '角色编码',
  `ROLE_NAME` varchar(32) NOT NULL COMMENT '角色名称',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '机构编码',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态 :I 非激活 /A  激活',
  `LOCK_STATUS` varchar(1) NOT NULL COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  KEY `INDEX_AGENCY_CODE` (`AGENCY_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of security_role
-- ----------------------------
INSERT INTO `security_role` VALUES ('1', 'ADMIN', '管理员', 'SUPER_ADMIN', '2019-02-25 18:25:18', '9527', 'A', 'N', null, null, null, null, null, '系统管理员');
INSERT INTO `security_role` VALUES ('1099978774826532864', 'COMMON', '普通用户', 'SUPER_ADMIN', '2019-02-25 18:25:51', '9527', 'A', 'N', null, null, null, null, null, '系统普通用户');

-- ----------------------------
-- Table structure for security_session
-- ----------------------------
DROP TABLE IF EXISTS `security_session`;
CREATE TABLE `security_session` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `SESSION_ID` varchar(50) NOT NULL COMMENT '会话ID',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '商家编码',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户ID',
  `USER_NAME` varchar(32) DEFAULT NULL COMMENT '会话名称',
  `LOGIN_ID` varchar(64) NOT NULL COMMENT '登录账户ID',
  `USER_TYPE` int(11) NOT NULL COMMENT '用户类型',
  `PRODUCT` varchar(32) NOT NULL COMMENT '登录设备',
  `REMOTE_IP` varchar(255) DEFAULT NULL COMMENT '远端IP地址',
  `EXPIRATION` varchar(32) NOT NULL COMMENT 'session存活时间',
  `STATUS` varchar(1) NOT NULL COMMENT 'session状态',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建或修改时间',
  `USER_AGENT` varchar(255) DEFAULT NULL COMMENT '远端请求代理',
  PRIMARY KEY (`SEQUENCE_NBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户会话表';

-- ----------------------------
-- Records of security_session
-- ----------------------------
INSERT INTO `security_session` VALUES ('1099923033172230144', '9bb60255-2382-46c5-b7cc-2843e725fe40', 'SUPER_ADMIN', '9527', '管理员', 'super', '300', 'UNKNOWN', '127.0.0.1', '2592000', 'N', '2019-02-25 14:44:21', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36');
INSERT INTO `security_session` VALUES ('1099942376069140480', '42feb780-1e47-44a0-9006-312e202850b5', 'SUPER_ADMIN', '1099942374290755584', '匿名用户', 'ANONYMOUS1099942374290755585', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 16:01:13', 'request');
INSERT INTO `security_session` VALUES ('1099978329831849984', 'e7997b14-483c-4e26-8820-15c25d6abdd8', 'SUPER_ADMIN', '1099978329701826560', '匿名用户', 'ANONYMOUS1099978329701826561', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:24:05', 'request');
INSERT INTO `security_session` VALUES ('1099978347548590080', 'b3385a0f-d0d5-43ce-8557-cefc61c1c790', 'SUPER_ADMIN', '1099978347510841344', '匿名用户', 'ANONYMOUS1099978347510841345', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:24:09', 'request');
INSERT INTO `security_session` VALUES ('1099979062614507520', 'bdf929b3-d384-4be3-9add-c3160919f530', 'SUPER_ADMIN', '1099979062580953088', '匿名用户', 'ANONYMOUS1099979062580953089', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:27:00', 'request');
INSERT INTO `security_session` VALUES ('1099979062853582848', '92bd1b32-1685-4dc7-ad61-071ebebf67d2', 'SUPER_ADMIN', '1099952418356989952', '吴强', '10086', '300', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:27:00', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36');
INSERT INTO `security_session` VALUES ('1099979334904528896', 'd6cb6930-dc4d-46e4-ab3a-08d8430af46e', 'SUPER_ADMIN', '1099979334875168768', '匿名用户', 'ANONYMOUS1099979334875168769', '0', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:28:05', 'request');
INSERT INTO `security_session` VALUES ('1099979335181352960', '9a4ea7f2-9cc8-4b6e-aacc-6c7d9ef7cf7d', 'SUPER_ADMIN', '9527', '管理员', 'super', '300', 'Manage', '192.168.2.253', '2592000', 'N', '2019-02-25 18:28:05', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36');

-- ----------------------------
-- Table structure for security_user_role
-- ----------------------------
DROP TABLE IF EXISTS `security_user_role`;
CREATE TABLE `security_user_role` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `USER_ID` bigint(20) NOT NULL COMMENT '机构用户表外键',
  `ROLE_CODE` varchar(32) NOT NULL COMMENT '角色表外键',
  `AGENCY_CODE` varchar(16) NOT NULL COMMENT '机构编码',
  `REC_DATE` datetime NOT NULL COMMENT '修改时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL DEFAULT 'A' COMMENT '数据状态 :I 非激活 /A  激活',
  `LOCK_STATUS` varchar(1) NOT NULL DEFAULT 'N' COMMENT '数据锁定状态: N :非锁定 / Y: 锁定 ',
  `LOCK_DATE` datetime DEFAULT NULL COMMENT '数据锁定时间',
  `LOCK_USER_ID` varchar(32) DEFAULT NULL COMMENT '锁定人ID外键',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Records of security_user_role
-- ----------------------------
INSERT INTO `security_user_role` VALUES ('1099979028787445760', '1099952418356989952', 'ADMIN', 'SUPER_ADMIN', '2019-02-25 18:26:52', '9527', 'A', 'N', null, null, null);

-- ----------------------------
-- Table structure for systemctl_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `systemctl_dictionary`;
CREATE TABLE `systemctl_dictionary` (
  `SEQUENCE_NBR` bigint(20) NOT NULL,
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '机构编码',
  `DICT_CODE` varchar(32) NOT NULL COMMENT '字典编码 系统中固定不变',
  `DICT_NAME` varchar(100) NOT NULL COMMENT '字典名字',
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态 :I 非激活 /A  激活',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  UNIQUE KEY `INDEX_DICT_AGENCY_CODE` (`DICT_CODE`,`AGENCY_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统字典表';

-- ----------------------------
-- Records of systemctl_dictionary
-- ----------------------------

-- ----------------------------
-- Table structure for systemctl_dictionary_entry
-- ----------------------------
DROP TABLE IF EXISTS `systemctl_dictionary_entry`;
CREATE TABLE `systemctl_dictionary_entry` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `AGENCY_CODE` varchar(32) NOT NULL COMMENT '机构编码',
  `DICT_CODE` varchar(32) NOT NULL COMMENT '字典编码(系统中固定不变的)',
  `ENTRY_KEY` varchar(32) NOT NULL COMMENT '字典KEY(当前字典中唯一)',
  `ENTRY_VALUE` varchar(500) DEFAULT NULL,
  `ORDER_NUM` int(11) DEFAULT '0' COMMENT '排序字段',
  `LOCK_STATUS` varchar(1) NOT NULL,
  `LOCK_USER_ID` varchar(32) DEFAULT NULL,
  `LOCK_DATE` datetime DEFAULT NULL,
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL COMMENT '数据状态 :I 非激活 /A  激活',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统字典表数据';

-- ----------------------------
-- Records of systemctl_dictionary_entry
-- ----------------------------

-- ----------------------------
-- Table structure for systemctl_location_info
-- ----------------------------
DROP TABLE IF EXISTS `systemctl_location_info`;
CREATE TABLE `systemctl_location_info` (
  `SEQUENCE_NBR` bigint(20) NOT NULL COMMENT '物理主键',
  `PINYIN_NAME` varchar(32) NOT NULL COMMENT '拼音码',
  `DATA_ACTION` varchar(32) NOT NULL COMMENT '对应上一个版本的操作',
  `LOCATION_NAME` varchar(100) NOT NULL COMMENT '位置名称',
  `LOCATION_CODE` varchar(32) NOT NULL COMMENT '位置编号',
  `LOCATION_TYPE` varchar(32) NOT NULL COMMENT '位置信息类型（不同的系统使用不同的编号类型）',
  `LAST_UPDATE_TIME` datetime NOT NULL COMMENT '信息更新时间',
  `DATA_VERSION` int(11) NOT NULL DEFAULT '0' COMMENT '信息版本',
  `LOCATION_CENTER` varchar(50) DEFAULT NULL COMMENT '地理位置坐标',
  `PARENT_CODE` varchar(32) DEFAULT NULL COMMENT '父节点主键;根节点为0',
  `LEVEL_NUM` int(11) DEFAULT '0' COMMENT '深度级别;树的层级',
  `ORDER_NUM` int(11) DEFAULT '0' COMMENT '排序字段',
  `REC_DATE` datetime NOT NULL COMMENT '创建时间',
  `REC_USER_ID` varchar(32) NOT NULL COMMENT '创建者',
  `REC_STATUS` varchar(1) NOT NULL DEFAULT 'A' COMMENT '数据状态 :I 非激活 /A  激活',
  `EXTEND1` varchar(32) DEFAULT NULL COMMENT '扩展字段1',
  `EXTEND2` varchar(32) DEFAULT NULL COMMENT '扩展字段2',
  `EXTEND3` varchar(32) DEFAULT NULL COMMENT '扩展字段3',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`SEQUENCE_NBR`),
  UNIQUE KEY `INDEX_LOCATION_CODE` (`LOCATION_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地区位置信息表';

-- ----------------------------
-- Records of systemctl_location_info
-- ----------------------------
INSERT INTO `systemctl_location_info` VALUES ('1', 'KJX', 'insert', '开江县', '511723', 'region', '2015-01-19 15:59:00', '1', '', '511700', null, '1', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开江县');
INSERT INTO `systemctl_location_info` VALUES ('2', 'DZX', 'insert', '大竹县', '511724', 'region', '2015-01-19 15:59:00', '1', '', '511700', null, '2', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大竹县');
INSERT INTO `systemctl_location_info` VALUES ('3', 'QX', 'insert', '渠县', '511725', 'region', '2015-01-19 15:59:00', '1', '', '511700', null, '3', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '渠县');
INSERT INTO `systemctl_location_info` VALUES ('4', 'WYS', 'insert', '万源市', '511781', 'region', '2015-01-19 15:59:00', '1', '', '511700', null, '4', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万源市');
INSERT INTO `systemctl_location_info` VALUES ('5', 'YAS', 'insert', '雅安市', '511800', 'city', '2015-01-19 15:59:00', '1', '103.009356,29.999716', '510000', null, '5', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '雅安市');
INSERT INTO `systemctl_location_info` VALUES ('6', 'YCQ', 'insert', '雨城区', '511802', 'region', '2015-01-19 15:59:00', '1', '', '511800', null, '6', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雨城区');
INSERT INTO `systemctl_location_info` VALUES ('7', 'MSX', 'insert', '名山县', '511821', 'region', '2015-01-19 15:59:00', '1', '', '511800', null, '7', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '名山县');
INSERT INTO `systemctl_location_info` VALUES ('8', 'YJX', 'insert', '荥经县', '511822', 'region', '2015-01-19 15:59:00', '1', '', '511800', null, '8', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荥经县');
INSERT INTO `systemctl_location_info` VALUES ('9', 'HYX', 'insert', '汉源县', '511823', 'region', '2015-01-19 15:59:00', '1', '', '511800', null, '9', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汉源县');
INSERT INTO `systemctl_location_info` VALUES ('10', 'SMX', 'insert', '石棉县', '511824', 'region', '2015-01-19 15:59:00', '1', '', '511800', null, '10', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石棉县');
INSERT INTO `systemctl_location_info` VALUES ('11', 'TQX', 'insert', '天全县', '511825', 'region', '2015-01-19 15:59:00', '1', '', '511800', null, '11', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天全县');
INSERT INTO `systemctl_location_info` VALUES ('12', 'LSX', 'insert', '芦山县', '511826', 'region', '2015-01-19 15:59:00', '1', '', '511800', null, '12', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芦山县');
INSERT INTO `systemctl_location_info` VALUES ('13', 'BXX', 'insert', '宝兴县', '511827', 'region', '2015-01-19 15:59:00', '1', '', '511800', null, '13', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝兴县');
INSERT INTO `systemctl_location_info` VALUES ('14', 'BZS', 'insert', '巴中市', '511900', 'city', '2015-01-19 15:59:00', '1', '106.757916,31.869189', '510000', null, '14', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '巴中市');
INSERT INTO `systemctl_location_info` VALUES ('15', 'BZQ', 'insert', '巴州区', '511902', 'region', '2015-01-19 15:59:00', '1', '', '511900', null, '15', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴州区');
INSERT INTO `systemctl_location_info` VALUES ('16', 'TJX', 'insert', '通江县', '511921', 'region', '2015-01-19 15:59:00', '1', '', '511900', null, '16', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通江县');
INSERT INTO `systemctl_location_info` VALUES ('17', 'NJX', 'insert', '南江县', '511922', 'region', '2015-01-19 15:59:00', '1', '', '511900', null, '17', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南江县');
INSERT INTO `systemctl_location_info` VALUES ('18', 'PCX', 'insert', '平昌县', '511923', 'region', '2015-01-19 15:59:00', '1', '', '511900', null, '18', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平昌县');
INSERT INTO `systemctl_location_info` VALUES ('19', 'ZYS', 'insert', '资阳市', '512000', 'city', '2015-01-19 15:59:00', '1', '104.63593,30.132191', '510000', null, '19', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '资阳市');
INSERT INTO `systemctl_location_info` VALUES ('20', 'YJQ', 'insert', '雁江区', '512002', 'region', '2015-01-19 15:59:00', '1', '', '512000', null, '20', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雁江区');
INSERT INTO `systemctl_location_info` VALUES ('21', 'AYX', 'insert', '安岳县', '512021', 'region', '2015-01-19 15:59:00', '1', '', '512000', null, '21', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安岳县');
INSERT INTO `systemctl_location_info` VALUES ('22', 'LZX', 'insert', '乐至县', '512022', 'region', '2015-01-19 15:59:00', '1', '', '512000', null, '22', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐至县');
INSERT INTO `systemctl_location_info` VALUES ('23', 'JYS', 'insert', '简阳市', '512081', 'region', '2015-01-19 15:59:00', '1', '', '512000', null, '23', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '简阳市');
INSERT INTO `systemctl_location_info` VALUES ('24', 'ABZZQZZZZ', 'insert', '阿坝藏族羌族自治州', '513200', 'city', '2015-01-19 15:59:00', '1', '', '510000', null, '24', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿坝藏族羌族自治州');
INSERT INTO `systemctl_location_info` VALUES ('25', 'WCX', 'insert', '汶川县', '513221', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '25', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汶川县');
INSERT INTO `systemctl_location_info` VALUES ('26', 'LX', 'insert', '理县', '513222', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '26', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '理县');
INSERT INTO `systemctl_location_info` VALUES ('27', 'MX', 'insert', '茂县', '513223', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '27', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '茂县');
INSERT INTO `systemctl_location_info` VALUES ('28', 'SPX', 'insert', '松潘县', '513224', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '28', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松潘县');
INSERT INTO `systemctl_location_info` VALUES ('29', 'JZGX', 'insert', '九寨沟县', '513225', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '29', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '九寨沟县');
INSERT INTO `systemctl_location_info` VALUES ('30', 'JCX', 'insert', '金川县', '513226', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '30', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金川县');
INSERT INTO `systemctl_location_info` VALUES ('31', 'XJX', 'insert', '小金县', '513227', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '31', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '小金县');
INSERT INTO `systemctl_location_info` VALUES ('32', 'HSX', 'insert', '黑水县', '513228', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '32', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黑水县');
INSERT INTO `systemctl_location_info` VALUES ('33', 'MEKX', 'insert', '马尔康县', '513229', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '33', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '马尔康县');
INSERT INTO `systemctl_location_info` VALUES ('34', 'RTX', 'insert', '壤塘县', '513230', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '34', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '壤塘县');
INSERT INTO `systemctl_location_info` VALUES ('35', 'ABX', 'insert', '阿坝县', '513231', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '35', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿坝县');
INSERT INTO `systemctl_location_info` VALUES ('36', 'REGX', 'insert', '若尔盖县', '513232', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '36', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '若尔盖县');
INSERT INTO `systemctl_location_info` VALUES ('37', 'HYX', 'insert', '红原县', '513233', 'region', '2015-01-19 15:59:00', '1', '', '513200', null, '37', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红原县');
INSERT INTO `systemctl_location_info` VALUES ('38', 'GZZZZZZ', 'insert', '甘孜藏族自治州', '513300', 'city', '2015-01-19 15:59:00', '1', '', '510000', null, '38', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘孜藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('39', 'KDX', 'insert', '康定县', '513321', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '39', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '康定县');
INSERT INTO `systemctl_location_info` VALUES ('40', 'LDX', 'insert', '泸定县', '513322', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '40', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泸定县');
INSERT INTO `systemctl_location_info` VALUES ('41', 'DBX', 'insert', '丹巴县', '513323', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '41', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丹巴县');
INSERT INTO `systemctl_location_info` VALUES ('42', 'JLX', 'insert', '九龙县', '513324', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '42', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '九龙县');
INSERT INTO `systemctl_location_info` VALUES ('43', 'YJX', 'insert', '雅江县', '513325', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '43', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雅江县');
INSERT INTO `systemctl_location_info` VALUES ('44', 'DFX', 'insert', '道孚县', '513326', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '44', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '道孚县');
INSERT INTO `systemctl_location_info` VALUES ('45', 'LHX', 'insert', '炉霍县', '513327', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '45', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '炉霍县');
INSERT INTO `systemctl_location_info` VALUES ('46', 'GZX', 'insert', '甘孜县', '513328', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '46', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘孜县');
INSERT INTO `systemctl_location_info` VALUES ('47', 'XLX', 'insert', '新龙县', '513329', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '47', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新龙县');
INSERT INTO `systemctl_location_info` VALUES ('48', 'DGX', 'insert', '德格县', '513330', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '48', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德格县');
INSERT INTO `systemctl_location_info` VALUES ('49', 'BYX', 'insert', '白玉县', '513331', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '49', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白玉县');
INSERT INTO `systemctl_location_info` VALUES ('50', 'SQX', 'insert', '石渠县', '513332', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '50', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石渠县');
INSERT INTO `systemctl_location_info` VALUES ('51', 'SDX', 'insert', '色达县', '513333', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '51', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '色达县');
INSERT INTO `systemctl_location_info` VALUES ('52', 'LTX', 'insert', '理塘县', '513334', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '52', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '理塘县');
INSERT INTO `systemctl_location_info` VALUES ('53', 'BTX', 'insert', '巴塘县', '513335', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '53', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴塘县');
INSERT INTO `systemctl_location_info` VALUES ('54', 'XCX', 'insert', '乡城县', '513336', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '54', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乡城县');
INSERT INTO `systemctl_location_info` VALUES ('55', 'DCX', 'insert', '稻城县', '513337', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '55', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '稻城县');
INSERT INTO `systemctl_location_info` VALUES ('56', 'DRX', 'insert', '得荣县', '513338', 'region', '2015-01-19 15:59:00', '1', '', '513300', null, '56', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '得荣县');
INSERT INTO `systemctl_location_info` VALUES ('57', 'LSYZZZZ', 'insert', '凉山彝族自治州', '513400', 'city', '2015-01-19 15:59:00', '1', '', '510000', null, '57', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凉山彝族自治州');
INSERT INTO `systemctl_location_info` VALUES ('58', 'XCS', 'insert', '西昌市', '513401', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '58', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西昌市');
INSERT INTO `systemctl_location_info` VALUES ('59', 'MLZZZZX', 'insert', '木里藏族自治县', '513422', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '59', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '木里藏族自治县');
INSERT INTO `systemctl_location_info` VALUES ('60', 'YYX', 'insert', '盐源县', '513423', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '60', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐源县');
INSERT INTO `systemctl_location_info` VALUES ('61', 'DCX', 'insert', '德昌县', '513424', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '61', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德昌县');
INSERT INTO `systemctl_location_info` VALUES ('62', 'HLX', 'insert', '会理县', '513425', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '62', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '会理县');
INSERT INTO `systemctl_location_info` VALUES ('63', 'HDX', 'insert', '会东县', '513426', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '63', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '会东县');
INSERT INTO `systemctl_location_info` VALUES ('64', 'NNX', 'insert', '宁南县', '513427', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '64', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁南县');
INSERT INTO `systemctl_location_info` VALUES ('65', 'PGX', 'insert', '普格县', '513428', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '65', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '普格县');
INSERT INTO `systemctl_location_info` VALUES ('66', 'BTX', 'insert', '布拖县', '513429', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '66', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '布拖县');
INSERT INTO `systemctl_location_info` VALUES ('67', 'JYX', 'insert', '金阳县', '513430', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '67', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金阳县');
INSERT INTO `systemctl_location_info` VALUES ('68', 'ZJX', 'insert', '昭觉县', '513431', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '68', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昭觉县');
INSERT INTO `systemctl_location_info` VALUES ('69', 'XDX', 'insert', '喜德县', '513432', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '69', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '喜德县');
INSERT INTO `systemctl_location_info` VALUES ('70', 'MNX', 'insert', '冕宁县', '513433', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '70', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '冕宁县');
INSERT INTO `systemctl_location_info` VALUES ('71', 'YXX', 'insert', '越西县', '513434', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '71', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '越西县');
INSERT INTO `systemctl_location_info` VALUES ('72', 'GLX', 'insert', '甘洛县', '513435', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '72', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘洛县');
INSERT INTO `systemctl_location_info` VALUES ('73', 'MGX', 'insert', '美姑县', '513436', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '73', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '美姑县');
INSERT INTO `systemctl_location_info` VALUES ('74', 'LBX', 'insert', '雷波县', '513437', 'region', '2015-01-19 15:59:00', '1', '', '513400', null, '74', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雷波县');
INSERT INTO `systemctl_location_info` VALUES ('75', 'GZS', 'insert', '贵州省', '520000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '75', '2015-01-19 15:59:00', 'system', 'A', '贵', '', '', '贵州省');
INSERT INTO `systemctl_location_info` VALUES ('76', 'GYS', 'insert', '贵阳市', '520100', 'city', '2015-01-19 15:59:00', '1', '106.709177,26.629907', '520000', null, '76', '2015-01-19 15:59:00', 'system', 'A', '贵A', '12', '', '贵阳市');
INSERT INTO `systemctl_location_info` VALUES ('77', 'NMQ', 'insert', '南明区', '520102', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '77', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南明区');
INSERT INTO `systemctl_location_info` VALUES ('78', 'YYQ', 'insert', '云岩区', '520103', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '78', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云岩区');
INSERT INTO `systemctl_location_info` VALUES ('79', 'HXQ', 'insert', '花溪区', '520111', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '79', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '花溪区');
INSERT INTO `systemctl_location_info` VALUES ('80', 'WDQ', 'insert', '乌当区', '520112', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '80', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌当区');
INSERT INTO `systemctl_location_info` VALUES ('81', 'BYQ', 'insert', '白云区', '520113', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '81', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白云区');
INSERT INTO `systemctl_location_info` VALUES ('82', 'XHQ', 'insert', '小河区', '520114', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '82', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '小河区');
INSERT INTO `systemctl_location_info` VALUES ('83', 'KYX', 'insert', '开阳县', '520121', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '83', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开阳县');
INSERT INTO `systemctl_location_info` VALUES ('84', 'XFX', 'insert', '息烽县', '520122', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '84', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '息烽县');
INSERT INTO `systemctl_location_info` VALUES ('85', 'XWX', 'insert', '修文县', '520123', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '85', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '修文县');
INSERT INTO `systemctl_location_info` VALUES ('86', 'QZS', 'insert', '清镇市', '520181', 'region', '2015-01-19 15:59:00', '1', '', '520100', null, '86', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清镇市');
INSERT INTO `systemctl_location_info` VALUES ('87', 'LPSS', 'insert', '六盘水市', '520200', 'city', '2015-01-19 15:59:00', '1', '104.852087,26.591866', '520000', null, '87', '2015-01-19 15:59:00', 'system', 'A', '贵B', '13', '', '六盘水市');
INSERT INTO `systemctl_location_info` VALUES ('88', 'ZSQ', 'insert', '钟山区', '520201', 'region', '2015-01-19 15:59:00', '1', '', '520200', null, '88', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '钟山区');
INSERT INTO `systemctl_location_info` VALUES ('89', 'LZTQ', 'insert', '六枝特区', '520203', 'region', '2015-01-19 15:59:00', '1', '', '520200', null, '89', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '六枝特区');
INSERT INTO `systemctl_location_info` VALUES ('90', 'SCX', 'insert', '水城县', '520221', 'region', '2015-01-19 15:59:00', '1', '', '520200', null, '90', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '水城县');
INSERT INTO `systemctl_location_info` VALUES ('91', 'PX', 'insert', '盘县', '520222', 'region', '2015-01-19 15:59:00', '1', '', '520200', null, '91', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盘县');
INSERT INTO `systemctl_location_info` VALUES ('92', 'ZYS', 'insert', '遵义市', '520300', 'city', '2015-01-19 15:59:00', '1', '106.93126,27.699961', '520000', null, '92', '2015-01-19 15:59:00', 'system', 'A', '贵C', '13', '', '遵义市');
INSERT INTO `systemctl_location_info` VALUES ('93', 'HHGQ', 'insert', '红花岗区', '520302', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '93', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红花岗区');
INSERT INTO `systemctl_location_info` VALUES ('94', 'HCQ', 'insert', '汇川区', '520303', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '94', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汇川区');
INSERT INTO `systemctl_location_info` VALUES ('95', 'ZYX', 'insert', '遵义县', '520321', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '95', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '遵义县');
INSERT INTO `systemctl_location_info` VALUES ('96', 'TZX', 'insert', '桐梓县', '520322', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '96', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桐梓县');
INSERT INTO `systemctl_location_info` VALUES ('97', 'SYX', 'insert', '绥阳县', '520323', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '97', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绥阳县');
INSERT INTO `systemctl_location_info` VALUES ('98', 'ZAX', 'insert', '正安县', '520324', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '98', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '正安县');
INSERT INTO `systemctl_location_info` VALUES ('99', 'DZGLZMZZZX', 'insert', '道真仡佬族苗族自治县', '520325', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '99', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '道真仡佬族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('100', 'WCGLZMZZZX', 'insert', '务川仡佬族苗族自治县', '520326', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '100', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '务川仡佬族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('101', 'FGX', 'insert', '凤冈县', '520327', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '101', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤冈县');
INSERT INTO `systemctl_location_info` VALUES ('102', 'MTX', 'insert', '湄潭县', '520328', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '102', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湄潭县');
INSERT INTO `systemctl_location_info` VALUES ('103', 'YQX', 'insert', '余庆县', '520329', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '103', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '余庆县');
INSERT INTO `systemctl_location_info` VALUES ('104', 'XSX', 'insert', '习水县', '520330', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '104', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '习水县');
INSERT INTO `systemctl_location_info` VALUES ('105', 'CSS', 'insert', '赤水市', '520381', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '105', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赤水市');
INSERT INTO `systemctl_location_info` VALUES ('106', 'RHS', 'insert', '仁怀市', '520382', 'region', '2015-01-19 15:59:00', '1', '', '520300', null, '106', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仁怀市');
INSERT INTO `systemctl_location_info` VALUES ('107', 'ASS', 'insert', '安顺市', '520400', 'city', '2015-01-19 15:59:00', '1', '105.92827,26.228595', '520000', null, '107', '2015-01-19 15:59:00', 'system', 'A', '贵G', '13', '', '安顺市');
INSERT INTO `systemctl_location_info` VALUES ('108', 'XXQ', 'insert', '西秀区', '520402', 'region', '2015-01-19 15:59:00', '1', '', '520400', null, '108', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西秀区');
INSERT INTO `systemctl_location_info` VALUES ('109', 'PBX', 'insert', '平坝县', '520421', 'region', '2015-01-19 15:59:00', '1', '', '520400', null, '109', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平坝县');
INSERT INTO `systemctl_location_info` VALUES ('110', 'PDX', 'insert', '普定县', '520422', 'region', '2015-01-19 15:59:00', '1', '', '520400', null, '110', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '普定县');
INSERT INTO `systemctl_location_info` VALUES ('111', 'ZNBYZMZZZX', 'insert', '镇宁布依族苗族自治县', '520423', 'region', '2015-01-19 15:59:00', '1', '', '520400', null, '111', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇宁布依族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('112', 'GLBYZMZZZX', 'insert', '关岭布依族苗族自治县', '520424', 'region', '2015-01-19 15:59:00', '1', '', '520400', null, '112', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '关岭布依族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('113', 'ZYMZBYZZZX', 'insert', '紫云苗族布依族自治县', '520425', 'region', '2015-01-19 15:59:00', '1', '', '520400', null, '113', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '紫云苗族布依族自治县');
INSERT INTO `systemctl_location_info` VALUES ('114', 'BJS', 'insert', '毕节市', '520500', 'city', '2015-01-19 15:59:00', '1', '', '520000', null, '114', '2015-01-19 15:59:00', 'system', 'A', '贵F', '', '', '毕节市');
INSERT INTO `systemctl_location_info` VALUES ('115', 'QXGQ', 'insert', '七星关区', '520501', 'region', '2015-01-19 15:59:00', '1', '', '520500', null, '115', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '七星关区');
INSERT INTO `systemctl_location_info` VALUES ('116', 'DFX', 'insert', '大方县', '520522', 'region', '2015-01-19 15:59:00', '1', '', '520500', null, '116', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大方县');
INSERT INTO `systemctl_location_info` VALUES ('117', 'QXX', 'insert', '黔西县', '520523', 'region', '2015-01-19 15:59:00', '1', '', '520500', null, '117', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黔西县');
INSERT INTO `systemctl_location_info` VALUES ('118', 'JSX', 'insert', '金沙县', '520524', 'region', '2015-01-19 15:59:00', '1', '', '520500', null, '118', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金沙县');
INSERT INTO `systemctl_location_info` VALUES ('119', 'ZJX', 'insert', '织金县', '520525', 'region', '2015-01-19 15:59:00', '1', '', '520500', null, '119', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '织金县');
INSERT INTO `systemctl_location_info` VALUES ('120', 'NYX', 'insert', '纳雍县', '520526', 'region', '2015-01-19 15:59:00', '1', '', '520500', null, '120', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '纳雍县');
INSERT INTO `systemctl_location_info` VALUES ('121', 'WNYZHZMZZZX', 'insert', '威宁彝族回族苗族自治县', '520527', 'region', '2015-01-19 15:59:00', '1', '', '520500', null, '121', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '威宁彝族回族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('122', 'HZX', 'insert', '赫章县', '520528', 'region', '2015-01-19 15:59:00', '1', '', '520500', null, '122', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赫章县');
INSERT INTO `systemctl_location_info` VALUES ('123', 'TRS', 'insert', '铜仁市', '520600', 'city', '2015-01-19 15:59:00', '1', '', '520000', null, '123', '2015-01-19 15:59:00', 'system', 'A', '贵D', '', '', '铜仁市');
INSERT INTO `systemctl_location_info` VALUES ('124', 'BJQ', 'insert', '碧江区', '520601', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '124', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '碧江区');
INSERT INTO `systemctl_location_info` VALUES ('125', 'WSQ', 'insert', '万山区', '520602', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '125', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万山区');
INSERT INTO `systemctl_location_info` VALUES ('126', 'JKX', 'insert', '江口县', '520622', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '126', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江口县');
INSERT INTO `systemctl_location_info` VALUES ('127', 'YPDZZZX', 'insert', '玉屏侗族自治县', '520623', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '127', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉屏侗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('128', 'SQX', 'insert', '石阡县', '520624', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '128', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石阡县');
INSERT INTO `systemctl_location_info` VALUES ('129', 'SNX', 'insert', '思南县', '520625', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '129', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '思南县');
INSERT INTO `systemctl_location_info` VALUES ('130', 'YJTJZMZZZX', 'insert', '印江土家族苗族自治县', '520626', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '130', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '印江土家族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('131', 'DJX', 'insert', '德江县', '520627', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '131', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德江县');
INSERT INTO `systemctl_location_info` VALUES ('132', 'YHTJZZZX', 'insert', '沿河土家族自治县', '520628', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '132', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沿河土家族自治县');
INSERT INTO `systemctl_location_info` VALUES ('133', 'STMZZZX', 'insert', '松桃苗族自治县', '520629', 'region', '2015-01-19 15:59:00', '1', '', '520600', null, '133', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松桃苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('134', 'QXNBYZMZZZZ', 'insert', '黔西南布依族苗族自治州', '522300', 'city', '2015-01-19 15:59:00', '1', '', '520000', null, '134', '2015-01-19 15:59:00', 'system', 'A', '贵E', '', '', '黔西南布依族苗族自治州');
INSERT INTO `systemctl_location_info` VALUES ('135', 'XYS', 'insert', '兴义市', '522301', 'region', '2015-01-19 15:59:00', '1', '', '522300', null, '135', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴义市');
INSERT INTO `systemctl_location_info` VALUES ('136', 'XRX', 'insert', '兴仁县', '522322', 'region', '2015-01-19 15:59:00', '1', '', '522300', null, '136', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴仁县');
INSERT INTO `systemctl_location_info` VALUES ('137', 'PAX', 'insert', '普安县', '522323', 'region', '2015-01-19 15:59:00', '1', '', '522300', null, '137', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '普安县');
INSERT INTO `systemctl_location_info` VALUES ('138', 'QLX', 'insert', '晴隆县', '522324', 'region', '2015-01-19 15:59:00', '1', '', '522300', null, '138', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '晴隆县');
INSERT INTO `systemctl_location_info` VALUES ('139', 'ZFX', 'insert', '贞丰县', '522325', 'region', '2015-01-19 15:59:00', '1', '', '522300', null, '139', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贞丰县');
INSERT INTO `systemctl_location_info` VALUES ('140', 'WMX', 'insert', '望谟县', '522326', 'region', '2015-01-19 15:59:00', '1', '', '522300', null, '140', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '望谟县');
INSERT INTO `systemctl_location_info` VALUES ('141', 'CHX', 'insert', '册亨县', '522327', 'region', '2015-01-19 15:59:00', '1', '', '522300', null, '141', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '册亨县');
INSERT INTO `systemctl_location_info` VALUES ('142', 'ALX', 'insert', '安龙县', '522328', 'region', '2015-01-19 15:59:00', '1', '', '522300', null, '142', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安龙县');
INSERT INTO `systemctl_location_info` VALUES ('143', 'QDNMZDZZZZ', 'insert', '黔东南苗族侗族自治州', '522600', 'city', '2015-01-19 15:59:00', '1', '', '520000', null, '143', '2015-01-19 15:59:00', 'system', 'A', '贵H', '', '', '黔东南苗族侗族自治州');
INSERT INTO `systemctl_location_info` VALUES ('144', 'KLS', 'insert', '凯里市', '522601', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '144', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凯里市');
INSERT INTO `systemctl_location_info` VALUES ('145', 'HPX', 'insert', '黄平县', '522622', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '145', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄平县');
INSERT INTO `systemctl_location_info` VALUES ('146', 'SBX', 'insert', '施秉县', '522623', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '146', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '施秉县');
INSERT INTO `systemctl_location_info` VALUES ('147', 'SSX', 'insert', '三穗县', '522624', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '147', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三穗县');
INSERT INTO `systemctl_location_info` VALUES ('148', 'ZYX', 'insert', '镇远县', '522625', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '148', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇远县');
INSERT INTO `systemctl_location_info` VALUES ('149', 'CGX', 'insert', '岑巩县', '522626', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '149', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岑巩县');
INSERT INTO `systemctl_location_info` VALUES ('150', 'TZX', 'insert', '天柱县', '522627', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '150', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天柱县');
INSERT INTO `systemctl_location_info` VALUES ('151', 'JPX', 'insert', '锦屏县', '522628', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '151', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '锦屏县');
INSERT INTO `systemctl_location_info` VALUES ('152', 'JHX', 'insert', '剑河县', '522629', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '152', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '剑河县');
INSERT INTO `systemctl_location_info` VALUES ('153', 'TJX', 'insert', '台江县', '522630', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '153', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台江县');
INSERT INTO `systemctl_location_info` VALUES ('154', 'LPX', 'insert', '黎平县', '522631', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '154', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黎平县');
INSERT INTO `systemctl_location_info` VALUES ('155', 'RJX', 'insert', '榕江县', '522632', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '155', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '榕江县');
INSERT INTO `systemctl_location_info` VALUES ('156', 'CJX', 'insert', '从江县', '522633', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '156', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '从江县');
INSERT INTO `systemctl_location_info` VALUES ('157', 'LSX', 'insert', '雷山县', '522634', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '157', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雷山县');
INSERT INTO `systemctl_location_info` VALUES ('158', 'MJX', 'insert', '麻江县', '522635', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '158', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麻江县');
INSERT INTO `systemctl_location_info` VALUES ('159', 'DZX', 'insert', '丹寨县', '522636', 'region', '2015-01-19 15:59:00', '1', '', '522600', null, '159', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丹寨县');
INSERT INTO `systemctl_location_info` VALUES ('160', 'QNBYZMZZZZ', 'insert', '黔南布依族苗族自治州', '522700', 'city', '2015-01-19 15:59:00', '1', '', '520000', null, '160', '2015-01-19 15:59:00', 'system', 'A', '贵J', '', '', '黔南布依族苗族自治州');
INSERT INTO `systemctl_location_info` VALUES ('161', 'DYS', 'insert', '都匀市', '522701', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '161', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '都匀市');
INSERT INTO `systemctl_location_info` VALUES ('162', 'FQS', 'insert', '福泉市', '522702', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '162', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '福泉市');
INSERT INTO `systemctl_location_info` VALUES ('163', 'LBX', 'insert', '荔波县', '522722', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '163', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荔波县');
INSERT INTO `systemctl_location_info` VALUES ('164', 'GDX', 'insert', '贵定县', '522723', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '164', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贵定县');
INSERT INTO `systemctl_location_info` VALUES ('165', 'WAX', 'insert', '瓮安县', '522725', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '165', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瓮安县');
INSERT INTO `systemctl_location_info` VALUES ('166', 'DSX', 'insert', '独山县', '522726', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '166', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '独山县');
INSERT INTO `systemctl_location_info` VALUES ('167', 'PTX', 'insert', '平塘县', '522727', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '167', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平塘县');
INSERT INTO `systemctl_location_info` VALUES ('168', 'LDX', 'insert', '罗甸县', '522728', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '168', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗甸县');
INSERT INTO `systemctl_location_info` VALUES ('169', 'ZSX', 'insert', '长顺县', '522729', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '169', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长顺县');
INSERT INTO `systemctl_location_info` VALUES ('170', 'LLX', 'insert', '龙里县', '522730', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '170', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙里县');
INSERT INTO `systemctl_location_info` VALUES ('171', 'HSX', 'insert', '惠水县', '522731', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '171', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠水县');
INSERT INTO `systemctl_location_info` VALUES ('172', 'SDSZZZX', 'insert', '三都水族自治县', '522732', 'region', '2015-01-19 15:59:00', '1', '', '522700', null, '172', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三都水族自治县');
INSERT INTO `systemctl_location_info` VALUES ('173', 'YNS', 'insert', '云南省', '530000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '173', '2015-01-19 15:59:00', 'system', 'A', '云', '', '', '云南省');
INSERT INTO `systemctl_location_info` VALUES ('174', 'KMS', 'insert', '昆明市', '530100', 'city', '2015-01-19 15:59:00', '1', '102.714601,25.049153', '530000', null, '174', '2015-01-19 15:59:00', 'system', 'A', '云A', '12', '', '昆明市');
INSERT INTO `systemctl_location_info` VALUES ('175', 'WHQ', 'insert', '五华区', '530102', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '175', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五华区');
INSERT INTO `systemctl_location_info` VALUES ('176', 'PLQ', 'insert', '盘龙区', '530103', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '176', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盘龙区');
INSERT INTO `systemctl_location_info` VALUES ('177', 'GDQ', 'insert', '官渡区', '530111', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '177', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '官渡区');
INSERT INTO `systemctl_location_info` VALUES ('178', 'XSQ', 'insert', '西山区', '530112', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '178', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西山区');
INSERT INTO `systemctl_location_info` VALUES ('179', 'DCQ', 'insert', '东川区', '530113', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '179', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东川区');
INSERT INTO `systemctl_location_info` VALUES ('180', 'CGQ', 'insert', '呈贡区', '530121', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '180', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '呈贡区');
INSERT INTO `systemctl_location_info` VALUES ('181', 'JNX', 'insert', '晋宁县', '530122', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '181', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '晋宁县');
INSERT INTO `systemctl_location_info` VALUES ('182', 'FMX', 'insert', '富民县', '530124', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '182', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富民县');
INSERT INTO `systemctl_location_info` VALUES ('183', 'YLX', 'insert', '宜良县', '530125', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '183', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜良县');
INSERT INTO `systemctl_location_info` VALUES ('184', 'SLYZZZX', 'insert', '石林彝族自治县', '530126', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '184', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石林彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('185', 'SMX', 'insert', '嵩明县', '530127', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '185', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嵩明县');
INSERT INTO `systemctl_location_info` VALUES ('186', 'LQYZMZZZX', 'insert', '禄劝彝族苗族自治县', '530128', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '186', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '禄劝彝族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('187', 'XDHZYZZZX', 'insert', '寻甸回族彝族自治县', '530129', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '187', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '寻甸回族彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('188', 'ANS', 'insert', '安宁市', '530181', 'region', '2015-01-19 15:59:00', '1', '', '530100', null, '188', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安宁市');
INSERT INTO `systemctl_location_info` VALUES ('189', 'QJS', 'insert', '曲靖市', '530300', 'city', '2015-01-19 15:59:00', '1', '103.782539,25.520758', '530000', null, '189', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '曲靖市');
INSERT INTO `systemctl_location_info` VALUES ('190', 'QLQ', 'insert', '麒麟区', '530302', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '190', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麒麟区');
INSERT INTO `systemctl_location_info` VALUES ('191', 'MLX', 'insert', '马龙县', '530321', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '191', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '马龙县');
INSERT INTO `systemctl_location_info` VALUES ('192', 'LLX', 'insert', '陆良县', '530322', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '192', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陆良县');
INSERT INTO `systemctl_location_info` VALUES ('193', 'SZX', 'insert', '师宗县', '530323', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '193', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '师宗县');
INSERT INTO `systemctl_location_info` VALUES ('194', 'LPX', 'insert', '罗平县', '530324', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '194', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗平县');
INSERT INTO `systemctl_location_info` VALUES ('195', 'FYX', 'insert', '富源县', '530325', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '195', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富源县');
INSERT INTO `systemctl_location_info` VALUES ('196', 'HZX', 'insert', '会泽县', '530326', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '196', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '会泽县');
INSERT INTO `systemctl_location_info` VALUES ('197', 'BJS', 'insert', '北京市', '110000', 'city', '2015-01-19 15:59:00', '1', '116.395645,39.929986', '100000', null, '197', '2015-01-19 15:59:00', 'system', 'A', '京', '12', '', '北京市');
INSERT INTO `systemctl_location_info` VALUES ('198', 'DCQ', 'insert', '东城区', '110101', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '198', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东城区');
INSERT INTO `systemctl_location_info` VALUES ('199', 'XCQ', 'insert', '西城区', '110102', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '199', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西城区');
INSERT INTO `systemctl_location_info` VALUES ('200', 'CYQ', 'insert', '朝阳区', '110105', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '200', '2015-01-19 15:59:00', 'system', 'A', '辽N', '', '', '朝阳区');
INSERT INTO `systemctl_location_info` VALUES ('201', 'FTQ', 'insert', '丰台区', '110106', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '201', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰台区');
INSERT INTO `systemctl_location_info` VALUES ('202', 'SJSQ', 'insert', '石景山区', '110107', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '202', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石景山区');
INSERT INTO `systemctl_location_info` VALUES ('203', 'HDQ', 'insert', '海淀区', '110108', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '203', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海淀区');
INSERT INTO `systemctl_location_info` VALUES ('204', 'MTGQ', 'insert', '门头沟区', '110109', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '204', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '门头沟区');
INSERT INTO `systemctl_location_info` VALUES ('205', 'FSQ', 'insert', '房山区', '110111', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '205', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '房山区');
INSERT INTO `systemctl_location_info` VALUES ('206', 'TZQ', 'insert', '通州区', '110112', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '206', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通州区');
INSERT INTO `systemctl_location_info` VALUES ('207', 'SYQ', 'insert', '顺义区', '110113', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '207', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '顺义区');
INSERT INTO `systemctl_location_info` VALUES ('208', 'CPQ', 'insert', '昌平区', '110114', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '208', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌平区');
INSERT INTO `systemctl_location_info` VALUES ('209', 'DXQ', 'insert', '大兴区', '110115', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '209', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大兴区');
INSERT INTO `systemctl_location_info` VALUES ('210', 'HRQ', 'insert', '怀柔区', '110116', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '210', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '怀柔区');
INSERT INTO `systemctl_location_info` VALUES ('211', 'PGQ', 'insert', '平谷区', '110117', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '211', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平谷区');
INSERT INTO `systemctl_location_info` VALUES ('212', 'MYX', 'insert', '密云县', '110228', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '212', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '密云县');
INSERT INTO `systemctl_location_info` VALUES ('213', 'YQX', 'insert', '延庆县', '110229', 'region', '2015-01-19 15:59:00', '1', '', '110000', null, '213', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '延庆县');
INSERT INTO `systemctl_location_info` VALUES ('214', 'TJS', 'insert', '天津市', '120000', 'city', '2015-01-19 15:59:00', '1', '117.210813,39.14393', '100001', null, '214', '2015-01-19 15:59:00', 'system', 'A', '津', '12', '', '天津市');
INSERT INTO `systemctl_location_info` VALUES ('215', 'HPQ', 'insert', '和平区', '120101', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '215', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和平区');
INSERT INTO `systemctl_location_info` VALUES ('216', 'HDQ', 'insert', '河东区', '120102', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '216', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河东区');
INSERT INTO `systemctl_location_info` VALUES ('217', 'HXQ', 'insert', '河西区', '120103', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '217', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河西区');
INSERT INTO `systemctl_location_info` VALUES ('218', 'NKQ', 'insert', '南开区', '120104', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '218', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南开区');
INSERT INTO `systemctl_location_info` VALUES ('219', 'HBQ', 'insert', '河北区', '120105', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '219', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河北区');
INSERT INTO `systemctl_location_info` VALUES ('220', 'HQQ', 'insert', '红桥区', '120106', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '220', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红桥区');
INSERT INTO `systemctl_location_info` VALUES ('221', 'DLQ', 'insert', '东丽区', '120110', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '221', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东丽区');
INSERT INTO `systemctl_location_info` VALUES ('222', 'XQQ', 'insert', '西青区', '120111', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '222', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西青区');
INSERT INTO `systemctl_location_info` VALUES ('223', 'JNQ', 'insert', '津南区', '120112', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '223', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '津南区');
INSERT INTO `systemctl_location_info` VALUES ('224', 'BCQ', 'insert', '北辰区', '120113', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '224', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北辰区');
INSERT INTO `systemctl_location_info` VALUES ('225', 'WQQ', 'insert', '武清区', '120114', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '225', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武清区');
INSERT INTO `systemctl_location_info` VALUES ('226', 'BCQ', 'insert', '宝坻区', '120115', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '226', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝坻区');
INSERT INTO `systemctl_location_info` VALUES ('227', 'BHXQ', 'insert', '滨海新区', '120116', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '227', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滨海新区');
INSERT INTO `systemctl_location_info` VALUES ('228', 'NHX', 'insert', '宁河县', '120221', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '228', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁河县');
INSERT INTO `systemctl_location_info` VALUES ('229', 'JHX', 'insert', '静海县', '120223', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '229', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '静海县');
INSERT INTO `systemctl_location_info` VALUES ('230', 'JX', 'insert', '蓟县', '120225', 'region', '2015-01-19 15:59:00', '1', '', '120000', null, '230', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蓟县');
INSERT INTO `systemctl_location_info` VALUES ('231', 'HBS', 'insert', '河北省', '130000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '231', '2015-01-19 15:59:00', 'system', 'A', '冀', '', '', '河北省');
INSERT INTO `systemctl_location_info` VALUES ('232', 'SJZS', 'insert', '石家庄市', '130100', 'city', '2015-01-19 15:59:00', '1', '114.522082,38.048958', '130000', null, '232', '2015-01-19 15:59:00', 'system', 'A', '冀A', '12', '', '石家庄市');
INSERT INTO `systemctl_location_info` VALUES ('233', 'ZAQ', 'insert', '长安区', '130102', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '233', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长安区');
INSERT INTO `systemctl_location_info` VALUES ('234', 'QDQ', 'insert', '桥东区', '130103', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '234', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桥东区');
INSERT INTO `systemctl_location_info` VALUES ('235', 'QXQ', 'insert', '桥西区', '130104', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '235', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桥西区');
INSERT INTO `systemctl_location_info` VALUES ('236', 'XHQ', 'insert', '新华区', '130105', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '236', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新华区');
INSERT INTO `systemctl_location_info` VALUES ('237', 'JXKQ', 'insert', '井陉矿区', '130107', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '237', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '井陉矿区');
INSERT INTO `systemctl_location_info` VALUES ('238', 'YHQ', 'insert', '裕华区', '130108', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '238', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '裕华区');
INSERT INTO `systemctl_location_info` VALUES ('239', 'JXX', 'insert', '井陉县', '130121', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '239', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '井陉县');
INSERT INTO `systemctl_location_info` VALUES ('240', 'ZDX', 'insert', '正定县', '130123', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '240', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '正定县');
INSERT INTO `systemctl_location_info` VALUES ('241', 'LCX', 'insert', '栾城县', '130124', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '241', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '栾城县');
INSERT INTO `systemctl_location_info` VALUES ('242', 'XTX', 'insert', '行唐县', '130125', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '242', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '行唐县');
INSERT INTO `systemctl_location_info` VALUES ('243', 'LSX', 'insert', '灵寿县', '130126', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '243', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵寿县');
INSERT INTO `systemctl_location_info` VALUES ('244', 'GYX', 'insert', '高邑县', '130127', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '244', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高邑县');
INSERT INTO `systemctl_location_info` VALUES ('245', 'SZX', 'insert', '深泽县', '130128', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '245', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '深泽县');
INSERT INTO `systemctl_location_info` VALUES ('246', 'ZHX', 'insert', '赞皇县', '130129', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '246', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赞皇县');
INSERT INTO `systemctl_location_info` VALUES ('247', 'WJX', 'insert', '无极县', '130130', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '247', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '无极县');
INSERT INTO `systemctl_location_info` VALUES ('248', 'PSX', 'insert', '平山县', '130131', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '248', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平山县');
INSERT INTO `systemctl_location_info` VALUES ('249', 'YSX', 'insert', '元氏县', '130132', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '249', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '元氏县');
INSERT INTO `systemctl_location_info` VALUES ('250', 'ZX', 'insert', '赵县', '130133', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '250', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赵县');
INSERT INTO `systemctl_location_info` VALUES ('251', 'XJS', 'insert', '辛集市', '130181', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '251', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '辛集市');
INSERT INTO `systemctl_location_info` VALUES ('252', 'GCS', 'insert', '藁城市', '130182', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '252', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '藁城市');
INSERT INTO `systemctl_location_info` VALUES ('253', 'JZS', 'insert', '晋州市', '130183', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '253', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '晋州市');
INSERT INTO `systemctl_location_info` VALUES ('254', 'XLS', 'insert', '新乐市', '130184', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '254', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新乐市');
INSERT INTO `systemctl_location_info` VALUES ('255', 'LQS', 'insert', '鹿泉市', '130185', 'region', '2015-01-19 15:59:00', '1', '', '130100', null, '255', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹿泉市');
INSERT INTO `systemctl_location_info` VALUES ('256', 'TSS', 'insert', '唐山市', '130200', 'city', '2015-01-19 15:59:00', '1', '118.183451,39.650531', '130000', null, '256', '2015-01-19 15:59:00', 'system', 'A', '冀B', '13', '', '唐山市');
INSERT INTO `systemctl_location_info` VALUES ('257', 'LNQ', 'insert', '路南区', '130202', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '257', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '路南区');
INSERT INTO `systemctl_location_info` VALUES ('258', 'LBQ', 'insert', '路北区', '130203', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '258', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '路北区');
INSERT INTO `systemctl_location_info` VALUES ('259', 'GYQ', 'insert', '古冶区', '130204', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '259', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古冶区');
INSERT INTO `systemctl_location_info` VALUES ('260', 'KPQ', 'insert', '开平区', '130205', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '260', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开平区');
INSERT INTO `systemctl_location_info` VALUES ('261', 'FNQ', 'insert', '丰南区', '130207', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '261', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰南区');
INSERT INTO `systemctl_location_info` VALUES ('262', 'FRQ', 'insert', '丰润区', '130208', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '262', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰润区');
INSERT INTO `systemctl_location_info` VALUES ('263', 'LX', 'insert', '滦县', '130223', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '263', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滦县');
INSERT INTO `systemctl_location_info` VALUES ('264', 'LNX', 'insert', '滦南县', '130224', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '264', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滦南县');
INSERT INTO `systemctl_location_info` VALUES ('265', 'LTX', 'insert', '乐亭县', '130225', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '265', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐亭县');
INSERT INTO `systemctl_location_info` VALUES ('266', 'QXX', 'insert', '迁西县', '130227', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '266', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '迁西县');
INSERT INTO `systemctl_location_info` VALUES ('267', 'YTX', 'insert', '玉田县', '130229', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '267', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉田县');
INSERT INTO `systemctl_location_info` VALUES ('268', 'CFDQ', 'insert', '曹妃甸区', '130230', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '268', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曹妃甸区');
INSERT INTO `systemctl_location_info` VALUES ('269', 'ZHS', 'insert', '遵化市', '130281', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '269', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '遵化市');
INSERT INTO `systemctl_location_info` VALUES ('270', 'QAS', 'insert', '迁安市', '130283', 'region', '2015-01-19 15:59:00', '1', '', '130200', null, '270', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '迁安市');
INSERT INTO `systemctl_location_info` VALUES ('271', 'QHDS', 'insert', '秦皇岛市', '130300', 'city', '2015-01-19 15:59:00', '1', '119.604368,39.945462', '130000', null, '271', '2015-01-19 15:59:00', 'system', 'A', '冀C', '12', '', '秦皇岛市');
INSERT INTO `systemctl_location_info` VALUES ('272', 'HGQ', 'insert', '海港区', '130302', 'region', '2015-01-19 15:59:00', '1', '', '130300', null, '272', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海港区');
INSERT INTO `systemctl_location_info` VALUES ('273', 'SHGQ', 'insert', '山海关区', '130303', 'region', '2015-01-19 15:59:00', '1', '', '130300', null, '273', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '山海关区');
INSERT INTO `systemctl_location_info` VALUES ('274', 'BDHQ', 'insert', '北戴河区', '130304', 'region', '2015-01-19 15:59:00', '1', '', '130300', null, '274', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北戴河区');
INSERT INTO `systemctl_location_info` VALUES ('275', 'QLMZZZX', 'insert', '青龙满族自治县', '130321', 'region', '2015-01-19 15:59:00', '1', '', '130300', null, '275', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青龙满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('276', 'CLX', 'insert', '昌黎县', '130322', 'region', '2015-01-19 15:59:00', '1', '', '130300', null, '276', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌黎县');
INSERT INTO `systemctl_location_info` VALUES ('277', 'FNX', 'insert', '抚宁县', '130323', 'region', '2015-01-19 15:59:00', '1', '', '130300', null, '277', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '抚宁县');
INSERT INTO `systemctl_location_info` VALUES ('278', 'LLX', 'insert', '卢龙县', '130324', 'region', '2015-01-19 15:59:00', '1', '', '130300', null, '278', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '卢龙县');
INSERT INTO `systemctl_location_info` VALUES ('279', 'HDS', 'insert', '邯郸市', '130400', 'city', '2015-01-19 15:59:00', '1', '114.482694,36.609308', '130000', null, '279', '2015-01-19 15:59:00', 'system', 'A', '冀D', '13', '', '邯郸市');
INSERT INTO `systemctl_location_info` VALUES ('280', 'HSQ', 'insert', '邯山区', '130402', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '280', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邯山区');
INSERT INTO `systemctl_location_info` VALUES ('281', 'CTQ', 'insert', '丛台区', '130403', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '281', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丛台区');
INSERT INTO `systemctl_location_info` VALUES ('282', 'FXQ', 'insert', '复兴区', '130404', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '282', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '复兴区');
INSERT INTO `systemctl_location_info` VALUES ('283', 'FFKQ', 'insert', '峰峰矿区', '130406', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '283', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '峰峰矿区');
INSERT INTO `systemctl_location_info` VALUES ('284', 'HDX', 'insert', '邯郸县', '130421', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '284', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邯郸县');
INSERT INTO `systemctl_location_info` VALUES ('285', 'LZX', 'insert', '临漳县', '130423', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '285', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临漳县');
INSERT INTO `systemctl_location_info` VALUES ('286', 'CAX', 'insert', '成安县', '130424', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '286', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '成安县');
INSERT INTO `systemctl_location_info` VALUES ('287', 'DMX', 'insert', '大名县', '130425', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '287', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大名县');
INSERT INTO `systemctl_location_info` VALUES ('288', 'SX', 'insert', '涉县', '130426', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '288', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涉县');
INSERT INTO `systemctl_location_info` VALUES ('289', 'CX', 'insert', '磁县', '130427', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '289', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '磁县');
INSERT INTO `systemctl_location_info` VALUES ('290', 'FXX', 'insert', '肥乡县', '130428', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '290', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肥乡县');
INSERT INTO `systemctl_location_info` VALUES ('291', 'YNX', 'insert', '永年县', '130429', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '291', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永年县');
INSERT INTO `systemctl_location_info` VALUES ('292', 'QX', 'insert', '邱县', '130430', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '292', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邱县');
INSERT INTO `systemctl_location_info` VALUES ('293', 'JZX', 'insert', '鸡泽县', '130431', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '293', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鸡泽县');
INSERT INTO `systemctl_location_info` VALUES ('294', 'GPX', 'insert', '广平县', '130432', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '294', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广平县');
INSERT INTO `systemctl_location_info` VALUES ('295', 'GTX', 'insert', '馆陶县', '130433', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '295', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '馆陶县');
INSERT INTO `systemctl_location_info` VALUES ('296', 'WX', 'insert', '魏县', '130434', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '296', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '魏县');
INSERT INTO `systemctl_location_info` VALUES ('297', 'QZX', 'insert', '曲周县', '130435', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '297', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曲周县');
INSERT INTO `systemctl_location_info` VALUES ('298', 'WAS', 'insert', '武安市', '130481', 'region', '2015-01-19 15:59:00', '1', '', '130400', null, '298', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武安市');
INSERT INTO `systemctl_location_info` VALUES ('299', 'XTS', 'insert', '邢台市', '130500', 'city', '2015-01-19 15:59:00', '1', '114.520487,37.069531', '130000', null, '299', '2015-01-19 15:59:00', 'system', 'A', '冀E', '13', '', '邢台市');
INSERT INTO `systemctl_location_info` VALUES ('300', 'QDQ', 'insert', '桥东区', '130502', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '300', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桥东区');
INSERT INTO `systemctl_location_info` VALUES ('301', 'QXQ', 'insert', '桥西区', '130503', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '301', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桥西区');
INSERT INTO `systemctl_location_info` VALUES ('302', 'XTX', 'insert', '邢台县', '130521', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '302', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邢台县');
INSERT INTO `systemctl_location_info` VALUES ('303', 'LCX', 'insert', '临城县', '130522', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '303', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临城县');
INSERT INTO `systemctl_location_info` VALUES ('304', 'NQX', 'insert', '内丘县', '130523', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '304', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '内丘县');
INSERT INTO `systemctl_location_info` VALUES ('305', 'BXX', 'insert', '柏乡县', '130524', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '305', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柏乡县');
INSERT INTO `systemctl_location_info` VALUES ('306', 'LYX', 'insert', '隆尧县', '130525', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '306', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆尧县');
INSERT INTO `systemctl_location_info` VALUES ('307', 'RX', 'insert', '任县', '130526', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '307', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '任县');
INSERT INTO `systemctl_location_info` VALUES ('308', 'NHX', 'insert', '南和县', '130527', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '308', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南和县');
INSERT INTO `systemctl_location_info` VALUES ('309', 'NJX', 'insert', '宁晋县', '130528', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '309', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁晋县');
INSERT INTO `systemctl_location_info` VALUES ('310', 'JLX', 'insert', '巨鹿县', '130529', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '310', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巨鹿县');
INSERT INTO `systemctl_location_info` VALUES ('311', 'XHX', 'insert', '新河县', '130530', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '311', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新河县');
INSERT INTO `systemctl_location_info` VALUES ('312', 'GZX', 'insert', '广宗县', '130531', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '312', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广宗县');
INSERT INTO `systemctl_location_info` VALUES ('313', 'PXX', 'insert', '平乡县', '130532', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '313', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平乡县');
INSERT INTO `systemctl_location_info` VALUES ('314', 'WX', 'insert', '威县', '130533', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '314', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '威县');
INSERT INTO `systemctl_location_info` VALUES ('315', 'QHX', 'insert', '清河县', '130534', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '315', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清河县');
INSERT INTO `systemctl_location_info` VALUES ('316', 'LXX', 'insert', '临西县', '130535', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '316', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临西县');
INSERT INTO `systemctl_location_info` VALUES ('317', 'NGS', 'insert', '南宫市', '130581', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '317', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南宫市');
INSERT INTO `systemctl_location_info` VALUES ('318', 'SHS', 'insert', '沙河市', '130582', 'region', '2015-01-19 15:59:00', '1', '', '130500', null, '318', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙河市');
INSERT INTO `systemctl_location_info` VALUES ('319', 'BDS', 'insert', '保定市', '130600', 'city', '2015-01-19 15:59:00', '1', '115.49481,38.886565', '130000', null, '319', '2015-01-19 15:59:00', 'system', 'A', '冀F', '13', '', '保定市');
INSERT INTO `systemctl_location_info` VALUES ('320', 'XSQ', 'insert', '新市区', '130602', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '320', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新市区');
INSERT INTO `systemctl_location_info` VALUES ('321', 'BSQ', 'insert', '北市区', '130603', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '321', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北市区');
INSERT INTO `systemctl_location_info` VALUES ('322', 'NSQ', 'insert', '南市区', '130604', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '322', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南市区');
INSERT INTO `systemctl_location_info` VALUES ('323', 'MCX', 'insert', '满城县', '130621', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '323', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '满城县');
INSERT INTO `systemctl_location_info` VALUES ('324', 'QYX', 'insert', '清苑县', '130622', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '324', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清苑县');
INSERT INTO `systemctl_location_info` VALUES ('325', 'LSX', 'insert', '涞水县', '130623', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '325', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涞水县');
INSERT INTO `systemctl_location_info` VALUES ('326', 'FPX', 'insert', '阜平县', '130624', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '326', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阜平县');
INSERT INTO `systemctl_location_info` VALUES ('327', 'XSX', 'insert', '徐水县', '130625', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '327', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '徐水县');
INSERT INTO `systemctl_location_info` VALUES ('328', 'DXX', 'insert', '定兴县', '130626', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '328', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定兴县');
INSERT INTO `systemctl_location_info` VALUES ('329', 'TX', 'insert', '唐县', '130627', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '329', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '唐县');
INSERT INTO `systemctl_location_info` VALUES ('330', 'GYX', 'insert', '高阳县', '130628', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '330', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高阳县');
INSERT INTO `systemctl_location_info` VALUES ('331', 'RCX', 'insert', '容城县', '130629', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '331', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '容城县');
INSERT INTO `systemctl_location_info` VALUES ('332', 'LYX', 'insert', '涞源县', '130630', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '332', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涞源县');
INSERT INTO `systemctl_location_info` VALUES ('333', 'WDX', 'insert', '望都县', '130631', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '333', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '望都县');
INSERT INTO `systemctl_location_info` VALUES ('334', 'AXX', 'insert', '安新县', '130632', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '334', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安新县');
INSERT INTO `systemctl_location_info` VALUES ('335', 'YX', 'insert', '易县', '130633', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '335', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '易县');
INSERT INTO `systemctl_location_info` VALUES ('336', 'QYX', 'insert', '曲阳县', '130634', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '336', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曲阳县');
INSERT INTO `systemctl_location_info` VALUES ('337', 'LX', 'insert', '蠡县', '130635', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '337', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蠡县');
INSERT INTO `systemctl_location_info` VALUES ('338', 'SPX', 'insert', '顺平县', '130636', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '338', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '顺平县');
INSERT INTO `systemctl_location_info` VALUES ('339', 'BYX', 'insert', '博野县', '130637', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '339', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博野县');
INSERT INTO `systemctl_location_info` VALUES ('340', 'XX', 'insert', '雄县', '130638', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '340', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雄县');
INSERT INTO `systemctl_location_info` VALUES ('341', 'ZZS', 'insert', '涿州市', '130681', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '341', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涿州市');
INSERT INTO `systemctl_location_info` VALUES ('342', 'DZS', 'insert', '定州市', '130682', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '342', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定州市');
INSERT INTO `systemctl_location_info` VALUES ('343', 'AGS', 'insert', '安国市', '130683', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '343', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安国市');
INSERT INTO `systemctl_location_info` VALUES ('344', 'GBDS', 'insert', '高碑店市', '130684', 'region', '2015-01-19 15:59:00', '1', '', '130600', null, '344', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高碑店市');
INSERT INTO `systemctl_location_info` VALUES ('345', 'ZJKS', 'insert', '张家口市', '130700', 'city', '2015-01-19 15:59:00', '1', '114.893782,40.811188', '130000', null, '345', '2015-01-19 15:59:00', 'system', 'A', '冀G', '13', '', '张家口市');
INSERT INTO `systemctl_location_info` VALUES ('346', 'QDQ', 'insert', '桥东区', '130702', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '346', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桥东区');
INSERT INTO `systemctl_location_info` VALUES ('347', 'QXQ', 'insert', '桥西区', '130703', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '347', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桥西区');
INSERT INTO `systemctl_location_info` VALUES ('348', 'XHQ', 'insert', '宣化区', '130705', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '348', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宣化区');
INSERT INTO `systemctl_location_info` VALUES ('349', 'XHYQ', 'insert', '下花园区', '130706', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '349', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '下花园区');
INSERT INTO `systemctl_location_info` VALUES ('350', 'XHX', 'insert', '宣化县', '130721', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '350', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宣化县');
INSERT INTO `systemctl_location_info` VALUES ('351', 'ZBX', 'insert', '张北县', '130722', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '351', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '张北县');
INSERT INTO `systemctl_location_info` VALUES ('352', 'KBX', 'insert', '康保县', '130723', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '352', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '康保县');
INSERT INTO `systemctl_location_info` VALUES ('353', 'GYX', 'insert', '沽源县', '130724', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '353', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沽源县');
INSERT INTO `systemctl_location_info` VALUES ('354', 'SYX', 'insert', '尚义县', '130725', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '354', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尚义县');
INSERT INTO `systemctl_location_info` VALUES ('355', 'YX', 'insert', '蔚县', '130726', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '355', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蔚县');
INSERT INTO `systemctl_location_info` VALUES ('356', 'YYX', 'insert', '阳原县', '130727', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '356', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳原县');
INSERT INTO `systemctl_location_info` VALUES ('357', 'HAX', 'insert', '怀安县', '130728', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '357', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '怀安县');
INSERT INTO `systemctl_location_info` VALUES ('358', 'WQX', 'insert', '万全县', '130729', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '358', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万全县');
INSERT INTO `systemctl_location_info` VALUES ('359', 'HLX', 'insert', '怀来县', '130730', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '359', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '怀来县');
INSERT INTO `systemctl_location_info` VALUES ('360', 'ZLX', 'insert', '涿鹿县', '130731', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '360', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涿鹿县');
INSERT INTO `systemctl_location_info` VALUES ('361', 'CCX', 'insert', '赤城县', '130732', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '361', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赤城县');
INSERT INTO `systemctl_location_info` VALUES ('362', 'CLX', 'insert', '崇礼县', '130733', 'region', '2015-01-19 15:59:00', '1', '', '130700', null, '362', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇礼县');
INSERT INTO `systemctl_location_info` VALUES ('363', 'CDS', 'insert', '承德市', '130800', 'city', '2015-01-19 15:59:00', '1', '117.933822,40.992521', '130000', null, '363', '2015-01-19 15:59:00', 'system', 'A', '冀H', '14', '', '承德市');
INSERT INTO `systemctl_location_info` VALUES ('364', 'SQQ', 'insert', '双桥区', '130802', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '364', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双桥区');
INSERT INTO `systemctl_location_info` VALUES ('365', 'SLQ', 'insert', '双滦区', '130803', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '365', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双滦区');
INSERT INTO `systemctl_location_info` VALUES ('366', 'YSYZKQ', 'insert', '鹰手营子矿区', '130804', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '366', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹰手营子矿区');
INSERT INTO `systemctl_location_info` VALUES ('367', 'CDX', 'insert', '承德县', '130821', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '367', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '承德县');
INSERT INTO `systemctl_location_info` VALUES ('368', 'XLX', 'insert', '兴隆县', '130822', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '368', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴隆县');
INSERT INTO `systemctl_location_info` VALUES ('369', 'PQX', 'insert', '平泉县', '130823', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '369', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平泉县');
INSERT INTO `systemctl_location_info` VALUES ('370', 'LPX', 'insert', '滦平县', '130824', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '370', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滦平县');
INSERT INTO `systemctl_location_info` VALUES ('371', 'LHX', 'insert', '隆化县', '130825', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '371', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆化县');
INSERT INTO `systemctl_location_info` VALUES ('372', 'FNMZZZX', 'insert', '丰宁满族自治县', '130826', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '372', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰宁满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('373', 'KCMZZZX', 'insert', '宽城满族自治县', '130827', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '373', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宽城满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('374', 'WCMZMGZZZX', 'insert', '围场满族蒙古族自治县', '130828', 'region', '2015-01-19 15:59:00', '1', '', '130800', null, '374', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '围场满族蒙古族自治县');
INSERT INTO `systemctl_location_info` VALUES ('375', 'CZS', 'insert', '沧州市', '130900', 'city', '2015-01-19 15:59:00', '1', '116.863806,38.297615', '130000', null, '375', '2015-01-19 15:59:00', 'system', 'A', '冀J', '13', '', '沧州市');
INSERT INTO `systemctl_location_info` VALUES ('376', 'XHQ', 'insert', '新华区', '130902', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '376', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新华区');
INSERT INTO `systemctl_location_info` VALUES ('377', 'YHQ', 'insert', '运河区', '130903', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '377', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '运河区');
INSERT INTO `systemctl_location_info` VALUES ('378', 'CX', 'insert', '沧县', '130921', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '378', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沧县');
INSERT INTO `systemctl_location_info` VALUES ('379', 'QX', 'insert', '青县', '130922', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '379', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青县');
INSERT INTO `systemctl_location_info` VALUES ('380', 'DGX', 'insert', '东光县', '130923', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '380', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东光县');
INSERT INTO `systemctl_location_info` VALUES ('381', 'HXX', 'insert', '海兴县', '130924', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '381', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海兴县');
INSERT INTO `systemctl_location_info` VALUES ('382', 'YSX', 'insert', '盐山县', '130925', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '382', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐山县');
INSERT INTO `systemctl_location_info` VALUES ('383', 'SNX', 'insert', '肃宁县', '130926', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '383', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肃宁县');
INSERT INTO `systemctl_location_info` VALUES ('384', 'NPX', 'insert', '南皮县', '130927', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '384', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南皮县');
INSERT INTO `systemctl_location_info` VALUES ('385', 'WQX', 'insert', '吴桥县', '130928', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '385', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吴桥县');
INSERT INTO `systemctl_location_info` VALUES ('386', 'XX', 'insert', '献县', '130929', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '386', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '献县');
INSERT INTO `systemctl_location_info` VALUES ('387', 'MCHZZZX', 'insert', '孟村回族自治县', '130930', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '387', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '孟村回族自治县');
INSERT INTO `systemctl_location_info` VALUES ('388', 'BTS', 'insert', '泊头市', '130981', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '388', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泊头市');
INSERT INTO `systemctl_location_info` VALUES ('389', 'RQS', 'insert', '任丘市', '130982', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '389', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '任丘市');
INSERT INTO `systemctl_location_info` VALUES ('390', 'HHS', 'insert', '黄骅市', '130983', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '390', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄骅市');
INSERT INTO `systemctl_location_info` VALUES ('391', 'HJS', 'insert', '河间市', '130984', 'region', '2015-01-19 15:59:00', '1', '', '130900', null, '391', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河间市');
INSERT INTO `systemctl_location_info` VALUES ('392', 'LFS', 'insert', '廊坊市', '131000', 'city', '2015-01-19 15:59:00', '1', '116.703602,39.518611', '130000', null, '392', '2015-01-19 15:59:00', 'system', 'A', '冀R', '13', '', '廊坊市');
INSERT INTO `systemctl_location_info` VALUES ('393', 'ACQ', 'insert', '安次区', '131002', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '393', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安次区');
INSERT INTO `systemctl_location_info` VALUES ('394', 'GYQ', 'insert', '广阳区', '131003', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '394', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广阳区');
INSERT INTO `systemctl_location_info` VALUES ('395', 'GAX', 'insert', '固安县', '131022', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '395', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '固安县');
INSERT INTO `systemctl_location_info` VALUES ('396', 'YQX', 'insert', '永清县', '131023', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '396', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永清县');
INSERT INTO `systemctl_location_info` VALUES ('397', 'XHX', 'insert', '香河县', '131024', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '397', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '香河县');
INSERT INTO `systemctl_location_info` VALUES ('398', 'DCX', 'insert', '大城县', '131025', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '398', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大城县');
INSERT INTO `systemctl_location_info` VALUES ('399', 'WAX', 'insert', '文安县', '131026', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '399', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文安县');
INSERT INTO `systemctl_location_info` VALUES ('400', 'DCHZZZX', 'insert', '大厂回族自治县', '131028', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '400', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大厂回族自治县');
INSERT INTO `systemctl_location_info` VALUES ('401', 'BZS', 'insert', '霸州市', '131081', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '401', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '霸州市');
INSERT INTO `systemctl_location_info` VALUES ('402', 'SHS', 'insert', '三河市', '131082', 'region', '2015-01-19 15:59:00', '1', '', '131000', null, '402', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三河市');
INSERT INTO `systemctl_location_info` VALUES ('403', 'HSS', 'insert', '衡水市', '131100', 'city', '2015-01-19 15:59:00', '1', '115.686229,37.746929', '130000', null, '403', '2015-01-19 15:59:00', 'system', 'A', '冀T', '13', '', '衡水市');
INSERT INTO `systemctl_location_info` VALUES ('404', 'TCQ', 'insert', '桃城区', '131102', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '404', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桃城区');
INSERT INTO `systemctl_location_info` VALUES ('405', 'ZQX', 'insert', '枣强县', '131121', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '405', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '枣强县');
INSERT INTO `systemctl_location_info` VALUES ('406', 'WYX', 'insert', '武邑县', '131122', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '406', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武邑县');
INSERT INTO `systemctl_location_info` VALUES ('407', 'WQX', 'insert', '武强县', '131123', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '407', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武强县');
INSERT INTO `systemctl_location_info` VALUES ('408', 'RYX', 'insert', '饶阳县', '131124', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '408', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '饶阳县');
INSERT INTO `systemctl_location_info` VALUES ('409', 'APX', 'insert', '安平县', '131125', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '409', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安平县');
INSERT INTO `systemctl_location_info` VALUES ('410', 'GCX', 'insert', '故城县', '131126', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '410', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '故城县');
INSERT INTO `systemctl_location_info` VALUES ('411', 'JX', 'insert', '景县', '131127', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '411', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '景县');
INSERT INTO `systemctl_location_info` VALUES ('412', 'FCX', 'insert', '阜城县', '131128', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '412', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阜城县');
INSERT INTO `systemctl_location_info` VALUES ('413', 'JZS', 'insert', '冀州市', '131181', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '413', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '冀州市');
INSERT INTO `systemctl_location_info` VALUES ('414', 'SZS', 'insert', '深州市', '131182', 'region', '2015-01-19 15:59:00', '1', '', '131100', null, '414', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '深州市');
INSERT INTO `systemctl_location_info` VALUES ('415', 'SXS', 'insert', '山西省', '140000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '415', '2015-01-19 15:59:00', 'system', 'A', '晋', '', '', '山西省');
INSERT INTO `systemctl_location_info` VALUES ('416', 'TYS', 'insert', '太原市', '140100', 'city', '2015-01-19 15:59:00', '1', '112.550864,37.890277', '140000', null, '416', '2015-01-19 15:59:00', 'system', 'A', '晋A', '12', '', '太原市');
INSERT INTO `systemctl_location_info` VALUES ('417', 'XDQ', 'insert', '小店区', '140105', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '417', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '小店区');
INSERT INTO `systemctl_location_info` VALUES ('418', 'YZQ', 'insert', '迎泽区', '140106', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '418', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '迎泽区');
INSERT INTO `systemctl_location_info` VALUES ('419', 'XHLQ', 'insert', '杏花岭区', '140107', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '419', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杏花岭区');
INSERT INTO `systemctl_location_info` VALUES ('420', 'JCPQ', 'insert', '尖草坪区', '140108', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '420', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尖草坪区');
INSERT INTO `systemctl_location_info` VALUES ('421', 'WBLQ', 'insert', '万柏林区', '140109', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '421', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万柏林区');
INSERT INTO `systemctl_location_info` VALUES ('422', 'JYQ', 'insert', '晋源区', '140110', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '422', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '晋源区');
INSERT INTO `systemctl_location_info` VALUES ('423', 'QXX', 'insert', '清徐县', '140121', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '423', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清徐县');
INSERT INTO `systemctl_location_info` VALUES ('424', 'YQX', 'insert', '阳曲县', '140122', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '424', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳曲县');
INSERT INTO `systemctl_location_info` VALUES ('425', 'LFX', 'insert', '娄烦县', '140123', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '425', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '娄烦县');
INSERT INTO `systemctl_location_info` VALUES ('426', 'GJS', 'insert', '古交市', '140181', 'region', '2015-01-19 15:59:00', '1', '', '140100', null, '426', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古交市');
INSERT INTO `systemctl_location_info` VALUES ('427', 'DTS', 'insert', '大同市', '140200', 'city', '2015-01-19 15:59:00', '1', '113.290509,40.113744', '140000', null, '427', '2015-01-19 15:59:00', 'system', 'A', '晋B', '12', '', '大同市');
INSERT INTO `systemctl_location_info` VALUES ('428', 'CQ', 'insert', '城区', '140202', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '428', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城区');
INSERT INTO `systemctl_location_info` VALUES ('429', 'KQ', 'insert', '矿区', '140203', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '429', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '矿区');
INSERT INTO `systemctl_location_info` VALUES ('430', 'NJQ', 'insert', '南郊区', '140211', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '430', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南郊区');
INSERT INTO `systemctl_location_info` VALUES ('431', 'XRQ', 'insert', '新荣区', '140212', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '431', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新荣区');
INSERT INTO `systemctl_location_info` VALUES ('432', 'YGX', 'insert', '阳高县', '140221', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '432', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳高县');
INSERT INTO `systemctl_location_info` VALUES ('433', 'TZX', 'insert', '天镇县', '140222', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '433', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天镇县');
INSERT INTO `systemctl_location_info` VALUES ('434', 'GLX', 'insert', '广灵县', '140223', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '434', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广灵县');
INSERT INTO `systemctl_location_info` VALUES ('435', 'LQX', 'insert', '灵丘县', '140224', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '435', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵丘县');
INSERT INTO `systemctl_location_info` VALUES ('436', 'HYX', 'insert', '浑源县', '140225', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '436', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浑源县');
INSERT INTO `systemctl_location_info` VALUES ('437', 'ZYX', 'insert', '左云县', '140226', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '437', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '左云县');
INSERT INTO `systemctl_location_info` VALUES ('438', 'DTX', 'insert', '大同县', '140227', 'region', '2015-01-19 15:59:00', '1', '', '140200', null, '438', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大同县');
INSERT INTO `systemctl_location_info` VALUES ('439', 'YQS', 'insert', '阳泉市', '140300', 'city', '2015-01-19 15:59:00', '1', '113.569238,37.869529', '140000', null, '439', '2015-01-19 15:59:00', 'system', 'A', '晋C', '13', '', '阳泉市');
INSERT INTO `systemctl_location_info` VALUES ('440', 'CQ', 'insert', '城区', '140302', 'region', '2015-01-19 15:59:00', '1', '', '140300', null, '440', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城区');
INSERT INTO `systemctl_location_info` VALUES ('441', 'KQ', 'insert', '矿区', '140303', 'region', '2015-01-19 15:59:00', '1', '', '140300', null, '441', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '矿区');
INSERT INTO `systemctl_location_info` VALUES ('442', 'JQ', 'insert', '郊区', '140311', 'region', '2015-01-19 15:59:00', '1', '', '140300', null, '442', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郊区');
INSERT INTO `systemctl_location_info` VALUES ('443', 'PDX', 'insert', '平定县', '140321', 'region', '2015-01-19 15:59:00', '1', '', '140300', null, '443', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平定县');
INSERT INTO `systemctl_location_info` VALUES ('444', 'YX', 'insert', '盂县', '140322', 'region', '2015-01-19 15:59:00', '1', '', '140300', null, '444', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盂县');
INSERT INTO `systemctl_location_info` VALUES ('445', 'ZZS', 'insert', '长治市', '140400', 'city', '2015-01-19 15:59:00', '1', '113.120292,36.201664', '140000', null, '445', '2015-01-19 15:59:00', 'system', 'A', '晋D', '12', '', '长治市');
INSERT INTO `systemctl_location_info` VALUES ('446', 'CQ', 'insert', '城区', '140402', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '446', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城区');
INSERT INTO `systemctl_location_info` VALUES ('447', 'JQ', 'insert', '郊区', '140411', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '447', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郊区');
INSERT INTO `systemctl_location_info` VALUES ('448', 'ZZX', 'insert', '长治县', '140421', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '448', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长治县');
INSERT INTO `systemctl_location_info` VALUES ('449', 'XYX', 'insert', '襄垣县', '140423', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '449', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '襄垣县');
INSERT INTO `systemctl_location_info` VALUES ('450', 'TLX', 'insert', '屯留县', '140424', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '450', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '屯留县');
INSERT INTO `systemctl_location_info` VALUES ('451', 'PSX', 'insert', '平顺县', '140425', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '451', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平顺县');
INSERT INTO `systemctl_location_info` VALUES ('452', 'LCX', 'insert', '黎城县', '140426', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '452', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黎城县');
INSERT INTO `systemctl_location_info` VALUES ('453', 'HGX', 'insert', '壶关县', '140427', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '453', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '壶关县');
INSERT INTO `systemctl_location_info` VALUES ('454', 'ZZX', 'insert', '长子县', '140428', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '454', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长子县');
INSERT INTO `systemctl_location_info` VALUES ('455', 'WXX', 'insert', '武乡县', '140429', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '455', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武乡县');
INSERT INTO `systemctl_location_info` VALUES ('456', 'QX', 'insert', '沁县', '140430', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '456', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沁县');
INSERT INTO `systemctl_location_info` VALUES ('457', 'QYX', 'insert', '沁源县', '140431', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '457', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沁源县');
INSERT INTO `systemctl_location_info` VALUES ('458', 'LCS', 'insert', '潞城市', '140481', 'region', '2015-01-19 15:59:00', '1', '', '140400', null, '458', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潞城市');
INSERT INTO `systemctl_location_info` VALUES ('459', 'JCS', 'insert', '晋城市', '140500', 'city', '2015-01-19 15:59:00', '1', '112.867333,35.499834', '140000', null, '459', '2015-01-19 15:59:00', 'system', 'A', '晋E', '13', '', '晋城市');
INSERT INTO `systemctl_location_info` VALUES ('460', 'CQ', 'insert', '城区', '140502', 'region', '2015-01-19 15:59:00', '1', '', '140500', null, '460', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城区');
INSERT INTO `systemctl_location_info` VALUES ('461', 'QSX', 'insert', '沁水县', '140521', 'region', '2015-01-19 15:59:00', '1', '', '140500', null, '461', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沁水县');
INSERT INTO `systemctl_location_info` VALUES ('462', 'YCX', 'insert', '阳城县', '140522', 'region', '2015-01-19 15:59:00', '1', '', '140500', null, '462', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳城县');
INSERT INTO `systemctl_location_info` VALUES ('463', 'LCX', 'insert', '陵川县', '140524', 'region', '2015-01-19 15:59:00', '1', '', '140500', null, '463', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陵川县');
INSERT INTO `systemctl_location_info` VALUES ('464', 'ZZX', 'insert', '泽州县', '140525', 'region', '2015-01-19 15:59:00', '1', '', '140500', null, '464', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泽州县');
INSERT INTO `systemctl_location_info` VALUES ('465', 'GPS', 'insert', '高平市', '140581', 'region', '2015-01-19 15:59:00', '1', '', '140500', null, '465', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高平市');
INSERT INTO `systemctl_location_info` VALUES ('466', 'SZS', 'insert', '朔州市', '140600', 'city', '2015-01-19 15:59:00', '1', '112.479928,39.337672', '140000', null, '466', '2015-01-19 15:59:00', 'system', 'A', '晋F', '13', '', '朔州市');
INSERT INTO `systemctl_location_info` VALUES ('467', 'SCQ', 'insert', '朔城区', '140602', 'region', '2015-01-19 15:59:00', '1', '', '140600', null, '467', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '朔城区');
INSERT INTO `systemctl_location_info` VALUES ('468', 'PLQ', 'insert', '平鲁区', '140603', 'region', '2015-01-19 15:59:00', '1', '', '140600', null, '468', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平鲁区');
INSERT INTO `systemctl_location_info` VALUES ('469', 'SYX', 'insert', '山阴县', '140621', 'region', '2015-01-19 15:59:00', '1', '', '140600', null, '469', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '山阴县');
INSERT INTO `systemctl_location_info` VALUES ('470', 'YX', 'insert', '应县', '140622', 'region', '2015-01-19 15:59:00', '1', '', '140600', null, '470', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '应县');
INSERT INTO `systemctl_location_info` VALUES ('471', 'YYX', 'insert', '右玉县', '140623', 'region', '2015-01-19 15:59:00', '1', '', '140600', null, '471', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '右玉县');
INSERT INTO `systemctl_location_info` VALUES ('472', 'HRX', 'insert', '怀仁县', '140624', 'region', '2015-01-19 15:59:00', '1', '', '140600', null, '472', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '怀仁县');
INSERT INTO `systemctl_location_info` VALUES ('473', 'JZS', 'insert', '晋中市', '140700', 'city', '2015-01-19 15:59:00', '1', '112.738514,37.693362', '140000', null, '473', '2015-01-19 15:59:00', 'system', 'A', '晋K', '13', '', '晋中市');
INSERT INTO `systemctl_location_info` VALUES ('474', 'YCQ', 'insert', '榆次区', '140702', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '474', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '榆次区');
INSERT INTO `systemctl_location_info` VALUES ('475', 'YSX', 'insert', '榆社县', '140721', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '475', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '榆社县');
INSERT INTO `systemctl_location_info` VALUES ('476', 'ZQX', 'insert', '左权县', '140722', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '476', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '左权县');
INSERT INTO `systemctl_location_info` VALUES ('477', 'HSX', 'insert', '和顺县', '140723', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '477', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和顺县');
INSERT INTO `systemctl_location_info` VALUES ('478', 'XYX', 'insert', '昔阳县', '140724', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '478', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昔阳县');
INSERT INTO `systemctl_location_info` VALUES ('479', 'SYX', 'insert', '寿阳县', '140725', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '479', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '寿阳县');
INSERT INTO `systemctl_location_info` VALUES ('480', 'TGX', 'insert', '太谷县', '140726', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '480', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太谷县');
INSERT INTO `systemctl_location_info` VALUES ('481', 'QX', 'insert', '祁县', '140727', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '481', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '祁县');
INSERT INTO `systemctl_location_info` VALUES ('482', 'PYX', 'insert', '平遥县', '140728', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '482', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平遥县');
INSERT INTO `systemctl_location_info` VALUES ('483', 'LSX', 'insert', '灵石县', '140729', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '483', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵石县');
INSERT INTO `systemctl_location_info` VALUES ('484', 'JXS', 'insert', '介休市', '140781', 'region', '2015-01-19 15:59:00', '1', '', '140700', null, '484', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '介休市');
INSERT INTO `systemctl_location_info` VALUES ('485', 'YCS', 'insert', '运城市', '140800', 'city', '2015-01-19 15:59:00', '1', '111.006854,35.038859', '140000', null, '485', '2015-01-19 15:59:00', 'system', 'A', '晋M', '13', '', '运城市');
INSERT INTO `systemctl_location_info` VALUES ('486', 'YHQ', 'insert', '盐湖区', '140802', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '486', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐湖区');
INSERT INTO `systemctl_location_info` VALUES ('487', 'LYX', 'insert', '临猗县', '140821', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '487', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临猗县');
INSERT INTO `systemctl_location_info` VALUES ('488', 'WRX', 'insert', '万荣县', '140822', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '488', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万荣县');
INSERT INTO `systemctl_location_info` VALUES ('489', 'WXX', 'insert', '闻喜县', '140823', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '489', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '闻喜县');
INSERT INTO `systemctl_location_info` VALUES ('490', 'JSX', 'insert', '稷山县', '140824', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '490', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '稷山县');
INSERT INTO `systemctl_location_info` VALUES ('491', 'XJX', 'insert', '新绛县', '140825', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '491', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新绛县');
INSERT INTO `systemctl_location_info` VALUES ('492', 'JX', 'insert', '绛县', '140826', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '492', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绛县');
INSERT INTO `systemctl_location_info` VALUES ('493', 'YQX', 'insert', '垣曲县', '140827', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '493', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '垣曲县');
INSERT INTO `systemctl_location_info` VALUES ('494', 'XX', 'insert', '夏县', '140828', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '494', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '夏县');
INSERT INTO `systemctl_location_info` VALUES ('495', 'PLX', 'insert', '平陆县', '140829', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '495', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平陆县');
INSERT INTO `systemctl_location_info` VALUES ('496', 'RCX', 'insert', '芮城县', '140830', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '496', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芮城县');
INSERT INTO `systemctl_location_info` VALUES ('497', 'YJS', 'insert', '永济市', '140881', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '497', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永济市');
INSERT INTO `systemctl_location_info` VALUES ('498', 'HJS', 'insert', '河津市', '140882', 'region', '2015-01-19 15:59:00', '1', '', '140800', null, '498', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河津市');
INSERT INTO `systemctl_location_info` VALUES ('499', 'XZS', 'insert', '忻州市', '140900', 'city', '2015-01-19 15:59:00', '1', '112.727939,38.461031', '140000', null, '499', '2015-01-19 15:59:00', 'system', 'A', '晋H', '12', '', '忻州市');
INSERT INTO `systemctl_location_info` VALUES ('500', 'XFQ', 'insert', '忻府区', '140902', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '500', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '忻府区');
INSERT INTO `systemctl_location_info` VALUES ('501', 'DXX', 'insert', '定襄县', '140921', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '501', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定襄县');
INSERT INTO `systemctl_location_info` VALUES ('502', 'WTX', 'insert', '五台县', '140922', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '502', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五台县');
INSERT INTO `systemctl_location_info` VALUES ('503', 'DX', 'insert', '代县', '140923', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '503', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '代县');
INSERT INTO `systemctl_location_info` VALUES ('504', 'FZX', 'insert', '繁峙县', '140924', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '504', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '繁峙县');
INSERT INTO `systemctl_location_info` VALUES ('505', 'NWX', 'insert', '宁武县', '140925', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '505', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁武县');
INSERT INTO `systemctl_location_info` VALUES ('506', 'JLX', 'insert', '静乐县', '140926', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '506', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '静乐县');
INSERT INTO `systemctl_location_info` VALUES ('507', 'SCX', 'insert', '神池县', '140927', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '507', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '神池县');
INSERT INTO `systemctl_location_info` VALUES ('508', 'WZX', 'insert', '五寨县', '140928', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '508', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五寨县');
INSERT INTO `systemctl_location_info` VALUES ('509', 'KLX', 'insert', '岢岚县', '140929', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '509', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岢岚县');
INSERT INTO `systemctl_location_info` VALUES ('510', 'HQX', 'insert', '河曲县', '140930', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '510', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河曲县');
INSERT INTO `systemctl_location_info` VALUES ('511', 'BDX', 'insert', '保德县', '140931', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '511', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '保德县');
INSERT INTO `systemctl_location_info` VALUES ('512', 'PGX', 'insert', '偏关县', '140932', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '512', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '偏关县');
INSERT INTO `systemctl_location_info` VALUES ('513', 'YPS', 'insert', '原平市', '140981', 'region', '2015-01-19 15:59:00', '1', '', '140900', null, '513', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '原平市');
INSERT INTO `systemctl_location_info` VALUES ('514', 'LFS', 'insert', '临汾市', '141000', 'city', '2015-01-19 15:59:00', '1', '111.538788,36.099745', '140000', null, '514', '2015-01-19 15:59:00', 'system', 'A', '晋L', '13', '', '临汾市');
INSERT INTO `systemctl_location_info` VALUES ('515', 'YDQ', 'insert', '尧都区', '141002', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '515', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尧都区');
INSERT INTO `systemctl_location_info` VALUES ('516', 'QWX', 'insert', '曲沃县', '141021', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '516', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曲沃县');
INSERT INTO `systemctl_location_info` VALUES ('517', 'YCX', 'insert', '翼城县', '141022', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '517', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '翼城县');
INSERT INTO `systemctl_location_info` VALUES ('518', 'XFX', 'insert', '襄汾县', '141023', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '518', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '襄汾县');
INSERT INTO `systemctl_location_info` VALUES ('519', 'HDX', 'insert', '洪洞县', '141024', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '519', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洪洞县');
INSERT INTO `systemctl_location_info` VALUES ('520', 'GX', 'insert', '古县', '141025', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '520', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古县');
INSERT INTO `systemctl_location_info` VALUES ('521', 'AZX', 'insert', '安泽县', '141026', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '521', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安泽县');
INSERT INTO `systemctl_location_info` VALUES ('522', 'FSX', 'insert', '浮山县', '141027', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '522', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浮山县');
INSERT INTO `systemctl_location_info` VALUES ('523', 'JX', 'insert', '吉县', '141028', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '523', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉县');
INSERT INTO `systemctl_location_info` VALUES ('524', 'XNX', 'insert', '乡宁县', '141029', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '524', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乡宁县');
INSERT INTO `systemctl_location_info` VALUES ('525', 'DNX', 'insert', '大宁县', '141030', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '525', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大宁县');
INSERT INTO `systemctl_location_info` VALUES ('526', 'XX', 'insert', '隰县', '141031', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '526', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隰县');
INSERT INTO `systemctl_location_info` VALUES ('527', 'YHX', 'insert', '永和县', '141032', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '527', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永和县');
INSERT INTO `systemctl_location_info` VALUES ('528', 'PX', 'insert', '蒲县', '141033', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '528', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蒲县');
INSERT INTO `systemctl_location_info` VALUES ('529', 'FXX', 'insert', '汾西县', '141034', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '529', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汾西县');
INSERT INTO `systemctl_location_info` VALUES ('530', 'HMS', 'insert', '侯马市', '141081', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '530', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '侯马市');
INSERT INTO `systemctl_location_info` VALUES ('531', 'HZS', 'insert', '霍州市', '141082', 'region', '2015-01-19 15:59:00', '1', '', '141000', null, '531', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '霍州市');
INSERT INTO `systemctl_location_info` VALUES ('532', 'LLS', 'insert', '吕梁市', '141100', 'city', '2015-01-19 15:59:00', '1', '111.143157,37.527316', '140000', null, '532', '2015-01-19 15:59:00', 'system', 'A', '晋J', '14', '', '吕梁市');
INSERT INTO `systemctl_location_info` VALUES ('533', 'LSQ', 'insert', '离石区', '141102', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '533', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '离石区');
INSERT INTO `systemctl_location_info` VALUES ('534', 'WSX', 'insert', '文水县', '141121', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '534', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文水县');
INSERT INTO `systemctl_location_info` VALUES ('535', 'JCX', 'insert', '交城县', '141122', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '535', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '交城县');
INSERT INTO `systemctl_location_info` VALUES ('536', 'XX', 'insert', '兴县', '141123', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '536', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴县');
INSERT INTO `systemctl_location_info` VALUES ('537', 'LX', 'insert', '临县', '141124', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '537', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临县');
INSERT INTO `systemctl_location_info` VALUES ('538', 'LLX', 'insert', '柳林县', '141125', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '538', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柳林县');
INSERT INTO `systemctl_location_info` VALUES ('539', 'SLX', 'insert', '石楼县', '141126', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '539', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石楼县');
INSERT INTO `systemctl_location_info` VALUES ('540', 'LX', 'insert', '岚县', '141127', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '540', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岚县');
INSERT INTO `systemctl_location_info` VALUES ('541', 'FSX', 'insert', '方山县', '141128', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '541', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '方山县');
INSERT INTO `systemctl_location_info` VALUES ('542', 'ZYX', 'insert', '中阳县', '141129', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '542', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中阳县');
INSERT INTO `systemctl_location_info` VALUES ('543', 'JKX', 'insert', '交口县', '141130', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '543', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '交口县');
INSERT INTO `systemctl_location_info` VALUES ('544', 'XYS', 'insert', '孝义市', '141181', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '544', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '孝义市');
INSERT INTO `systemctl_location_info` VALUES ('545', 'FYS', 'insert', '汾阳市', '141182', 'region', '2015-01-19 15:59:00', '1', '', '141100', null, '545', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汾阳市');
INSERT INTO `systemctl_location_info` VALUES ('546', 'NMGZZQ', 'insert', '内蒙古自治区', '150000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '546', '2015-01-19 15:59:00', 'system', 'A', '蒙', '', '', '内蒙古自治区');
INSERT INTO `systemctl_location_info` VALUES ('547', 'HHHTS', 'insert', '呼和浩特市', '150100', 'city', '2015-01-19 15:59:00', '1', '111.660351,40.828319', '150000', null, '547', '2015-01-19 15:59:00', 'system', 'A', '蒙A', '12', '', '呼和浩特市');
INSERT INTO `systemctl_location_info` VALUES ('548', 'XCQ', 'insert', '新城区', '150102', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '548', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新城区');
INSERT INTO `systemctl_location_info` VALUES ('549', 'HMQ', 'insert', '回民区', '150103', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '549', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '回民区');
INSERT INTO `systemctl_location_info` VALUES ('550', 'YQQ', 'insert', '玉泉区', '150104', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '550', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉泉区');
INSERT INTO `systemctl_location_info` VALUES ('551', 'SHQ', 'insert', '赛罕区', '150105', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '551', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赛罕区');
INSERT INTO `systemctl_location_info` VALUES ('552', 'TMTZQ', 'insert', '土默特左旗', '150121', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '552', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '土默特左旗');
INSERT INTO `systemctl_location_info` VALUES ('553', 'TKTX', 'insert', '托克托县', '150122', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '553', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '托克托县');
INSERT INTO `systemctl_location_info` VALUES ('554', 'HLGEX', 'insert', '和林格尔县', '150123', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '554', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和林格尔县');
INSERT INTO `systemctl_location_info` VALUES ('555', 'QSHX', 'insert', '清水河县', '150124', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '555', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清水河县');
INSERT INTO `systemctl_location_info` VALUES ('556', 'WCX', 'insert', '武川县', '150125', 'region', '2015-01-19 15:59:00', '1', '', '150100', null, '556', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武川县');
INSERT INTO `systemctl_location_info` VALUES ('557', 'BTS', 'insert', '包头市', '150200', 'city', '2015-01-19 15:59:00', '1', '109.846239,40.647119', '150000', null, '557', '2015-01-19 15:59:00', 'system', 'A', '蒙B', '12', '', '包头市');
INSERT INTO `systemctl_location_info` VALUES ('558', 'DHQ', 'insert', '东河区', '150202', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '558', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东河区');
INSERT INTO `systemctl_location_info` VALUES ('559', 'KDLQ', 'insert', '昆都仑区', '150203', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '559', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昆都仑区');
INSERT INTO `systemctl_location_info` VALUES ('560', 'QSQ', 'insert', '青山区', '150204', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '560', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青山区');
INSERT INTO `systemctl_location_info` VALUES ('561', 'SGQ', 'insert', '石拐区', '150205', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '561', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石拐区');
INSERT INTO `systemctl_location_info` VALUES ('562', 'BYEBKQ', 'insert', '白云鄂博矿区', '150206', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '562', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白云鄂博矿区');
INSERT INTO `systemctl_location_info` VALUES ('563', 'JYQ', 'insert', '九原区', '150207', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '563', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '九原区');
INSERT INTO `systemctl_location_info` VALUES ('564', 'TMTYQ', 'insert', '土默特右旗', '150221', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '564', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '土默特右旗');
INSERT INTO `systemctl_location_info` VALUES ('565', 'GYX', 'insert', '固阳县', '150222', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '565', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '固阳县');
INSERT INTO `systemctl_location_info` VALUES ('566', 'DEHMMALHQ', 'insert', '达尔罕茂明安联合旗', '150223', 'region', '2015-01-19 15:59:00', '1', '', '150200', null, '566', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '达尔罕茂明安联合旗');
INSERT INTO `systemctl_location_info` VALUES ('567', 'WHS', 'insert', '乌海市', '150300', 'city', '2015-01-19 15:59:00', '1', '106.831999,39.683177', '150000', null, '567', '2015-01-19 15:59:00', 'system', 'A', '蒙C', '13', '', '乌海市');
INSERT INTO `systemctl_location_info` VALUES ('568', 'HBWQ', 'insert', '海勃湾区', '150302', 'region', '2015-01-19 15:59:00', '1', '', '150300', null, '568', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海勃湾区');
INSERT INTO `systemctl_location_info` VALUES ('569', 'HNQ', 'insert', '海南区', '150303', 'region', '2015-01-19 15:59:00', '1', '', '150300', null, '569', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海南区');
INSERT INTO `systemctl_location_info` VALUES ('570', 'WDQ', 'insert', '乌达区', '150304', 'region', '2015-01-19 15:59:00', '1', '', '150300', null, '570', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌达区');
INSERT INTO `systemctl_location_info` VALUES ('571', 'CFS', 'insert', '赤峰市', '150400', 'city', '2015-01-19 15:59:00', '1', '118.930761,42.297112', '150000', null, '571', '2015-01-19 15:59:00', 'system', 'A', '蒙D', '12', '', '赤峰市');
INSERT INTO `systemctl_location_info` VALUES ('572', 'HSQ', 'insert', '红山区', '150402', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '572', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红山区');
INSERT INTO `systemctl_location_info` VALUES ('573', 'YBSQ', 'insert', '元宝山区', '150403', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '573', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '元宝山区');
INSERT INTO `systemctl_location_info` VALUES ('574', 'SSQ', 'insert', '松山区', '150404', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '574', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松山区');
INSERT INTO `systemctl_location_info` VALUES ('575', 'ALKEQQ', 'insert', '阿鲁科尔沁旗', '150421', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '575', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿鲁科尔沁旗');
INSERT INTO `systemctl_location_info` VALUES ('576', 'BLZQ', 'insert', '巴林左旗', '150422', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '576', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴林左旗');
INSERT INTO `systemctl_location_info` VALUES ('577', 'BLYQ', 'insert', '巴林右旗', '150423', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '577', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴林右旗');
INSERT INTO `systemctl_location_info` VALUES ('578', 'LXX', 'insert', '林西县', '150424', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '578', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '林西县');
INSERT INTO `systemctl_location_info` VALUES ('579', 'KSKTQ', 'insert', '克什克腾旗', '150425', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '579', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '克什克腾旗');
INSERT INTO `systemctl_location_info` VALUES ('580', 'WNTQ', 'insert', '翁牛特旗', '150426', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '580', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '翁牛特旗');
INSERT INTO `systemctl_location_info` VALUES ('581', 'KLQQ', 'insert', '喀喇沁旗', '150428', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '581', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '喀喇沁旗');
INSERT INTO `systemctl_location_info` VALUES ('582', 'NCX', 'insert', '宁城县', '150429', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '582', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁城县');
INSERT INTO `systemctl_location_info` VALUES ('583', 'AHQ', 'insert', '敖汉旗', '150430', 'region', '2015-01-19 15:59:00', '1', '', '150400', null, '583', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '敖汉旗');
INSERT INTO `systemctl_location_info` VALUES ('584', 'TLS', 'insert', '通辽市', '150500', 'city', '2015-01-19 15:59:00', '1', '122.260363,43.633756', '150000', null, '584', '2015-01-19 15:59:00', 'system', 'A', '蒙G', '12', '', '通辽市');
INSERT INTO `systemctl_location_info` VALUES ('585', 'KEQQ', 'insert', '科尔沁区', '150502', 'region', '2015-01-19 15:59:00', '1', '', '150500', null, '585', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '科尔沁区');
INSERT INTO `systemctl_location_info` VALUES ('586', 'KEQZYZQ', 'insert', '科尔沁左翼中旗', '150521', 'region', '2015-01-19 15:59:00', '1', '', '150500', null, '586', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '科尔沁左翼中旗');
INSERT INTO `systemctl_location_info` VALUES ('587', 'KEQZYHQ', 'insert', '科尔沁左翼后旗', '150522', 'region', '2015-01-19 15:59:00', '1', '', '150500', null, '587', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '科尔沁左翼后旗');
INSERT INTO `systemctl_location_info` VALUES ('588', 'KLX', 'insert', '开鲁县', '150523', 'region', '2015-01-19 15:59:00', '1', '', '150500', null, '588', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开鲁县');
INSERT INTO `systemctl_location_info` VALUES ('589', 'KLQ', 'insert', '库伦旗', '150524', 'region', '2015-01-19 15:59:00', '1', '', '150500', null, '589', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '库伦旗');
INSERT INTO `systemctl_location_info` VALUES ('590', 'NMQ', 'insert', '奈曼旗', '150525', 'region', '2015-01-19 15:59:00', '1', '', '150500', null, '590', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '奈曼旗');
INSERT INTO `systemctl_location_info` VALUES ('591', 'ZLTQ', 'insert', '扎鲁特旗', '150526', 'region', '2015-01-19 15:59:00', '1', '', '150500', null, '591', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扎鲁特旗');
INSERT INTO `systemctl_location_info` VALUES ('592', 'HLGLS', 'insert', '霍林郭勒市', '150581', 'region', '2015-01-19 15:59:00', '1', '', '150500', null, '592', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '霍林郭勒市');
INSERT INTO `systemctl_location_info` VALUES ('593', 'EEDSS', 'insert', '鄂尔多斯市', '150600', 'city', '2015-01-19 15:59:00', '1', '109.993706,39.81649', '150000', null, '593', '2015-01-19 15:59:00', 'system', 'A', '蒙K', '12', '', '鄂尔多斯市');
INSERT INTO `systemctl_location_info` VALUES ('594', 'DSQ', 'insert', '东胜区', '150602', 'region', '2015-01-19 15:59:00', '1', '', '150600', null, '594', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东胜区');
INSERT INTO `systemctl_location_info` VALUES ('595', 'DLTQ', 'insert', '达拉特旗', '150621', 'region', '2015-01-19 15:59:00', '1', '', '150600', null, '595', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '达拉特旗');
INSERT INTO `systemctl_location_info` VALUES ('596', 'ZGEQ', 'insert', '准格尔旗', '150622', 'region', '2015-01-19 15:59:00', '1', '', '150600', null, '596', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '准格尔旗');
INSERT INTO `systemctl_location_info` VALUES ('597', 'ETKQQ', 'insert', '鄂托克前旗', '150623', 'region', '2015-01-19 15:59:00', '1', '', '150600', null, '597', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄂托克前旗');
INSERT INTO `systemctl_location_info` VALUES ('598', 'ETKQ', 'insert', '鄂托克旗', '150624', 'region', '2015-01-19 15:59:00', '1', '', '150600', null, '598', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄂托克旗');
INSERT INTO `systemctl_location_info` VALUES ('599', 'HJQ', 'insert', '杭锦旗', '150625', 'region', '2015-01-19 15:59:00', '1', '', '150600', null, '599', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杭锦旗');
INSERT INTO `systemctl_location_info` VALUES ('600', 'WSQ', 'insert', '乌审旗', '150626', 'region', '2015-01-19 15:59:00', '1', '', '150600', null, '600', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌审旗');
INSERT INTO `systemctl_location_info` VALUES ('601', 'YJHLQ', 'insert', '伊金霍洛旗', '150627', 'region', '2015-01-19 15:59:00', '1', '', '150600', null, '601', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伊金霍洛旗');
INSERT INTO `systemctl_location_info` VALUES ('602', 'HLBES', 'insert', '呼伦贝尔市', '150700', 'city', '2015-01-19 15:59:00', '1', '119.760822,49.201636', '150000', null, '602', '2015-01-19 15:59:00', 'system', 'A', '蒙E', '12', '', '呼伦贝尔市');
INSERT INTO `systemctl_location_info` VALUES ('603', 'HLEQ', 'insert', '海拉尔区', '150702', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '603', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海拉尔区');
INSERT INTO `systemctl_location_info` VALUES ('604', 'ARQ', 'insert', '阿荣旗', '150721', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '604', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿荣旗');
INSERT INTO `systemctl_location_info` VALUES ('605', 'MLDWDWEZZZQ', 'insert', '莫力达瓦达斡尔族自治旗', '150722', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '605', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莫力达瓦达斡尔族自治旗');
INSERT INTO `systemctl_location_info` VALUES ('606', 'ELCZZQ', 'insert', '鄂伦春自治旗', '150723', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '606', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄂伦春自治旗');
INSERT INTO `systemctl_location_info` VALUES ('607', 'EWKZZZQ', 'insert', '鄂温克族自治旗', '150724', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '607', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄂温克族自治旗');
INSERT INTO `systemctl_location_info` VALUES ('608', 'CBEHQ', 'insert', '陈巴尔虎旗', '150725', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '608', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陈巴尔虎旗');
INSERT INTO `systemctl_location_info` VALUES ('609', 'XBEHZQ', 'insert', '新巴尔虎左旗', '150726', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '609', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新巴尔虎左旗');
INSERT INTO `systemctl_location_info` VALUES ('610', 'XBEHYQ', 'insert', '新巴尔虎右旗', '150727', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '610', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新巴尔虎右旗');
INSERT INTO `systemctl_location_info` VALUES ('611', 'MZLS', 'insert', '满洲里市', '150781', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '611', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '满洲里市');
INSERT INTO `systemctl_location_info` VALUES ('612', 'YKSS', 'insert', '牙克石市', '150782', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '612', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '牙克石市');
INSERT INTO `systemctl_location_info` VALUES ('613', 'ZLTS', 'insert', '扎兰屯市', '150783', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '613', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扎兰屯市');
INSERT INTO `systemctl_location_info` VALUES ('614', 'EEGNS', 'insert', '额尔古纳市', '150784', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '614', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '额尔古纳市');
INSERT INTO `systemctl_location_info` VALUES ('615', 'GHS', 'insert', '根河市', '150785', 'region', '2015-01-19 15:59:00', '1', '', '150700', null, '615', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '根河市');
INSERT INTO `systemctl_location_info` VALUES ('616', 'BYNES', 'insert', '巴彦淖尔市', '150800', 'city', '2015-01-19 15:59:00', '1', '107.423807,40.76918', '150000', null, '616', '2015-01-19 15:59:00', 'system', 'A', '蒙L', '12', '', '巴彦淖尔市');
INSERT INTO `systemctl_location_info` VALUES ('617', 'LHQ', 'insert', '临河区', '150802', 'region', '2015-01-19 15:59:00', '1', '', '150800', null, '617', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临河区');
INSERT INTO `systemctl_location_info` VALUES ('618', 'WYX', 'insert', '五原县', '150821', 'region', '2015-01-19 15:59:00', '1', '', '150800', null, '618', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五原县');
INSERT INTO `systemctl_location_info` VALUES ('619', 'DKX', 'insert', '磴口县', '150822', 'region', '2015-01-19 15:59:00', '1', '', '150800', null, '619', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '磴口县');
INSERT INTO `systemctl_location_info` VALUES ('620', 'WLTQQ', 'insert', '乌拉特前旗', '150823', 'region', '2015-01-19 15:59:00', '1', '', '150800', null, '620', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌拉特前旗');
INSERT INTO `systemctl_location_info` VALUES ('621', 'WLTZQ', 'insert', '乌拉特中旗', '150824', 'region', '2015-01-19 15:59:00', '1', '', '150800', null, '621', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌拉特中旗');
INSERT INTO `systemctl_location_info` VALUES ('622', 'WLTHQ', 'insert', '乌拉特后旗', '150825', 'region', '2015-01-19 15:59:00', '1', '', '150800', null, '622', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌拉特后旗');
INSERT INTO `systemctl_location_info` VALUES ('623', 'HJHQ', 'insert', '杭锦后旗', '150826', 'region', '2015-01-19 15:59:00', '1', '', '150800', null, '623', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杭锦后旗');
INSERT INTO `systemctl_location_info` VALUES ('624', 'WLCBS', 'insert', '乌兰察布市', '150900', 'city', '2015-01-19 15:59:00', '1', '113.112846,41.022363', '150000', null, '624', '2015-01-19 15:59:00', 'system', 'A', '蒙J', '12', '', '乌兰察布市');
INSERT INTO `systemctl_location_info` VALUES ('625', 'JNQ', 'insert', '集宁区', '150902', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '625', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '集宁区');
INSERT INTO `systemctl_location_info` VALUES ('626', 'ZZX', 'insert', '卓资县', '150921', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '626', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '卓资县');
INSERT INTO `systemctl_location_info` VALUES ('627', 'HDX', 'insert', '化德县', '150922', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '627', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '化德县');
INSERT INTO `systemctl_location_info` VALUES ('628', 'SDX', 'insert', '商都县', '150923', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '628', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '商都县');
INSERT INTO `systemctl_location_info` VALUES ('629', 'XHX', 'insert', '兴和县', '150924', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '629', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴和县');
INSERT INTO `systemctl_location_info` VALUES ('630', 'LCX', 'insert', '凉城县', '150925', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '630', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凉城县');
INSERT INTO `systemctl_location_info` VALUES ('631', 'CHEYYQQ', 'insert', '察哈尔右翼前旗', '150926', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '631', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '察哈尔右翼前旗');
INSERT INTO `systemctl_location_info` VALUES ('632', 'CHEYYZQ', 'insert', '察哈尔右翼中旗', '150927', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '632', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '察哈尔右翼中旗');
INSERT INTO `systemctl_location_info` VALUES ('633', 'CHEYYHQ', 'insert', '察哈尔右翼后旗', '150928', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '633', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '察哈尔右翼后旗');
INSERT INTO `systemctl_location_info` VALUES ('634', 'SZWQ', 'insert', '四子王旗', '150929', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '634', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '四子王旗');
INSERT INTO `systemctl_location_info` VALUES ('635', 'FZS', 'insert', '丰镇市', '150981', 'region', '2015-01-19 15:59:00', '1', '', '150900', null, '635', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰镇市');
INSERT INTO `systemctl_location_info` VALUES ('636', 'XAM', 'insert', '兴安盟', '152200', 'city', '2015-01-19 15:59:00', '1', '122.048167,46.083757', '150000', null, '636', '2015-01-19 15:59:00', 'system', 'A', '蒙F', '11', '', '兴安盟');
INSERT INTO `systemctl_location_info` VALUES ('637', 'WLHTS', 'insert', '乌兰浩特市', '152201', 'region', '2015-01-19 15:59:00', '1', '', '152200', null, '637', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌兰浩特市');
INSERT INTO `systemctl_location_info` VALUES ('638', 'AESS', 'insert', '阿尔山市', '152202', 'region', '2015-01-19 15:59:00', '1', '', '152200', null, '638', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿尔山市');
INSERT INTO `systemctl_location_info` VALUES ('639', 'KEQYYQQ', 'insert', '科尔沁右翼前旗', '152221', 'region', '2015-01-19 15:59:00', '1', '', '152200', null, '639', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '科尔沁右翼前旗');
INSERT INTO `systemctl_location_info` VALUES ('640', 'KEQYYZQ', 'insert', '科尔沁右翼中旗', '152222', 'region', '2015-01-19 15:59:00', '1', '', '152200', null, '640', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '科尔沁右翼中旗');
INSERT INTO `systemctl_location_info` VALUES ('641', 'ZLTQ', 'insert', '扎赉特旗', '152223', 'region', '2015-01-19 15:59:00', '1', '', '152200', null, '641', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扎赉特旗');
INSERT INTO `systemctl_location_info` VALUES ('642', 'TQX', 'insert', '突泉县', '152224', 'region', '2015-01-19 15:59:00', '1', '', '152200', null, '642', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '突泉县');
INSERT INTO `systemctl_location_info` VALUES ('643', 'XLGLM', 'insert', '锡林郭勒盟', '152500', 'city', '2015-01-19 15:59:00', '1', '116.02734,43.939705', '150000', null, '643', '2015-01-19 15:59:00', 'system', 'A', '蒙H', '11', '', '锡林郭勒盟');
INSERT INTO `systemctl_location_info` VALUES ('644', 'ELHTS', 'insert', '二连浩特市', '152501', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '644', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '二连浩特市');
INSERT INTO `systemctl_location_info` VALUES ('645', 'XLHTS', 'insert', '锡林浩特市', '152502', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '645', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '锡林浩特市');
INSERT INTO `systemctl_location_info` VALUES ('646', 'ABGQ', 'insert', '阿巴嘎旗', '152522', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '646', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿巴嘎旗');
INSERT INTO `systemctl_location_info` VALUES ('647', 'SNTZQ', 'insert', '苏尼特左旗', '152523', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '647', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苏尼特左旗');
INSERT INTO `systemctl_location_info` VALUES ('648', 'SNTYQ', 'insert', '苏尼特右旗', '152524', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '648', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苏尼特右旗');
INSERT INTO `systemctl_location_info` VALUES ('649', 'DWZMQQ', 'insert', '东乌珠穆沁旗', '152525', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '649', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东乌珠穆沁旗');
INSERT INTO `systemctl_location_info` VALUES ('650', 'XWZMQQ', 'insert', '西乌珠穆沁旗', '152526', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '650', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西乌珠穆沁旗');
INSERT INTO `systemctl_location_info` VALUES ('651', 'TPSQ', 'insert', '太仆寺旗', '152527', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '651', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太仆寺旗');
INSERT INTO `systemctl_location_info` VALUES ('652', 'XHQ', 'insert', '镶黄旗', '152528', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '652', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镶黄旗');
INSERT INTO `systemctl_location_info` VALUES ('653', 'ZXBQ', 'insert', '正镶白旗', '152529', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '653', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '正镶白旗');
INSERT INTO `systemctl_location_info` VALUES ('654', 'ZLQ', 'insert', '正蓝旗', '152530', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '654', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '正蓝旗');
INSERT INTO `systemctl_location_info` VALUES ('655', 'DLX', 'insert', '多伦县', '152531', 'region', '2015-01-19 15:59:00', '1', '', '152500', null, '655', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '多伦县');
INSERT INTO `systemctl_location_info` VALUES ('656', 'ALSM', 'insert', '阿拉善盟', '152900', 'city', '2015-01-19 15:59:00', '1', '105.695683,38.843075', '150000', null, '656', '2015-01-19 15:59:00', 'system', 'A', '蒙M', '14', '', '阿拉善盟');
INSERT INTO `systemctl_location_info` VALUES ('657', 'ALSZQ', 'insert', '阿拉善左旗', '152921', 'region', '2015-01-19 15:59:00', '1', '', '152900', null, '657', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿拉善左旗');
INSERT INTO `systemctl_location_info` VALUES ('658', 'ALSYQ', 'insert', '阿拉善右旗', '152922', 'region', '2015-01-19 15:59:00', '1', '', '152900', null, '658', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿拉善右旗');
INSERT INTO `systemctl_location_info` VALUES ('659', 'EJNQ', 'insert', '额济纳旗', '152923', 'region', '2015-01-19 15:59:00', '1', '', '152900', null, '659', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '额济纳旗');
INSERT INTO `systemctl_location_info` VALUES ('660', 'LNS', 'insert', '辽宁省', '210000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '660', '2015-01-19 15:59:00', 'system', 'A', '辽', '', '', '辽宁省');
INSERT INTO `systemctl_location_info` VALUES ('661', 'SYS', 'insert', '沈阳市', '210100', 'city', '2015-01-19 15:59:00', '1', '123.432791,41.808645', '210000', null, '661', '2015-01-19 15:59:00', 'system', 'A', '辽A', '12', '', '沈阳市');
INSERT INTO `systemctl_location_info` VALUES ('662', 'HPQ', 'insert', '和平区', '210102', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '662', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和平区');
INSERT INTO `systemctl_location_info` VALUES ('663', 'SHQ', 'insert', '沈河区', '210103', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '663', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沈河区');
INSERT INTO `systemctl_location_info` VALUES ('664', 'DDQ', 'insert', '大东区', '210104', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '664', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大东区');
INSERT INTO `systemctl_location_info` VALUES ('665', 'HGQ', 'insert', '皇姑区', '210105', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '665', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '皇姑区');
INSERT INTO `systemctl_location_info` VALUES ('666', 'TXQ', 'insert', '铁西区', '210106', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '666', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁西区');
INSERT INTO `systemctl_location_info` VALUES ('667', 'SJTQ', 'insert', '苏家屯区', '210111', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '667', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苏家屯区');
INSERT INTO `systemctl_location_info` VALUES ('668', 'DLQ', 'insert', '东陵区', '210112', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '668', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东陵区');
INSERT INTO `systemctl_location_info` VALUES ('669', 'SBXQ', 'insert', '沈北新区', '210113', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '669', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沈北新区');
INSERT INTO `systemctl_location_info` VALUES ('670', 'YHQ', 'insert', '于洪区', '210114', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '670', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '于洪区');
INSERT INTO `systemctl_location_info` VALUES ('671', 'LZX', 'insert', '辽中县', '210122', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '671', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '辽中县');
INSERT INTO `systemctl_location_info` VALUES ('672', 'KPX', 'insert', '康平县', '210123', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '672', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '康平县');
INSERT INTO `systemctl_location_info` VALUES ('673', 'FKX', 'insert', '法库县', '210124', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '673', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '法库县');
INSERT INTO `systemctl_location_info` VALUES ('674', 'XMS', 'insert', '新民市', '210181', 'region', '2015-01-19 15:59:00', '1', '', '210100', null, '674', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新民市');
INSERT INTO `systemctl_location_info` VALUES ('675', 'DLS', 'insert', '大连市', '210200', 'city', '2015-01-19 15:59:00', '1', '121.593478,38.94871', '210000', null, '675', '2015-01-19 15:59:00', 'system', 'A', '辽B', '12', '', '大连市');
INSERT INTO `systemctl_location_info` VALUES ('676', 'ZSQ', 'insert', '中山区', '210202', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '676', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中山区');
INSERT INTO `systemctl_location_info` VALUES ('677', 'XGQ', 'insert', '西岗区', '210203', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '677', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西岗区');
INSERT INTO `systemctl_location_info` VALUES ('678', 'SHKQ', 'insert', '沙河口区', '210204', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '678', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙河口区');
INSERT INTO `systemctl_location_info` VALUES ('679', 'GJZQ', 'insert', '甘井子区', '210211', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '679', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘井子区');
INSERT INTO `systemctl_location_info` VALUES ('680', 'LSKQ', 'insert', '旅顺口区', '210212', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '680', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '旅顺口区');
INSERT INTO `systemctl_location_info` VALUES ('681', 'JZQ', 'insert', '金州区', '210213', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '681', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金州区');
INSERT INTO `systemctl_location_info` VALUES ('682', 'ZHX', 'insert', '长海县', '210224', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '682', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长海县');
INSERT INTO `systemctl_location_info` VALUES ('683', 'WFDS', 'insert', '瓦房店市', '210281', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '683', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瓦房店市');
INSERT INTO `systemctl_location_info` VALUES ('684', 'PLDS', 'insert', '普兰店市', '210282', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '684', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '普兰店市');
INSERT INTO `systemctl_location_info` VALUES ('685', 'ZHS', 'insert', '庄河市', '210283', 'region', '2015-01-19 15:59:00', '1', '', '210200', null, '685', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庄河市');
INSERT INTO `systemctl_location_info` VALUES ('686', 'ASS', 'insert', '鞍山市', '210300', 'city', '2015-01-19 15:59:00', '1', '123.007763,41.118744', '210000', null, '686', '2015-01-19 15:59:00', 'system', 'A', '辽C', '13', '', '鞍山市');
INSERT INTO `systemctl_location_info` VALUES ('687', 'TDQ', 'insert', '铁东区', '210302', 'region', '2015-01-19 15:59:00', '1', '', '210300', null, '687', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁东区');
INSERT INTO `systemctl_location_info` VALUES ('688', 'TXQ', 'insert', '铁西区', '210303', 'region', '2015-01-19 15:59:00', '1', '', '210300', null, '688', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁西区');
INSERT INTO `systemctl_location_info` VALUES ('689', 'LSQ', 'insert', '立山区', '210304', 'region', '2015-01-19 15:59:00', '1', '', '210300', null, '689', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '立山区');
INSERT INTO `systemctl_location_info` VALUES ('690', 'QSQ', 'insert', '千山区', '210311', 'region', '2015-01-19 15:59:00', '1', '', '210300', null, '690', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '千山区');
INSERT INTO `systemctl_location_info` VALUES ('691', 'TAX', 'insert', '台安县', '210321', 'region', '2015-01-19 15:59:00', '1', '', '210300', null, '691', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台安县');
INSERT INTO `systemctl_location_info` VALUES ('692', 'XYMZZZX', 'insert', '岫岩满族自治县', '210323', 'region', '2015-01-19 15:59:00', '1', '', '210300', null, '692', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岫岩满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('693', 'HCS', 'insert', '海城市', '210381', 'region', '2015-01-19 15:59:00', '1', '', '210300', null, '693', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海城市');
INSERT INTO `systemctl_location_info` VALUES ('694', 'FSS', 'insert', '抚顺市', '210400', 'city', '2015-01-19 15:59:00', '1', '123.92982,41.877304', '210000', null, '694', '2015-01-19 15:59:00', 'system', 'A', '辽D', '12', '', '抚顺市');
INSERT INTO `systemctl_location_info` VALUES ('695', 'XFQ', 'insert', '新抚区', '210402', 'region', '2015-01-19 15:59:00', '1', '', '210400', null, '695', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新抚区');
INSERT INTO `systemctl_location_info` VALUES ('696', 'DZQ', 'insert', '东洲区', '210403', 'region', '2015-01-19 15:59:00', '1', '', '210400', null, '696', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东洲区');
INSERT INTO `systemctl_location_info` VALUES ('697', 'WHQ', 'insert', '望花区', '210404', 'region', '2015-01-19 15:59:00', '1', '', '210400', null, '697', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '望花区');
INSERT INTO `systemctl_location_info` VALUES ('698', 'SCQ', 'insert', '顺城区', '210411', 'region', '2015-01-19 15:59:00', '1', '', '210400', null, '698', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '顺城区');
INSERT INTO `systemctl_location_info` VALUES ('699', 'FSX', 'insert', '抚顺县', '210421', 'region', '2015-01-19 15:59:00', '1', '', '210400', null, '699', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '抚顺县');
INSERT INTO `systemctl_location_info` VALUES ('700', 'XBMZZZX', 'insert', '新宾满族自治县', '210422', 'region', '2015-01-19 15:59:00', '1', '', '210400', null, '700', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新宾满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('701', 'QYMZZZX', 'insert', '清原满族自治县', '210423', 'region', '2015-01-19 15:59:00', '1', '', '210400', null, '701', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清原满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('702', 'BXS', 'insert', '本溪市', '210500', 'city', '2015-01-19 15:59:00', '1', '123.778062,41.325838', '210000', null, '702', '2015-01-19 15:59:00', 'system', 'A', '辽E', '12', '', '本溪市');
INSERT INTO `systemctl_location_info` VALUES ('703', 'PSQ', 'insert', '平山区', '210502', 'region', '2015-01-19 15:59:00', '1', '', '210500', null, '703', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平山区');
INSERT INTO `systemctl_location_info` VALUES ('704', 'XHQ', 'insert', '溪湖区', '210503', 'region', '2015-01-19 15:59:00', '1', '', '210500', null, '704', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '溪湖区');
INSERT INTO `systemctl_location_info` VALUES ('705', 'MSQ', 'insert', '明山区', '210504', 'region', '2015-01-19 15:59:00', '1', '', '210500', null, '705', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '明山区');
INSERT INTO `systemctl_location_info` VALUES ('706', 'NFQ', 'insert', '南芬区', '210505', 'region', '2015-01-19 15:59:00', '1', '', '210500', null, '706', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南芬区');
INSERT INTO `systemctl_location_info` VALUES ('707', 'BXMZZZX', 'insert', '本溪满族自治县', '210521', 'region', '2015-01-19 15:59:00', '1', '', '210500', null, '707', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '本溪满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('708', 'HRMZZZX', 'insert', '桓仁满族自治县', '210522', 'region', '2015-01-19 15:59:00', '1', '', '210500', null, '708', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桓仁满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('709', 'DDS', 'insert', '丹东市', '210600', 'city', '2015-01-19 15:59:00', '1', '124.338543,40.129023', '210000', null, '709', '2015-01-19 15:59:00', 'system', 'A', '辽F', '12', '', '丹东市');
INSERT INTO `systemctl_location_info` VALUES ('710', 'YBQ', 'insert', '元宝区', '210602', 'region', '2015-01-19 15:59:00', '1', '', '210600', null, '710', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '元宝区');
INSERT INTO `systemctl_location_info` VALUES ('711', 'ZXQ', 'insert', '振兴区', '210603', 'region', '2015-01-19 15:59:00', '1', '', '210600', null, '711', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '振兴区');
INSERT INTO `systemctl_location_info` VALUES ('712', 'ZAQ', 'insert', '振安区', '210604', 'region', '2015-01-19 15:59:00', '1', '', '210600', null, '712', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '振安区');
INSERT INTO `systemctl_location_info` VALUES ('713', 'KDMZZZX', 'insert', '宽甸满族自治县', '210624', 'region', '2015-01-19 15:59:00', '1', '', '210600', null, '713', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宽甸满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('714', 'DGS', 'insert', '东港市', '210681', 'region', '2015-01-19 15:59:00', '1', '', '210600', null, '714', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东港市');
INSERT INTO `systemctl_location_info` VALUES ('715', 'FCS', 'insert', '凤城市', '210682', 'region', '2015-01-19 15:59:00', '1', '', '210600', null, '715', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤城市');
INSERT INTO `systemctl_location_info` VALUES ('716', 'JZS', 'insert', '锦州市', '210700', 'city', '2015-01-19 15:59:00', '1', '121.147749,41.130879', '210000', null, '716', '2015-01-19 15:59:00', 'system', 'A', '辽G', '13', '', '锦州市');
INSERT INTO `systemctl_location_info` VALUES ('717', 'GTQ', 'insert', '古塔区', '210702', 'region', '2015-01-19 15:59:00', '1', '', '210700', null, '717', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古塔区');
INSERT INTO `systemctl_location_info` VALUES ('718', 'LHQ', 'insert', '凌河区', '210703', 'region', '2015-01-19 15:59:00', '1', '', '210700', null, '718', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凌河区');
INSERT INTO `systemctl_location_info` VALUES ('719', 'THQ', 'insert', '太和区', '210711', 'region', '2015-01-19 15:59:00', '1', '', '210700', null, '719', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太和区');
INSERT INTO `systemctl_location_info` VALUES ('720', 'HSX', 'insert', '黑山县', '210726', 'region', '2015-01-19 15:59:00', '1', '', '210700', null, '720', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黑山县');
INSERT INTO `systemctl_location_info` VALUES ('721', 'YX', 'insert', '义县', '210727', 'region', '2015-01-19 15:59:00', '1', '', '210700', null, '721', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '义县');
INSERT INTO `systemctl_location_info` VALUES ('722', 'LHS', 'insert', '凌海市', '210781', 'region', '2015-01-19 15:59:00', '1', '', '210700', null, '722', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凌海市');
INSERT INTO `systemctl_location_info` VALUES ('723', 'BZS', 'insert', '北镇市', '210782', 'region', '2015-01-19 15:59:00', '1', '', '210700', null, '723', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北镇市');
INSERT INTO `systemctl_location_info` VALUES ('724', 'YKS', 'insert', '营口市', '210800', 'city', '2015-01-19 15:59:00', '1', '122.233391,40.668651', '210000', null, '724', '2015-01-19 15:59:00', 'system', 'A', '辽H', '13', '', '营口市');
INSERT INTO `systemctl_location_info` VALUES ('725', 'ZQQ', 'insert', '站前区', '210802', 'region', '2015-01-19 15:59:00', '1', '', '210800', null, '725', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '站前区');
INSERT INTO `systemctl_location_info` VALUES ('726', 'XSQ', 'insert', '西市区', '210803', 'region', '2015-01-19 15:59:00', '1', '', '210800', null, '726', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西市区');
INSERT INTO `systemctl_location_info` VALUES ('727', 'BYQQ', 'insert', '鲅鱼圈区', '210804', 'region', '2015-01-19 15:59:00', '1', '', '210800', null, '727', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鲅鱼圈区');
INSERT INTO `systemctl_location_info` VALUES ('728', 'LBQ', 'insert', '老边区', '210811', 'region', '2015-01-19 15:59:00', '1', '', '210800', null, '728', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '老边区');
INSERT INTO `systemctl_location_info` VALUES ('729', 'GZS', 'insert', '盖州市', '210881', 'region', '2015-01-19 15:59:00', '1', '', '210800', null, '729', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盖州市');
INSERT INTO `systemctl_location_info` VALUES ('730', 'DSQS', 'insert', '大石桥市', '210882', 'region', '2015-01-19 15:59:00', '1', '', '210800', null, '730', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大石桥市');
INSERT INTO `systemctl_location_info` VALUES ('731', 'FXS', 'insert', '阜新市', '210900', 'city', '2015-01-19 15:59:00', '1', '121.660822,42.01925', '210000', null, '731', '2015-01-19 15:59:00', 'system', 'A', '辽J', '14', '', '阜新市');
INSERT INTO `systemctl_location_info` VALUES ('732', 'HZQ', 'insert', '海州区', '210902', 'region', '2015-01-19 15:59:00', '1', '', '210900', null, '732', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海州区');
INSERT INTO `systemctl_location_info` VALUES ('733', 'XQQ', 'insert', '新邱区', '210903', 'region', '2015-01-19 15:59:00', '1', '', '210900', null, '733', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新邱区');
INSERT INTO `systemctl_location_info` VALUES ('734', 'TPQ', 'insert', '太平区', '210904', 'region', '2015-01-19 15:59:00', '1', '', '210900', null, '734', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太平区');
INSERT INTO `systemctl_location_info` VALUES ('735', 'QHMQ', 'insert', '清河门区', '210905', 'region', '2015-01-19 15:59:00', '1', '', '210900', null, '735', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清河门区');
INSERT INTO `systemctl_location_info` VALUES ('736', 'XHQ', 'insert', '细河区', '210911', 'region', '2015-01-19 15:59:00', '1', '', '210900', null, '736', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '细河区');
INSERT INTO `systemctl_location_info` VALUES ('737', 'FXMGZZZX', 'insert', '阜新蒙古族自治县', '210921', 'region', '2015-01-19 15:59:00', '1', '', '210900', null, '737', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阜新蒙古族自治县');
INSERT INTO `systemctl_location_info` VALUES ('738', 'ZWX', 'insert', '彰武县', '210922', 'region', '2015-01-19 15:59:00', '1', '', '210900', null, '738', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彰武县');
INSERT INTO `systemctl_location_info` VALUES ('739', 'LYS', 'insert', '辽阳市', '211000', 'city', '2015-01-19 15:59:00', '1', '123.172451,41.273339', '210000', null, '739', '2015-01-19 15:59:00', 'system', 'A', '辽K', '14', '', '辽阳市');
INSERT INTO `systemctl_location_info` VALUES ('740', 'BTQ', 'insert', '白塔区', '211002', 'region', '2015-01-19 15:59:00', '1', '', '211000', null, '740', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白塔区');
INSERT INTO `systemctl_location_info` VALUES ('741', 'WSQ', 'insert', '文圣区', '211003', 'region', '2015-01-19 15:59:00', '1', '', '211000', null, '741', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文圣区');
INSERT INTO `systemctl_location_info` VALUES ('742', 'HWQ', 'insert', '宏伟区', '211004', 'region', '2015-01-19 15:59:00', '1', '', '211000', null, '742', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宏伟区');
INSERT INTO `systemctl_location_info` VALUES ('743', 'GZLQ', 'insert', '弓长岭区', '211005', 'region', '2015-01-19 15:59:00', '1', '', '211000', null, '743', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '弓长岭区');
INSERT INTO `systemctl_location_info` VALUES ('744', 'TZHQ', 'insert', '太子河区', '211011', 'region', '2015-01-19 15:59:00', '1', '', '211000', null, '744', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太子河区');
INSERT INTO `systemctl_location_info` VALUES ('745', 'LYX', 'insert', '辽阳县', '211021', 'region', '2015-01-19 15:59:00', '1', '', '211000', null, '745', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '辽阳县');
INSERT INTO `systemctl_location_info` VALUES ('746', 'DTS', 'insert', '灯塔市', '211081', 'region', '2015-01-19 15:59:00', '1', '', '211000', null, '746', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灯塔市');
INSERT INTO `systemctl_location_info` VALUES ('747', 'PJS', 'insert', '盘锦市', '211100', 'city', '2015-01-19 15:59:00', '1', '122.073228,41.141248', '210000', null, '747', '2015-01-19 15:59:00', 'system', 'A', '辽L', '13', '', '盘锦市');
INSERT INTO `systemctl_location_info` VALUES ('748', 'STZQ', 'insert', '双台子区', '211102', 'region', '2015-01-19 15:59:00', '1', '', '211100', null, '748', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双台子区');
INSERT INTO `systemctl_location_info` VALUES ('749', 'XLTQ', 'insert', '兴隆台区', '211103', 'region', '2015-01-19 15:59:00', '1', '', '211100', null, '749', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴隆台区');
INSERT INTO `systemctl_location_info` VALUES ('750', 'DWX', 'insert', '大洼县', '211121', 'region', '2015-01-19 15:59:00', '1', '', '211100', null, '750', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大洼县');
INSERT INTO `systemctl_location_info` VALUES ('751', 'PSX', 'insert', '盘山县', '211122', 'region', '2015-01-19 15:59:00', '1', '', '211100', null, '751', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盘山县');
INSERT INTO `systemctl_location_info` VALUES ('752', 'TLS', 'insert', '铁岭市', '211200', 'city', '2015-01-19 15:59:00', '1', '123.85485,42.299757', '210000', null, '752', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '铁岭市');
INSERT INTO `systemctl_location_info` VALUES ('753', 'YZQ', 'insert', '银州区', '211202', 'region', '2015-01-19 15:59:00', '1', '', '211200', null, '753', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '银州区');
INSERT INTO `systemctl_location_info` VALUES ('754', 'QHQ', 'insert', '清河区', '211204', 'region', '2015-01-19 15:59:00', '1', '', '211200', null, '754', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清河区');
INSERT INTO `systemctl_location_info` VALUES ('755', 'TLX', 'insert', '铁岭县', '211221', 'region', '2015-01-19 15:59:00', '1', '', '211200', null, '755', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁岭县');
INSERT INTO `systemctl_location_info` VALUES ('756', 'XFX', 'insert', '西丰县', '211223', 'region', '2015-01-19 15:59:00', '1', '', '211200', null, '756', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西丰县');
INSERT INTO `systemctl_location_info` VALUES ('757', 'CTX', 'insert', '昌图县', '211224', 'region', '2015-01-19 15:59:00', '1', '', '211200', null, '757', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌图县');
INSERT INTO `systemctl_location_info` VALUES ('758', 'DBSS', 'insert', '调兵山市', '211281', 'region', '2015-01-19 15:59:00', '1', '', '211200', null, '758', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '调兵山市');
INSERT INTO `systemctl_location_info` VALUES ('759', 'KYS', 'insert', '开原市', '211282', 'region', '2015-01-19 15:59:00', '1', '', '211200', null, '759', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开原市');
INSERT INTO `systemctl_location_info` VALUES ('760', 'CYS', 'insert', '朝阳市', '211300', 'city', '2015-01-19 15:59:00', '1', '120.446163,41.571828', '210000', null, '760', '2015-01-19 15:59:00', 'system', 'A', '辽N', '13', '', '朝阳市');
INSERT INTO `systemctl_location_info` VALUES ('761', 'STQ', 'insert', '双塔区', '211302', 'region', '2015-01-19 15:59:00', '1', '', '211300', null, '761', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双塔区');
INSERT INTO `systemctl_location_info` VALUES ('762', 'LCQ', 'insert', '龙城区', '211303', 'region', '2015-01-19 15:59:00', '1', '', '211300', null, '762', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙城区');
INSERT INTO `systemctl_location_info` VALUES ('763', 'CYX', 'insert', '朝阳县', '211321', 'region', '2015-01-19 15:59:00', '1', '', '211300', null, '763', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '朝阳县');
INSERT INTO `systemctl_location_info` VALUES ('764', 'JPX', 'insert', '建平县', '211322', 'region', '2015-01-19 15:59:00', '1', '', '211300', null, '764', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建平县');
INSERT INTO `systemctl_location_info` VALUES ('765', 'KLQZYMGZZZX', 'insert', '喀喇沁左翼蒙古族自治县', '211324', 'region', '2015-01-19 15:59:00', '1', '', '211300', null, '765', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '喀喇沁左翼蒙古族自治县');
INSERT INTO `systemctl_location_info` VALUES ('766', 'BPS', 'insert', '北票市', '211381', 'region', '2015-01-19 15:59:00', '1', '', '211300', null, '766', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北票市');
INSERT INTO `systemctl_location_info` VALUES ('767', 'LYS', 'insert', '凌源市', '211382', 'region', '2015-01-19 15:59:00', '1', '', '211300', null, '767', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凌源市');
INSERT INTO `systemctl_location_info` VALUES ('768', 'HLDS', 'insert', '葫芦岛市', '211400', 'city', '2015-01-19 15:59:00', '1', '120.860758,40.74303', '210000', null, '768', '2015-01-19 15:59:00', 'system', 'A', '辽P', '13', '', '葫芦岛市');
INSERT INTO `systemctl_location_info` VALUES ('769', 'LSQ', 'insert', '连山区', '211402', 'region', '2015-01-19 15:59:00', '1', '', '211400', null, '769', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '连山区');
INSERT INTO `systemctl_location_info` VALUES ('770', 'LGQ', 'insert', '龙港区', '211403', 'region', '2015-01-19 15:59:00', '1', '', '211400', null, '770', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙港区');
INSERT INTO `systemctl_location_info` VALUES ('771', 'NPQ', 'insert', '南票区', '211404', 'region', '2015-01-19 15:59:00', '1', '', '211400', null, '771', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南票区');
INSERT INTO `systemctl_location_info` VALUES ('772', 'SZX', 'insert', '绥中县', '211421', 'region', '2015-01-19 15:59:00', '1', '', '211400', null, '772', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绥中县');
INSERT INTO `systemctl_location_info` VALUES ('773', 'JCX', 'insert', '建昌县', '211422', 'region', '2015-01-19 15:59:00', '1', '', '211400', null, '773', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建昌县');
INSERT INTO `systemctl_location_info` VALUES ('774', 'XCS', 'insert', '兴城市', '211481', 'region', '2015-01-19 15:59:00', '1', '', '211400', null, '774', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴城市');
INSERT INTO `systemctl_location_info` VALUES ('775', 'JLS', 'insert', '吉林省', '220000', 'province', '2015-01-19 15:59:00', '1', '126.564544,43.871988', '0', null, '775', '2015-01-19 15:59:00', 'system', 'A', '吉', '12', '', '吉林省');
INSERT INTO `systemctl_location_info` VALUES ('776', 'ZCS', 'insert', '长春市', '220100', 'city', '2015-01-19 15:59:00', '1', '125.313642,43.898338', '220000', null, '776', '2015-01-19 15:59:00', 'system', 'A', '吉A', '12', '', '长春市');
INSERT INTO `systemctl_location_info` VALUES ('777', 'NGQ', 'insert', '南关区', '220102', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '777', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南关区');
INSERT INTO `systemctl_location_info` VALUES ('778', 'KCQ', 'insert', '宽城区', '220103', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '778', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宽城区');
INSERT INTO `systemctl_location_info` VALUES ('779', 'CYQ', 'insert', '朝阳区', '220104', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '779', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '朝阳区');
INSERT INTO `systemctl_location_info` VALUES ('780', 'EDQ', 'insert', '二道区', '220105', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '780', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '二道区');
INSERT INTO `systemctl_location_info` VALUES ('781', 'LYQ', 'insert', '绿园区', '220106', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '781', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绿园区');
INSERT INTO `systemctl_location_info` VALUES ('782', 'SYQ', 'insert', '双阳区', '220112', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '782', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双阳区');
INSERT INTO `systemctl_location_info` VALUES ('783', 'NAX', 'insert', '农安县', '220122', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '783', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '农安县');
INSERT INTO `systemctl_location_info` VALUES ('784', 'JTS', 'insert', '九台市', '220181', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '784', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '九台市');
INSERT INTO `systemctl_location_info` VALUES ('785', 'YSS', 'insert', '榆树市', '220182', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '785', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '榆树市');
INSERT INTO `systemctl_location_info` VALUES ('786', 'DHS', 'insert', '德惠市', '220183', 'region', '2015-01-19 15:59:00', '1', '', '220100', null, '786', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德惠市');
INSERT INTO `systemctl_location_info` VALUES ('787', 'JLS', 'insert', '吉林市', '220200', 'city', '2015-01-19 15:59:00', '1', '126.564544,43.871988', '220000', null, '787', '2015-01-19 15:59:00', 'system', 'A', '吉B', '12', '', '吉林市');
INSERT INTO `systemctl_location_info` VALUES ('788', 'CYQ', 'insert', '昌邑区', '220202', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '788', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌邑区');
INSERT INTO `systemctl_location_info` VALUES ('789', 'LTQ', 'insert', '龙潭区', '220203', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '789', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙潭区');
INSERT INTO `systemctl_location_info` VALUES ('790', 'CYQ', 'insert', '船营区', '220204', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '790', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '船营区');
INSERT INTO `systemctl_location_info` VALUES ('791', 'FMQ', 'insert', '丰满区', '220211', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '791', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰满区');
INSERT INTO `systemctl_location_info` VALUES ('792', 'YJX', 'insert', '永吉县', '220221', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '792', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永吉县');
INSERT INTO `systemctl_location_info` VALUES ('793', 'JHS', 'insert', '蛟河市', '220281', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '793', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蛟河市');
INSERT INTO `systemctl_location_info` VALUES ('794', 'HDS', 'insert', '桦甸市', '220282', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '794', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桦甸市');
INSERT INTO `systemctl_location_info` VALUES ('795', 'SLS', 'insert', '舒兰市', '220283', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '795', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '舒兰市');
INSERT INTO `systemctl_location_info` VALUES ('796', 'PSS', 'insert', '磐石市', '220284', 'region', '2015-01-19 15:59:00', '1', '', '220200', null, '796', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '磐石市');
INSERT INTO `systemctl_location_info` VALUES ('797', 'SPS', 'insert', '四平市', '220300', 'city', '2015-01-19 15:59:00', '1', '124.391382,43.175525', '220000', null, '797', '2015-01-19 15:59:00', 'system', 'A', '吉C', '12', '', '四平市');
INSERT INTO `systemctl_location_info` VALUES ('798', 'TXQ', 'insert', '铁西区', '220302', 'region', '2015-01-19 15:59:00', '1', '', '220300', null, '798', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁西区');
INSERT INTO `systemctl_location_info` VALUES ('799', 'TDQ', 'insert', '铁东区', '220303', 'region', '2015-01-19 15:59:00', '1', '', '220300', null, '799', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁东区');
INSERT INTO `systemctl_location_info` VALUES ('800', 'LSX', 'insert', '梨树县', '220322', 'region', '2015-01-19 15:59:00', '1', '', '220300', null, '800', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梨树县');
INSERT INTO `systemctl_location_info` VALUES ('801', 'YTMZZZX', 'insert', '伊通满族自治县', '220323', 'region', '2015-01-19 15:59:00', '1', '', '220300', null, '801', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伊通满族自治县');
INSERT INTO `systemctl_location_info` VALUES ('802', 'GZLS', 'insert', '公主岭市', '220381', 'region', '2015-01-19 15:59:00', '1', '', '220300', null, '802', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '公主岭市');
INSERT INTO `systemctl_location_info` VALUES ('803', 'SLS', 'insert', '双辽市', '220382', 'region', '2015-01-19 15:59:00', '1', '', '220300', null, '803', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双辽市');
INSERT INTO `systemctl_location_info` VALUES ('804', 'LYS', 'insert', '辽源市', '220400', 'city', '2015-01-19 15:59:00', '1', '125.133686,42.923303', '220000', null, '804', '2015-01-19 15:59:00', 'system', 'A', '吉D', '13', '', '辽源市');
INSERT INTO `systemctl_location_info` VALUES ('805', 'LSQ', 'insert', '龙山区', '220402', 'region', '2015-01-19 15:59:00', '1', '', '220400', null, '805', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙山区');
INSERT INTO `systemctl_location_info` VALUES ('806', 'XAQ', 'insert', '西安区', '220403', 'region', '2015-01-19 15:59:00', '1', '', '220400', null, '806', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西安区');
INSERT INTO `systemctl_location_info` VALUES ('807', 'DFX', 'insert', '东丰县', '220421', 'region', '2015-01-19 15:59:00', '1', '', '220400', null, '807', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东丰县');
INSERT INTO `systemctl_location_info` VALUES ('808', 'DLX', 'insert', '东辽县', '220422', 'region', '2015-01-19 15:59:00', '1', '', '220400', null, '808', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东辽县');
INSERT INTO `systemctl_location_info` VALUES ('809', 'THS', 'insert', '通化市', '220500', 'city', '2015-01-19 15:59:00', '1', '125.94265,41.736397', '220000', null, '809', '2015-01-19 15:59:00', 'system', 'A', '吉E', '13', '', '通化市');
INSERT INTO `systemctl_location_info` VALUES ('810', 'DCQ', 'insert', '东昌区', '220502', 'region', '2015-01-19 15:59:00', '1', '', '220500', null, '810', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东昌区');
INSERT INTO `systemctl_location_info` VALUES ('811', 'EDJQ', 'insert', '二道江区', '220503', 'region', '2015-01-19 15:59:00', '1', '', '220500', null, '811', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '二道江区');
INSERT INTO `systemctl_location_info` VALUES ('812', 'THX', 'insert', '通化县', '220521', 'region', '2015-01-19 15:59:00', '1', '', '220500', null, '812', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通化县');
INSERT INTO `systemctl_location_info` VALUES ('813', 'HNX', 'insert', '辉南县', '220523', 'region', '2015-01-19 15:59:00', '1', '', '220500', null, '813', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '辉南县');
INSERT INTO `systemctl_location_info` VALUES ('814', 'LHX', 'insert', '柳河县', '220524', 'region', '2015-01-19 15:59:00', '1', '', '220500', null, '814', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柳河县');
INSERT INTO `systemctl_location_info` VALUES ('815', 'MHKS', 'insert', '梅河口市', '220581', 'region', '2015-01-19 15:59:00', '1', '', '220500', null, '815', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梅河口市');
INSERT INTO `systemctl_location_info` VALUES ('816', 'JAS', 'insert', '集安市', '220582', 'region', '2015-01-19 15:59:00', '1', '', '220500', null, '816', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '集安市');
INSERT INTO `systemctl_location_info` VALUES ('817', 'BSS', 'insert', '白山市', '220600', 'city', '2015-01-19 15:59:00', '1', '126.435798,41.945859', '220000', null, '817', '2015-01-19 15:59:00', 'system', 'A', '吉F', '13', '', '白山市');
INSERT INTO `systemctl_location_info` VALUES ('818', 'HJQ', 'insert', '浑江区', '220602', 'region', '2015-01-19 15:59:00', '1', '', '220600', null, '818', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浑江区');
INSERT INTO `systemctl_location_info` VALUES ('819', 'JYQ', 'insert', '江源区', '220605', 'region', '2015-01-19 15:59:00', '1', '', '220600', null, '819', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江源区');
INSERT INTO `systemctl_location_info` VALUES ('820', 'FSX', 'insert', '抚松县', '220621', 'region', '2015-01-19 15:59:00', '1', '', '220600', null, '820', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '抚松县');
INSERT INTO `systemctl_location_info` VALUES ('821', 'JYX', 'insert', '靖宇县', '220622', 'region', '2015-01-19 15:59:00', '1', '', '220600', null, '821', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '靖宇县');
INSERT INTO `systemctl_location_info` VALUES ('822', 'ZBCXZZZX', 'insert', '长白朝鲜族自治县', '220623', 'region', '2015-01-19 15:59:00', '1', '', '220600', null, '822', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长白朝鲜族自治县');
INSERT INTO `systemctl_location_info` VALUES ('823', 'LJS', 'insert', '临江市', '220681', 'region', '2015-01-19 15:59:00', '1', '', '220600', null, '823', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临江市');
INSERT INTO `systemctl_location_info` VALUES ('824', 'SYS', 'insert', '松原市', '220700', 'city', '2015-01-19 15:59:00', '1', '124.832995,45.136049', '220000', null, '824', '2015-01-19 15:59:00', 'system', 'A', '吉J', '13', '', '松原市');
INSERT INTO `systemctl_location_info` VALUES ('825', 'NJQ', 'insert', '宁江区', '220702', 'region', '2015-01-19 15:59:00', '1', '', '220700', null, '825', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁江区');
INSERT INTO `systemctl_location_info` VALUES ('826', 'QGELSMGZZZX', 'insert', '前郭尔罗斯蒙古族自治县', '220721', 'region', '2015-01-19 15:59:00', '1', '', '220700', null, '826', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '前郭尔罗斯蒙古族自治县');
INSERT INTO `systemctl_location_info` VALUES ('827', 'ZLX', 'insert', '长岭县', '220722', 'region', '2015-01-19 15:59:00', '1', '', '220700', null, '827', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长岭县');
INSERT INTO `systemctl_location_info` VALUES ('828', 'QAX', 'insert', '乾安县', '220723', 'region', '2015-01-19 15:59:00', '1', '', '220700', null, '828', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乾安县');
INSERT INTO `systemctl_location_info` VALUES ('829', 'FYX', 'insert', '扶余县', '220724', 'region', '2015-01-19 15:59:00', '1', '', '220700', null, '829', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扶余县');
INSERT INTO `systemctl_location_info` VALUES ('830', 'BCS', 'insert', '白城市', '220800', 'city', '2015-01-19 15:59:00', '1', '122.840777,45.621086', '220000', null, '830', '2015-01-19 15:59:00', 'system', 'A', '吉G', '13', '', '白城市');
INSERT INTO `systemctl_location_info` VALUES ('831', 'TBQ', 'insert', '洮北区', '220802', 'region', '2015-01-19 15:59:00', '1', '', '220800', null, '831', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洮北区');
INSERT INTO `systemctl_location_info` VALUES ('832', 'ZLX', 'insert', '镇赉县', '220821', 'region', '2015-01-19 15:59:00', '1', '', '220800', null, '832', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇赉县');
INSERT INTO `systemctl_location_info` VALUES ('833', 'TYX', 'insert', '通榆县', '220822', 'region', '2015-01-19 15:59:00', '1', '', '220800', null, '833', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通榆县');
INSERT INTO `systemctl_location_info` VALUES ('834', 'TNS', 'insert', '洮南市', '220881', 'region', '2015-01-19 15:59:00', '1', '', '220800', null, '834', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洮南市');
INSERT INTO `systemctl_location_info` VALUES ('835', '', '', '大安市', '220882', 'region', '2015-01-19 15:59:00', '1', '', '220800', null, '835', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大安市');
INSERT INTO `systemctl_location_info` VALUES ('836', 'YBCXZZZZ', 'insert', '延边朝鲜族自治州', '222400', 'city', '2015-01-19 15:59:00', '1', '129.485902,42.896414', '220000', null, '836', '2015-01-19 15:59:00', 'system', 'A', '吉H', '13', '', '延边朝鲜族自治州');
INSERT INTO `systemctl_location_info` VALUES ('837', 'YJS', 'insert', '延吉市', '222401', 'region', '2015-01-19 15:59:00', '1', '', '222400', null, '837', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '延吉市');
INSERT INTO `systemctl_location_info` VALUES ('838', 'TMS', 'insert', '图们市', '222402', 'region', '2015-01-19 15:59:00', '1', '', '222400', null, '838', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '图们市');
INSERT INTO `systemctl_location_info` VALUES ('839', 'DHS', 'insert', '敦化市', '222403', 'region', '2015-01-19 15:59:00', '1', '', '222400', null, '839', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '敦化市');
INSERT INTO `systemctl_location_info` VALUES ('840', 'HCS', 'insert', '珲春市', '222404', 'region', '2015-01-19 15:59:00', '1', '', '222400', null, '840', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '珲春市');
INSERT INTO `systemctl_location_info` VALUES ('841', 'LJS', 'insert', '龙井市', '222405', 'region', '2015-01-19 15:59:00', '1', '', '222400', null, '841', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙井市');
INSERT INTO `systemctl_location_info` VALUES ('842', 'HLS', 'insert', '和龙市', '222406', 'region', '2015-01-19 15:59:00', '1', '', '222400', null, '842', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和龙市');
INSERT INTO `systemctl_location_info` VALUES ('843', 'WQX', 'insert', '汪清县', '222424', 'region', '2015-01-19 15:59:00', '1', '', '222400', null, '843', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汪清县');
INSERT INTO `systemctl_location_info` VALUES ('844', 'ATX', 'insert', '安图县', '222426', 'region', '2015-01-19 15:59:00', '1', '', '222400', null, '844', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安图县');
INSERT INTO `systemctl_location_info` VALUES ('845', 'HLJS', 'insert', '黑龙江省', '230000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '845', '2015-01-19 15:59:00', 'system', 'A', '贵', '', '', '贵龙江省');
INSERT INTO `systemctl_location_info` VALUES ('846', 'HEBS', 'insert', '哈尔滨市', '230100', 'city', '2015-01-19 15:59:00', '1', '126.657717,45.773225', '230000', null, '846', '2015-01-19 15:59:00', 'system', 'A', '黑A', '12', '', '哈尔滨市');
INSERT INTO `systemctl_location_info` VALUES ('847', 'DLQ', 'insert', '道里区', '230102', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '847', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '道里区');
INSERT INTO `systemctl_location_info` VALUES ('848', 'NGQ', 'insert', '南岗区', '230103', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '848', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南岗区');
INSERT INTO `systemctl_location_info` VALUES ('849', 'DWQ', 'insert', '道外区', '230104', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '849', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '道外区');
INSERT INTO `systemctl_location_info` VALUES ('850', 'PFQ', 'insert', '平房区', '230108', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '850', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平房区');
INSERT INTO `systemctl_location_info` VALUES ('851', 'SBQ', 'insert', '松北区', '230109', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '851', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松北区');
INSERT INTO `systemctl_location_info` VALUES ('852', 'XFQ', 'insert', '香坊区', '230110', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '852', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '香坊区');
INSERT INTO `systemctl_location_info` VALUES ('853', 'HLQ', 'insert', '呼兰区', '230111', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '853', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '呼兰区');
INSERT INTO `systemctl_location_info` VALUES ('854', 'ACQ', 'insert', '阿城区', '230112', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '854', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿城区');
INSERT INTO `systemctl_location_info` VALUES ('855', 'YLX', 'insert', '依兰县', '230123', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '855', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '依兰县');
INSERT INTO `systemctl_location_info` VALUES ('856', 'FZX', 'insert', '方正县', '230124', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '856', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '方正县');
INSERT INTO `systemctl_location_info` VALUES ('857', 'BX', 'insert', '宾县', '230125', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '857', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宾县');
INSERT INTO `systemctl_location_info` VALUES ('858', 'BYX', 'insert', '巴彦县', '230126', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '858', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴彦县');
INSERT INTO `systemctl_location_info` VALUES ('859', 'MLX', 'insert', '木兰县', '230127', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '859', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '木兰县');
INSERT INTO `systemctl_location_info` VALUES ('860', 'THX', 'insert', '通河县', '230128', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '860', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通河县');
INSERT INTO `systemctl_location_info` VALUES ('861', 'YSX', 'insert', '延寿县', '230129', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '861', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '延寿县');
INSERT INTO `systemctl_location_info` VALUES ('862', 'SCS', 'insert', '双城市', '230182', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '862', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双城市');
INSERT INTO `systemctl_location_info` VALUES ('863', 'SZS', 'insert', '尚志市', '230183', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '863', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尚志市');
INSERT INTO `systemctl_location_info` VALUES ('864', 'WCS', 'insert', '五常市', '230184', 'region', '2015-01-19 15:59:00', '1', '', '230100', null, '864', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五常市');
INSERT INTO `systemctl_location_info` VALUES ('865', 'QQHES', 'insert', '齐齐哈尔市', '230200', 'city', '2015-01-19 15:59:00', '1', '123.987289,47.3477', '230000', null, '865', '2015-01-19 15:59:00', 'system', 'A', '黑B', '13', '', '齐齐哈尔市');
INSERT INTO `systemctl_location_info` VALUES ('866', 'LSQ', 'insert', '龙沙区', '230202', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '866', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙沙区');
INSERT INTO `systemctl_location_info` VALUES ('867', 'JHQ', 'insert', '建华区', '230203', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '867', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建华区');
INSERT INTO `systemctl_location_info` VALUES ('868', 'TFQ', 'insert', '铁锋区', '230204', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '868', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁锋区');
INSERT INTO `systemctl_location_info` VALUES ('869', 'AAXQ', 'insert', '昂昂溪区', '230205', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '869', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昂昂溪区');
INSERT INTO `systemctl_location_info` VALUES ('870', 'FLEJQ', 'insert', '富拉尔基区', '230206', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '870', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富拉尔基区');
INSERT INTO `systemctl_location_info` VALUES ('871', 'NZSQ', 'insert', '碾子山区', '230207', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '871', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '碾子山区');
INSERT INTO `systemctl_location_info` VALUES ('872', 'MLSDWEZQ', 'insert', '梅里斯达斡尔族区', '230208', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '872', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梅里斯达斡尔族区');
INSERT INTO `systemctl_location_info` VALUES ('873', 'LJX', 'insert', '龙江县', '230221', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '873', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙江县');
INSERT INTO `systemctl_location_info` VALUES ('874', 'YAX', 'insert', '依安县', '230223', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '874', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '依安县');
INSERT INTO `systemctl_location_info` VALUES ('875', 'TLX', 'insert', '泰来县', '230224', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '875', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泰来县');
INSERT INTO `systemctl_location_info` VALUES ('876', 'GNX', 'insert', '甘南县', '230225', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '876', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘南县');
INSERT INTO `systemctl_location_info` VALUES ('877', 'FYX', 'insert', '富裕县', '230227', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '877', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富裕县');
INSERT INTO `systemctl_location_info` VALUES ('878', 'KSX', 'insert', '克山县', '230229', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '878', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '克山县');
INSERT INTO `systemctl_location_info` VALUES ('879', 'KDX', 'insert', '克东县', '230230', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '879', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '克东县');
INSERT INTO `systemctl_location_info` VALUES ('880', 'BQX', 'insert', '拜泉县', '230231', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '880', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '拜泉县');
INSERT INTO `systemctl_location_info` VALUES ('881', 'NHS', 'insert', '讷河市', '230281', 'region', '2015-01-19 15:59:00', '1', '', '230200', null, '881', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '讷河市');
INSERT INTO `systemctl_location_info` VALUES ('882', 'JXS', 'insert', '鸡西市', '230300', 'city', '2015-01-19 15:59:00', '1', '130.941767,45.32154', '230000', null, '882', '2015-01-19 15:59:00', 'system', 'A', '黑G', '13', '', '鸡西市');
INSERT INTO `systemctl_location_info` VALUES ('883', 'JGQ', 'insert', '鸡冠区', '230302', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '883', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鸡冠区');
INSERT INTO `systemctl_location_info` VALUES ('884', 'HSQ', 'insert', '恒山区', '230303', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '884', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '恒山区');
INSERT INTO `systemctl_location_info` VALUES ('885', 'DDQ', 'insert', '滴道区', '230304', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '885', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滴道区');
INSERT INTO `systemctl_location_info` VALUES ('886', 'LSQ', 'insert', '梨树区', '230305', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '886', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梨树区');
INSERT INTO `systemctl_location_info` VALUES ('887', 'CZHQ', 'insert', '城子河区', '230306', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '887', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城子河区');
INSERT INTO `systemctl_location_info` VALUES ('888', 'MSQ', 'insert', '麻山区', '230307', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '888', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麻山区');
INSERT INTO `systemctl_location_info` VALUES ('889', 'JDX', 'insert', '鸡东县', '230321', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '889', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鸡东县');
INSERT INTO `systemctl_location_info` VALUES ('890', 'HLS', 'insert', '虎林市', '230381', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '890', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '虎林市');
INSERT INTO `systemctl_location_info` VALUES ('891', 'MSS', 'insert', '密山市', '230382', 'region', '2015-01-19 15:59:00', '1', '', '230300', null, '891', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '密山市');
INSERT INTO `systemctl_location_info` VALUES ('892', 'HGS', 'insert', '鹤岗市', '230400', 'city', '2015-01-19 15:59:00', '1', '130.292472,47.338666', '230000', null, '892', '2015-01-19 15:59:00', 'system', 'A', '黑H', '13', '', '鹤岗市');
INSERT INTO `systemctl_location_info` VALUES ('893', 'XYQ', 'insert', '向阳区', '230402', 'region', '2015-01-19 15:59:00', '1', '', '230400', null, '893', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '向阳区');
INSERT INTO `systemctl_location_info` VALUES ('894', 'GNQ', 'insert', '工农区', '230403', 'region', '2015-01-19 15:59:00', '1', '', '230400', null, '894', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '工农区');
INSERT INTO `systemctl_location_info` VALUES ('895', 'NSQ', 'insert', '南山区', '230404', 'region', '2015-01-19 15:59:00', '1', '', '230400', null, '895', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南山区');
INSERT INTO `systemctl_location_info` VALUES ('896', 'XAQ', 'insert', '兴安区', '230405', 'region', '2015-01-19 15:59:00', '1', '', '230400', null, '896', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴安区');
INSERT INTO `systemctl_location_info` VALUES ('897', 'DSQ', 'insert', '东山区', '230406', 'region', '2015-01-19 15:59:00', '1', '', '230400', null, '897', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东山区');
INSERT INTO `systemctl_location_info` VALUES ('898', 'XSQ', 'insert', '兴山区', '230407', 'region', '2015-01-19 15:59:00', '1', '', '230400', null, '898', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴山区');
INSERT INTO `systemctl_location_info` VALUES ('899', 'LBX', 'insert', '萝北县', '230421', 'region', '2015-01-19 15:59:00', '1', '', '230400', null, '899', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '萝北县');
INSERT INTO `systemctl_location_info` VALUES ('900', 'SBX', 'insert', '绥滨县', '230422', 'region', '2015-01-19 15:59:00', '1', '', '230400', null, '900', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绥滨县');
INSERT INTO `systemctl_location_info` VALUES ('901', 'SYSS', 'insert', '双鸭山市', '230500', 'city', '2015-01-19 15:59:00', '1', '131.171402,46.655102', '230000', null, '901', '2015-01-19 15:59:00', 'system', 'A', '黑J', '13', '', '双鸭山市');
INSERT INTO `systemctl_location_info` VALUES ('902', 'JSQ', 'insert', '尖山区', '230502', 'region', '2015-01-19 15:59:00', '1', '', '230500', null, '902', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尖山区');
INSERT INTO `systemctl_location_info` VALUES ('903', 'LDQ', 'insert', '岭东区', '230503', 'region', '2015-01-19 15:59:00', '1', '', '230500', null, '903', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岭东区');
INSERT INTO `systemctl_location_info` VALUES ('904', 'SFTQ', 'insert', '四方台区', '230505', 'region', '2015-01-19 15:59:00', '1', '', '230500', null, '904', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '四方台区');
INSERT INTO `systemctl_location_info` VALUES ('905', 'BSQ', 'insert', '宝山区', '230506', 'region', '2015-01-19 15:59:00', '1', '', '230500', null, '905', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝山区');
INSERT INTO `systemctl_location_info` VALUES ('906', 'JXX', 'insert', '集贤县', '230521', 'region', '2015-01-19 15:59:00', '1', '', '230500', null, '906', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '集贤县');
INSERT INTO `systemctl_location_info` VALUES ('907', 'YYX', 'insert', '友谊县', '230522', 'region', '2015-01-19 15:59:00', '1', '', '230500', null, '907', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '友谊县');
INSERT INTO `systemctl_location_info` VALUES ('908', 'BQX', 'insert', '宝清县', '230523', 'region', '2015-01-19 15:59:00', '1', '', '230500', null, '908', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝清县');
INSERT INTO `systemctl_location_info` VALUES ('909', 'RHX', 'insert', '饶河县', '230524', 'region', '2015-01-19 15:59:00', '1', '', '230500', null, '909', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '饶河县');
INSERT INTO `systemctl_location_info` VALUES ('910', 'DQS', 'insert', '大庆市', '230600', 'city', '2015-01-19 15:59:00', '1', '125.02184,46.596709', '230000', null, '910', '2015-01-19 15:59:00', 'system', 'A', '黑E', '12', '', '大庆市');
INSERT INTO `systemctl_location_info` VALUES ('911', 'SETQ', 'insert', '萨尔图区', '230602', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '911', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '萨尔图区');
INSERT INTO `systemctl_location_info` VALUES ('912', 'LFQ', 'insert', '龙凤区', '230603', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '912', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙凤区');
INSERT INTO `systemctl_location_info` VALUES ('913', 'RHLQ', 'insert', '让胡路区', '230604', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '913', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '让胡路区');
INSERT INTO `systemctl_location_info` VALUES ('914', 'HGQ', 'insert', '红岗区', '230605', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '914', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红岗区');
INSERT INTO `systemctl_location_info` VALUES ('915', 'DTQ', 'insert', '大同区', '230606', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '915', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大同区');
INSERT INTO `systemctl_location_info` VALUES ('916', 'ZZX', 'insert', '肇州县', '230621', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '916', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肇州县');
INSERT INTO `systemctl_location_info` VALUES ('917', 'ZYX', 'insert', '肇源县', '230622', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '917', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肇源县');
INSERT INTO `systemctl_location_info` VALUES ('918', 'LDX', 'insert', '林甸县', '230623', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '918', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '林甸县');
INSERT INTO `systemctl_location_info` VALUES ('919', 'DEBTMGZZZX', 'insert', '杜尔伯特蒙古族自治县', '230624', 'region', '2015-01-19 15:59:00', '1', '', '230600', null, '919', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杜尔伯特蒙古族自治县');
INSERT INTO `systemctl_location_info` VALUES ('920', 'YCS', 'insert', '伊春市', '230700', 'city', '2015-01-19 15:59:00', '1', '128.910766,47.734685', '230000', null, '920', '2015-01-19 15:59:00', 'system', 'A', '黑F', '14', '', '伊春市');
INSERT INTO `systemctl_location_info` VALUES ('921', 'YCQ', 'insert', '伊春区', '230702', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '921', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伊春区');
INSERT INTO `systemctl_location_info` VALUES ('922', 'NCQ', 'insert', '南岔区', '230703', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '922', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南岔区');
INSERT INTO `systemctl_location_info` VALUES ('923', 'YHQ', 'insert', '友好区', '230704', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '923', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '友好区');
INSERT INTO `systemctl_location_info` VALUES ('924', 'XLQ', 'insert', '西林区', '230705', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '924', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西林区');
INSERT INTO `systemctl_location_info` VALUES ('925', 'CLQ', 'insert', '翠峦区', '230706', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '925', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '翠峦区');
INSERT INTO `systemctl_location_info` VALUES ('926', 'XQQ', 'insert', '新青区', '230707', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '926', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新青区');
INSERT INTO `systemctl_location_info` VALUES ('927', 'MXQ', 'insert', '美溪区', '230708', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '927', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '美溪区');
INSERT INTO `systemctl_location_info` VALUES ('928', 'JSTQ', 'insert', '金山屯区', '230709', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '928', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金山屯区');
INSERT INTO `systemctl_location_info` VALUES ('929', 'WYQ', 'insert', '五营区', '230710', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '929', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五营区');
INSERT INTO `systemctl_location_info` VALUES ('930', 'WMHQ', 'insert', '乌马河区', '230711', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '930', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌马河区');
INSERT INTO `systemctl_location_info` VALUES ('931', 'TWHQ', 'insert', '汤旺河区', '230712', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '931', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汤旺河区');
INSERT INTO `systemctl_location_info` VALUES ('932', 'DLQ', 'insert', '带岭区', '230713', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '932', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '带岭区');
INSERT INTO `systemctl_location_info` VALUES ('933', 'WYLQ', 'insert', '乌伊岭区', '230714', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '933', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌伊岭区');
INSERT INTO `systemctl_location_info` VALUES ('934', 'HXQ', 'insert', '红星区', '230715', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '934', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红星区');
INSERT INTO `systemctl_location_info` VALUES ('935', 'SGLQ', 'insert', '上甘岭区', '230716', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '935', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上甘岭区');
INSERT INTO `systemctl_location_info` VALUES ('936', 'JYX', 'insert', '嘉荫县', '230722', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '936', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉荫县');
INSERT INTO `systemctl_location_info` VALUES ('937', 'TLS', 'insert', '铁力市', '230781', 'region', '2015-01-19 15:59:00', '1', '', '230700', null, '937', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁力市');
INSERT INTO `systemctl_location_info` VALUES ('938', 'JMSS', 'insert', '佳木斯市', '230800', 'city', '2015-01-19 15:59:00', '1', '130.284735,46.81378', '230000', null, '938', '2015-01-19 15:59:00', 'system', 'A', '黑D', '12', '', '佳木斯市');
INSERT INTO `systemctl_location_info` VALUES ('939', 'XYQ', 'insert', '向阳区', '230803', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '939', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '向阳区');
INSERT INTO `systemctl_location_info` VALUES ('940', 'QJQ', 'insert', '前进区', '230804', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '940', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '前进区');
INSERT INTO `systemctl_location_info` VALUES ('941', 'DFQ', 'insert', '东风区', '230805', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '941', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东风区');
INSERT INTO `systemctl_location_info` VALUES ('942', 'JQ', 'insert', '郊区', '230811', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '942', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郊区');
INSERT INTO `systemctl_location_info` VALUES ('943', 'HNX', 'insert', '桦南县', '230822', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '943', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桦南县');
INSERT INTO `systemctl_location_info` VALUES ('944', 'HCX', 'insert', '桦川县', '230826', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '944', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桦川县');
INSERT INTO `systemctl_location_info` VALUES ('945', 'TYX', 'insert', '汤原县', '230828', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '945', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汤原县');
INSERT INTO `systemctl_location_info` VALUES ('946', 'FYX', 'insert', '抚远县', '230833', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '946', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '抚远县');
INSERT INTO `systemctl_location_info` VALUES ('947', 'TJS', 'insert', '同江市', '230881', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '947', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '同江市');
INSERT INTO `systemctl_location_info` VALUES ('948', 'FJS', 'insert', '富锦市', '230882', 'region', '2015-01-19 15:59:00', '1', '', '230800', null, '948', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富锦市');
INSERT INTO `systemctl_location_info` VALUES ('949', 'QTHS', 'insert', '七台河市', '230900', 'city', '2015-01-19 15:59:00', '1', '131.019048,45.775005', '230000', null, '949', '2015-01-19 15:59:00', 'system', 'A', '黑K', '14', '', '七台河市');
INSERT INTO `systemctl_location_info` VALUES ('950', 'XXQ', 'insert', '新兴区', '230902', 'region', '2015-01-19 15:59:00', '1', '', '230900', null, '950', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新兴区');
INSERT INTO `systemctl_location_info` VALUES ('951', 'TSQ', 'insert', '桃山区', '230903', 'region', '2015-01-19 15:59:00', '1', '', '230900', null, '951', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桃山区');
INSERT INTO `systemctl_location_info` VALUES ('952', 'QZHQ', 'insert', '茄子河区', '230904', 'region', '2015-01-19 15:59:00', '1', '', '230900', null, '952', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '茄子河区');
INSERT INTO `systemctl_location_info` VALUES ('953', 'BLX', 'insert', '勃利县', '230921', 'region', '2015-01-19 15:59:00', '1', '', '230900', null, '953', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '勃利县');
INSERT INTO `systemctl_location_info` VALUES ('954', 'MDJS', 'insert', '牡丹江市', '231000', 'city', '2015-01-19 15:59:00', '1', '129.608035,44.588521', '230000', null, '954', '2015-01-19 15:59:00', 'system', 'A', '黑C', '13', '', '牡丹江市');
INSERT INTO `systemctl_location_info` VALUES ('955', 'DAQ', 'insert', '东安区', '231002', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '955', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东安区');
INSERT INTO `systemctl_location_info` VALUES ('956', 'YMQ', 'insert', '阳明区', '231003', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '956', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳明区');
INSERT INTO `systemctl_location_info` VALUES ('957', 'AMQ', 'insert', '爱民区', '231004', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '957', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '爱民区');
INSERT INTO `systemctl_location_info` VALUES ('958', 'XAQ', 'insert', '西安区', '231005', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '958', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西安区');
INSERT INTO `systemctl_location_info` VALUES ('959', 'DNX', 'insert', '东宁县', '231024', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '959', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东宁县');
INSERT INTO `systemctl_location_info` VALUES ('960', 'LKX', 'insert', '林口县', '231025', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '960', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '林口县');
INSERT INTO `systemctl_location_info` VALUES ('961', 'SFHS', 'insert', '绥芬河市', '231081', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '961', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绥芬河市');
INSERT INTO `systemctl_location_info` VALUES ('962', 'HLS', 'insert', '海林市', '231083', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '962', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海林市');
INSERT INTO `systemctl_location_info` VALUES ('963', 'NAS', 'insert', '宁安市', '231084', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '963', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁安市');
INSERT INTO `systemctl_location_info` VALUES ('964', 'MLS', 'insert', '穆棱市', '231085', 'region', '2015-01-19 15:59:00', '1', '', '231000', null, '964', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '穆棱市');
INSERT INTO `systemctl_location_info` VALUES ('965', 'HHS', 'insert', '黑河市', '231100', 'city', '2015-01-19 15:59:00', '1', '127.50083,50.25069', '230000', null, '965', '2015-01-19 15:59:00', 'system', 'A', '黑N', '14', '', '黑河市');
INSERT INTO `systemctl_location_info` VALUES ('966', 'AHQ', 'insert', '爱辉区', '231102', 'region', '2015-01-19 15:59:00', '1', '', '231100', null, '966', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '爱辉区');
INSERT INTO `systemctl_location_info` VALUES ('967', 'NJX', 'insert', '嫩江县', '231121', 'region', '2015-01-19 15:59:00', '1', '', '231100', null, '967', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嫩江县');
INSERT INTO `systemctl_location_info` VALUES ('968', 'XKX', 'insert', '逊克县', '231123', 'region', '2015-01-19 15:59:00', '1', '', '231100', null, '968', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '逊克县');
INSERT INTO `systemctl_location_info` VALUES ('969', 'SWX', 'insert', '孙吴县', '231124', 'region', '2015-01-19 15:59:00', '1', '', '231100', null, '969', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '孙吴县');
INSERT INTO `systemctl_location_info` VALUES ('970', 'BAS', 'insert', '北安市', '231181', 'region', '2015-01-19 15:59:00', '1', '', '231100', null, '970', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北安市');
INSERT INTO `systemctl_location_info` VALUES ('971', 'WDLCS', 'insert', '五大连池市', '231182', 'region', '2015-01-19 15:59:00', '1', '', '231100', null, '971', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五大连池市');
INSERT INTO `systemctl_location_info` VALUES ('972', 'SHS', 'insert', '绥化市', '231200', 'city', '2015-01-19 15:59:00', '1', '126.989095,46.646064', '230000', null, '972', '2015-01-19 15:59:00', 'system', 'A', '黑M', '13', '', '绥化市');
INSERT INTO `systemctl_location_info` VALUES ('973', 'BLQ', 'insert', '北林区', '231202', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '973', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北林区');
INSERT INTO `systemctl_location_info` VALUES ('974', 'WKX', 'insert', '望奎县', '231221', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '974', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '望奎县');
INSERT INTO `systemctl_location_info` VALUES ('975', 'LXX', 'insert', '兰西县', '231222', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '975', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兰西县');
INSERT INTO `systemctl_location_info` VALUES ('976', 'QGX', 'insert', '青冈县', '231223', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '976', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青冈县');
INSERT INTO `systemctl_location_info` VALUES ('977', 'QAX', 'insert', '庆安县', '231224', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '977', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庆安县');
INSERT INTO `systemctl_location_info` VALUES ('978', 'MSX', 'insert', '明水县', '231225', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '978', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '明水县');
INSERT INTO `systemctl_location_info` VALUES ('979', 'SLX', 'insert', '绥棱县', '231226', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '979', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绥棱县');
INSERT INTO `systemctl_location_info` VALUES ('980', 'ADS', 'insert', '安达市', '231281', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '980', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安达市');
INSERT INTO `systemctl_location_info` VALUES ('981', 'ZDS', 'insert', '肇东市', '231282', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '981', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肇东市');
INSERT INTO `systemctl_location_info` VALUES ('982', 'HLS', 'insert', '海伦市', '231283', 'region', '2015-01-19 15:59:00', '1', '', '231200', null, '982', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海伦市');
INSERT INTO `systemctl_location_info` VALUES ('983', 'DXALDQ', 'insert', '大兴安岭地区', '232700', 'city', '2015-01-19 15:59:00', '1', '124.196104,51.991789', '230000', null, '983', '2015-01-19 15:59:00', 'system', 'A', '', '10', '', '大兴安岭地区');
INSERT INTO `systemctl_location_info` VALUES ('984', 'JGDQQ', 'insert', '加格达奇区', '232701', 'region', '2015-01-19 15:59:00', '1', '', '232700', null, '984', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '加格达奇区');
INSERT INTO `systemctl_location_info` VALUES ('985', 'SLQ', 'insert', '松岭区', '232702', 'region', '2015-01-19 15:59:00', '1', '', '232700', null, '985', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松岭区');
INSERT INTO `systemctl_location_info` VALUES ('986', 'XLQ', 'insert', '新林区', '232703', 'region', '2015-01-19 15:59:00', '1', '', '232700', null, '986', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新林区');
INSERT INTO `systemctl_location_info` VALUES ('987', 'HZQ', 'insert', '呼中区', '232704', 'region', '2015-01-19 15:59:00', '1', '', '232700', null, '987', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '呼中区');
INSERT INTO `systemctl_location_info` VALUES ('988', 'HMX', 'insert', '呼玛县', '232721', 'region', '2015-01-19 15:59:00', '1', '', '232700', null, '988', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '呼玛县');
INSERT INTO `systemctl_location_info` VALUES ('989', 'THX', 'insert', '塔河县', '232722', 'region', '2015-01-19 15:59:00', '1', '', '232700', null, '989', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '塔河县');
INSERT INTO `systemctl_location_info` VALUES ('990', 'MHX', 'insert', '漠河县', '232723', 'region', '2015-01-19 15:59:00', '1', '', '232700', null, '990', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '漠河县');
INSERT INTO `systemctl_location_info` VALUES ('991', 'SHS', 'insert', '上海市', '310000', 'city', '2015-01-19 15:59:00', '1', '121.487899,31.249162', '100002', null, '991', '2015-01-19 15:59:00', 'system', 'A', '沪', '12', '', '上海市');
INSERT INTO `systemctl_location_info` VALUES ('992', 'HPQ', 'insert', '黄浦区', '310101', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '992', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄浦区');
INSERT INTO `systemctl_location_info` VALUES ('993', 'XHQ', 'insert', '徐汇区', '310104', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '993', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '徐汇区');
INSERT INTO `systemctl_location_info` VALUES ('994', 'ZNQ', 'insert', '长宁区', '310105', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '994', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长宁区');
INSERT INTO `systemctl_location_info` VALUES ('995', 'JAQ', 'insert', '静安区', '310106', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '995', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '静安区');
INSERT INTO `systemctl_location_info` VALUES ('996', 'PTQ', 'insert', '普陀区', '310107', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '996', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '普陀区');
INSERT INTO `systemctl_location_info` VALUES ('997', 'ZBQ', 'insert', '闸北区', '310108', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '997', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '闸北区');
INSERT INTO `systemctl_location_info` VALUES ('998', 'HKQ', 'insert', '虹口区', '310109', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '998', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '虹口区');
INSERT INTO `systemctl_location_info` VALUES ('999', 'YPQ', 'insert', '杨浦区', '310110', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '999', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杨浦区');
INSERT INTO `systemctl_location_info` VALUES ('1000', 'MXQ', 'insert', '闵行区', '310112', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1000', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '闵行区');
INSERT INTO `systemctl_location_info` VALUES ('1001', 'BSQ', 'insert', '宝山区', '310113', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1001', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝山区');
INSERT INTO `systemctl_location_info` VALUES ('1002', 'JDQ', 'insert', '嘉定区', '310114', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1002', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉定区');
INSERT INTO `systemctl_location_info` VALUES ('1003', 'PDXQ', 'insert', '浦东新区', '310115', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1003', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浦东新区');
INSERT INTO `systemctl_location_info` VALUES ('1004', 'JSQ', 'insert', '金山区', '310116', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1004', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金山区');
INSERT INTO `systemctl_location_info` VALUES ('1005', 'SJQ', 'insert', '松江区', '310117', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1005', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松江区');
INSERT INTO `systemctl_location_info` VALUES ('1006', 'QPQ', 'insert', '青浦区', '310118', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1006', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青浦区');
INSERT INTO `systemctl_location_info` VALUES ('1007', 'FXQ', 'insert', '奉贤区', '310120', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1007', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '奉贤区');
INSERT INTO `systemctl_location_info` VALUES ('1008', 'CMX', 'insert', '崇明县', '310230', 'region', '2015-01-19 15:59:00', '1', '', '310000', null, '1008', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇明县');
INSERT INTO `systemctl_location_info` VALUES ('1009', 'JSS', 'insert', '江苏省', '320000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '1009', '2015-01-19 15:59:00', 'system', 'A', '苏', '', '', '江苏省');
INSERT INTO `systemctl_location_info` VALUES ('1010', 'NJS', 'insert', '南京市', '320100', 'city', '2015-01-19 15:59:00', '1', '118.778074,32.057236', '320000', null, '1010', '2015-01-19 15:59:00', 'system', 'A', '苏A', '12', '', '南京市');
INSERT INTO `systemctl_location_info` VALUES ('1011', 'XWQ', 'insert', '玄武区', '320102', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1011', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玄武区');
INSERT INTO `systemctl_location_info` VALUES ('1012', 'BXQ', 'insert', '白下区', '320103', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1012', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白下区');
INSERT INTO `systemctl_location_info` VALUES ('1013', 'QHQ', 'insert', '秦淮区', '320104', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1013', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秦淮区');
INSERT INTO `systemctl_location_info` VALUES ('1014', 'JYQ', 'insert', '建邺区', '320105', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1014', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建邺区');
INSERT INTO `systemctl_location_info` VALUES ('1015', 'GLQ', 'insert', '鼓楼区', '320106', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1015', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鼓楼区');
INSERT INTO `systemctl_location_info` VALUES ('1016', 'XGQ', 'insert', '下关区', '320107', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1016', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '下关区');
INSERT INTO `systemctl_location_info` VALUES ('1017', 'PKQ', 'insert', '浦口区', '320111', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1017', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浦口区');
INSERT INTO `systemctl_location_info` VALUES ('1018', 'QXQ', 'insert', '栖霞区', '320113', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1018', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '栖霞区');
INSERT INTO `systemctl_location_info` VALUES ('1019', 'YHTQ', 'insert', '雨花台区', '320114', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1019', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雨花台区');
INSERT INTO `systemctl_location_info` VALUES ('1020', 'JNQ', 'insert', '江宁区', '320115', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1020', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江宁区');
INSERT INTO `systemctl_location_info` VALUES ('1021', 'LHQ', 'insert', '六合区', '320116', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1021', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '六合区');
INSERT INTO `systemctl_location_info` VALUES ('1022', 'LSX', 'insert', '溧水县', '320124', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1022', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '溧水县');
INSERT INTO `systemctl_location_info` VALUES ('1023', 'GCX', 'insert', '高淳县', '320125', 'region', '2015-01-19 15:59:00', '1', '', '320100', null, '1023', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高淳县');
INSERT INTO `systemctl_location_info` VALUES ('1024', 'WXS', 'insert', '无锡市', '320200', 'city', '2015-01-19 15:59:00', '1', '120.305456,31.570037', '320000', null, '1024', '2015-01-19 15:59:00', 'system', 'A', '苏B', '12', '', '无锡市');
INSERT INTO `systemctl_location_info` VALUES ('1025', 'CAQ', 'insert', '崇安区', '320202', 'region', '2015-01-19 15:59:00', '1', '', '320200', null, '1025', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇安区');
INSERT INTO `systemctl_location_info` VALUES ('1026', 'NZQ', 'insert', '南长区', '320203', 'region', '2015-01-19 15:59:00', '1', '', '320200', null, '1026', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南长区');
INSERT INTO `systemctl_location_info` VALUES ('1027', 'BTQ', 'insert', '北塘区', '320204', 'region', '2015-01-19 15:59:00', '1', '', '320200', null, '1027', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北塘区');
INSERT INTO `systemctl_location_info` VALUES ('1028', 'XSQ', 'insert', '锡山区', '320205', 'region', '2015-01-19 15:59:00', '1', '', '320200', null, '1028', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '锡山区');
INSERT INTO `systemctl_location_info` VALUES ('1029', 'HSQ', 'insert', '惠山区', '320206', 'region', '2015-01-19 15:59:00', '1', '', '320200', null, '1029', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠山区');
INSERT INTO `systemctl_location_info` VALUES ('1030', 'BHQ', 'insert', '滨湖区', '320211', 'region', '2015-01-19 15:59:00', '1', '', '320200', null, '1030', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滨湖区');
INSERT INTO `systemctl_location_info` VALUES ('1031', 'JYS', 'insert', '江阴市', '320281', 'region', '2015-01-19 15:59:00', '1', '', '320200', null, '1031', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江阴市');
INSERT INTO `systemctl_location_info` VALUES ('1032', 'YXS', 'insert', '宜兴市', '320282', 'region', '2015-01-19 15:59:00', '1', '', '320200', null, '1032', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜兴市');
INSERT INTO `systemctl_location_info` VALUES ('1033', 'XZS', 'insert', '徐州市', '320300', 'city', '2015-01-19 15:59:00', '1', '117.188107,34.271553', '320000', null, '1033', '2015-01-19 15:59:00', 'system', 'A', '苏C', '12', '', '徐州市');
INSERT INTO `systemctl_location_info` VALUES ('1034', 'GLQ', 'insert', '鼓楼区', '320302', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1034', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鼓楼区');
INSERT INTO `systemctl_location_info` VALUES ('1035', 'YLQ', 'insert', '云龙区', '320303', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1035', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云龙区');
INSERT INTO `systemctl_location_info` VALUES ('1036', 'JWQ', 'insert', '贾汪区', '320305', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1036', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贾汪区');
INSERT INTO `systemctl_location_info` VALUES ('1037', 'QSQ', 'insert', '泉山区', '320311', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1037', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泉山区');
INSERT INTO `systemctl_location_info` VALUES ('1038', 'TSQ', 'insert', '铜山区', '320312', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1038', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铜山区');
INSERT INTO `systemctl_location_info` VALUES ('1039', 'FX', 'insert', '丰县', '320321', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1039', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰县');
INSERT INTO `systemctl_location_info` VALUES ('1040', 'PX', 'insert', '沛县', '320322', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1040', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沛县');
INSERT INTO `systemctl_location_info` VALUES ('1041', 'SNX', 'insert', '睢宁县', '320324', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1041', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '睢宁县');
INSERT INTO `systemctl_location_info` VALUES ('1042', 'XYS', 'insert', '新沂市', '320381', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1042', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新沂市');
INSERT INTO `systemctl_location_info` VALUES ('1043', 'PZS', 'insert', '邳州市', '320382', 'region', '2015-01-19 15:59:00', '1', '', '320300', null, '1043', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邳州市');
INSERT INTO `systemctl_location_info` VALUES ('1044', 'CZS', 'insert', '常州市', '320400', 'city', '2015-01-19 15:59:00', '1', '119.981861,31.771397', '320000', null, '1044', '2015-01-19 15:59:00', 'system', 'A', '苏D', '12', '', '常州市');
INSERT INTO `systemctl_location_info` VALUES ('1045', 'TNQ', 'insert', '天宁区', '320402', 'region', '2015-01-19 15:59:00', '1', '', '320400', null, '1045', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天宁区');
INSERT INTO `systemctl_location_info` VALUES ('1046', 'ZLQ', 'insert', '钟楼区', '320404', 'region', '2015-01-19 15:59:00', '1', '', '320400', null, '1046', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '钟楼区');
INSERT INTO `systemctl_location_info` VALUES ('1047', 'QSYQ', 'insert', '戚墅堰区', '320405', 'region', '2015-01-19 15:59:00', '1', '', '320400', null, '1047', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '戚墅堰区');
INSERT INTO `systemctl_location_info` VALUES ('1048', 'XBQ', 'insert', '新北区', '320411', 'region', '2015-01-19 15:59:00', '1', '', '320400', null, '1048', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新北区');
INSERT INTO `systemctl_location_info` VALUES ('1049', 'WJQ', 'insert', '武进区', '320412', 'region', '2015-01-19 15:59:00', '1', '', '320400', null, '1049', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武进区');
INSERT INTO `systemctl_location_info` VALUES ('1050', 'LYS', 'insert', '溧阳市', '320481', 'region', '2015-01-19 15:59:00', '1', '', '320400', null, '1050', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '溧阳市');
INSERT INTO `systemctl_location_info` VALUES ('1051', 'JTS', 'insert', '金坛市', '320482', 'region', '2015-01-19 15:59:00', '1', '', '320400', null, '1051', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金坛市');
INSERT INTO `systemctl_location_info` VALUES ('1052', 'SZS', 'insert', '苏州市', '320500', 'city', '2015-01-19 15:59:00', '1', '120.619907,31.317987', '320000', null, '1052', '2015-01-19 15:59:00', 'system', 'A', '苏E', '12', '', '苏州市');
INSERT INTO `systemctl_location_info` VALUES ('1053', 'GSQ', 'insert', '姑苏区', '320503', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1053', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '姑苏区');
INSERT INTO `systemctl_location_info` VALUES ('1054', 'HQQ', 'insert', '虎丘区', '320505', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1054', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '虎丘区');
INSERT INTO `systemctl_location_info` VALUES ('1055', 'WZQ', 'insert', '吴中区', '320506', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1055', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吴中区');
INSERT INTO `systemctl_location_info` VALUES ('1056', 'XCQ', 'insert', '相城区', '320507', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1056', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '相城区');
INSERT INTO `systemctl_location_info` VALUES ('1057', 'CSS', 'insert', '常熟市', '320581', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1057', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '常熟市');
INSERT INTO `systemctl_location_info` VALUES ('1058', 'ZJGS', 'insert', '张家港市', '320582', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1058', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '张家港市');
INSERT INTO `systemctl_location_info` VALUES ('1059', 'KSS', 'insert', '昆山市', '320583', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1059', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昆山市');
INSERT INTO `systemctl_location_info` VALUES ('1060', 'WJQ', 'insert', '吴江区', '320584', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1060', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吴江区');
INSERT INTO `systemctl_location_info` VALUES ('1061', 'TCS', 'insert', '太仓市', '320585', 'region', '2015-01-19 15:59:00', '1', '', '320500', null, '1061', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太仓市');
INSERT INTO `systemctl_location_info` VALUES ('1062', 'NTS', 'insert', '南通市', '320600', 'city', '2015-01-19 15:59:00', '1', '120.873801,32.014665', '320000', null, '1062', '2015-01-19 15:59:00', 'system', 'A', '苏F', '12', '', '南通市');
INSERT INTO `systemctl_location_info` VALUES ('1063', 'CCQ', 'insert', '崇川区', '320602', 'region', '2015-01-19 15:59:00', '1', '', '320600', null, '1063', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇川区');
INSERT INTO `systemctl_location_info` VALUES ('1064', 'GZQ', 'insert', '港闸区', '320611', 'region', '2015-01-19 15:59:00', '1', '', '320600', null, '1064', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '港闸区');
INSERT INTO `systemctl_location_info` VALUES ('1065', 'TZQ', 'insert', '通州区', '320612', 'region', '2015-01-19 15:59:00', '1', '', '320600', null, '1065', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通州区');
INSERT INTO `systemctl_location_info` VALUES ('1066', 'HAX', 'insert', '海安县', '320621', 'region', '2015-01-19 15:59:00', '1', '', '320600', null, '1066', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海安县');
INSERT INTO `systemctl_location_info` VALUES ('1067', 'RDX', 'insert', '如东县', '320623', 'region', '2015-01-19 15:59:00', '1', '', '320600', null, '1067', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '如东县');
INSERT INTO `systemctl_location_info` VALUES ('1068', 'QDS', 'insert', '启东市', '320681', 'region', '2015-01-19 15:59:00', '1', '', '320600', null, '1068', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '启东市');
INSERT INTO `systemctl_location_info` VALUES ('1069', 'RGS', 'insert', '如皋市', '320682', 'region', '2015-01-19 15:59:00', '1', '', '320600', null, '1069', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '如皋市');
INSERT INTO `systemctl_location_info` VALUES ('1070', 'HMS', 'insert', '海门市', '320684', 'region', '2015-01-19 15:59:00', '1', '', '320600', null, '1070', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海门市');
INSERT INTO `systemctl_location_info` VALUES ('1071', 'LYGS', 'insert', '连云港市', '320700', 'city', '2015-01-19 15:59:00', '1', '119.173872,34.601549', '320000', null, '1071', '2015-01-19 15:59:00', 'system', 'A', '苏G', '12', '', '连云港市');
INSERT INTO `systemctl_location_info` VALUES ('1072', 'LYQ', 'insert', '连云区', '320703', 'region', '2015-01-19 15:59:00', '1', '', '320700', null, '1072', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '连云区');
INSERT INTO `systemctl_location_info` VALUES ('1073', 'XPQ', 'insert', '新浦区', '320705', 'region', '2015-01-19 15:59:00', '1', '', '320700', null, '1073', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新浦区');
INSERT INTO `systemctl_location_info` VALUES ('1074', 'HZQ', 'insert', '海州区', '320706', 'region', '2015-01-19 15:59:00', '1', '', '320700', null, '1074', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海州区');
INSERT INTO `systemctl_location_info` VALUES ('1075', 'GYX', 'insert', '赣榆县', '320721', 'region', '2015-01-19 15:59:00', '1', '', '320700', null, '1075', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赣榆县');
INSERT INTO `systemctl_location_info` VALUES ('1076', 'DHX', 'insert', '东海县', '320722', 'region', '2015-01-19 15:59:00', '1', '', '320700', null, '1076', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东海县');
INSERT INTO `systemctl_location_info` VALUES ('1077', 'GYX', 'insert', '灌云县', '320723', 'region', '2015-01-19 15:59:00', '1', '', '320700', null, '1077', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灌云县');
INSERT INTO `systemctl_location_info` VALUES ('1078', 'GNX', 'insert', '灌南县', '320724', 'region', '2015-01-19 15:59:00', '1', '', '320700', null, '1078', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灌南县');
INSERT INTO `systemctl_location_info` VALUES ('1079', 'HAS', 'insert', '淮安市', '320800', 'city', '2015-01-19 15:59:00', '1', '119.030186,33.606513', '320000', null, '1079', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '淮安市');
INSERT INTO `systemctl_location_info` VALUES ('1080', 'QHQ', 'insert', '清河区', '320802', 'region', '2015-01-19 15:59:00', '1', '', '320800', null, '1080', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清河区');
INSERT INTO `systemctl_location_info` VALUES ('1081', 'HAQ', 'insert', '淮安区', '320803', 'region', '2015-01-19 15:59:00', '1', '', '320800', null, '1081', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淮安区');
INSERT INTO `systemctl_location_info` VALUES ('1082', 'HYQ', 'insert', '淮阴区', '320804', 'region', '2015-01-19 15:59:00', '1', '', '320800', null, '1082', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淮阴区');
INSERT INTO `systemctl_location_info` VALUES ('1083', 'QPQ', 'insert', '青浦区', '320811', 'region', '2015-01-19 15:59:00', '1', '', '320800', null, '1083', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青浦区');
INSERT INTO `systemctl_location_info` VALUES ('1084', 'LSX', 'insert', '涟水县', '320826', 'region', '2015-01-19 15:59:00', '1', '', '320800', null, '1084', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涟水县');
INSERT INTO `systemctl_location_info` VALUES ('1085', 'HZX', 'insert', '洪泽县', '320829', 'region', '2015-01-19 15:59:00', '1', '', '320800', null, '1085', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洪泽县');
INSERT INTO `systemctl_location_info` VALUES ('1086', 'XYX', 'insert', '盱眙县', '320830', 'region', '2015-01-19 15:59:00', '1', '', '320800', null, '1086', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盱眙县');
INSERT INTO `systemctl_location_info` VALUES ('1087', 'JHX', 'insert', '金湖县', '320831', 'region', '2015-01-19 15:59:00', '1', '', '320800', null, '1087', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金湖县');
INSERT INTO `systemctl_location_info` VALUES ('1088', 'YCS', 'insert', '盐城市', '320900', 'city', '2015-01-19 15:59:00', '1', '120.148872,33.379862', '320000', null, '1088', '2015-01-19 15:59:00', 'system', 'A', '苏J', '12', '', '盐城市');
INSERT INTO `systemctl_location_info` VALUES ('1089', 'THQ', 'insert', '亭湖区', '320902', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1089', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '亭湖区');
INSERT INTO `systemctl_location_info` VALUES ('1090', 'YDQ', 'insert', '盐都区', '320903', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1090', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐都区');
INSERT INTO `systemctl_location_info` VALUES ('1091', 'XSX', 'insert', '响水县', '320921', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1091', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '响水县');
INSERT INTO `systemctl_location_info` VALUES ('1092', 'BHX', 'insert', '滨海县', '320922', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1092', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滨海县');
INSERT INTO `systemctl_location_info` VALUES ('1093', 'FNX', 'insert', '阜宁县', '320923', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1093', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阜宁县');
INSERT INTO `systemctl_location_info` VALUES ('1094', 'SYX', 'insert', '射阳县', '320924', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1094', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '射阳县');
INSERT INTO `systemctl_location_info` VALUES ('1095', 'JHX', 'insert', '建湖县', '320925', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1095', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建湖县');
INSERT INTO `systemctl_location_info` VALUES ('1096', 'DTS', 'insert', '东台市', '320981', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1096', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东台市');
INSERT INTO `systemctl_location_info` VALUES ('1097', 'DFS', 'insert', '大丰市', '320982', 'region', '2015-01-19 15:59:00', '1', '', '320900', null, '1097', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大丰市');
INSERT INTO `systemctl_location_info` VALUES ('1098', 'YZS', 'insert', '扬州市', '321000', 'city', '2015-01-19 15:59:00', '1', '119.427778,32.408505', '320000', null, '1098', '2015-01-19 15:59:00', 'system', 'A', '苏K', '13', '', '扬州市');
INSERT INTO `systemctl_location_info` VALUES ('1099', 'GLQ', 'insert', '广陵区', '321002', 'region', '2015-01-19 15:59:00', '1', '', '321000', null, '1099', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广陵区');
INSERT INTO `systemctl_location_info` VALUES ('1100', 'HJQ', 'insert', '邗江区', '321003', 'region', '2015-01-19 15:59:00', '1', '', '321000', null, '1100', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邗江区');
INSERT INTO `systemctl_location_info` VALUES ('1101', 'BYX', 'insert', '宝应县', '321023', 'region', '2015-01-19 15:59:00', '1', '', '321000', null, '1101', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝应县');
INSERT INTO `systemctl_location_info` VALUES ('1102', 'YZS', 'insert', '仪征市', '321081', 'region', '2015-01-19 15:59:00', '1', '', '321000', null, '1102', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仪征市');
INSERT INTO `systemctl_location_info` VALUES ('1103', 'GYS', 'insert', '高邮市', '321084', 'region', '2015-01-19 15:59:00', '1', '', '321000', null, '1103', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高邮市');
INSERT INTO `systemctl_location_info` VALUES ('1104', 'JDS', 'insert', '江都市', '321088', 'region', '2015-01-19 15:59:00', '1', '', '321000', null, '1104', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江都市');
INSERT INTO `systemctl_location_info` VALUES ('1105', 'ZJS', 'insert', '镇江市', '321100', 'city', '2015-01-19 15:59:00', '1', '119.455835,32.204409', '320000', null, '1105', '2015-01-19 15:59:00', 'system', 'A', '苏L', '13', '', '镇江市');
INSERT INTO `systemctl_location_info` VALUES ('1106', 'JKQ', 'insert', '京口区', '321102', 'region', '2015-01-19 15:59:00', '1', '', '321100', null, '1106', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '京口区');
INSERT INTO `systemctl_location_info` VALUES ('1107', 'RZQ', 'insert', '润州区', '321111', 'region', '2015-01-19 15:59:00', '1', '', '321100', null, '1107', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '润州区');
INSERT INTO `systemctl_location_info` VALUES ('1108', 'DTQ', 'insert', '丹徒区', '321112', 'region', '2015-01-19 15:59:00', '1', '', '321100', null, '1108', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丹徒区');
INSERT INTO `systemctl_location_info` VALUES ('1109', 'DYS', 'insert', '丹阳市', '321181', 'region', '2015-01-19 15:59:00', '1', '', '321100', null, '1109', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丹阳市');
INSERT INTO `systemctl_location_info` VALUES ('1110', 'YZS', 'insert', '扬中市', '321182', 'region', '2015-01-19 15:59:00', '1', '', '321100', null, '1110', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扬中市');
INSERT INTO `systemctl_location_info` VALUES ('1111', 'JRS', 'insert', '句容市', '321183', 'region', '2015-01-19 15:59:00', '1', '', '321100', null, '1111', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '句容市');
INSERT INTO `systemctl_location_info` VALUES ('1112', 'TZS', 'insert', '泰州市', '321200', 'city', '2015-01-19 15:59:00', '1', '119.919606,32.476053', '320000', null, '1112', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '泰州市');
INSERT INTO `systemctl_location_info` VALUES ('1113', 'HLQ', 'insert', '海陵区', '321202', 'region', '2015-01-19 15:59:00', '1', '', '321200', null, '1113', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海陵区');
INSERT INTO `systemctl_location_info` VALUES ('1114', 'GGQ', 'insert', '高港区', '321203', 'region', '2015-01-19 15:59:00', '1', '', '321200', null, '1114', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高港区');
INSERT INTO `systemctl_location_info` VALUES ('1115', 'XHS', 'insert', '兴化市', '321281', 'region', '2015-01-19 15:59:00', '1', '', '321200', null, '1115', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴化市');
INSERT INTO `systemctl_location_info` VALUES ('1116', 'JJS', 'insert', '靖江市', '321282', 'region', '2015-01-19 15:59:00', '1', '', '321200', null, '1116', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '靖江市');
INSERT INTO `systemctl_location_info` VALUES ('1117', 'TXS', 'insert', '泰兴市', '321283', 'region', '2015-01-19 15:59:00', '1', '', '321200', null, '1117', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泰兴市');
INSERT INTO `systemctl_location_info` VALUES ('1118', 'JYS', 'insert', '姜堰市', '321284', 'region', '2015-01-19 15:59:00', '1', '', '321200', null, '1118', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '姜堰市');
INSERT INTO `systemctl_location_info` VALUES ('1119', 'SQS', 'insert', '宿迁市', '321300', 'city', '2015-01-19 15:59:00', '1', '118.296893,33.95205', '320000', null, '1119', '2015-01-19 15:59:00', 'system', 'A', '苏N', '13', '', '宿迁市');
INSERT INTO `systemctl_location_info` VALUES ('1120', 'SCQ', 'insert', '宿城区', '321302', 'region', '2015-01-19 15:59:00', '1', '', '321300', null, '1120', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宿城区');
INSERT INTO `systemctl_location_info` VALUES ('1121', 'SYQ', 'insert', '宿豫区', '321311', 'region', '2015-01-19 15:59:00', '1', '', '321300', null, '1121', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宿豫区');
INSERT INTO `systemctl_location_info` VALUES ('1122', 'SYX', 'insert', '沭阳县', '321322', 'region', '2015-01-19 15:59:00', '1', '', '321300', null, '1122', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沭阳县');
INSERT INTO `systemctl_location_info` VALUES ('1123', 'SYX', 'insert', '泗阳县', '321323', 'region', '2015-01-19 15:59:00', '1', '', '321300', null, '1123', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泗阳县');
INSERT INTO `systemctl_location_info` VALUES ('1124', 'SHX', 'insert', '泗洪县', '321324', 'region', '2015-01-19 15:59:00', '1', '', '321300', null, '1124', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泗洪县');
INSERT INTO `systemctl_location_info` VALUES ('1125', 'ZJS', 'insert', '浙江省', '330000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '1125', '2015-01-19 15:59:00', 'system', 'A', '浙', '', '', '浙江省');
INSERT INTO `systemctl_location_info` VALUES ('1126', 'HZS', 'insert', '杭州市', '330100', 'city', '2015-01-19 15:59:00', '1', '120.219375,30.259244', '330000', null, '1126', '2015-01-19 15:59:00', 'system', 'A', '浙A', '12', '', '杭州市');
INSERT INTO `systemctl_location_info` VALUES ('1127', 'SCQ', 'insert', '上城区', '330102', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1127', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上城区');
INSERT INTO `systemctl_location_info` VALUES ('1128', 'XCQ', 'insert', '下城区', '330103', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1128', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '下城区');
INSERT INTO `systemctl_location_info` VALUES ('1129', 'JGQ', 'insert', '江干区', '330104', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1129', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江干区');
INSERT INTO `systemctl_location_info` VALUES ('1130', 'GSQ', 'insert', '拱墅区', '330105', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1130', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '拱墅区');
INSERT INTO `systemctl_location_info` VALUES ('1131', 'XHQ', 'insert', '西湖区', '330106', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1131', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西湖区');
INSERT INTO `systemctl_location_info` VALUES ('1132', 'BJQ', 'insert', '滨江区', '330108', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1132', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滨江区');
INSERT INTO `systemctl_location_info` VALUES ('1133', 'XSQ', 'insert', '萧山区', '330109', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1133', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '萧山区');
INSERT INTO `systemctl_location_info` VALUES ('1134', 'YHQ', 'insert', '余杭区', '330110', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1134', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '余杭区');
INSERT INTO `systemctl_location_info` VALUES ('1135', 'TLX', 'insert', '桐庐县', '330122', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1135', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桐庐县');
INSERT INTO `systemctl_location_info` VALUES ('1136', 'CAX', 'insert', '淳安县', '330127', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1136', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淳安县');
INSERT INTO `systemctl_location_info` VALUES ('1137', 'JDS', 'insert', '建德市', '330182', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1137', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建德市');
INSERT INTO `systemctl_location_info` VALUES ('1138', 'FYS', 'insert', '富阳市', '330183', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1138', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富阳市');
INSERT INTO `systemctl_location_info` VALUES ('1139', 'LAS', 'insert', '临安市', '330185', 'region', '2015-01-19 15:59:00', '1', '', '330100', null, '1139', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临安市');
INSERT INTO `systemctl_location_info` VALUES ('1140', 'NBS', 'insert', '宁波市', '330200', 'city', '2015-01-19 15:59:00', '1', '121.579006,29.885259', '330000', null, '1140', '2015-01-19 15:59:00', 'system', 'A', '浙B', '12', '', '宁波市');
INSERT INTO `systemctl_location_info` VALUES ('1141', 'HSQ', 'insert', '海曙区', '330203', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1141', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海曙区');
INSERT INTO `systemctl_location_info` VALUES ('1142', 'JDQ', 'insert', '江东区', '330204', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1142', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江东区');
INSERT INTO `systemctl_location_info` VALUES ('1143', 'JBQ', 'insert', '江北区', '330205', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1143', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江北区');
INSERT INTO `systemctl_location_info` VALUES ('1144', 'BLQ', 'insert', '北仑区', '330206', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1144', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北仑区');
INSERT INTO `systemctl_location_info` VALUES ('1145', 'ZHQ', 'insert', '镇海区', '330211', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1145', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇海区');
INSERT INTO `systemctl_location_info` VALUES ('1146', 'YZQ', 'insert', '鄞州区', '330212', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1146', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄞州区');
INSERT INTO `systemctl_location_info` VALUES ('1147', 'XSX', 'insert', '象山县', '330225', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1147', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '象山县');
INSERT INTO `systemctl_location_info` VALUES ('1148', 'NHX', 'insert', '宁海县', '330226', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1148', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁海县');
INSERT INTO `systemctl_location_info` VALUES ('1149', 'YYS', 'insert', '余姚市', '330281', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1149', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '余姚市');
INSERT INTO `systemctl_location_info` VALUES ('1150', 'CXS', 'insert', '慈溪市', '330282', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1150', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '慈溪市');
INSERT INTO `systemctl_location_info` VALUES ('1151', 'FHS', 'insert', '奉化市', '330283', 'region', '2015-01-19 15:59:00', '1', '', '330200', null, '1151', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '奉化市');
INSERT INTO `systemctl_location_info` VALUES ('1152', 'WZS', 'insert', '温州市', '330300', 'city', '2015-01-19 15:59:00', '1', '120.690635,28.002838', '330000', null, '1152', '2015-01-19 15:59:00', 'system', 'A', '浙C', '12', '', '温州市');
INSERT INTO `systemctl_location_info` VALUES ('1153', 'LCQ', 'insert', '鹿城区', '330302', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1153', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹿城区');
INSERT INTO `systemctl_location_info` VALUES ('1154', 'LWQ', 'insert', '龙湾区', '330303', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1154', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙湾区');
INSERT INTO `systemctl_location_info` VALUES ('1155', 'OHQ', 'insert', '瓯海区', '330304', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1155', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瓯海区');
INSERT INTO `systemctl_location_info` VALUES ('1156', 'DTX', 'insert', '洞头县', '330322', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1156', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洞头县');
INSERT INTO `systemctl_location_info` VALUES ('1157', 'YJX', 'insert', '永嘉县', '330324', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1157', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永嘉县');
INSERT INTO `systemctl_location_info` VALUES ('1158', 'PYX', 'insert', '平阳县', '330326', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1158', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平阳县');
INSERT INTO `systemctl_location_info` VALUES ('1159', 'CNX', 'insert', '苍南县', '330327', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1159', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苍南县');
INSERT INTO `systemctl_location_info` VALUES ('1160', 'WCX', 'insert', '文成县', '330328', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1160', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文成县');
INSERT INTO `systemctl_location_info` VALUES ('1161', 'TSX', 'insert', '泰顺县', '330329', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1161', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泰顺县');
INSERT INTO `systemctl_location_info` VALUES ('1162', 'RAS', 'insert', '瑞安市', '330381', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1162', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瑞安市');
INSERT INTO `systemctl_location_info` VALUES ('1163', 'LQS', 'insert', '乐清市', '330382', 'region', '2015-01-19 15:59:00', '1', '', '330300', null, '1163', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐清市');
INSERT INTO `systemctl_location_info` VALUES ('1164', 'JXS', 'insert', '嘉兴市', '330400', 'city', '2015-01-19 15:59:00', '1', '120.760428,30.773992', '330000', null, '1164', '2015-01-19 15:59:00', 'system', 'A', '浙F', '13', '', '嘉兴市');
INSERT INTO `systemctl_location_info` VALUES ('1165', 'NHQ', 'insert', '南湖区', '330402', 'region', '2015-01-19 15:59:00', '1', '', '330400', null, '1165', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南湖区');
INSERT INTO `systemctl_location_info` VALUES ('1166', 'XZQ', 'insert', '秀洲区', '330411', 'region', '2015-01-19 15:59:00', '1', '', '330400', null, '1166', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秀洲区');
INSERT INTO `systemctl_location_info` VALUES ('1167', 'JSX', 'insert', '嘉善县', '330421', 'region', '2015-01-19 15:59:00', '1', '', '330400', null, '1167', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉善县');
INSERT INTO `systemctl_location_info` VALUES ('1168', 'HYX', 'insert', '海盐县', '330424', 'region', '2015-01-19 15:59:00', '1', '', '330400', null, '1168', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海盐县');
INSERT INTO `systemctl_location_info` VALUES ('1169', 'HNS', 'insert', '海宁市', '330481', 'region', '2015-01-19 15:59:00', '1', '', '330400', null, '1169', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海宁市');
INSERT INTO `systemctl_location_info` VALUES ('1170', 'PHS', 'insert', '平湖市', '330482', 'region', '2015-01-19 15:59:00', '1', '', '330400', null, '1170', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平湖市');
INSERT INTO `systemctl_location_info` VALUES ('1171', 'TXS', 'insert', '桐乡市', '330483', 'region', '2015-01-19 15:59:00', '1', '', '330400', null, '1171', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桐乡市');
INSERT INTO `systemctl_location_info` VALUES ('1172', 'HZS', 'insert', '湖州市', '330500', 'city', '2015-01-19 15:59:00', '1', '120.137243,30.877925', '330000', null, '1172', '2015-01-19 15:59:00', 'system', 'A', '浙E', '12', '', '湖州市');
INSERT INTO `systemctl_location_info` VALUES ('1173', 'WXQ', 'insert', '吴兴区', '330502', 'region', '2015-01-19 15:59:00', '1', '', '330500', null, '1173', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吴兴区');
INSERT INTO `systemctl_location_info` VALUES ('1174', 'NXQ', 'insert', '南浔区', '330503', 'region', '2015-01-19 15:59:00', '1', '', '330500', null, '1174', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南浔区');
INSERT INTO `systemctl_location_info` VALUES ('1175', 'DQX', 'insert', '德清县', '330521', 'region', '2015-01-19 15:59:00', '1', '', '330500', null, '1175', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德清县');
INSERT INTO `systemctl_location_info` VALUES ('1176', 'ZXX', 'insert', '长兴县', '330522', 'region', '2015-01-19 15:59:00', '1', '', '330500', null, '1176', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长兴县');
INSERT INTO `systemctl_location_info` VALUES ('1177', 'AJX', 'insert', '安吉县', '330523', 'region', '2015-01-19 15:59:00', '1', '', '330500', null, '1177', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安吉县');
INSERT INTO `systemctl_location_info` VALUES ('1178', 'SXS', 'insert', '绍兴市', '330600', 'city', '2015-01-19 15:59:00', '1', '120.592467,30.002365', '330000', null, '1178', '2015-01-19 15:59:00', 'system', 'A', '浙D', '13', '', '绍兴市');
INSERT INTO `systemctl_location_info` VALUES ('1179', 'YCQ', 'insert', '越城区', '330602', 'region', '2015-01-19 15:59:00', '1', '', '330600', null, '1179', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '越城区');
INSERT INTO `systemctl_location_info` VALUES ('1180', 'SXX', 'insert', '绍兴县', '330621', 'region', '2015-01-19 15:59:00', '1', '', '330600', null, '1180', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绍兴县');
INSERT INTO `systemctl_location_info` VALUES ('1181', 'XCX', 'insert', '新昌县', '330624', 'region', '2015-01-19 15:59:00', '1', '', '330600', null, '1181', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新昌县');
INSERT INTO `systemctl_location_info` VALUES ('1182', 'ZJS', 'insert', '诸暨市', '330681', 'region', '2015-01-19 15:59:00', '1', '', '330600', null, '1182', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '诸暨市');
INSERT INTO `systemctl_location_info` VALUES ('1183', 'SYS', 'insert', '上虞市', '330682', 'region', '2015-01-19 15:59:00', '1', '', '330600', null, '1183', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上虞市');
INSERT INTO `systemctl_location_info` VALUES ('1184', 'SZS', 'insert', '嵊州市', '330683', 'region', '2015-01-19 15:59:00', '1', '', '330600', null, '1184', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嵊州市');
INSERT INTO `systemctl_location_info` VALUES ('1185', 'JHS', 'insert', '金华市', '330700', 'city', '2015-01-19 15:59:00', '1', '119.652576,29.102899', '330000', null, '1185', '2015-01-19 15:59:00', 'system', 'A', '浙G', '12', '', '金华市');
INSERT INTO `systemctl_location_info` VALUES ('1186', 'WCQ', 'insert', '婺城区', '330702', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1186', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '婺城区');
INSERT INTO `systemctl_location_info` VALUES ('1187', 'JDQ', 'insert', '金东区', '330703', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1187', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金东区');
INSERT INTO `systemctl_location_info` VALUES ('1188', 'WYX', 'insert', '武义县', '330723', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1188', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武义县');
INSERT INTO `systemctl_location_info` VALUES ('1189', 'PJX', 'insert', '浦江县', '330726', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1189', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浦江县');
INSERT INTO `systemctl_location_info` VALUES ('1190', 'PAX', 'insert', '磐安县', '330727', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1190', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '磐安县');
INSERT INTO `systemctl_location_info` VALUES ('1191', 'LXS', 'insert', '兰溪市', '330781', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1191', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兰溪市');
INSERT INTO `systemctl_location_info` VALUES ('1192', 'YWS', 'insert', '义乌市', '330782', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1192', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '义乌市');
INSERT INTO `systemctl_location_info` VALUES ('1193', 'DYS', 'insert', '东阳市', '330783', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1193', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东阳市');
INSERT INTO `systemctl_location_info` VALUES ('1194', 'YKS', 'insert', '永康市', '330784', 'region', '2015-01-19 15:59:00', '1', '', '330700', null, '1194', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永康市');
INSERT INTO `systemctl_location_info` VALUES ('1195', 'QZS', 'insert', '衢州市', '330800', 'city', '2015-01-19 15:59:00', '1', '118.875842,28.95691', '330000', null, '1195', '2015-01-19 15:59:00', 'system', 'A', '浙H', '12', '', '衢州市');
INSERT INTO `systemctl_location_info` VALUES ('1196', 'KCQ', 'insert', '柯城区', '330802', 'region', '2015-01-19 15:59:00', '1', '', '330800', null, '1196', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柯城区');
INSERT INTO `systemctl_location_info` VALUES ('1197', 'QJQ', 'insert', '衢江区', '330803', 'region', '2015-01-19 15:59:00', '1', '', '330800', null, '1197', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '衢江区');
INSERT INTO `systemctl_location_info` VALUES ('1198', 'CSX', 'insert', '常山县', '330822', 'region', '2015-01-19 15:59:00', '1', '', '330800', null, '1198', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '常山县');
INSERT INTO `systemctl_location_info` VALUES ('1199', 'KHX', 'insert', '开化县', '330824', 'region', '2015-01-19 15:59:00', '1', '', '330800', null, '1199', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开化县');
INSERT INTO `systemctl_location_info` VALUES ('1200', 'LYX', 'insert', '龙游县', '330825', 'region', '2015-01-19 15:59:00', '1', '', '330800', null, '1200', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙游县');
INSERT INTO `systemctl_location_info` VALUES ('1201', 'JSS', 'insert', '江山市', '330881', 'region', '2015-01-19 15:59:00', '1', '', '330800', null, '1201', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江山市');
INSERT INTO `systemctl_location_info` VALUES ('1202', 'ZSS', 'insert', '舟山市', '330900', 'city', '2015-01-19 15:59:00', '1', '122.169872,30.03601', '330000', null, '1202', '2015-01-19 15:59:00', 'system', 'A', '浙L', '13', '', '舟山市');
INSERT INTO `systemctl_location_info` VALUES ('1203', 'DHQ', 'insert', '定海区', '330902', 'region', '2015-01-19 15:59:00', '1', '', '330900', null, '1203', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定海区');
INSERT INTO `systemctl_location_info` VALUES ('1204', 'PTQ', 'insert', '普陀区', '330903', 'region', '2015-01-19 15:59:00', '1', '', '330900', null, '1204', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '普陀区');
INSERT INTO `systemctl_location_info` VALUES ('1205', 'DSX', 'insert', '岱山县', '330921', 'region', '2015-01-19 15:59:00', '1', '', '330900', null, '1205', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岱山县');
INSERT INTO `systemctl_location_info` VALUES ('1206', 'SSX', 'insert', '嵊泗县', '330922', 'region', '2015-01-19 15:59:00', '1', '', '330900', null, '1206', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嵊泗县');
INSERT INTO `systemctl_location_info` VALUES ('1207', 'TZS', 'insert', '台州市', '331000', 'city', '2015-01-19 15:59:00', '1', '121.440613,28.668283', '330000', null, '1207', '2015-01-19 15:59:00', 'system', 'A', '浙J', '13', '', '台州市');
INSERT INTO `systemctl_location_info` VALUES ('1208', 'JJQ', 'insert', '椒江区', '331002', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1208', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '椒江区');
INSERT INTO `systemctl_location_info` VALUES ('1209', 'HYQ', 'insert', '黄岩区', '331003', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1209', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄岩区');
INSERT INTO `systemctl_location_info` VALUES ('1210', 'LQQ', 'insert', '路桥区', '331004', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1210', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '路桥区');
INSERT INTO `systemctl_location_info` VALUES ('1211', 'YHX', 'insert', '玉环县', '331021', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1211', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉环县');
INSERT INTO `systemctl_location_info` VALUES ('1212', 'SMX', 'insert', '三门县', '331022', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1212', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三门县');
INSERT INTO `systemctl_location_info` VALUES ('1213', 'TTX', 'insert', '天台县', '331023', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1213', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天台县');
INSERT INTO `systemctl_location_info` VALUES ('1214', 'XJX', 'insert', '仙居县', '331024', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1214', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仙居县');
INSERT INTO `systemctl_location_info` VALUES ('1215', 'WLS', 'insert', '温岭市', '331081', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1215', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '温岭市');
INSERT INTO `systemctl_location_info` VALUES ('1216', 'LHS', 'insert', '临海市', '331082', 'region', '2015-01-19 15:59:00', '1', '', '331000', null, '1216', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临海市');
INSERT INTO `systemctl_location_info` VALUES ('1217', 'LSS', 'insert', '丽水市', '331100', 'city', '2015-01-19 15:59:00', '1', '119.929576,28.4563', '330000', null, '1217', '2015-01-19 15:59:00', 'system', 'A', '浙K', '13', '', '丽水市');
INSERT INTO `systemctl_location_info` VALUES ('1218', 'LDQ', 'insert', '莲都区', '331102', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1218', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莲都区');
INSERT INTO `systemctl_location_info` VALUES ('1219', 'QTX', 'insert', '青田县', '331121', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1219', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青田县');
INSERT INTO `systemctl_location_info` VALUES ('1220', 'JYX', 'insert', '缙云县', '331122', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1220', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '缙云县');
INSERT INTO `systemctl_location_info` VALUES ('1221', 'SCX', 'insert', '遂昌县', '331123', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1221', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '遂昌县');
INSERT INTO `systemctl_location_info` VALUES ('1222', 'SYX', 'insert', '松阳县', '331124', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1222', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松阳县');
INSERT INTO `systemctl_location_info` VALUES ('1223', 'YHX', 'insert', '云和县', '331125', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1223', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云和县');
INSERT INTO `systemctl_location_info` VALUES ('1224', 'QYX', 'insert', '庆元县', '331126', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1224', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庆元县');
INSERT INTO `systemctl_location_info` VALUES ('1225', 'JNSZZZX', 'insert', '景宁畲族自治县', '331127', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1225', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '景宁畲族自治县');
INSERT INTO `systemctl_location_info` VALUES ('1226', 'LQS', 'insert', '龙泉市', '331181', 'region', '2015-01-19 15:59:00', '1', '', '331100', null, '1226', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙泉市');
INSERT INTO `systemctl_location_info` VALUES ('1227', 'AHS', 'insert', '安徽省', '340000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '1227', '2015-01-19 15:59:00', 'system', 'A', '皖', '', '', '安徽省');
INSERT INTO `systemctl_location_info` VALUES ('1228', 'HFS', 'insert', '合肥市', '340100', 'city', '2015-01-19 15:59:00', '1', '117.282699,31.866942', '340000', null, '1228', '2015-01-19 15:59:00', 'system', 'A', '皖A', '12', '', '合肥市');
INSERT INTO `systemctl_location_info` VALUES ('1229', 'YHQ', 'insert', '瑶海区', '340102', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1229', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瑶海区');
INSERT INTO `systemctl_location_info` VALUES ('1230', 'LYQ', 'insert', '庐阳区', '340103', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1230', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庐阳区');
INSERT INTO `systemctl_location_info` VALUES ('1231', 'SSQ', 'insert', '蜀山区', '340104', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1231', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蜀山区');
INSERT INTO `systemctl_location_info` VALUES ('1232', 'BHQ', 'insert', '包河区', '340111', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1232', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '包河区');
INSERT INTO `systemctl_location_info` VALUES ('1233', 'ZFX', 'insert', '长丰县', '340121', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1233', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长丰县');
INSERT INTO `systemctl_location_info` VALUES ('1234', 'FDX', 'insert', '肥东县', '340122', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1234', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肥东县');
INSERT INTO `systemctl_location_info` VALUES ('1235', 'FXX', 'insert', '肥西县', '340123', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1235', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肥西县');
INSERT INTO `systemctl_location_info` VALUES ('1236', 'LJX', 'insert', '庐江县', '340124', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1236', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庐江县');
INSERT INTO `systemctl_location_info` VALUES ('1237', 'CHS', 'insert', '巢湖市', '340181', 'region', '2015-01-19 15:59:00', '1', '', '340100', null, '1237', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巢湖市');
INSERT INTO `systemctl_location_info` VALUES ('1238', 'WHS', 'insert', '芜湖市', '340200', 'city', '2015-01-19 15:59:00', '1', '118.384108,31.36602', '340000', null, '1238', '2015-01-19 15:59:00', 'system', 'A', '皖B', '12', '', '芜湖市');
INSERT INTO `systemctl_location_info` VALUES ('1239', 'JHQ', 'insert', '镜湖区', '340202', 'region', '2015-01-19 15:59:00', '1', '', '340200', null, '1239', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镜湖区');
INSERT INTO `systemctl_location_info` VALUES ('1240', 'YJQ', 'insert', '弋江区', '340203', 'region', '2015-01-19 15:59:00', '1', '', '340200', null, '1240', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '弋江区');
INSERT INTO `systemctl_location_info` VALUES ('1241', 'JJQ', 'insert', '鸠江区', '340207', 'region', '2015-01-19 15:59:00', '1', '', '340200', null, '1241', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鸠江区');
INSERT INTO `systemctl_location_info` VALUES ('1242', 'SSQ', 'insert', '三山区', '340208', 'region', '2015-01-19 15:59:00', '1', '', '340200', null, '1242', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三山区');
INSERT INTO `systemctl_location_info` VALUES ('1243', 'WHX', 'insert', '芜湖县', '340221', 'region', '2015-01-19 15:59:00', '1', '', '340200', null, '1243', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芜湖县');
INSERT INTO `systemctl_location_info` VALUES ('1244', 'FCX', 'insert', '繁昌县', '340222', 'region', '2015-01-19 15:59:00', '1', '', '340200', null, '1244', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '繁昌县');
INSERT INTO `systemctl_location_info` VALUES ('1245', 'NLX', 'insert', '南陵县', '340223', 'region', '2015-01-19 15:59:00', '1', '', '340200', null, '1245', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南陵县');
INSERT INTO `systemctl_location_info` VALUES ('1246', 'WWX', 'insert', '无为县', '340225', 'region', '2015-01-19 15:59:00', '1', '', '340200', null, '1246', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '无为县');
INSERT INTO `systemctl_location_info` VALUES ('1247', 'BBS', 'insert', '蚌埠市', '340300', 'city', '2015-01-19 15:59:00', '1', '117.35708,32.929499', '340000', null, '1247', '2015-01-19 15:59:00', 'system', 'A', '皖C', '13', '', '蚌埠市');
INSERT INTO `systemctl_location_info` VALUES ('1248', 'LZHQ', 'insert', '龙子湖区', '340302', 'region', '2015-01-19 15:59:00', '1', '', '340300', null, '1248', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙子湖区');
INSERT INTO `systemctl_location_info` VALUES ('1249', 'BSQ', 'insert', '蚌山区', '340303', 'region', '2015-01-19 15:59:00', '1', '', '340300', null, '1249', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蚌山区');
INSERT INTO `systemctl_location_info` VALUES ('1250', 'YHQ', 'insert', '禹会区', '340304', 'region', '2015-01-19 15:59:00', '1', '', '340300', null, '1250', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '禹会区');
INSERT INTO `systemctl_location_info` VALUES ('1251', 'HSQ', 'insert', '淮上区', '340311', 'region', '2015-01-19 15:59:00', '1', '', '340300', null, '1251', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淮上区');
INSERT INTO `systemctl_location_info` VALUES ('1252', 'HYX', 'insert', '怀远县', '340321', 'region', '2015-01-19 15:59:00', '1', '', '340300', null, '1252', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '怀远县');
INSERT INTO `systemctl_location_info` VALUES ('1253', 'WHX', 'insert', '五河县', '340322', 'region', '2015-01-19 15:59:00', '1', '', '340300', null, '1253', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五河县');
INSERT INTO `systemctl_location_info` VALUES ('1254', 'GZX', 'insert', '固镇县', '340323', 'region', '2015-01-19 15:59:00', '1', '', '340300', null, '1254', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '固镇县');
INSERT INTO `systemctl_location_info` VALUES ('1255', 'HNS', 'insert', '淮南市', '340400', 'city', '2015-01-19 15:59:00', '1', '117.018639,32.642812', '340000', null, '1255', '2015-01-19 15:59:00', 'system', 'A', '皖D', '13', '', '淮南市');
INSERT INTO `systemctl_location_info` VALUES ('1256', 'DTQ', 'insert', '大通区', '340402', 'region', '2015-01-19 15:59:00', '1', '', '340400', null, '1256', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大通区');
INSERT INTO `systemctl_location_info` VALUES ('1257', 'TJAQ', 'insert', '田家庵区', '340403', 'region', '2015-01-19 15:59:00', '1', '', '340400', null, '1257', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '田家庵区');
INSERT INTO `systemctl_location_info` VALUES ('1258', 'XJJQ', 'insert', '谢家集区', '340404', 'region', '2015-01-19 15:59:00', '1', '', '340400', null, '1258', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '谢家集区');
INSERT INTO `systemctl_location_info` VALUES ('1259', 'BGSQ', 'insert', '八公山区', '340405', 'region', '2015-01-19 15:59:00', '1', '', '340400', null, '1259', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '八公山区');
INSERT INTO `systemctl_location_info` VALUES ('1260', 'PJQ', 'insert', '潘集区', '340406', 'region', '2015-01-19 15:59:00', '1', '', '340400', null, '1260', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潘集区');
INSERT INTO `systemctl_location_info` VALUES ('1261', 'FTX', 'insert', '凤台县', '340421', 'region', '2015-01-19 15:59:00', '1', '', '340400', null, '1261', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤台县');
INSERT INTO `systemctl_location_info` VALUES ('1262', 'MASS', 'insert', '马鞍山市', '340500', 'city', '2015-01-19 15:59:00', '1', '118.515882,31.688528', '340000', null, '1262', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '马鞍山市');
INSERT INTO `systemctl_location_info` VALUES ('1263', 'HSQ', 'insert', '花山区', '340503', 'region', '2015-01-19 15:59:00', '1', '', '340500', null, '1263', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '花山区');
INSERT INTO `systemctl_location_info` VALUES ('1264', 'YSQ', 'insert', '雨山区', '340504', 'region', '2015-01-19 15:59:00', '1', '', '340500', null, '1264', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雨山区');
INSERT INTO `systemctl_location_info` VALUES ('1265', 'DTX', 'insert', '当涂县', '340521', 'region', '2015-01-19 15:59:00', '1', '', '340500', null, '1265', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '当涂县');
INSERT INTO `systemctl_location_info` VALUES ('1266', 'HSX', 'insert', '含山县', '340522', 'region', '2015-01-19 15:59:00', '1', '', '340500', null, '1266', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '含山县');
INSERT INTO `systemctl_location_info` VALUES ('1267', 'HX', 'insert', '和县', '340523', 'region', '2015-01-19 15:59:00', '1', '', '340500', null, '1267', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和县');
INSERT INTO `systemctl_location_info` VALUES ('1268', 'BWQ', 'insert', '博望区', '340596', 'region', '2015-01-19 15:59:00', '1', '', '340500', null, '1268', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博望区');
INSERT INTO `systemctl_location_info` VALUES ('1269', 'HBS', 'insert', '淮北市', '340600', 'city', '2015-01-19 15:59:00', '1', '116.791447,33.960023', '340000', null, '1269', '2015-01-19 15:59:00', 'system', 'A', '皖F', '13', '', '淮北市');
INSERT INTO `systemctl_location_info` VALUES ('1270', 'DJQ', 'insert', '杜集区', '340602', 'region', '2015-01-19 15:59:00', '1', '', '340600', null, '1270', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杜集区');
INSERT INTO `systemctl_location_info` VALUES ('1271', 'XSQ', 'insert', '相山区', '340603', 'region', '2015-01-19 15:59:00', '1', '', '340600', null, '1271', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '相山区');
INSERT INTO `systemctl_location_info` VALUES ('1272', 'LSQ', 'insert', '烈山区', '340604', 'region', '2015-01-19 15:59:00', '1', '', '340600', null, '1272', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '烈山区');
INSERT INTO `systemctl_location_info` VALUES ('1273', 'SXX', 'insert', '濉溪县', '340621', 'region', '2015-01-19 15:59:00', '1', '', '340600', null, '1273', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '濉溪县');
INSERT INTO `systemctl_location_info` VALUES ('1274', 'TLS', 'insert', '铜陵市', '340700', 'city', '2015-01-19 15:59:00', '1', '117.819429,30.94093', '340000', null, '1274', '2015-01-19 15:59:00', 'system', 'A', '皖G', '14', '', '铜陵市');
INSERT INTO `systemctl_location_info` VALUES ('1275', 'TGSQ', 'insert', '铜官山区', '340702', 'region', '2015-01-19 15:59:00', '1', '', '340700', null, '1275', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铜官山区');
INSERT INTO `systemctl_location_info` VALUES ('1276', 'SZSQ', 'insert', '狮子山区', '340703', 'region', '2015-01-19 15:59:00', '1', '', '340700', null, '1276', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '狮子山区');
INSERT INTO `systemctl_location_info` VALUES ('1277', 'JQ', 'insert', '郊区', '340711', 'region', '2015-01-19 15:59:00', '1', '', '340700', null, '1277', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郊区');
INSERT INTO `systemctl_location_info` VALUES ('1278', 'TLX', 'insert', '铜陵县', '340721', 'region', '2015-01-19 15:59:00', '1', '', '340700', null, '1278', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铜陵县');
INSERT INTO `systemctl_location_info` VALUES ('1279', 'AQS', 'insert', '安庆市', '340800', 'city', '2015-01-19 15:59:00', '1', '117.058739,30.537898', '340000', null, '1279', '2015-01-19 15:59:00', 'system', 'A', '皖H', '13', '', '安庆市');
INSERT INTO `systemctl_location_info` VALUES ('1280', 'YJQ', 'insert', '迎江区', '340802', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1280', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '迎江区');
INSERT INTO `systemctl_location_info` VALUES ('1281', 'DGQ', 'insert', '大观区', '340803', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1281', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大观区');
INSERT INTO `systemctl_location_info` VALUES ('1282', 'YXQ', 'insert', '宜秀区', '340811', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1282', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜秀区');
INSERT INTO `systemctl_location_info` VALUES ('1283', 'HNX', 'insert', '怀宁县', '340822', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1283', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '怀宁县');
INSERT INTO `systemctl_location_info` VALUES ('1284', 'ZYX', 'insert', '枞阳县', '340823', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1284', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '枞阳县');
INSERT INTO `systemctl_location_info` VALUES ('1285', 'QSX', 'insert', '潜山县', '340824', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1285', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潜山县');
INSERT INTO `systemctl_location_info` VALUES ('1286', 'THX', 'insert', '太湖县', '340825', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1286', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太湖县');
INSERT INTO `systemctl_location_info` VALUES ('1287', 'SSX', 'insert', '宿松县', '340826', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1287', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宿松县');
INSERT INTO `systemctl_location_info` VALUES ('1288', 'WJX', 'insert', '望江县', '340827', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1288', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '望江县');
INSERT INTO `systemctl_location_info` VALUES ('1289', 'YXX', 'insert', '岳西县', '340828', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1289', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岳西县');
INSERT INTO `systemctl_location_info` VALUES ('1290', 'TCS', 'insert', '桐城市', '340881', 'region', '2015-01-19 15:59:00', '1', '', '340800', null, '1290', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桐城市');
INSERT INTO `systemctl_location_info` VALUES ('1291', 'HSS', 'insert', '黄山市', '341000', 'city', '2015-01-19 15:59:00', '1', '118.29357,29.734435', '340000', null, '1291', '2015-01-19 15:59:00', 'system', 'A', '皖J', '13', '', '黄山市');
INSERT INTO `systemctl_location_info` VALUES ('1292', 'TXQ', 'insert', '屯溪区', '341002', 'region', '2015-01-19 15:59:00', '1', '', '341000', null, '1292', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '屯溪区');
INSERT INTO `systemctl_location_info` VALUES ('1293', 'HSQ', 'insert', '黄山区', '341003', 'region', '2015-01-19 15:59:00', '1', '', '341000', null, '1293', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄山区');
INSERT INTO `systemctl_location_info` VALUES ('1294', 'HZQ', 'insert', '徽州区', '341004', 'region', '2015-01-19 15:59:00', '1', '', '341000', null, '1294', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '徽州区');
INSERT INTO `systemctl_location_info` VALUES ('1295', 'SX', 'insert', '歙县', '341021', 'region', '2015-01-19 15:59:00', '1', '', '341000', null, '1295', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '歙县');
INSERT INTO `systemctl_location_info` VALUES ('1296', 'XNX', 'insert', '休宁县', '341022', 'region', '2015-01-19 15:59:00', '1', '', '341000', null, '1296', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '休宁县');
INSERT INTO `systemctl_location_info` VALUES ('1297', 'YX', 'insert', '黟县', '341023', 'region', '2015-01-19 15:59:00', '1', '', '341000', null, '1297', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黟县');
INSERT INTO `systemctl_location_info` VALUES ('1298', 'QMX', 'insert', '祁门县', '341024', 'region', '2015-01-19 15:59:00', '1', '', '341000', null, '1298', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '祁门县');
INSERT INTO `systemctl_location_info` VALUES ('1299', 'CZS', 'insert', '滁州市', '341100', 'city', '2015-01-19 15:59:00', '1', '118.32457,32.317351', '340000', null, '1299', '2015-01-19 15:59:00', 'system', 'A', '皖M', '13', '', '滁州市');
INSERT INTO `systemctl_location_info` VALUES ('1300', 'LYQ', 'insert', '琅琊区', '341102', 'region', '2015-01-19 15:59:00', '1', '', '341100', null, '1300', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '琅琊区');
INSERT INTO `systemctl_location_info` VALUES ('1301', 'NQQ', 'insert', '南谯区', '341103', 'region', '2015-01-19 15:59:00', '1', '', '341100', null, '1301', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南谯区');
INSERT INTO `systemctl_location_info` VALUES ('1302', 'LAX', 'insert', '来安县', '341122', 'region', '2015-01-19 15:59:00', '1', '', '341100', null, '1302', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '来安县');
INSERT INTO `systemctl_location_info` VALUES ('1303', 'QJX', 'insert', '全椒县', '341124', 'region', '2015-01-19 15:59:00', '1', '', '341100', null, '1303', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '全椒县');
INSERT INTO `systemctl_location_info` VALUES ('1304', 'DYX', 'insert', '定远县', '341125', 'region', '2015-01-19 15:59:00', '1', '', '341100', null, '1304', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定远县');
INSERT INTO `systemctl_location_info` VALUES ('1305', 'FYX', 'insert', '凤阳县', '341126', 'region', '2015-01-19 15:59:00', '1', '', '341100', null, '1305', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤阳县');
INSERT INTO `systemctl_location_info` VALUES ('1306', 'TZS', 'insert', '天长市', '341181', 'region', '2015-01-19 15:59:00', '1', '', '341100', null, '1306', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天长市');
INSERT INTO `systemctl_location_info` VALUES ('1307', 'MGS', 'insert', '明光市', '341182', 'region', '2015-01-19 15:59:00', '1', '', '341100', null, '1307', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '明光市');
INSERT INTO `systemctl_location_info` VALUES ('1308', 'FYS', 'insert', '阜阳市', '341200', 'city', '2015-01-19 15:59:00', '1', '115.820932,32.901211', '340000', null, '1308', '2015-01-19 15:59:00', 'system', 'A', '皖K', '13', '', '阜阳市');
INSERT INTO `systemctl_location_info` VALUES ('1309', 'YZQ', 'insert', '颍州区', '341202', 'region', '2015-01-19 15:59:00', '1', '', '341200', null, '1309', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '颍州区');
INSERT INTO `systemctl_location_info` VALUES ('1310', 'YDQ', 'insert', '颍东区', '341203', 'region', '2015-01-19 15:59:00', '1', '', '341200', null, '1310', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '颍东区');
INSERT INTO `systemctl_location_info` VALUES ('1311', 'YQQ', 'insert', '颍泉区', '341204', 'region', '2015-01-19 15:59:00', '1', '', '341200', null, '1311', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '颍泉区');
INSERT INTO `systemctl_location_info` VALUES ('1312', 'LQX', 'insert', '临泉县', '341221', 'region', '2015-01-19 15:59:00', '1', '', '341200', null, '1312', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临泉县');
INSERT INTO `systemctl_location_info` VALUES ('1313', 'THX', 'insert', '太和县', '341222', 'region', '2015-01-19 15:59:00', '1', '', '341200', null, '1313', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太和县');
INSERT INTO `systemctl_location_info` VALUES ('1314', 'FNX', 'insert', '阜南县', '341225', 'region', '2015-01-19 15:59:00', '1', '', '341200', null, '1314', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阜南县');
INSERT INTO `systemctl_location_info` VALUES ('1315', 'YSX', 'insert', '颍上县', '341226', 'region', '2015-01-19 15:59:00', '1', '', '341200', null, '1315', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '颍上县');
INSERT INTO `systemctl_location_info` VALUES ('1316', 'JSS', 'insert', '界首市', '341282', 'region', '2015-01-19 15:59:00', '1', '', '341200', null, '1316', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '界首市');
INSERT INTO `systemctl_location_info` VALUES ('1317', 'SZS', 'insert', '宿州市', '341300', 'city', '2015-01-19 15:59:00', '1', '116.988692,33.636772', '340000', null, '1317', '2015-01-19 15:59:00', 'system', 'A', '皖L', '13', '', '宿州市');
INSERT INTO `systemctl_location_info` VALUES ('1318', 'YQQ', 'insert', '埇桥区', '341302', 'region', '2015-01-19 15:59:00', '1', '', '341300', null, '1318', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '埇桥区');
INSERT INTO `systemctl_location_info` VALUES ('1319', 'DSX', 'insert', '砀山县', '341321', 'region', '2015-01-19 15:59:00', '1', '', '341300', null, '1319', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '砀山县');
INSERT INTO `systemctl_location_info` VALUES ('1320', 'XX', 'insert', '萧县', '341322', 'region', '2015-01-19 15:59:00', '1', '', '341300', null, '1320', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '萧县');
INSERT INTO `systemctl_location_info` VALUES ('1321', 'LBX', 'insert', '灵璧县', '341323', 'region', '2015-01-19 15:59:00', '1', '', '341300', null, '1321', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵璧县');
INSERT INTO `systemctl_location_info` VALUES ('1322', 'SX', 'insert', '泗县', '341324', 'region', '2015-01-19 15:59:00', '1', '', '341300', null, '1322', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泗县');
INSERT INTO `systemctl_location_info` VALUES ('1323', 'LAS', 'insert', '六安市', '341500', 'city', '2015-01-19 15:59:00', '1', '116.505253,31.755558', '340000', null, '1323', '2015-01-19 15:59:00', 'system', 'A', '皖N', '13', '', '六安市');
INSERT INTO `systemctl_location_info` VALUES ('1324', 'JAQ', 'insert', '金安区', '341502', 'region', '2015-01-19 15:59:00', '1', '', '341500', null, '1324', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金安区');
INSERT INTO `systemctl_location_info` VALUES ('1325', 'YAQ', 'insert', '裕安区', '341503', 'region', '2015-01-19 15:59:00', '1', '', '341500', null, '1325', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '裕安区');
INSERT INTO `systemctl_location_info` VALUES ('1326', 'SX', 'insert', '寿县', '341521', 'region', '2015-01-19 15:59:00', '1', '', '341500', null, '1326', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '寿县');
INSERT INTO `systemctl_location_info` VALUES ('1327', 'HQX', 'insert', '霍邱县', '341522', 'region', '2015-01-19 15:59:00', '1', '', '341500', null, '1327', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '霍邱县');
INSERT INTO `systemctl_location_info` VALUES ('1328', 'SCX', 'insert', '舒城县', '341523', 'region', '2015-01-19 15:59:00', '1', '', '341500', null, '1328', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '舒城县');
INSERT INTO `systemctl_location_info` VALUES ('1329', 'JZX', 'insert', '金寨县', '341524', 'region', '2015-01-19 15:59:00', '1', '', '341500', null, '1329', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金寨县');
INSERT INTO `systemctl_location_info` VALUES ('1330', 'HSX', 'insert', '霍山县', '341525', 'region', '2015-01-19 15:59:00', '1', '', '341500', null, '1330', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '霍山县');
INSERT INTO `systemctl_location_info` VALUES ('1331', 'BZS', 'insert', '亳州市', '341600', 'city', '2015-01-19 15:59:00', '1', '115.787928,33.871211', '340000', null, '1331', '2015-01-19 15:59:00', 'system', 'A', '皖S', '13', '', '亳州市');
INSERT INTO `systemctl_location_info` VALUES ('1332', 'QCQ', 'insert', '谯城区', '341602', 'region', '2015-01-19 15:59:00', '1', '', '341600', null, '1332', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '谯城区');
INSERT INTO `systemctl_location_info` VALUES ('1333', 'WYX', 'insert', '涡阳县', '341621', 'region', '2015-01-19 15:59:00', '1', '', '341600', null, '1333', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涡阳县');
INSERT INTO `systemctl_location_info` VALUES ('1334', 'MCX', 'insert', '蒙城县', '341622', 'region', '2015-01-19 15:59:00', '1', '', '341600', null, '1334', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蒙城县');
INSERT INTO `systemctl_location_info` VALUES ('1335', 'LXX', 'insert', '利辛县', '341623', 'region', '2015-01-19 15:59:00', '1', '', '341600', null, '1335', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '利辛县');
INSERT INTO `systemctl_location_info` VALUES ('1336', 'CZS', 'insert', '池州市', '341700', 'city', '2015-01-19 15:59:00', '1', '117.494477,30.660019', '340000', null, '1336', '2015-01-19 15:59:00', 'system', 'A', '皖R', '14', '', '池州市');
INSERT INTO `systemctl_location_info` VALUES ('1337', 'GCQ', 'insert', '贵池区', '341702', 'region', '2015-01-19 15:59:00', '1', '', '341700', null, '1337', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贵池区');
INSERT INTO `systemctl_location_info` VALUES ('1338', 'DZX', 'insert', '东至县', '341721', 'region', '2015-01-19 15:59:00', '1', '', '341700', null, '1338', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东至县');
INSERT INTO `systemctl_location_info` VALUES ('1339', 'STX', 'insert', '石台县', '341722', 'region', '2015-01-19 15:59:00', '1', '', '341700', null, '1339', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石台县');
INSERT INTO `systemctl_location_info` VALUES ('1340', 'QYX', 'insert', '青阳县', '341723', 'region', '2015-01-19 15:59:00', '1', '', '341700', null, '1340', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青阳县');
INSERT INTO `systemctl_location_info` VALUES ('1341', 'XCS', 'insert', '宣城市', '341800', 'city', '2015-01-19 15:59:00', '1', '118.752096,30.951642', '340000', null, '1341', '2015-01-19 15:59:00', 'system', 'A', '皖P', '13', '', '宣城市');
INSERT INTO `systemctl_location_info` VALUES ('1342', 'XZQ', 'insert', '宣州区', '341802', 'region', '2015-01-19 15:59:00', '1', '', '341800', null, '1342', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宣州区');
INSERT INTO `systemctl_location_info` VALUES ('1343', 'LXX', 'insert', '郎溪县', '341821', 'region', '2015-01-19 15:59:00', '1', '', '341800', null, '1343', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郎溪县');
INSERT INTO `systemctl_location_info` VALUES ('1344', 'GDX', 'insert', '广德县', '341822', 'region', '2015-01-19 15:59:00', '1', '', '341800', null, '1344', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广德县');
INSERT INTO `systemctl_location_info` VALUES ('1345', 'JX', 'insert', '泾县', '341823', 'region', '2015-01-19 15:59:00', '1', '', '341800', null, '1345', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泾县');
INSERT INTO `systemctl_location_info` VALUES ('1346', 'JXX', 'insert', '绩溪县', '341824', 'region', '2015-01-19 15:59:00', '1', '', '341800', null, '1346', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绩溪县');
INSERT INTO `systemctl_location_info` VALUES ('1347', 'JDX', 'insert', '旌德县', '341825', 'region', '2015-01-19 15:59:00', '1', '', '341800', null, '1347', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '旌德县');
INSERT INTO `systemctl_location_info` VALUES ('1348', 'NGS', 'insert', '宁国市', '341881', 'region', '2015-01-19 15:59:00', '1', '', '341800', null, '1348', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁国市');
INSERT INTO `systemctl_location_info` VALUES ('1349', 'FJS', 'insert', '福建省', '350000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '1349', '2015-01-19 15:59:00', 'system', 'A', '闽', '', '', '福建省');
INSERT INTO `systemctl_location_info` VALUES ('1350', 'FZS', 'insert', '福州市', '350100', 'city', '2015-01-19 15:59:00', '1', '119.330221,26.047125', '350000', null, '1350', '2015-01-19 15:59:00', 'system', 'A', '闽A', '12', '', '福州市');
INSERT INTO `systemctl_location_info` VALUES ('1351', 'GLQ', 'insert', '鼓楼区', '350102', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1351', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鼓楼区');
INSERT INTO `systemctl_location_info` VALUES ('1352', 'TJQ', 'insert', '台江区', '350103', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1352', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台江区');
INSERT INTO `systemctl_location_info` VALUES ('1353', 'CSQ', 'insert', '仓山区', '350104', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1353', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仓山区');
INSERT INTO `systemctl_location_info` VALUES ('1354', 'MWQ', 'insert', '马尾区', '350105', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1354', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '马尾区');
INSERT INTO `systemctl_location_info` VALUES ('1355', 'JAQ', 'insert', '晋安区', '350111', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1355', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '晋安区');
INSERT INTO `systemctl_location_info` VALUES ('1356', 'MHX', 'insert', '闽侯县', '350121', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1356', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '闽侯县');
INSERT INTO `systemctl_location_info` VALUES ('1357', 'LJX', 'insert', '连江县', '350122', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1357', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '连江县');
INSERT INTO `systemctl_location_info` VALUES ('1358', 'LYX', 'insert', '罗源县', '350123', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1358', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗源县');
INSERT INTO `systemctl_location_info` VALUES ('1359', 'MQX', 'insert', '闽清县', '350124', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1359', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '闽清县');
INSERT INTO `systemctl_location_info` VALUES ('1360', 'YTX', 'insert', '永泰县', '350125', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1360', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永泰县');
INSERT INTO `systemctl_location_info` VALUES ('1361', 'PTX', 'insert', '平潭县', '350128', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1361', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平潭县');
INSERT INTO `systemctl_location_info` VALUES ('1362', 'FQS', 'insert', '福清市', '350181', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1362', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '福清市');
INSERT INTO `systemctl_location_info` VALUES ('1363', 'ZLS', 'insert', '长乐市', '350182', 'region', '2015-01-19 15:59:00', '1', '', '350100', null, '1363', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长乐市');
INSERT INTO `systemctl_location_info` VALUES ('1364', 'SMS', 'insert', '厦门市', '350200', 'city', '2015-01-19 15:59:00', '1', '118.103886,24.489231', '350000', null, '1364', '2015-01-19 15:59:00', 'system', 'A', '闽D', '12', '', '厦门市');
INSERT INTO `systemctl_location_info` VALUES ('1365', 'SMQ', 'insert', '思明区', '350203', 'region', '2015-01-19 15:59:00', '1', '', '350200', null, '1365', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '思明区');
INSERT INTO `systemctl_location_info` VALUES ('1366', 'HCQ', 'insert', '海沧区', '350205', 'region', '2015-01-19 15:59:00', '1', '', '350200', null, '1366', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海沧区');
INSERT INTO `systemctl_location_info` VALUES ('1367', 'HLQ', 'insert', '湖里区', '350206', 'region', '2015-01-19 15:59:00', '1', '', '350200', null, '1367', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湖里区');
INSERT INTO `systemctl_location_info` VALUES ('1368', 'JMQ', 'insert', '集美区', '350211', 'region', '2015-01-19 15:59:00', '1', '', '350200', null, '1368', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '集美区');
INSERT INTO `systemctl_location_info` VALUES ('1369', 'TAQ', 'insert', '同安区', '350212', 'region', '2015-01-19 15:59:00', '1', '', '350200', null, '1369', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '同安区');
INSERT INTO `systemctl_location_info` VALUES ('1370', 'XAQ', 'insert', '翔安区', '350213', 'region', '2015-01-19 15:59:00', '1', '', '350200', null, '1370', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '翔安区');
INSERT INTO `systemctl_location_info` VALUES ('1371', 'PTS', 'insert', '莆田市', '350300', 'city', '2015-01-19 15:59:00', '1', '119.077731,25.44845', '350000', null, '1371', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '莆田市');
INSERT INTO `systemctl_location_info` VALUES ('1372', 'CXQ', 'insert', '城厢区', '350302', 'region', '2015-01-19 15:59:00', '1', '', '350300', null, '1372', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城厢区');
INSERT INTO `systemctl_location_info` VALUES ('1373', 'HJQ', 'insert', '涵江区', '350303', 'region', '2015-01-19 15:59:00', '1', '', '350300', null, '1373', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涵江区');
INSERT INTO `systemctl_location_info` VALUES ('1374', 'LCQ', 'insert', '荔城区', '350304', 'region', '2015-01-19 15:59:00', '1', '', '350300', null, '1374', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荔城区');
INSERT INTO `systemctl_location_info` VALUES ('1375', 'XYQ', 'insert', '秀屿区', '350305', 'region', '2015-01-19 15:59:00', '1', '', '350300', null, '1375', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秀屿区');
INSERT INTO `systemctl_location_info` VALUES ('1376', 'XYX', 'insert', '仙游县', '350322', 'region', '2015-01-19 15:59:00', '1', '', '350300', null, '1376', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仙游县');
INSERT INTO `systemctl_location_info` VALUES ('1377', 'SMS', 'insert', '三明市', '350400', 'city', '2015-01-19 15:59:00', '1', '117.642194,26.270835', '350000', null, '1377', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '三明市');
INSERT INTO `systemctl_location_info` VALUES ('1378', 'MLQ', 'insert', '梅列区', '350402', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1378', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梅列区');
INSERT INTO `systemctl_location_info` VALUES ('1379', 'SYQ', 'insert', '三元区', '350403', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1379', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三元区');
INSERT INTO `systemctl_location_info` VALUES ('1380', 'MXX', 'insert', '明溪县', '350421', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1380', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '明溪县');
INSERT INTO `systemctl_location_info` VALUES ('1381', 'QLX', 'insert', '清流县', '350423', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1381', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清流县');
INSERT INTO `systemctl_location_info` VALUES ('1382', 'NHX', 'insert', '宁化县', '350424', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1382', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁化县');
INSERT INTO `systemctl_location_info` VALUES ('1383', 'DTX', 'insert', '大田县', '350425', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1383', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大田县');
INSERT INTO `systemctl_location_info` VALUES ('1384', 'YXX', 'insert', '尤溪县', '350426', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1384', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尤溪县');
INSERT INTO `systemctl_location_info` VALUES ('1385', 'SX', 'insert', '沙县', '350427', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1385', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙县');
INSERT INTO `systemctl_location_info` VALUES ('1386', 'JLX', 'insert', '将乐县', '350428', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1386', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '将乐县');
INSERT INTO `systemctl_location_info` VALUES ('1387', 'TNX', 'insert', '泰宁县', '350429', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1387', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泰宁县');
INSERT INTO `systemctl_location_info` VALUES ('1388', 'JNX', 'insert', '建宁县', '350430', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1388', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建宁县');
INSERT INTO `systemctl_location_info` VALUES ('1389', 'YAS', 'insert', '永安市', '350481', 'region', '2015-01-19 15:59:00', '1', '', '350400', null, '1389', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永安市');
INSERT INTO `systemctl_location_info` VALUES ('1390', 'QZS', 'insert', '泉州市', '350500', 'city', '2015-01-19 15:59:00', '1', '118.600362,24.901652', '350000', null, '1390', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '泉州市');
INSERT INTO `systemctl_location_info` VALUES ('1391', 'LCQ', 'insert', '鲤城区', '350502', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1391', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鲤城区');
INSERT INTO `systemctl_location_info` VALUES ('1392', 'FZQ', 'insert', '丰泽区', '350503', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1392', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰泽区');
INSERT INTO `systemctl_location_info` VALUES ('1393', 'LJQ', 'insert', '洛江区', '350504', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1393', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洛江区');
INSERT INTO `systemctl_location_info` VALUES ('1394', 'QGQ', 'insert', '泉港区', '350505', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1394', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泉港区');
INSERT INTO `systemctl_location_info` VALUES ('1395', 'HAX', 'insert', '惠安县', '350521', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1395', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠安县');
INSERT INTO `systemctl_location_info` VALUES ('1396', 'AXX', 'insert', '安溪县', '350524', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1396', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安溪县');
INSERT INTO `systemctl_location_info` VALUES ('1397', 'YCX', 'insert', '永春县', '350525', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1397', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永春县');
INSERT INTO `systemctl_location_info` VALUES ('1398', 'DHX', 'insert', '德化县', '350526', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1398', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德化县');
INSERT INTO `systemctl_location_info` VALUES ('1399', 'JMX', 'insert', '金门县', '350527', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1399', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金门县');
INSERT INTO `systemctl_location_info` VALUES ('1400', 'SSS', 'insert', '石狮市', '350581', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1400', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石狮市');
INSERT INTO `systemctl_location_info` VALUES ('1401', 'JJS', 'insert', '晋江市', '350582', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1401', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '晋江市');
INSERT INTO `systemctl_location_info` VALUES ('1402', 'NAS', 'insert', '南安市', '350583', 'region', '2015-01-19 15:59:00', '1', '', '350500', null, '1402', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南安市');
INSERT INTO `systemctl_location_info` VALUES ('1403', 'ZZS', 'insert', '漳州市', '350600', 'city', '2015-01-19 15:59:00', '1', '117.676205,24.517065', '350000', null, '1403', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '漳州市');
INSERT INTO `systemctl_location_info` VALUES ('1404', 'XCQ', 'insert', '芗城区', '350602', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1404', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芗城区');
INSERT INTO `systemctl_location_info` VALUES ('1405', 'LWQ', 'insert', '龙文区', '350603', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1405', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙文区');
INSERT INTO `systemctl_location_info` VALUES ('1406', 'YXX', 'insert', '云霄县', '350622', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1406', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云霄县');
INSERT INTO `systemctl_location_info` VALUES ('1407', 'ZPX', 'insert', '漳浦县', '350623', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1407', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '漳浦县');
INSERT INTO `systemctl_location_info` VALUES ('1408', 'ZAX', 'insert', '诏安县', '350624', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1408', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '诏安县');
INSERT INTO `systemctl_location_info` VALUES ('1409', 'ZTX', 'insert', '长泰县', '350625', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1409', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长泰县');
INSERT INTO `systemctl_location_info` VALUES ('1410', 'DSX', 'insert', '东山县', '350626', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1410', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东山县');
INSERT INTO `systemctl_location_info` VALUES ('1411', 'NJX', 'insert', '南靖县', '350627', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1411', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南靖县');
INSERT INTO `systemctl_location_info` VALUES ('1412', 'PHX', 'insert', '平和县', '350628', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1412', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平和县');
INSERT INTO `systemctl_location_info` VALUES ('1413', 'HAX', 'insert', '华安县', '350629', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1413', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华安县');
INSERT INTO `systemctl_location_info` VALUES ('1414', 'LHS', 'insert', '龙海市', '350681', 'region', '2015-01-19 15:59:00', '1', '', '350600', null, '1414', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙海市');
INSERT INTO `systemctl_location_info` VALUES ('1415', 'NPS', 'insert', '南平市', '350700', 'city', '2015-01-19 15:59:00', '1', '118.181883,26.643626', '350000', null, '1415', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '南平市');
INSERT INTO `systemctl_location_info` VALUES ('1416', 'YPQ', 'insert', '延平区', '350702', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1416', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '延平区');
INSERT INTO `systemctl_location_info` VALUES ('1417', 'SCX', 'insert', '顺昌县', '350721', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1417', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '顺昌县');
INSERT INTO `systemctl_location_info` VALUES ('1418', 'PCX', 'insert', '浦城县', '350722', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1418', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浦城县');
INSERT INTO `systemctl_location_info` VALUES ('1419', 'GZX', 'insert', '光泽县', '350723', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1419', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '光泽县');
INSERT INTO `systemctl_location_info` VALUES ('1420', 'SXX', 'insert', '松溪县', '350724', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1420', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松溪县');
INSERT INTO `systemctl_location_info` VALUES ('1421', 'ZHX', 'insert', '政和县', '350725', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1421', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '政和县');
INSERT INTO `systemctl_location_info` VALUES ('1422', 'SWS', 'insert', '邵武市', '350781', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1422', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邵武市');
INSERT INTO `systemctl_location_info` VALUES ('1423', 'WYSS', 'insert', '武夷山市', '350782', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1423', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武夷山市');
INSERT INTO `systemctl_location_info` VALUES ('1424', 'JOS', 'insert', '建瓯市', '350783', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1424', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建瓯市');
INSERT INTO `systemctl_location_info` VALUES ('1425', 'JYS', 'insert', '建阳市', '350784', 'region', '2015-01-19 15:59:00', '1', '', '350700', null, '1425', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建阳市');
INSERT INTO `systemctl_location_info` VALUES ('1426', 'LYS', 'insert', '龙岩市', '350800', 'city', '2015-01-19 15:59:00', '1', '117.017997,25.078685', '350000', null, '1426', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '龙岩市');
INSERT INTO `systemctl_location_info` VALUES ('1427', 'XLQ', 'insert', '新罗区', '350802', 'region', '2015-01-19 15:59:00', '1', '', '350800', null, '1427', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新罗区');
INSERT INTO `systemctl_location_info` VALUES ('1428', 'ZTX', 'insert', '长汀县', '350821', 'region', '2015-01-19 15:59:00', '1', '', '350800', null, '1428', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长汀县');
INSERT INTO `systemctl_location_info` VALUES ('1429', 'YDX', 'insert', '永定县', '350822', 'region', '2015-01-19 15:59:00', '1', '', '350800', null, '1429', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永定县');
INSERT INTO `systemctl_location_info` VALUES ('1430', 'SHX', 'insert', '上杭县', '350823', 'region', '2015-01-19 15:59:00', '1', '', '350800', null, '1430', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上杭县');
INSERT INTO `systemctl_location_info` VALUES ('1431', 'WPX', 'insert', '武平县', '350824', 'region', '2015-01-19 15:59:00', '1', '', '350800', null, '1431', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武平县');
INSERT INTO `systemctl_location_info` VALUES ('1432', 'LCX', 'insert', '连城县', '350825', 'region', '2015-01-19 15:59:00', '1', '', '350800', null, '1432', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '连城县');
INSERT INTO `systemctl_location_info` VALUES ('1433', 'ZPS', 'insert', '漳平市', '350881', 'region', '2015-01-19 15:59:00', '1', '', '350800', null, '1433', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '漳平市');
INSERT INTO `systemctl_location_info` VALUES ('1434', 'NDS', 'insert', '宁德市', '350900', 'city', '2015-01-19 15:59:00', '1', '119.542082,26.656527', '350000', null, '1434', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '宁德市');
INSERT INTO `systemctl_location_info` VALUES ('1435', 'JCQ', 'insert', '蕉城区', '350902', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1435', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蕉城区');
INSERT INTO `systemctl_location_info` VALUES ('1436', 'XPX', 'insert', '霞浦县', '350921', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1436', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '霞浦县');
INSERT INTO `systemctl_location_info` VALUES ('1437', 'GTX', 'insert', '古田县', '350922', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1437', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古田县');
INSERT INTO `systemctl_location_info` VALUES ('1438', 'PNX', 'insert', '屏南县', '350923', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1438', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '屏南县');
INSERT INTO `systemctl_location_info` VALUES ('1439', 'SNX', 'insert', '寿宁县', '350924', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1439', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '寿宁县');
INSERT INTO `systemctl_location_info` VALUES ('1440', 'ZNX', 'insert', '周宁县', '350925', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1440', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '周宁县');
INSERT INTO `systemctl_location_info` VALUES ('1441', 'ZRX', 'insert', '柘荣县', '350926', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1441', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柘荣县');
INSERT INTO `systemctl_location_info` VALUES ('1442', 'FAS', 'insert', '福安市', '350981', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1442', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '福安市');
INSERT INTO `systemctl_location_info` VALUES ('1443', 'FDS', 'insert', '福鼎市', '350982', 'region', '2015-01-19 15:59:00', '1', '', '350900', null, '1443', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '福鼎市');
INSERT INTO `systemctl_location_info` VALUES ('1444', 'JXS', 'insert', '江西省', '360000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '1444', '2015-01-19 15:59:00', 'system', 'A', '赣', '', '', '江西省');
INSERT INTO `systemctl_location_info` VALUES ('1445', 'NCS', 'insert', '南昌市', '360100', 'city', '2015-01-19 15:59:00', '1', '115.893528,28.689578', '360000', null, '1445', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '南昌市');
INSERT INTO `systemctl_location_info` VALUES ('1446', 'DHQ', 'insert', '东湖区', '360102', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1446', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东湖区');
INSERT INTO `systemctl_location_info` VALUES ('1447', 'XHQ', 'insert', '西湖区', '360103', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1447', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西湖区');
INSERT INTO `systemctl_location_info` VALUES ('1448', 'QYPQ', 'insert', '青云谱区', '360104', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1448', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青云谱区');
INSERT INTO `systemctl_location_info` VALUES ('1449', 'WLQ', 'insert', '湾里区', '360105', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1449', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湾里区');
INSERT INTO `systemctl_location_info` VALUES ('1450', 'QSHQ', 'insert', '青山湖区', '360111', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1450', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青山湖区');
INSERT INTO `systemctl_location_info` VALUES ('1451', 'NCX', 'insert', '南昌县', '360121', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1451', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南昌县');
INSERT INTO `systemctl_location_info` VALUES ('1452', 'XJX', 'insert', '新建县', '360122', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1452', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新建县');
INSERT INTO `systemctl_location_info` VALUES ('1453', 'AYX', 'insert', '安义县', '360123', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1453', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安义县');
INSERT INTO `systemctl_location_info` VALUES ('1454', 'JXX', 'insert', '进贤县', '360124', 'region', '2015-01-19 15:59:00', '1', '', '360100', null, '1454', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '进贤县');
INSERT INTO `systemctl_location_info` VALUES ('1455', 'JDZS', 'insert', '景德镇市', '360200', 'city', '2015-01-19 15:59:00', '1', '117.186523,29.303563', '360000', null, '1455', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '景德镇市');
INSERT INTO `systemctl_location_info` VALUES ('1456', 'CJQ', 'insert', '昌江区', '360202', 'region', '2015-01-19 15:59:00', '1', '', '360200', null, '1456', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌江区');
INSERT INTO `systemctl_location_info` VALUES ('1457', 'ZSQ', 'insert', '珠山区', '360203', 'region', '2015-01-19 15:59:00', '1', '', '360200', null, '1457', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '珠山区');
INSERT INTO `systemctl_location_info` VALUES ('1458', 'FLX', 'insert', '浮梁县', '360222', 'region', '2015-01-19 15:59:00', '1', '', '360200', null, '1458', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浮梁县');
INSERT INTO `systemctl_location_info` VALUES ('1459', 'LPS', 'insert', '乐平市', '360281', 'region', '2015-01-19 15:59:00', '1', '', '360200', null, '1459', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐平市');
INSERT INTO `systemctl_location_info` VALUES ('1460', 'PXS', 'insert', '萍乡市', '360300', 'city', '2015-01-19 15:59:00', '1', '113.859917,27.639544', '360000', null, '1460', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '萍乡市');
INSERT INTO `systemctl_location_info` VALUES ('1461', 'AYQ', 'insert', '安源区', '360302', 'region', '2015-01-19 15:59:00', '1', '', '360300', null, '1461', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安源区');
INSERT INTO `systemctl_location_info` VALUES ('1462', 'XDQ', 'insert', '湘东区', '360313', 'region', '2015-01-19 15:59:00', '1', '', '360300', null, '1462', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湘东区');
INSERT INTO `systemctl_location_info` VALUES ('1463', 'LHX', 'insert', '莲花县', '360321', 'region', '2015-01-19 15:59:00', '1', '', '360300', null, '1463', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莲花县');
INSERT INTO `systemctl_location_info` VALUES ('1464', 'SLX', 'insert', '上栗县', '360322', 'region', '2015-01-19 15:59:00', '1', '', '360300', null, '1464', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上栗县');
INSERT INTO `systemctl_location_info` VALUES ('1465', 'LXX', 'insert', '芦溪县', '360323', 'region', '2015-01-19 15:59:00', '1', '', '360300', null, '1465', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芦溪县');
INSERT INTO `systemctl_location_info` VALUES ('1466', 'JJS', 'insert', '九江市', '360400', 'city', '2015-01-19 15:59:00', '1', '115.999848,29.71964', '360000', null, '1466', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '九江市');
INSERT INTO `systemctl_location_info` VALUES ('1467', 'LSQ', 'insert', '庐山区', '360402', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1467', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庐山区');
INSERT INTO `systemctl_location_info` VALUES ('1468', 'XYQ', 'insert', '浔阳区', '360403', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1468', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浔阳区');
INSERT INTO `systemctl_location_info` VALUES ('1469', 'JJX', 'insert', '九江县', '360421', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1469', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '九江县');
INSERT INTO `systemctl_location_info` VALUES ('1470', 'WNX', 'insert', '武宁县', '360423', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1470', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武宁县');
INSERT INTO `systemctl_location_info` VALUES ('1471', 'XSX', 'insert', '修水县', '360424', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1471', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '修水县');
INSERT INTO `systemctl_location_info` VALUES ('1472', 'YXX', 'insert', '永修县', '360425', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1472', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永修县');
INSERT INTO `systemctl_location_info` VALUES ('1473', 'DAX', 'insert', '德安县', '360426', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1473', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德安县');
INSERT INTO `systemctl_location_info` VALUES ('1474', 'XZX', 'insert', '星子县', '360427', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1474', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '星子县');
INSERT INTO `systemctl_location_info` VALUES ('1475', 'DCX', 'insert', '都昌县', '360428', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1475', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '都昌县');
INSERT INTO `systemctl_location_info` VALUES ('1476', 'HKX', 'insert', '湖口县', '360429', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1476', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湖口县');
INSERT INTO `systemctl_location_info` VALUES ('1477', 'PZX', 'insert', '彭泽县', '360430', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1477', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彭泽县');
INSERT INTO `systemctl_location_info` VALUES ('1478', 'RCS', 'insert', '瑞昌市', '360481', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1478', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瑞昌市');
INSERT INTO `systemctl_location_info` VALUES ('1479', 'GQCS', 'insert', '共青城市', '360482', 'region', '2015-01-19 15:59:00', '1', '', '360400', null, '1479', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '共青城市');
INSERT INTO `systemctl_location_info` VALUES ('1480', 'XYS', 'insert', '新余市', '360500', 'city', '2015-01-19 15:59:00', '1', '114.947117,27.822322', '360000', null, '1480', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '新余市');
INSERT INTO `systemctl_location_info` VALUES ('1481', 'YSQ', 'insert', '渝水区', '360502', 'region', '2015-01-19 15:59:00', '1', '', '360500', null, '1481', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '渝水区');
INSERT INTO `systemctl_location_info` VALUES ('1482', 'FYX', 'insert', '分宜县', '360521', 'region', '2015-01-19 15:59:00', '1', '', '360500', null, '1482', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '分宜县');
INSERT INTO `systemctl_location_info` VALUES ('1483', 'YTS', 'insert', '鹰潭市', '360600', 'city', '2015-01-19 15:59:00', '1', '117.03545,28.24131', '360000', null, '1483', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '鹰潭市');
INSERT INTO `systemctl_location_info` VALUES ('1484', 'YHQ', 'insert', '月湖区', '360602', 'region', '2015-01-19 15:59:00', '1', '', '360600', null, '1484', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '月湖区');
INSERT INTO `systemctl_location_info` VALUES ('1485', 'YJX', 'insert', '余江县', '360622', 'region', '2015-01-19 15:59:00', '1', '', '360600', null, '1485', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '余江县');
INSERT INTO `systemctl_location_info` VALUES ('1486', 'GXS', 'insert', '贵溪市', '360681', 'region', '2015-01-19 15:59:00', '1', '', '360600', null, '1486', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贵溪市');
INSERT INTO `systemctl_location_info` VALUES ('1487', 'GZS', 'insert', '赣州市', '360700', 'city', '2015-01-19 15:59:00', '1', '114.935909,25.845296', '360000', null, '1487', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '赣州市');
INSERT INTO `systemctl_location_info` VALUES ('1488', 'ZGQ', 'insert', '章贡区', '360702', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1488', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '章贡区');
INSERT INTO `systemctl_location_info` VALUES ('1489', 'GX', 'insert', '赣县', '360721', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1489', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赣县');
INSERT INTO `systemctl_location_info` VALUES ('1490', 'XFX', 'insert', '信丰县', '360722', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1490', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '信丰县');
INSERT INTO `systemctl_location_info` VALUES ('1491', 'DYX', 'insert', '大余县', '360723', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1491', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大余县');
INSERT INTO `systemctl_location_info` VALUES ('1492', 'SYX', 'insert', '上犹县', '360724', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1492', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上犹县');
INSERT INTO `systemctl_location_info` VALUES ('1493', 'CYX', 'insert', '崇义县', '360725', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1493', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇义县');
INSERT INTO `systemctl_location_info` VALUES ('1494', 'AYX', 'insert', '安远县', '360726', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1494', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安远县');
INSERT INTO `systemctl_location_info` VALUES ('1495', 'LNX', 'insert', '龙南县', '360727', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1495', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙南县');
INSERT INTO `systemctl_location_info` VALUES ('1496', 'DNX', 'insert', '定南县', '360728', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1496', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定南县');
INSERT INTO `systemctl_location_info` VALUES ('1497', 'QNX', 'insert', '全南县', '360729', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1497', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '全南县');
INSERT INTO `systemctl_location_info` VALUES ('1498', 'NDX', 'insert', '宁都县', '360730', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1498', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁都县');
INSERT INTO `systemctl_location_info` VALUES ('1499', 'YDX', 'insert', '于都县', '360731', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1499', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '于都县');
INSERT INTO `systemctl_location_info` VALUES ('1500', 'XGX', 'insert', '兴国县', '360732', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1500', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴国县');
INSERT INTO `systemctl_location_info` VALUES ('1501', 'HCX', 'insert', '会昌县', '360733', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1501', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '会昌县');
INSERT INTO `systemctl_location_info` VALUES ('1502', 'XWX', 'insert', '寻乌县', '360734', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1502', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '寻乌县');
INSERT INTO `systemctl_location_info` VALUES ('1503', 'SCX', 'insert', '石城县', '360735', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1503', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石城县');
INSERT INTO `systemctl_location_info` VALUES ('1504', 'RJS', 'insert', '瑞金市', '360781', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1504', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瑞金市');
INSERT INTO `systemctl_location_info` VALUES ('1505', 'NKS', 'insert', '南康市', '360782', 'region', '2015-01-19 15:59:00', '1', '', '360700', null, '1505', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南康市');
INSERT INTO `systemctl_location_info` VALUES ('1506', 'JAS', 'insert', '吉安市', '360800', 'city', '2015-01-19 15:59:00', '1', '114.992039,27.113848', '360000', null, '1506', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '吉安市');
INSERT INTO `systemctl_location_info` VALUES ('1507', 'JZQ', 'insert', '吉州区', '360802', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1507', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉州区');
INSERT INTO `systemctl_location_info` VALUES ('1508', 'QYQ', 'insert', '青原区', '360803', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1508', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青原区');
INSERT INTO `systemctl_location_info` VALUES ('1509', 'JAX', 'insert', '吉安县', '360821', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1509', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉安县');
INSERT INTO `systemctl_location_info` VALUES ('1510', 'JSX', 'insert', '吉水县', '360822', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1510', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉水县');
INSERT INTO `systemctl_location_info` VALUES ('1511', 'XJX', 'insert', '峡江县', '360823', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1511', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '峡江县');
INSERT INTO `systemctl_location_info` VALUES ('1512', 'XGX', 'insert', '新干县', '360824', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1512', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新干县');
INSERT INTO `systemctl_location_info` VALUES ('1513', 'YFX', 'insert', '永丰县', '360825', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1513', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永丰县');
INSERT INTO `systemctl_location_info` VALUES ('1514', 'THX', 'insert', '泰和县', '360826', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1514', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泰和县');
INSERT INTO `systemctl_location_info` VALUES ('1515', 'SCX', 'insert', '遂川县', '360827', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1515', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '遂川县');
INSERT INTO `systemctl_location_info` VALUES ('1516', 'WAX', 'insert', '万安县', '360828', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1516', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万安县');
INSERT INTO `systemctl_location_info` VALUES ('1517', 'AFX', 'insert', '安福县', '360829', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1517', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安福县');
INSERT INTO `systemctl_location_info` VALUES ('1518', 'YXX', 'insert', '永新县', '360830', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1518', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永新县');
INSERT INTO `systemctl_location_info` VALUES ('1519', 'JGSS', 'insert', '井冈山市', '360881', 'region', '2015-01-19 15:59:00', '1', '', '360800', null, '1519', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '井冈山市');
INSERT INTO `systemctl_location_info` VALUES ('1520', 'YCS', 'insert', '宜春市', '360900', 'city', '2015-01-19 15:59:00', '1', '114.400039,27.81113', '360000', null, '1520', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '宜春市');
INSERT INTO `systemctl_location_info` VALUES ('1521', 'YZQ', 'insert', '袁州区', '360902', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1521', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '袁州区');
INSERT INTO `systemctl_location_info` VALUES ('1522', 'FXX', 'insert', '奉新县', '360921', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1522', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '奉新县');
INSERT INTO `systemctl_location_info` VALUES ('1523', 'WZX', 'insert', '万载县', '360922', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1523', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万载县');
INSERT INTO `systemctl_location_info` VALUES ('1524', 'SGX', 'insert', '上高县', '360923', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1524', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上高县');
INSERT INTO `systemctl_location_info` VALUES ('1525', 'YFX', 'insert', '宜丰县', '360924', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1525', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜丰县');
INSERT INTO `systemctl_location_info` VALUES ('1526', 'JAX', 'insert', '靖安县', '360925', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1526', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '靖安县');
INSERT INTO `systemctl_location_info` VALUES ('1527', 'TGX', 'insert', '铜鼓县', '360926', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1527', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铜鼓县');
INSERT INTO `systemctl_location_info` VALUES ('1528', 'FCS', 'insert', '丰城市', '360981', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1528', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰城市');
INSERT INTO `systemctl_location_info` VALUES ('1529', 'ZSS', 'insert', '樟树市', '360982', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1529', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '樟树市');
INSERT INTO `systemctl_location_info` VALUES ('1530', 'GAS', 'insert', '高安市', '360983', 'region', '2015-01-19 15:59:00', '1', '', '360900', null, '1530', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高安市');
INSERT INTO `systemctl_location_info` VALUES ('1531', 'FZS', 'insert', '抚州市', '361000', 'city', '2015-01-19 15:59:00', '1', '116.360919,27.954545', '360000', null, '1531', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '抚州市');
INSERT INTO `systemctl_location_info` VALUES ('1532', 'LCQ', 'insert', '临川区', '361002', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1532', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临川区');
INSERT INTO `systemctl_location_info` VALUES ('1533', 'NCX', 'insert', '南城县', '361021', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1533', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南城县');
INSERT INTO `systemctl_location_info` VALUES ('1534', 'LCX', 'insert', '黎川县', '361022', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1534', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黎川县');
INSERT INTO `systemctl_location_info` VALUES ('1535', 'NFX', 'insert', '南丰县', '361023', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1535', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南丰县');
INSERT INTO `systemctl_location_info` VALUES ('1536', 'CRX', 'insert', '崇仁县', '361024', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1536', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇仁县');
INSERT INTO `systemctl_location_info` VALUES ('1537', 'LAX', 'insert', '乐安县', '361025', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1537', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐安县');
INSERT INTO `systemctl_location_info` VALUES ('1538', 'YHX', 'insert', '宜黄县', '361026', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1538', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜黄县');
INSERT INTO `systemctl_location_info` VALUES ('1539', 'JXX', 'insert', '金溪县', '361027', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1539', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金溪县');
INSERT INTO `systemctl_location_info` VALUES ('1540', 'ZXX', 'insert', '资溪县', '361028', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1540', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '资溪县');
INSERT INTO `systemctl_location_info` VALUES ('1541', 'DXX', 'insert', '东乡县', '361029', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1541', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东乡县');
INSERT INTO `systemctl_location_info` VALUES ('1542', 'GCX', 'insert', '广昌县', '361030', 'region', '2015-01-19 15:59:00', '1', '', '361000', null, '1542', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广昌县');
INSERT INTO `systemctl_location_info` VALUES ('1543', 'SRS', 'insert', '上饶市', '361100', 'city', '2015-01-19 15:59:00', '1', '117.955464,28.457623', '360000', null, '1543', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '上饶市');
INSERT INTO `systemctl_location_info` VALUES ('1544', 'XZQ', 'insert', '信州区', '361102', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1544', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '信州区');
INSERT INTO `systemctl_location_info` VALUES ('1545', 'SRX', 'insert', '上饶县', '361121', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1545', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上饶县');
INSERT INTO `systemctl_location_info` VALUES ('1546', 'GFX', 'insert', '广丰县', '361122', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1546', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广丰县');
INSERT INTO `systemctl_location_info` VALUES ('1547', 'YSX', 'insert', '玉山县', '361123', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1547', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉山县');
INSERT INTO `systemctl_location_info` VALUES ('1548', 'QSX', 'insert', '铅山县', '361124', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1548', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铅山县');
INSERT INTO `systemctl_location_info` VALUES ('1549', 'HFX', 'insert', '横峰县', '361125', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1549', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '横峰县');
INSERT INTO `systemctl_location_info` VALUES ('1550', 'YYX', 'insert', '弋阳县', '361126', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1550', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '弋阳县');
INSERT INTO `systemctl_location_info` VALUES ('1551', 'YGX', 'insert', '余干县', '361127', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1551', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '余干县');
INSERT INTO `systemctl_location_info` VALUES ('1552', 'PYX', 'insert', '鄱阳县', '361128', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1552', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄱阳县');
INSERT INTO `systemctl_location_info` VALUES ('1553', 'WNX', 'insert', '万年县', '361129', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1553', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万年县');
INSERT INTO `systemctl_location_info` VALUES ('1554', 'WYX', 'insert', '婺源县', '361130', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1554', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '婺源县');
INSERT INTO `systemctl_location_info` VALUES ('1555', 'DXS', 'insert', '德兴市', '361181', 'region', '2015-01-19 15:59:00', '1', '', '361100', null, '1555', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德兴市');
INSERT INTO `systemctl_location_info` VALUES ('1556', 'SDS', 'insert', '山东省', '370000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '1556', '2015-01-19 15:59:00', 'system', 'A', '鲁', '', '', '山东省');
INSERT INTO `systemctl_location_info` VALUES ('1557', 'JNS', 'insert', '济南市', '370100', 'city', '2015-01-19 15:59:00', '1', '117.024967,36.682785', '370000', null, '1557', '2015-01-19 15:59:00', 'system', 'A', '鲁A', '12', '', '济南市');
INSERT INTO `systemctl_location_info` VALUES ('1558', 'LXQ', 'insert', '历下区', '370102', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1558', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '历下区');
INSERT INTO `systemctl_location_info` VALUES ('1559', 'SZQ', 'insert', '市中区', '370103', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1559', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '市中区');
INSERT INTO `systemctl_location_info` VALUES ('1560', 'HYQ', 'insert', '槐荫区', '370104', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1560', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '槐荫区');
INSERT INTO `systemctl_location_info` VALUES ('1561', 'TQQ', 'insert', '天桥区', '370105', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1561', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天桥区');
INSERT INTO `systemctl_location_info` VALUES ('1562', 'LCQ', 'insert', '历城区', '370112', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1562', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '历城区');
INSERT INTO `systemctl_location_info` VALUES ('1563', 'ZQQ', 'insert', '长清区', '370113', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1563', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长清区');
INSERT INTO `systemctl_location_info` VALUES ('1564', 'PYX', 'insert', '平阴县', '370124', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1564', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平阴县');
INSERT INTO `systemctl_location_info` VALUES ('1565', 'JYX', 'insert', '济阳县', '370125', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1565', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '济阳县');
INSERT INTO `systemctl_location_info` VALUES ('1566', 'SHX', 'insert', '商河县', '370126', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1566', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '商河县');
INSERT INTO `systemctl_location_info` VALUES ('1567', 'ZQS', 'insert', '章丘市', '370181', 'region', '2015-01-19 15:59:00', '1', '', '370100', null, '1567', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '章丘市');
INSERT INTO `systemctl_location_info` VALUES ('1568', 'QDS', 'insert', '青岛市', '370200', 'city', '2015-01-19 15:59:00', '1', '120.384428,36.105215', '370000', null, '1568', '2015-01-19 15:59:00', 'system', 'A', '鲁B', '12', '', '青岛市');
INSERT INTO `systemctl_location_info` VALUES ('1569', 'SNQ', 'insert', '市南区', '370202', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1569', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '市南区');
INSERT INTO `systemctl_location_info` VALUES ('1570', 'SBQ', 'insert', '市北区', '370203', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1570', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '市北区');
INSERT INTO `systemctl_location_info` VALUES ('1571', 'SFQ', 'insert', '四方区', '370205', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1571', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '四方区');
INSERT INTO `systemctl_location_info` VALUES ('1572', 'HDQ', 'insert', '黄岛区', '370211', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1572', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄岛区');
INSERT INTO `systemctl_location_info` VALUES ('1573', 'LSQ', 'insert', '崂山区', '370212', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1573', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崂山区');
INSERT INTO `systemctl_location_info` VALUES ('1574', 'LCQ', 'insert', '李沧区', '370213', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1574', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '李沧区');
INSERT INTO `systemctl_location_info` VALUES ('1575', 'CYQ', 'insert', '城阳区', '370214', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1575', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城阳区');
INSERT INTO `systemctl_location_info` VALUES ('1576', 'JZS', 'insert', '胶州市', '370281', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1576', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '胶州市');
INSERT INTO `systemctl_location_info` VALUES ('1577', 'JMS', 'insert', '即墨市', '370282', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1577', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '即墨市');
INSERT INTO `systemctl_location_info` VALUES ('1578', 'PDS', 'insert', '平度市', '370283', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1578', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平度市');
INSERT INTO `systemctl_location_info` VALUES ('1579', 'JNS', 'insert', '胶南市', '370284', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1579', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '胶南市');
INSERT INTO `systemctl_location_info` VALUES ('1580', 'LXS', 'insert', '莱西市', '370285', 'region', '2015-01-19 15:59:00', '1', '', '370200', null, '1580', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莱西市');
INSERT INTO `systemctl_location_info` VALUES ('1581', 'ZBS', 'insert', '淄博市', '370300', 'city', '2015-01-19 15:59:00', '1', '118.059134,36.804685', '370000', null, '1581', '2015-01-19 15:59:00', 'system', 'A', '鲁C', '12', '', '淄博市');
INSERT INTO `systemctl_location_info` VALUES ('1582', 'ZCQ', 'insert', '淄川区', '370302', 'region', '2015-01-19 15:59:00', '1', '', '370300', null, '1582', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淄川区');
INSERT INTO `systemctl_location_info` VALUES ('1583', 'ZDQ', 'insert', '张店区', '370303', 'region', '2015-01-19 15:59:00', '1', '', '370300', null, '1583', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '张店区');
INSERT INTO `systemctl_location_info` VALUES ('1584', 'BSQ', 'insert', '博山区', '370304', 'region', '2015-01-19 15:59:00', '1', '', '370300', null, '1584', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博山区');
INSERT INTO `systemctl_location_info` VALUES ('1585', 'LZQ', 'insert', '临淄区', '370305', 'region', '2015-01-19 15:59:00', '1', '', '370300', null, '1585', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临淄区');
INSERT INTO `systemctl_location_info` VALUES ('1586', 'ZCQ', 'insert', '周村区', '370306', 'region', '2015-01-19 15:59:00', '1', '', '370300', null, '1586', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '周村区');
INSERT INTO `systemctl_location_info` VALUES ('1587', 'HTX', 'insert', '桓台县', '370321', 'region', '2015-01-19 15:59:00', '1', '', '370300', null, '1587', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桓台县');
INSERT INTO `systemctl_location_info` VALUES ('1588', 'GQX', 'insert', '高青县', '370322', 'region', '2015-01-19 15:59:00', '1', '', '370300', null, '1588', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高青县');
INSERT INTO `systemctl_location_info` VALUES ('1589', 'YYX', 'insert', '沂源县', '370323', 'region', '2015-01-19 15:59:00', '1', '', '370300', null, '1589', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沂源县');
INSERT INTO `systemctl_location_info` VALUES ('1590', 'ZZS', 'insert', '枣庄市', '370400', 'city', '2015-01-19 15:59:00', '1', '117.279305,34.807883', '370000', null, '1590', '2015-01-19 15:59:00', 'system', 'A', '鲁D', '13', '', '枣庄市');
INSERT INTO `systemctl_location_info` VALUES ('1591', 'SZQ', 'insert', '市中区', '370402', 'region', '2015-01-19 15:59:00', '1', '', '370400', null, '1591', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '市中区');
INSERT INTO `systemctl_location_info` VALUES ('1592', 'XCQ', 'insert', '薛城区', '370403', 'region', '2015-01-19 15:59:00', '1', '', '370400', null, '1592', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '薛城区');
INSERT INTO `systemctl_location_info` VALUES ('1593', 'YCQ', 'insert', '峄城区', '370404', 'region', '2015-01-19 15:59:00', '1', '', '370400', null, '1593', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '峄城区');
INSERT INTO `systemctl_location_info` VALUES ('1594', 'TEZQ', 'insert', '台儿庄区', '370405', 'region', '2015-01-19 15:59:00', '1', '', '370400', null, '1594', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台儿庄区');
INSERT INTO `systemctl_location_info` VALUES ('1595', 'STQ', 'insert', '山亭区', '370406', 'region', '2015-01-19 15:59:00', '1', '', '370400', null, '1595', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '山亭区');
INSERT INTO `systemctl_location_info` VALUES ('1596', 'TZS', 'insert', '滕州市', '370481', 'region', '2015-01-19 15:59:00', '1', '', '370400', null, '1596', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滕州市');
INSERT INTO `systemctl_location_info` VALUES ('1597', 'DYS', 'insert', '东营市', '370500', 'city', '2015-01-19 15:59:00', '1', '118.583926,37.487121', '370000', null, '1597', '2015-01-19 15:59:00', 'system', 'A', '鲁E', '12', '', '东营市');
INSERT INTO `systemctl_location_info` VALUES ('1598', 'DYQ', 'insert', '东营区', '370502', 'region', '2015-01-19 15:59:00', '1', '', '370500', null, '1598', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东营区');
INSERT INTO `systemctl_location_info` VALUES ('1599', 'HKQ', 'insert', '河口区', '370503', 'region', '2015-01-19 15:59:00', '1', '', '370500', null, '1599', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河口区');
INSERT INTO `systemctl_location_info` VALUES ('1600', 'KLX', 'insert', '垦利县', '370521', 'region', '2015-01-19 15:59:00', '1', '', '370500', null, '1600', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '垦利县');
INSERT INTO `systemctl_location_info` VALUES ('1601', 'LJX', 'insert', '利津县', '370522', 'region', '2015-01-19 15:59:00', '1', '', '370500', null, '1601', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '利津县');
INSERT INTO `systemctl_location_info` VALUES ('1602', 'GRX', 'insert', '广饶县', '370523', 'region', '2015-01-19 15:59:00', '1', '', '370500', null, '1602', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广饶县');
INSERT INTO `systemctl_location_info` VALUES ('1603', 'YTS', 'insert', '烟台市', '370600', 'city', '2015-01-19 15:59:00', '1', '121.309555,37.536562', '370000', null, '1603', '2015-01-19 15:59:00', 'system', 'A', '鲁F', '12', '', '烟台市');
INSERT INTO `systemctl_location_info` VALUES ('1604', 'ZFQ', 'insert', '芝罘区', '370602', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1604', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芝罘区');
INSERT INTO `systemctl_location_info` VALUES ('1605', 'FSQ', 'insert', '福山区', '370611', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1605', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '福山区');
INSERT INTO `systemctl_location_info` VALUES ('1606', 'MPQ', 'insert', '牟平区', '370612', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1606', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '牟平区');
INSERT INTO `systemctl_location_info` VALUES ('1607', 'LSQ', 'insert', '莱山区', '370613', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1607', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莱山区');
INSERT INTO `systemctl_location_info` VALUES ('1608', 'ZDX', 'insert', '长岛县', '370634', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1608', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长岛县');
INSERT INTO `systemctl_location_info` VALUES ('1609', 'LKS', 'insert', '龙口市', '370681', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1609', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙口市');
INSERT INTO `systemctl_location_info` VALUES ('1610', 'LYS', 'insert', '莱阳市', '370682', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1610', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莱阳市');
INSERT INTO `systemctl_location_info` VALUES ('1611', 'LZS', 'insert', '莱州市', '370683', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1611', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莱州市');
INSERT INTO `systemctl_location_info` VALUES ('1612', 'PLS', 'insert', '蓬莱市', '370684', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1612', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蓬莱市');
INSERT INTO `systemctl_location_info` VALUES ('1613', 'ZYS', 'insert', '招远市', '370685', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1613', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '招远市');
INSERT INTO `systemctl_location_info` VALUES ('1614', 'QXS', 'insert', '栖霞市', '370686', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1614', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '栖霞市');
INSERT INTO `systemctl_location_info` VALUES ('1615', 'HYS', 'insert', '海阳市', '370687', 'region', '2015-01-19 15:59:00', '1', '', '370600', null, '1615', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海阳市');
INSERT INTO `systemctl_location_info` VALUES ('1616', 'WFS', 'insert', '潍坊市', '370700', 'city', '2015-01-19 15:59:00', '1', '119.142634,36.716115', '370000', null, '1616', '2015-01-19 15:59:00', 'system', 'A', '鲁G', '12', '', '潍坊市');
INSERT INTO `systemctl_location_info` VALUES ('1617', 'WCQ', 'insert', '潍城区', '370702', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1617', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潍城区');
INSERT INTO `systemctl_location_info` VALUES ('1618', 'HTQ', 'insert', '寒亭区', '370703', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1618', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '寒亭区');
INSERT INTO `systemctl_location_info` VALUES ('1619', 'FZQ', 'insert', '坊子区', '370704', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1619', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '坊子区');
INSERT INTO `systemctl_location_info` VALUES ('1620', 'KWQ', 'insert', '奎文区', '370705', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1620', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '奎文区');
INSERT INTO `systemctl_location_info` VALUES ('1621', 'LQX', 'insert', '临朐县', '370724', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1621', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临朐县');
INSERT INTO `systemctl_location_info` VALUES ('1622', 'CLX', 'insert', '昌乐县', '370725', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1622', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌乐县');
INSERT INTO `systemctl_location_info` VALUES ('1623', 'QZS', 'insert', '青州市', '370781', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1623', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青州市');
INSERT INTO `systemctl_location_info` VALUES ('1624', 'ZCS', 'insert', '诸城市', '370782', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1624', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '诸城市');
INSERT INTO `systemctl_location_info` VALUES ('1625', 'SGS', 'insert', '寿光市', '370783', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1625', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '寿光市');
INSERT INTO `systemctl_location_info` VALUES ('1626', 'AQS', 'insert', '安丘市', '370784', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1626', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安丘市');
INSERT INTO `systemctl_location_info` VALUES ('1627', 'GMS', 'insert', '高密市', '370785', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1627', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高密市');
INSERT INTO `systemctl_location_info` VALUES ('1628', 'CYS', 'insert', '昌邑市', '370786', 'region', '2015-01-19 15:59:00', '1', '', '370700', null, '1628', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌邑市');
INSERT INTO `systemctl_location_info` VALUES ('1629', 'JNS', 'insert', '济宁市', '370800', 'city', '2015-01-19 15:59:00', '1', '116.600798,35.402122', '370000', null, '1629', '2015-01-19 15:59:00', 'system', 'A', '鲁H', '13', '', '济宁市');
INSERT INTO `systemctl_location_info` VALUES ('1630', 'SZQ', 'insert', '市中区', '370802', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1630', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '市中区');
INSERT INTO `systemctl_location_info` VALUES ('1631', 'RCQ', 'insert', '任城区', '370811', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1631', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '任城区');
INSERT INTO `systemctl_location_info` VALUES ('1632', 'WSX', 'insert', '微山县', '370826', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1632', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '微山县');
INSERT INTO `systemctl_location_info` VALUES ('1633', 'YTX', 'insert', '鱼台县', '370827', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1633', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鱼台县');
INSERT INTO `systemctl_location_info` VALUES ('1634', 'JXX', 'insert', '金乡县', '370828', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1634', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金乡县');
INSERT INTO `systemctl_location_info` VALUES ('1635', 'JXX', 'insert', '嘉祥县', '370829', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1635', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉祥县');
INSERT INTO `systemctl_location_info` VALUES ('1636', 'WSX', 'insert', '汶上县', '370830', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1636', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汶上县');
INSERT INTO `systemctl_location_info` VALUES ('1637', 'SSX', 'insert', '泗水县', '370831', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1637', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泗水县');
INSERT INTO `systemctl_location_info` VALUES ('1638', 'LSX', 'insert', '梁山县', '370832', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1638', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梁山县');
INSERT INTO `systemctl_location_info` VALUES ('1639', 'QFS', 'insert', '曲阜市', '370881', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1639', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曲阜市');
INSERT INTO `systemctl_location_info` VALUES ('1640', 'YZS', 'insert', '兖州市', '370882', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1640', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兖州市');
INSERT INTO `systemctl_location_info` VALUES ('1641', 'ZCS', 'insert', '邹城市', '370883', 'region', '2015-01-19 15:59:00', '1', '', '370800', null, '1641', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邹城市');
INSERT INTO `systemctl_location_info` VALUES ('1642', 'TAS', 'insert', '泰安市', '370900', 'city', '2015-01-19 15:59:00', '1', '117.089415,36.188078', '370000', null, '1642', '2015-01-19 15:59:00', 'system', 'A', '鲁J', '13', '', '泰安市');
INSERT INTO `systemctl_location_info` VALUES ('1643', 'TSQ', 'insert', '泰山区', '370902', 'region', '2015-01-19 15:59:00', '1', '', '370900', null, '1643', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泰山区');
INSERT INTO `systemctl_location_info` VALUES ('1644', 'DYQ', 'insert', '岱岳区', '370911', 'region', '2015-01-19 15:59:00', '1', '', '370900', null, '1644', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岱岳区');
INSERT INTO `systemctl_location_info` VALUES ('1645', 'NYX', 'insert', '宁阳县', '370921', 'region', '2015-01-19 15:59:00', '1', '', '370900', null, '1645', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁阳县');
INSERT INTO `systemctl_location_info` VALUES ('1646', 'DPX', 'insert', '东平县', '370923', 'region', '2015-01-19 15:59:00', '1', '', '370900', null, '1646', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东平县');
INSERT INTO `systemctl_location_info` VALUES ('1647', 'XTS', 'insert', '新泰市', '370982', 'region', '2015-01-19 15:59:00', '1', '', '370900', null, '1647', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新泰市');
INSERT INTO `systemctl_location_info` VALUES ('1648', 'FCS', 'insert', '肥城市', '370983', 'region', '2015-01-19 15:59:00', '1', '', '370900', null, '1648', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肥城市');
INSERT INTO `systemctl_location_info` VALUES ('1649', 'WHS', 'insert', '威海市', '371000', 'city', '2015-01-19 15:59:00', '1', '122.093958,37.528787', '370000', null, '1649', '2015-01-19 15:59:00', 'system', 'A', '鲁K', '13', '', '威海市');
INSERT INTO `systemctl_location_info` VALUES ('1650', 'HCQ', 'insert', '环翠区', '371002', 'region', '2015-01-19 15:59:00', '1', '', '371000', null, '1650', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '环翠区');
INSERT INTO `systemctl_location_info` VALUES ('1651', 'WDS', 'insert', '文登市', '371081', 'region', '2015-01-19 15:59:00', '1', '', '371000', null, '1651', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文登市');
INSERT INTO `systemctl_location_info` VALUES ('1652', 'RCS', 'insert', '荣成市', '371082', 'region', '2015-01-19 15:59:00', '1', '', '371000', null, '1652', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荣成市');
INSERT INTO `systemctl_location_info` VALUES ('1653', 'RSS', 'insert', '乳山市', '371083', 'region', '2015-01-19 15:59:00', '1', '', '371000', null, '1653', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乳山市');
INSERT INTO `systemctl_location_info` VALUES ('1654', 'RZS', 'insert', '日照市', '371100', 'city', '2015-01-19 15:59:00', '1', '119.50718,35.420225', '370000', null, '1654', '2015-01-19 15:59:00', 'system', 'A', '鲁L', '12', '', '日照市');
INSERT INTO `systemctl_location_info` VALUES ('1655', 'DGQ', 'insert', '东港区', '371102', 'region', '2015-01-19 15:59:00', '1', '', '371100', null, '1655', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东港区');
INSERT INTO `systemctl_location_info` VALUES ('1656', 'LSQ', 'insert', '岚山区', '371103', 'region', '2015-01-19 15:59:00', '1', '', '371100', null, '1656', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岚山区');
INSERT INTO `systemctl_location_info` VALUES ('1657', 'WLX', 'insert', '五莲县', '371121', 'region', '2015-01-19 15:59:00', '1', '', '371100', null, '1657', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五莲县');
INSERT INTO `systemctl_location_info` VALUES ('1658', 'JX', 'insert', '莒县', '371122', 'region', '2015-01-19 15:59:00', '1', '', '371100', null, '1658', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莒县');
INSERT INTO `systemctl_location_info` VALUES ('1659', 'LWS', 'insert', '莱芜市', '371200', 'city', '2015-01-19 15:59:00', '1', '117.684667,36.233654', '370000', null, '1659', '2015-01-19 15:59:00', 'system', 'A', '鲁S', '13', '', '莱芜市');
INSERT INTO `systemctl_location_info` VALUES ('1660', 'LCQ', 'insert', '莱城区', '371202', 'region', '2015-01-19 15:59:00', '1', '', '371200', null, '1660', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莱城区');
INSERT INTO `systemctl_location_info` VALUES ('1661', 'GCQ', 'insert', '钢城区', '371203', 'region', '2015-01-19 15:59:00', '1', '', '371200', null, '1661', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '钢城区');
INSERT INTO `systemctl_location_info` VALUES ('1662', 'LYS', 'insert', '临沂市', '371300', 'city', '2015-01-19 15:59:00', '1', '118.340768,35.072409', '370000', null, '1662', '2015-01-19 15:59:00', 'system', 'A', '鲁Q', '12', '', '临沂市');
INSERT INTO `systemctl_location_info` VALUES ('1663', 'LSQ', 'insert', '兰山区', '371302', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1663', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兰山区');
INSERT INTO `systemctl_location_info` VALUES ('1664', 'LZQ', 'insert', '罗庄区', '371311', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1664', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗庄区');
INSERT INTO `systemctl_location_info` VALUES ('1665', 'HDQ', 'insert', '河东区', '371312', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1665', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河东区');
INSERT INTO `systemctl_location_info` VALUES ('1666', 'YNX', 'insert', '沂南县', '371321', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1666', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沂南县');
INSERT INTO `systemctl_location_info` VALUES ('1667', 'TCX', 'insert', '郯城县', '371322', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1667', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郯城县');
INSERT INTO `systemctl_location_info` VALUES ('1668', 'YSX', 'insert', '沂水县', '371323', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1668', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沂水县');
INSERT INTO `systemctl_location_info` VALUES ('1669', 'CSX', 'insert', '苍山县', '371324', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1669', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苍山县');
INSERT INTO `systemctl_location_info` VALUES ('1670', 'FX', 'insert', '费县', '371325', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1670', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '费县');
INSERT INTO `systemctl_location_info` VALUES ('1671', 'PYX', 'insert', '平邑县', '371326', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1671', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平邑县');
INSERT INTO `systemctl_location_info` VALUES ('1672', 'JNX', 'insert', '莒南县', '371327', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1672', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莒南县');
INSERT INTO `systemctl_location_info` VALUES ('1673', 'MYX', 'insert', '蒙阴县', '371328', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1673', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蒙阴县');
INSERT INTO `systemctl_location_info` VALUES ('1674', 'LSX', 'insert', '临沭县', '371329', 'region', '2015-01-19 15:59:00', '1', '', '371300', null, '1674', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临沭县');
INSERT INTO `systemctl_location_info` VALUES ('1675', 'DZS', 'insert', '德州市', '371400', 'city', '2015-01-19 15:59:00', '1', '116.328161,37.460826', '370000', null, '1675', '2015-01-19 15:59:00', 'system', 'A', '鲁N', '12', '', '德州市');
INSERT INTO `systemctl_location_info` VALUES ('1676', 'DCQ', 'insert', '德城区', '371402', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1676', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德城区');
INSERT INTO `systemctl_location_info` VALUES ('1677', 'LX', 'insert', '陵县', '371421', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1677', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陵县');
INSERT INTO `systemctl_location_info` VALUES ('1678', 'NJX', 'insert', '宁津县', '371422', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1678', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁津县');
INSERT INTO `systemctl_location_info` VALUES ('1679', 'QYX', 'insert', '庆云县', '371423', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1679', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庆云县');
INSERT INTO `systemctl_location_info` VALUES ('1680', 'LYX', 'insert', '临邑县', '371424', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1680', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临邑县');
INSERT INTO `systemctl_location_info` VALUES ('1681', 'QHX', 'insert', '齐河县', '371425', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1681', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '齐河县');
INSERT INTO `systemctl_location_info` VALUES ('1682', 'PYX', 'insert', '平原县', '371426', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1682', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平原县');
INSERT INTO `systemctl_location_info` VALUES ('1683', 'XJX', 'insert', '夏津县', '371427', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1683', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '夏津县');
INSERT INTO `systemctl_location_info` VALUES ('1684', 'WCX', 'insert', '武城县', '371428', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1684', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武城县');
INSERT INTO `systemctl_location_info` VALUES ('1685', 'LLS', 'insert', '乐陵市', '371481', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1685', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐陵市');
INSERT INTO `systemctl_location_info` VALUES ('1686', 'YCS', 'insert', '禹城市', '371482', 'region', '2015-01-19 15:59:00', '1', '', '371400', null, '1686', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '禹城市');
INSERT INTO `systemctl_location_info` VALUES ('1687', 'LCS', 'insert', '聊城市', '371500', 'city', '2015-01-19 15:59:00', '1', '115.986869,36.455829', '370000', null, '1687', '2015-01-19 15:59:00', 'system', 'A', '鲁P', '12', '', '聊城市');
INSERT INTO `systemctl_location_info` VALUES ('1688', 'DCFQ', 'insert', '东昌府区', '371502', 'region', '2015-01-19 15:59:00', '1', '', '371500', null, '1688', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东昌府区');
INSERT INTO `systemctl_location_info` VALUES ('1689', 'YGX', 'insert', '阳谷县', '371521', 'region', '2015-01-19 15:59:00', '1', '', '371500', null, '1689', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳谷县');
INSERT INTO `systemctl_location_info` VALUES ('1690', 'XX', 'insert', '莘县', '371522', 'region', '2015-01-19 15:59:00', '1', '', '371500', null, '1690', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莘县');
INSERT INTO `systemctl_location_info` VALUES ('1691', 'CPX', 'insert', '茌平县', '371523', 'region', '2015-01-19 15:59:00', '1', '', '371500', null, '1691', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '茌平县');
INSERT INTO `systemctl_location_info` VALUES ('1692', 'DAX', 'insert', '东阿县', '371524', 'region', '2015-01-19 15:59:00', '1', '', '371500', null, '1692', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东阿县');
INSERT INTO `systemctl_location_info` VALUES ('1693', 'GX', 'insert', '冠县', '371525', 'region', '2015-01-19 15:59:00', '1', '', '371500', null, '1693', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '冠县');
INSERT INTO `systemctl_location_info` VALUES ('1694', 'GTX', 'insert', '高唐县', '371526', 'region', '2015-01-19 15:59:00', '1', '', '371500', null, '1694', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高唐县');
INSERT INTO `systemctl_location_info` VALUES ('1695', 'LQS', 'insert', '临清市', '371581', 'region', '2015-01-19 15:59:00', '1', '', '371500', null, '1695', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临清市');
INSERT INTO `systemctl_location_info` VALUES ('1696', 'BZS', 'insert', '滨州市', '371600', 'city', '2015-01-19 15:59:00', '1', '117.968292,37.405314', '370000', null, '1696', '2015-01-19 15:59:00', 'system', 'A', '鲁M', '12', '', '滨州市');
INSERT INTO `systemctl_location_info` VALUES ('1697', 'BCQ', 'insert', '滨城区', '371602', 'region', '2015-01-19 15:59:00', '1', '', '371600', null, '1697', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滨城区');
INSERT INTO `systemctl_location_info` VALUES ('1698', 'HMX', 'insert', '惠民县', '371621', 'region', '2015-01-19 15:59:00', '1', '', '371600', null, '1698', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠民县');
INSERT INTO `systemctl_location_info` VALUES ('1699', 'YXX', 'insert', '阳信县', '371622', 'region', '2015-01-19 15:59:00', '1', '', '371600', null, '1699', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳信县');
INSERT INTO `systemctl_location_info` VALUES ('1700', 'WDX', 'insert', '无棣县', '371623', 'region', '2015-01-19 15:59:00', '1', '', '371600', null, '1700', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '无棣县');
INSERT INTO `systemctl_location_info` VALUES ('1701', 'ZHX', 'insert', '沾化县', '371624', 'region', '2015-01-19 15:59:00', '1', '', '371600', null, '1701', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沾化县');
INSERT INTO `systemctl_location_info` VALUES ('1702', 'BXX', 'insert', '博兴县', '371625', 'region', '2015-01-19 15:59:00', '1', '', '371600', null, '1702', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博兴县');
INSERT INTO `systemctl_location_info` VALUES ('1703', 'ZPX', 'insert', '邹平县', '371626', 'region', '2015-01-19 15:59:00', '1', '', '371600', null, '1703', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邹平县');
INSERT INTO `systemctl_location_info` VALUES ('1704', 'HZS', 'insert', '菏泽市', '371700', 'city', '2015-01-19 15:59:00', '1', '115.46336,35.26244', '370000', null, '1704', '2015-01-19 15:59:00', 'system', 'A', '鲁R', '13', '', '菏泽市');
INSERT INTO `systemctl_location_info` VALUES ('1705', 'MDQ', 'insert', '牡丹区', '371702', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1705', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '牡丹区');
INSERT INTO `systemctl_location_info` VALUES ('1706', 'CX', 'insert', '曹县', '371721', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1706', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曹县');
INSERT INTO `systemctl_location_info` VALUES ('1707', 'DX', 'insert', '单县', '371722', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1707', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '单县');
INSERT INTO `systemctl_location_info` VALUES ('1708', 'CWX', 'insert', '成武县', '371723', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1708', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '成武县');
INSERT INTO `systemctl_location_info` VALUES ('1709', 'JYX', 'insert', '巨野县', '371724', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1709', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巨野县');
INSERT INTO `systemctl_location_info` VALUES ('1710', 'YCX', 'insert', '郓城县', '371725', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1710', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郓城县');
INSERT INTO `systemctl_location_info` VALUES ('1711', 'JCX', 'insert', '鄄城县', '371726', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1711', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄄城县');
INSERT INTO `systemctl_location_info` VALUES ('1712', 'DTX', 'insert', '定陶县', '371727', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1712', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定陶县');
INSERT INTO `systemctl_location_info` VALUES ('1713', 'DMX', 'insert', '东明县', '371728', 'region', '2015-01-19 15:59:00', '1', '', '371700', null, '1713', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东明县');
INSERT INTO `systemctl_location_info` VALUES ('1714', 'HNS', 'insert', '河南省', '410000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '1714', '2015-01-19 15:59:00', 'system', 'A', '豫', '', '', '河南省');
INSERT INTO `systemctl_location_info` VALUES ('1715', 'ZZS', 'insert', '郑州市', '410100', 'city', '2015-01-19 15:59:00', '1', '113.649644,34.75661', '410000', null, '1715', '2015-01-19 15:59:00', 'system', 'A', '豫A', '12', '', '郑州市');
INSERT INTO `systemctl_location_info` VALUES ('1716', 'ZYQ', 'insert', '中原区', '410102', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1716', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中原区');
INSERT INTO `systemctl_location_info` VALUES ('1717', 'EQQ', 'insert', '二七区', '410103', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1717', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '二七区');
INSERT INTO `systemctl_location_info` VALUES ('1718', 'GCHZQ', 'insert', '管城回族区', '410104', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1718', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '管城回族区');
INSERT INTO `systemctl_location_info` VALUES ('1719', 'JSQ', 'insert', '金水区', '410105', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1719', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金水区');
INSERT INTO `systemctl_location_info` VALUES ('1720', 'SJQ', 'insert', '上街区', '410106', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1720', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上街区');
INSERT INTO `systemctl_location_info` VALUES ('1721', 'HJQ', 'insert', '惠济区', '410108', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1721', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠济区');
INSERT INTO `systemctl_location_info` VALUES ('1722', 'ZMX', 'insert', '中牟县', '410122', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1722', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中牟县');
INSERT INTO `systemctl_location_info` VALUES ('1723', 'GYS', 'insert', '巩义市', '410181', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1723', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巩义市');
INSERT INTO `systemctl_location_info` VALUES ('1724', 'YYS', 'insert', '荥阳市', '410182', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1724', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荥阳市');
INSERT INTO `systemctl_location_info` VALUES ('1725', 'XMS', 'insert', '新密市', '410183', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1725', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新密市');
INSERT INTO `systemctl_location_info` VALUES ('1726', 'XZS', 'insert', '新郑市', '410184', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1726', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新郑市');
INSERT INTO `systemctl_location_info` VALUES ('1727', 'DFS', 'insert', '登封市', '410185', 'region', '2015-01-19 15:59:00', '1', '', '410100', null, '1727', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '登封市');
INSERT INTO `systemctl_location_info` VALUES ('1728', 'KFS', 'insert', '开封市', '410200', 'city', '2015-01-19 15:59:00', '1', '114.351642,34.801854', '410000', null, '1728', '2015-01-19 15:59:00', 'system', 'A', '豫B', '13', '', '开封市');
INSERT INTO `systemctl_location_info` VALUES ('1729', 'LTQ', 'insert', '龙亭区', '410202', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1729', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙亭区');
INSERT INTO `systemctl_location_info` VALUES ('1730', 'SHHZQ', 'insert', '顺河回族区', '410203', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1730', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '顺河回族区');
INSERT INTO `systemctl_location_info` VALUES ('1731', 'GLQ', 'insert', '鼓楼区', '410204', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1731', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鼓楼区');
INSERT INTO `systemctl_location_info` VALUES ('1732', 'YWTQ', 'insert', '禹王台区', '410205', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1732', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '禹王台区');
INSERT INTO `systemctl_location_info` VALUES ('1733', 'JMQ', 'insert', '金明区', '410211', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1733', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金明区');
INSERT INTO `systemctl_location_info` VALUES ('1734', 'QX', 'insert', '杞县', '410221', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1734', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杞县');
INSERT INTO `systemctl_location_info` VALUES ('1735', 'TXX', 'insert', '通许县', '410222', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1735', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通许县');
INSERT INTO `systemctl_location_info` VALUES ('1736', 'WSX', 'insert', '尉氏县', '410223', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1736', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尉氏县');
INSERT INTO `systemctl_location_info` VALUES ('1737', 'KFX', 'insert', '开封县', '410224', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1737', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开封县');
INSERT INTO `systemctl_location_info` VALUES ('1738', 'LKX', 'insert', '兰考县', '410225', 'region', '2015-01-19 15:59:00', '1', '', '410200', null, '1738', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兰考县');
INSERT INTO `systemctl_location_info` VALUES ('1739', 'LYS', 'insert', '洛阳市', '410300', 'city', '2015-01-19 15:59:00', '1', '112.447525,34.657368', '410000', null, '1739', '2015-01-19 15:59:00', 'system', 'A', '豫C', '12', '', '洛阳市');
INSERT INTO `systemctl_location_info` VALUES ('1740', 'LCQ', 'insert', '老城区', '410302', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1740', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '老城区');
INSERT INTO `systemctl_location_info` VALUES ('1741', 'XGQ', 'insert', '西工区', '410303', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1741', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西工区');
INSERT INTO `systemctl_location_info` VALUES ('1742', 'CHHZQ', 'insert', '瀍河回族区', '410304', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1742', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瀍河回族区');
INSERT INTO `systemctl_location_info` VALUES ('1743', 'JXQ', 'insert', '涧西区', '410305', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1743', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涧西区');
INSERT INTO `systemctl_location_info` VALUES ('1744', 'JLQ', 'insert', '吉利区', '410306', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1744', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉利区');
INSERT INTO `systemctl_location_info` VALUES ('1745', 'LLQ', 'insert', '洛龙区', '410311', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1745', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洛龙区');
INSERT INTO `systemctl_location_info` VALUES ('1746', 'MJX', 'insert', '孟津县', '410322', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1746', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '孟津县');
INSERT INTO `systemctl_location_info` VALUES ('1747', 'XAX', 'insert', '新安县', '410323', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1747', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新安县');
INSERT INTO `systemctl_location_info` VALUES ('1748', 'LCX', 'insert', '栾川县', '410324', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1748', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '栾川县');
INSERT INTO `systemctl_location_info` VALUES ('1749', 'SX', 'insert', '嵩县', '410325', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1749', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嵩县');
INSERT INTO `systemctl_location_info` VALUES ('1750', 'RYX', 'insert', '汝阳县', '410326', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1750', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汝阳县');
INSERT INTO `systemctl_location_info` VALUES ('1751', 'YYX', 'insert', '宜阳县', '410327', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1751', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜阳县');
INSERT INTO `systemctl_location_info` VALUES ('1752', 'LNX', 'insert', '洛宁县', '410328', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1752', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洛宁县');
INSERT INTO `systemctl_location_info` VALUES ('1753', 'YCX', 'insert', '伊川县', '410329', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1753', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伊川县');
INSERT INTO `systemctl_location_info` VALUES ('1754', 'YSS', 'insert', '偃师市', '410381', 'region', '2015-01-19 15:59:00', '1', '', '410300', null, '1754', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '偃师市');
INSERT INTO `systemctl_location_info` VALUES ('1755', 'PDSS', 'insert', '平顶山市', '410400', 'city', '2015-01-19 15:59:00', '1', '113.300849,33.745301', '410000', null, '1755', '2015-01-19 15:59:00', 'system', 'A', '豫D', '13', '', '平顶山市');
INSERT INTO `systemctl_location_info` VALUES ('1756', 'XHQ', 'insert', '新华区', '410402', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1756', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新华区');
INSERT INTO `systemctl_location_info` VALUES ('1757', 'WDQ', 'insert', '卫东区', '410403', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1757', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '卫东区');
INSERT INTO `systemctl_location_info` VALUES ('1758', 'SLQ', 'insert', '石龙区', '410404', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1758', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石龙区');
INSERT INTO `systemctl_location_info` VALUES ('1759', 'ZHQ', 'insert', '湛河区', '410411', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1759', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湛河区');
INSERT INTO `systemctl_location_info` VALUES ('1760', 'BFX', 'insert', '宝丰县', '410421', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1760', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝丰县');
INSERT INTO `systemctl_location_info` VALUES ('1761', 'YX', 'insert', '叶县', '410422', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1761', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '叶县');
INSERT INTO `systemctl_location_info` VALUES ('1762', 'LSX', 'insert', '鲁山县', '410423', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1762', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鲁山县');
INSERT INTO `systemctl_location_info` VALUES ('1763', 'JX', 'insert', '郏县', '410425', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1763', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郏县');
INSERT INTO `systemctl_location_info` VALUES ('1764', 'WGS', 'insert', '舞钢市', '410481', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1764', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '舞钢市');
INSERT INTO `systemctl_location_info` VALUES ('1765', 'RZS', 'insert', '汝州市', '410482', 'region', '2015-01-19 15:59:00', '1', '', '410400', null, '1765', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汝州市');
INSERT INTO `systemctl_location_info` VALUES ('1766', 'AYS', 'insert', '安阳市', '410500', 'city', '2015-01-19 15:59:00', '1', '114.351807,36.110267', '410000', null, '1766', '2015-01-19 15:59:00', 'system', 'A', '豫E', '12', '', '安阳市');
INSERT INTO `systemctl_location_info` VALUES ('1767', 'WFQ', 'insert', '文峰区', '410502', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1767', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文峰区');
INSERT INTO `systemctl_location_info` VALUES ('1768', 'BGQ', 'insert', '北关区', '410503', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1768', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北关区');
INSERT INTO `systemctl_location_info` VALUES ('1769', 'YDQ', 'insert', '殷都区', '410505', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1769', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '殷都区');
INSERT INTO `systemctl_location_info` VALUES ('1770', 'LAQ', 'insert', '龙安区', '410506', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1770', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙安区');
INSERT INTO `systemctl_location_info` VALUES ('1771', 'AYX', 'insert', '安阳县', '410522', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1771', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安阳县');
INSERT INTO `systemctl_location_info` VALUES ('1772', 'TYX', 'insert', '汤阴县', '410523', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1772', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汤阴县');
INSERT INTO `systemctl_location_info` VALUES ('1773', 'HX', 'insert', '滑县', '410526', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1773', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '滑县');
INSERT INTO `systemctl_location_info` VALUES ('1774', 'NHX', 'insert', '内黄县', '410527', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1774', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '内黄县');
INSERT INTO `systemctl_location_info` VALUES ('1775', 'LZS', 'insert', '林州市', '410581', 'region', '2015-01-19 15:59:00', '1', '', '410500', null, '1775', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '林州市');
INSERT INTO `systemctl_location_info` VALUES ('1776', 'HBS', 'insert', '鹤壁市', '410600', 'city', '2015-01-19 15:59:00', '1', '114.29777,35.755426', '410000', null, '1776', '2015-01-19 15:59:00', 'system', 'A', '豫F', '13', '', '鹤壁市');
INSERT INTO `systemctl_location_info` VALUES ('1777', 'HSQ', 'insert', '鹤山区', '410602', 'region', '2015-01-19 15:59:00', '1', '', '410600', null, '1777', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹤山区');
INSERT INTO `systemctl_location_info` VALUES ('1778', 'SCQ', 'insert', '山城区', '410603', 'region', '2015-01-19 15:59:00', '1', '', '410600', null, '1778', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '山城区');
INSERT INTO `systemctl_location_info` VALUES ('1779', 'QBQ', 'insert', '淇滨区', '410611', 'region', '2015-01-19 15:59:00', '1', '', '410600', null, '1779', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淇滨区');
INSERT INTO `systemctl_location_info` VALUES ('1780', 'JX', 'insert', '浚县', '410621', 'region', '2015-01-19 15:59:00', '1', '', '410600', null, '1780', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浚县');
INSERT INTO `systemctl_location_info` VALUES ('1781', 'QX', 'insert', '淇县', '410622', 'region', '2015-01-19 15:59:00', '1', '', '410600', null, '1781', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淇县');
INSERT INTO `systemctl_location_info` VALUES ('1782', 'XXS', 'insert', '新乡市', '410700', 'city', '2015-01-19 15:59:00', '1', '113.91269,35.307258', '410000', null, '1782', '2015-01-19 15:59:00', 'system', 'A', '豫G', '13', '', '新乡市');
INSERT INTO `systemctl_location_info` VALUES ('1783', 'HQQ', 'insert', '红旗区', '410702', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1783', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红旗区');
INSERT INTO `systemctl_location_info` VALUES ('1784', 'WBQ', 'insert', '卫滨区', '410703', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1784', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '卫滨区');
INSERT INTO `systemctl_location_info` VALUES ('1785', 'FQQ', 'insert', '凤泉区', '410704', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1785', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤泉区');
INSERT INTO `systemctl_location_info` VALUES ('1786', 'MYQ', 'insert', '牧野区', '410711', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1786', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '牧野区');
INSERT INTO `systemctl_location_info` VALUES ('1787', 'XXX', 'insert', '新乡县', '410721', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1787', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新乡县');
INSERT INTO `systemctl_location_info` VALUES ('1788', 'HJX', 'insert', '获嘉县', '410724', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1788', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '获嘉县');
INSERT INTO `systemctl_location_info` VALUES ('1789', 'YYX', 'insert', '原阳县', '410725', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1789', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '原阳县');
INSERT INTO `systemctl_location_info` VALUES ('1790', 'YJX', 'insert', '延津县', '410726', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1790', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '延津县');
INSERT INTO `systemctl_location_info` VALUES ('1791', 'FQX', 'insert', '封丘县', '410727', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1791', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '封丘县');
INSERT INTO `systemctl_location_info` VALUES ('1792', 'ZYX', 'insert', '长垣县', '410728', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1792', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长垣县');
INSERT INTO `systemctl_location_info` VALUES ('1793', 'WHS', 'insert', '卫辉市', '410781', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1793', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '卫辉市');
INSERT INTO `systemctl_location_info` VALUES ('1794', 'HXS', 'insert', '辉县市', '410782', 'region', '2015-01-19 15:59:00', '1', '', '410700', null, '1794', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '辉县市');
INSERT INTO `systemctl_location_info` VALUES ('1795', 'JZS', 'insert', '焦作市', '410800', 'city', '2015-01-19 15:59:00', '1', '113.211836,35.234608', '410000', null, '1795', '2015-01-19 15:59:00', 'system', 'A', '豫H', '13', '', '焦作市');
INSERT INTO `systemctl_location_info` VALUES ('1796', 'JFQ', 'insert', '解放区', '410802', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1796', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '解放区');
INSERT INTO `systemctl_location_info` VALUES ('1797', 'ZZQ', 'insert', '中站区', '410803', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1797', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中站区');
INSERT INTO `systemctl_location_info` VALUES ('1798', 'MCQ', 'insert', '马村区', '410804', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1798', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '马村区');
INSERT INTO `systemctl_location_info` VALUES ('1799', 'SYQ', 'insert', '山阳区', '410811', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1799', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '山阳区');
INSERT INTO `systemctl_location_info` VALUES ('1800', 'XWX', 'insert', '修武县', '410821', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1800', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '修武县');
INSERT INTO `systemctl_location_info` VALUES ('1801', 'BAX', 'insert', '博爱县', '410822', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1801', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博爱县');
INSERT INTO `systemctl_location_info` VALUES ('1802', 'WZX', 'insert', '武陟县', '410823', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1802', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武陟县');
INSERT INTO `systemctl_location_info` VALUES ('1803', 'WX', 'insert', '温县', '410825', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1803', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '温县');
INSERT INTO `systemctl_location_info` VALUES ('1804', 'QYS', 'insert', '沁阳市', '410882', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1804', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沁阳市');
INSERT INTO `systemctl_location_info` VALUES ('1805', 'MZS', 'insert', '孟州市', '410883', 'region', '2015-01-19 15:59:00', '1', '', '410800', null, '1805', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '孟州市');
INSERT INTO `systemctl_location_info` VALUES ('1806', 'PYS', 'insert', '濮阳市', '410900', 'city', '2015-01-19 15:59:00', '1', '115.026627,35.753298', '410000', null, '1806', '2015-01-19 15:59:00', 'system', 'A', '豫J', '12', '', '濮阳市');
INSERT INTO `systemctl_location_info` VALUES ('1807', 'HLQ', 'insert', '华龙区', '410902', 'region', '2015-01-19 15:59:00', '1', '', '410900', null, '1807', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华龙区');
INSERT INTO `systemctl_location_info` VALUES ('1808', 'QFX', 'insert', '清丰县', '410922', 'region', '2015-01-19 15:59:00', '1', '', '410900', null, '1808', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清丰县');
INSERT INTO `systemctl_location_info` VALUES ('1809', 'NLX', 'insert', '南乐县', '410923', 'region', '2015-01-19 15:59:00', '1', '', '410900', null, '1809', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南乐县');
INSERT INTO `systemctl_location_info` VALUES ('1810', 'FX', 'insert', '范县', '410926', 'region', '2015-01-19 15:59:00', '1', '', '410900', null, '1810', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '范县');
INSERT INTO `systemctl_location_info` VALUES ('1811', 'TQX', 'insert', '台前县', '410927', 'region', '2015-01-19 15:59:00', '1', '', '410900', null, '1811', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台前县');
INSERT INTO `systemctl_location_info` VALUES ('1812', 'PYX', 'insert', '濮阳县', '410928', 'region', '2015-01-19 15:59:00', '1', '', '410900', null, '1812', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '濮阳县');
INSERT INTO `systemctl_location_info` VALUES ('1813', 'XCS', 'insert', '许昌市', '411000', 'city', '2015-01-19 15:59:00', '1', '113.835312,34.02674', '410000', null, '1813', '2015-01-19 15:59:00', 'system', 'A', '豫K', '13', '', '许昌市');
INSERT INTO `systemctl_location_info` VALUES ('1814', 'WDQ', 'insert', '魏都区', '411002', 'region', '2015-01-19 15:59:00', '1', '', '411000', null, '1814', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '魏都区');
INSERT INTO `systemctl_location_info` VALUES ('1815', 'XCX', 'insert', '许昌县', '411023', 'region', '2015-01-19 15:59:00', '1', '', '411000', null, '1815', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '许昌县');
INSERT INTO `systemctl_location_info` VALUES ('1816', 'YLX', 'insert', '鄢陵县', '411024', 'region', '2015-01-19 15:59:00', '1', '', '411000', null, '1816', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄢陵县');
INSERT INTO `systemctl_location_info` VALUES ('1817', 'XCX', 'insert', '襄城县', '411025', 'region', '2015-01-19 15:59:00', '1', '', '411000', null, '1817', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '襄城县');
INSERT INTO `systemctl_location_info` VALUES ('1818', 'YZS', 'insert', '禹州市', '411081', 'region', '2015-01-19 15:59:00', '1', '', '411000', null, '1818', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '禹州市');
INSERT INTO `systemctl_location_info` VALUES ('1819', 'ZGS', 'insert', '长葛市', '411082', 'region', '2015-01-19 15:59:00', '1', '', '411000', null, '1819', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长葛市');
INSERT INTO `systemctl_location_info` VALUES ('1820', 'LHS', 'insert', '漯河市', '411100', 'city', '2015-01-19 15:59:00', '1', '114.046061,33.576279', '410000', null, '1820', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '漯河市');
INSERT INTO `systemctl_location_info` VALUES ('1821', 'YHQ', 'insert', '源汇区', '411102', 'region', '2015-01-19 15:59:00', '1', '', '411100', null, '1821', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '源汇区');
INSERT INTO `systemctl_location_info` VALUES ('1822', 'YCQ', 'insert', '郾城区', '411103', 'region', '2015-01-19 15:59:00', '1', '', '411100', null, '1822', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郾城区');
INSERT INTO `systemctl_location_info` VALUES ('1823', 'ZLQ', 'insert', '召陵区', '411104', 'region', '2015-01-19 15:59:00', '1', '', '411100', null, '1823', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '召陵区');
INSERT INTO `systemctl_location_info` VALUES ('1824', 'WYX', 'insert', '舞阳县', '411121', 'region', '2015-01-19 15:59:00', '1', '', '411100', null, '1824', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '舞阳县');
INSERT INTO `systemctl_location_info` VALUES ('1825', 'LYX', 'insert', '临颍县', '411122', 'region', '2015-01-19 15:59:00', '1', '', '411100', null, '1825', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临颍县');
INSERT INTO `systemctl_location_info` VALUES ('1826', 'SMXS', 'insert', '三门峡市', '411200', 'city', '2015-01-19 15:59:00', '1', '111.181262,34.78332', '410000', null, '1826', '2015-01-19 15:59:00', 'system', 'A', '豫M', '13', '', '三门峡市');
INSERT INTO `systemctl_location_info` VALUES ('1827', 'HBQ', 'insert', '湖滨区', '411202', 'region', '2015-01-19 15:59:00', '1', '', '411200', null, '1827', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湖滨区');
INSERT INTO `systemctl_location_info` VALUES ('1828', 'MCX', 'insert', '渑池县', '411221', 'region', '2015-01-19 15:59:00', '1', '', '411200', null, '1828', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '渑池县');
INSERT INTO `systemctl_location_info` VALUES ('1829', 'SX', 'insert', '陕县', '411222', 'region', '2015-01-19 15:59:00', '1', '', '411200', null, '1829', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陕县');
INSERT INTO `systemctl_location_info` VALUES ('1830', 'LSX', 'insert', '卢氏县', '411224', 'region', '2015-01-19 15:59:00', '1', '', '411200', null, '1830', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '卢氏县');
INSERT INTO `systemctl_location_info` VALUES ('1831', 'YMS', 'insert', '义马市', '411281', 'region', '2015-01-19 15:59:00', '1', '', '411200', null, '1831', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '义马市');
INSERT INTO `systemctl_location_info` VALUES ('1832', 'LBS', 'insert', '灵宝市', '411282', 'region', '2015-01-19 15:59:00', '1', '', '411200', null, '1832', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵宝市');
INSERT INTO `systemctl_location_info` VALUES ('1833', 'NYS', 'insert', '南阳市', '411300', 'city', '2015-01-19 15:59:00', '1', '112.542842,33.01142', '410000', null, '1833', '2015-01-19 15:59:00', 'system', 'A', '豫R', '13', '', '南阳市');
INSERT INTO `systemctl_location_info` VALUES ('1834', 'WCQ', 'insert', '宛城区', '411302', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1834', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宛城区');
INSERT INTO `systemctl_location_info` VALUES ('1835', 'WLQ', 'insert', '卧龙区', '411303', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1835', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '卧龙区');
INSERT INTO `systemctl_location_info` VALUES ('1836', 'NZX', 'insert', '南召县', '411321', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1836', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南召县');
INSERT INTO `systemctl_location_info` VALUES ('1837', 'FCX', 'insert', '方城县', '411322', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1837', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '方城县');
INSERT INTO `systemctl_location_info` VALUES ('1838', 'XXX', 'insert', '西峡县', '411323', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1838', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西峡县');
INSERT INTO `systemctl_location_info` VALUES ('1839', 'ZPX', 'insert', '镇平县', '411324', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1839', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇平县');
INSERT INTO `systemctl_location_info` VALUES ('1840', 'NXX', 'insert', '内乡县', '411325', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1840', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '内乡县');
INSERT INTO `systemctl_location_info` VALUES ('1841', 'XCX', 'insert', '淅川县', '411326', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1841', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淅川县');
INSERT INTO `systemctl_location_info` VALUES ('1842', 'SQX', 'insert', '社旗县', '411327', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1842', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '社旗县');
INSERT INTO `systemctl_location_info` VALUES ('1843', 'THX', 'insert', '唐河县', '411328', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1843', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '唐河县');
INSERT INTO `systemctl_location_info` VALUES ('1844', 'XYX', 'insert', '新野县', '411329', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1844', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新野县');
INSERT INTO `systemctl_location_info` VALUES ('1845', 'TBX', 'insert', '桐柏县', '411330', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1845', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桐柏县');
INSERT INTO `systemctl_location_info` VALUES ('1846', 'DZS', 'insert', '邓州市', '411381', 'region', '2015-01-19 15:59:00', '1', '', '411300', null, '1846', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邓州市');
INSERT INTO `systemctl_location_info` VALUES ('1847', 'SQS', 'insert', '商丘市', '411400', 'city', '2015-01-19 15:59:00', '1', '115.641886,34.438589', '410000', null, '1847', '2015-01-19 15:59:00', 'system', 'A', '豫N', '13', '', '商丘市');
INSERT INTO `systemctl_location_info` VALUES ('1848', 'LYQ', 'insert', '梁园区', '411402', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1848', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梁园区');
INSERT INTO `systemctl_location_info` VALUES ('1849', 'SYQ', 'insert', '睢阳区', '411403', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1849', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '睢阳区');
INSERT INTO `systemctl_location_info` VALUES ('1850', 'MQX', 'insert', '民权县', '411421', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1850', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '民权县');
INSERT INTO `systemctl_location_info` VALUES ('1851', 'SX', 'insert', '睢县', '411422', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1851', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '睢县');
INSERT INTO `systemctl_location_info` VALUES ('1852', 'NLX', 'insert', '宁陵县', '411423', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1852', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁陵县');
INSERT INTO `systemctl_location_info` VALUES ('1853', 'ZCX', 'insert', '柘城县', '411424', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1853', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柘城县');
INSERT INTO `systemctl_location_info` VALUES ('1854', 'YCX', 'insert', '虞城县', '411425', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1854', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '虞城县');
INSERT INTO `systemctl_location_info` VALUES ('1855', 'XYX', 'insert', '夏邑县', '411426', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1855', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '夏邑县');
INSERT INTO `systemctl_location_info` VALUES ('1856', 'YCS', 'insert', '永城市', '411481', 'region', '2015-01-19 15:59:00', '1', '', '411400', null, '1856', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永城市');
INSERT INTO `systemctl_location_info` VALUES ('1857', 'XYS', 'insert', '信阳市', '411500', 'city', '2015-01-19 15:59:00', '1', '114.085491,32.128582', '410000', null, '1857', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '信阳市');
INSERT INTO `systemctl_location_info` VALUES ('1858', 'SHQ', 'insert', '浉河区', '411502', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1858', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浉河区');
INSERT INTO `systemctl_location_info` VALUES ('1859', 'PQQ', 'insert', '平桥区', '411503', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1859', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平桥区');
INSERT INTO `systemctl_location_info` VALUES ('1860', 'LSX', 'insert', '罗山县', '411521', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1860', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗山县');
INSERT INTO `systemctl_location_info` VALUES ('1861', 'GSX', 'insert', '光山县', '411522', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1861', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '光山县');
INSERT INTO `systemctl_location_info` VALUES ('1862', 'XX', 'insert', '新县', '411523', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1862', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新县');
INSERT INTO `systemctl_location_info` VALUES ('1863', 'SCX', 'insert', '商城县', '411524', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1863', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '商城县');
INSERT INTO `systemctl_location_info` VALUES ('1864', 'GSX', 'insert', '固始县', '411525', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1864', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '固始县');
INSERT INTO `systemctl_location_info` VALUES ('1865', 'HCX', 'insert', '潢川县', '411526', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1865', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潢川县');
INSERT INTO `systemctl_location_info` VALUES ('1866', 'HBX', 'insert', '淮滨县', '411527', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1866', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淮滨县');
INSERT INTO `systemctl_location_info` VALUES ('1867', 'XX', 'insert', '息县', '411528', 'region', '2015-01-19 15:59:00', '1', '', '411500', null, '1867', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '息县');
INSERT INTO `systemctl_location_info` VALUES ('1868', 'ZKS', 'insert', '周口市', '411600', 'city', '2015-01-19 15:59:00', '1', '114.654102,33.623741', '410000', null, '1868', '2015-01-19 15:59:00', 'system', 'A', '豫P', '13', '', '周口市');
INSERT INTO `systemctl_location_info` VALUES ('1869', 'CHQ', 'insert', '川汇区', '411602', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1869', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '川汇区');
INSERT INTO `systemctl_location_info` VALUES ('1870', 'FGX', 'insert', '扶沟县', '411621', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1870', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扶沟县');
INSERT INTO `systemctl_location_info` VALUES ('1871', 'XHX', 'insert', '西华县', '411622', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1871', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西华县');
INSERT INTO `systemctl_location_info` VALUES ('1872', 'SSX', 'insert', '商水县', '411623', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1872', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '商水县');
INSERT INTO `systemctl_location_info` VALUES ('1873', 'SQX', 'insert', '沈丘县', '411624', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1873', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沈丘县');
INSERT INTO `systemctl_location_info` VALUES ('1874', 'DCX', 'insert', '郸城县', '411625', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1874', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郸城县');
INSERT INTO `systemctl_location_info` VALUES ('1875', 'HYX', 'insert', '淮阳县', '411626', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1875', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淮阳县');
INSERT INTO `systemctl_location_info` VALUES ('1876', 'TKX', 'insert', '太康县', '411627', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1876', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太康县');
INSERT INTO `systemctl_location_info` VALUES ('1877', 'LYX', 'insert', '鹿邑县', '411628', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1877', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹿邑县');
INSERT INTO `systemctl_location_info` VALUES ('1878', 'XCS', 'insert', '项城市', '411681', 'region', '2015-01-19 15:59:00', '1', '', '411600', null, '1878', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '项城市');
INSERT INTO `systemctl_location_info` VALUES ('1879', 'ZMDS', 'insert', '驻马店市', '411700', 'city', '2015-01-19 15:59:00', '1', '114.049154,32.983158', '410000', null, '1879', '2015-01-19 15:59:00', 'system', 'A', '豫Q', '13', '', '驻马店市');
INSERT INTO `systemctl_location_info` VALUES ('1880', 'YCQ', 'insert', '驿城区', '411702', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1880', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '驿城区');
INSERT INTO `systemctl_location_info` VALUES ('1881', 'XPX', 'insert', '西平县', '411721', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1881', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西平县');
INSERT INTO `systemctl_location_info` VALUES ('1882', 'SCX', 'insert', '上蔡县', '411722', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1882', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上蔡县');
INSERT INTO `systemctl_location_info` VALUES ('1883', 'PYX', 'insert', '平舆县', '411723', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1883', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平舆县');
INSERT INTO `systemctl_location_info` VALUES ('1884', 'ZYX', 'insert', '正阳县', '411724', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1884', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '正阳县');
INSERT INTO `systemctl_location_info` VALUES ('1885', 'QSX', 'insert', '确山县', '411725', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1885', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '确山县');
INSERT INTO `systemctl_location_info` VALUES ('1886', 'MYX', 'insert', '泌阳县', '411726', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1886', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泌阳县');
INSERT INTO `systemctl_location_info` VALUES ('1887', 'RNX', 'insert', '汝南县', '411727', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1887', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汝南县');
INSERT INTO `systemctl_location_info` VALUES ('1888', 'SPX', 'insert', '遂平县', '411728', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1888', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '遂平县');
INSERT INTO `systemctl_location_info` VALUES ('1889', 'XCX', 'insert', '新蔡县', '411729', 'region', '2015-01-19 15:59:00', '1', '', '411700', null, '1889', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新蔡县');
INSERT INTO `systemctl_location_info` VALUES ('1890', 'SZX', 'insert', '省直辖', '419000', 'city', '2015-01-19 15:59:00', '1', '', '410000', null, '1890', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '省直辖');
INSERT INTO `systemctl_location_info` VALUES ('1891', 'JYS', 'insert', '济源市', '419001', 'region', '2015-01-19 15:59:00', '1', '', '419000', null, '1891', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '济源市');
INSERT INTO `systemctl_location_info` VALUES ('1892', 'HBS', 'insert', '湖北省', '420000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '1892', '2015-01-19 15:59:00', 'system', 'A', '鄂', '', '', '湖北省');
INSERT INTO `systemctl_location_info` VALUES ('1893', 'WHS', 'insert', '武汉市', '420100', 'city', '2015-01-19 15:59:00', '1', '114.3162,30.581084', '420000', null, '1893', '2015-01-19 15:59:00', 'system', 'A', '鄂A', '12', '', '武汉市');
INSERT INTO `systemctl_location_info` VALUES ('1894', 'JAQ', 'insert', '江岸区', '420102', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1894', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江岸区');
INSERT INTO `systemctl_location_info` VALUES ('1895', 'JHQ', 'insert', '江汉区', '420103', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1895', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江汉区');
INSERT INTO `systemctl_location_info` VALUES ('1896', 'QKQ', 'insert', '硚口区', '420104', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1896', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '硚口区');
INSERT INTO `systemctl_location_info` VALUES ('1897', 'HYQ', 'insert', '汉阳区', '420105', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1897', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汉阳区');
INSERT INTO `systemctl_location_info` VALUES ('1898', 'WCQ', 'insert', '武昌区', '420106', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1898', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武昌区');
INSERT INTO `systemctl_location_info` VALUES ('1899', 'QSQ', 'insert', '青山区', '420107', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1899', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青山区');
INSERT INTO `systemctl_location_info` VALUES ('1900', 'HSQ', 'insert', '洪山区', '420111', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1900', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洪山区');
INSERT INTO `systemctl_location_info` VALUES ('1901', 'DXHQ', 'insert', '东西湖区', '420112', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1901', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东西湖区');
INSERT INTO `systemctl_location_info` VALUES ('1902', 'HNQ', 'insert', '汉南区', '420113', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1902', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汉南区');
INSERT INTO `systemctl_location_info` VALUES ('1903', 'CDQ', 'insert', '蔡甸区', '420114', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1903', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蔡甸区');
INSERT INTO `systemctl_location_info` VALUES ('1904', 'JXQ', 'insert', '江夏区', '420115', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1904', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江夏区');
INSERT INTO `systemctl_location_info` VALUES ('1905', 'HPQ', 'insert', '黄陂区', '420116', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1905', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄陂区');
INSERT INTO `systemctl_location_info` VALUES ('1906', 'XZQ', 'insert', '新洲区', '420117', 'region', '2015-01-19 15:59:00', '1', '', '420100', null, '1906', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新洲区');
INSERT INTO `systemctl_location_info` VALUES ('1907', 'HSS', 'insert', '黄石市', '420200', 'city', '2015-01-19 15:59:00', '1', '115.050683,30.216127', '420000', null, '1907', '2015-01-19 15:59:00', 'system', 'A', '鄂B', '13', '', '黄石市');
INSERT INTO `systemctl_location_info` VALUES ('1908', 'HSGQ', 'insert', '黄石港区', '420202', 'region', '2015-01-19 15:59:00', '1', '', '420200', null, '1908', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄石港区');
INSERT INTO `systemctl_location_info` VALUES ('1909', 'XSSQ', 'insert', '西塞山区', '420203', 'region', '2015-01-19 15:59:00', '1', '', '420200', null, '1909', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西塞山区');
INSERT INTO `systemctl_location_info` VALUES ('1910', 'XLQ', 'insert', '下陆区', '420204', 'region', '2015-01-19 15:59:00', '1', '', '420200', null, '1910', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '下陆区');
INSERT INTO `systemctl_location_info` VALUES ('1911', 'TSQ', 'insert', '铁山区', '420205', 'region', '2015-01-19 15:59:00', '1', '', '420200', null, '1911', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁山区');
INSERT INTO `systemctl_location_info` VALUES ('1912', 'YXX', 'insert', '阳新县', '420222', 'region', '2015-01-19 15:59:00', '1', '', '420200', null, '1912', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳新县');
INSERT INTO `systemctl_location_info` VALUES ('1913', 'DYS', 'insert', '大冶市', '420281', 'region', '2015-01-19 15:59:00', '1', '', '420200', null, '1913', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大冶市');
INSERT INTO `systemctl_location_info` VALUES ('1914', 'SYS', 'insert', '十堰市', '420300', 'city', '2015-01-19 15:59:00', '1', '110.801229,32.636994', '420000', null, '1914', '2015-01-19 15:59:00', 'system', 'A', '鄂C', '13', '', '十堰市');
INSERT INTO `systemctl_location_info` VALUES ('1915', 'MJQ', 'insert', '茅箭区', '420302', 'region', '2015-01-19 15:59:00', '1', '', '420300', null, '1915', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '茅箭区');
INSERT INTO `systemctl_location_info` VALUES ('1916', 'ZWQ', 'insert', '张湾区', '420303', 'region', '2015-01-19 15:59:00', '1', '', '420300', null, '1916', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '张湾区');
INSERT INTO `systemctl_location_info` VALUES ('1917', 'YX', 'insert', '郧县', '420321', 'region', '2015-01-19 15:59:00', '1', '', '420300', null, '1917', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郧县');
INSERT INTO `systemctl_location_info` VALUES ('1918', 'YXX', 'insert', '郧西县', '420322', 'region', '2015-01-19 15:59:00', '1', '', '420300', null, '1918', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郧西县');
INSERT INTO `systemctl_location_info` VALUES ('1919', 'ZSX', 'insert', '竹山县', '420323', 'region', '2015-01-19 15:59:00', '1', '', '420300', null, '1919', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '竹山县');
INSERT INTO `systemctl_location_info` VALUES ('1920', 'ZXX', 'insert', '竹溪县', '420324', 'region', '2015-01-19 15:59:00', '1', '', '420300', null, '1920', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '竹溪县');
INSERT INTO `systemctl_location_info` VALUES ('1921', 'FX', 'insert', '房县', '420325', 'region', '2015-01-19 15:59:00', '1', '', '420300', null, '1921', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '房县');
INSERT INTO `systemctl_location_info` VALUES ('1922', 'DJKS', 'insert', '丹江口市', '420381', 'region', '2015-01-19 15:59:00', '1', '', '420300', null, '1922', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丹江口市');
INSERT INTO `systemctl_location_info` VALUES ('1923', 'YCS', 'insert', '宜昌市', '420500', 'city', '2015-01-19 15:59:00', '1', '111.310981,30.732758', '420000', null, '1923', '2015-01-19 15:59:00', 'system', 'A', '鄂E', '13', '', '宜昌市');
INSERT INTO `systemctl_location_info` VALUES ('1924', 'XLQ', 'insert', '西陵区', '420502', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1924', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西陵区');
INSERT INTO `systemctl_location_info` VALUES ('1925', 'WJGQ', 'insert', '伍家岗区', '420503', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1925', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伍家岗区');
INSERT INTO `systemctl_location_info` VALUES ('1926', 'DJQ', 'insert', '点军区', '420504', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1926', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '点军区');
INSERT INTO `systemctl_location_info` VALUES ('1927', 'YTQ', 'insert', '猇亭区', '420505', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1927', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '猇亭区');
INSERT INTO `systemctl_location_info` VALUES ('1928', 'YLQ', 'insert', '夷陵区', '420506', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1928', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '夷陵区');
INSERT INTO `systemctl_location_info` VALUES ('1929', 'YAX', 'insert', '远安县', '420525', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1929', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '远安县');
INSERT INTO `systemctl_location_info` VALUES ('1930', 'XSX', 'insert', '兴山县', '420526', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1930', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴山县');
INSERT INTO `systemctl_location_info` VALUES ('1931', 'ZGX', 'insert', '秭归县', '420527', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1931', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秭归县');
INSERT INTO `systemctl_location_info` VALUES ('1932', 'ZYTJZZZX', 'insert', '长阳土家族自治县', '420528', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1932', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长阳土家族自治县');
INSERT INTO `systemctl_location_info` VALUES ('1933', 'WFTJZZZX', 'insert', '五峰土家族自治县', '420529', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1933', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五峰土家族自治县');
INSERT INTO `systemctl_location_info` VALUES ('1934', 'YDS', 'insert', '宜都市', '420581', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1934', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜都市');
INSERT INTO `systemctl_location_info` VALUES ('1935', 'DYS', 'insert', '当阳市', '420582', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1935', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '当阳市');
INSERT INTO `systemctl_location_info` VALUES ('1936', 'ZJS', 'insert', '枝江市', '420583', 'region', '2015-01-19 15:59:00', '1', '', '420500', null, '1936', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '枝江市');
INSERT INTO `systemctl_location_info` VALUES ('1937', 'XYS', 'insert', '襄阳市', '420600', 'city', '2015-01-19 15:59:00', '1', '112.176326,32.094934', '420000', null, '1937', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '襄阳市');
INSERT INTO `systemctl_location_info` VALUES ('1938', 'XCQ', 'insert', '襄城区', '420602', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1938', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '襄城区');
INSERT INTO `systemctl_location_info` VALUES ('1939', 'FCQ', 'insert', '樊城区', '420606', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1939', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '樊城区');
INSERT INTO `systemctl_location_info` VALUES ('1940', 'XZQ', 'insert', '襄州区', '420607', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1940', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '襄州区');
INSERT INTO `systemctl_location_info` VALUES ('1941', 'NZX', 'insert', '南漳县', '420624', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1941', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南漳县');
INSERT INTO `systemctl_location_info` VALUES ('1942', 'GCX', 'insert', '谷城县', '420625', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1942', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '谷城县');
INSERT INTO `systemctl_location_info` VALUES ('1943', 'BKX', 'insert', '保康县', '420626', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1943', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '保康县');
INSERT INTO `systemctl_location_info` VALUES ('1944', 'LHKS', 'insert', '老河口市', '420682', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1944', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '老河口市');
INSERT INTO `systemctl_location_info` VALUES ('1945', 'ZYS', 'insert', '枣阳市', '420683', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1945', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '枣阳市');
INSERT INTO `systemctl_location_info` VALUES ('1946', 'YCS', 'insert', '宜城市', '420684', 'region', '2015-01-19 15:59:00', '1', '', '420600', null, '1946', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜城市');
INSERT INTO `systemctl_location_info` VALUES ('1947', 'EZS', 'insert', '鄂州市', '420700', 'city', '2015-01-19 15:59:00', '1', '114.895594,30.384439', '420000', null, '1947', '2015-01-19 15:59:00', 'system', 'A', '鄂G', '14', '', '鄂州市');
INSERT INTO `systemctl_location_info` VALUES ('1948', 'LZHQ', 'insert', '梁子湖区', '420702', 'region', '2015-01-19 15:59:00', '1', '', '420700', null, '1948', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梁子湖区');
INSERT INTO `systemctl_location_info` VALUES ('1949', 'HRQ', 'insert', '华容区', '420703', 'region', '2015-01-19 15:59:00', '1', '', '420700', null, '1949', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华容区');
INSERT INTO `systemctl_location_info` VALUES ('1950', 'ECQ', 'insert', '鄂城区', '420704', 'region', '2015-01-19 15:59:00', '1', '', '420700', null, '1950', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄂城区');
INSERT INTO `systemctl_location_info` VALUES ('1951', 'JMS', 'insert', '荆门市', '420800', 'city', '2015-01-19 15:59:00', '1', '112.21733,31.042611', '420000', null, '1951', '2015-01-19 15:59:00', 'system', 'A', '鄂H', '13', '', '荆门市');
INSERT INTO `systemctl_location_info` VALUES ('1952', 'DBQ', 'insert', '东宝区', '420802', 'region', '2015-01-19 15:59:00', '1', '', '420800', null, '1952', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东宝区');
INSERT INTO `systemctl_location_info` VALUES ('1953', 'DDQ', 'insert', '掇刀区', '420804', 'region', '2015-01-19 15:59:00', '1', '', '420800', null, '1953', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '掇刀区');
INSERT INTO `systemctl_location_info` VALUES ('1954', 'JSX', 'insert', '京山县', '420821', 'region', '2015-01-19 15:59:00', '1', '', '420800', null, '1954', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '京山县');
INSERT INTO `systemctl_location_info` VALUES ('1955', 'SYX', 'insert', '沙洋县', '420822', 'region', '2015-01-19 15:59:00', '1', '', '420800', null, '1955', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙洋县');
INSERT INTO `systemctl_location_info` VALUES ('1956', 'ZXS', 'insert', '钟祥市', '420881', 'region', '2015-01-19 15:59:00', '1', '', '420800', null, '1956', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '钟祥市');
INSERT INTO `systemctl_location_info` VALUES ('1957', 'XGS', 'insert', '孝感市', '420900', 'city', '2015-01-19 15:59:00', '1', '113.935734,30.927955', '420000', null, '1957', '2015-01-19 15:59:00', 'system', 'A', '鄂K', '13', '', '孝感市');
INSERT INTO `systemctl_location_info` VALUES ('1958', 'XNQ', 'insert', '孝南区', '420902', 'region', '2015-01-19 15:59:00', '1', '', '420900', null, '1958', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '孝南区');
INSERT INTO `systemctl_location_info` VALUES ('1959', 'XCX', 'insert', '孝昌县', '420921', 'region', '2015-01-19 15:59:00', '1', '', '420900', null, '1959', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '孝昌县');
INSERT INTO `systemctl_location_info` VALUES ('1960', 'DWX', 'insert', '大悟县', '420922', 'region', '2015-01-19 15:59:00', '1', '', '420900', null, '1960', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大悟县');
INSERT INTO `systemctl_location_info` VALUES ('1961', 'YMX', 'insert', '云梦县', '420923', 'region', '2015-01-19 15:59:00', '1', '', '420900', null, '1961', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云梦县');
INSERT INTO `systemctl_location_info` VALUES ('1962', 'YCS', 'insert', '应城市', '420981', 'region', '2015-01-19 15:59:00', '1', '', '420900', null, '1962', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '应城市');
INSERT INTO `systemctl_location_info` VALUES ('1963', 'ALS', 'insert', '安陆市', '420982', 'region', '2015-01-19 15:59:00', '1', '', '420900', null, '1963', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安陆市');
INSERT INTO `systemctl_location_info` VALUES ('1964', 'HCS', 'insert', '汉川市', '420984', 'region', '2015-01-19 15:59:00', '1', '', '420900', null, '1964', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汉川市');
INSERT INTO `systemctl_location_info` VALUES ('1965', 'JZS', 'insert', '荆州市', '421000', 'city', '2015-01-19 15:59:00', '1', '112.241866,30.332591', '420000', null, '1965', '2015-01-19 15:59:00', 'system', 'A', '鄂D', '12', '', '荆州市');
INSERT INTO `systemctl_location_info` VALUES ('1966', 'SSQ', 'insert', '沙市区', '421002', 'region', '2015-01-19 15:59:00', '1', '', '421000', null, '1966', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙市区');
INSERT INTO `systemctl_location_info` VALUES ('1967', 'JZQ', 'insert', '荆州区', '421003', 'region', '2015-01-19 15:59:00', '1', '', '421000', null, '1967', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荆州区');
INSERT INTO `systemctl_location_info` VALUES ('1968', 'GAX', 'insert', '公安县', '421022', 'region', '2015-01-19 15:59:00', '1', '', '421000', null, '1968', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '公安县');
INSERT INTO `systemctl_location_info` VALUES ('1969', 'JLX', 'insert', '监利县', '421023', 'region', '2015-01-19 15:59:00', '1', '', '421000', null, '1969', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '监利县');
INSERT INTO `systemctl_location_info` VALUES ('1970', 'JLX', 'insert', '江陵县', '421024', 'region', '2015-01-19 15:59:00', '1', '', '421000', null, '1970', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江陵县');
INSERT INTO `systemctl_location_info` VALUES ('1971', 'SSS', 'insert', '石首市', '421081', 'region', '2015-01-19 15:59:00', '1', '', '421000', null, '1971', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石首市');
INSERT INTO `systemctl_location_info` VALUES ('1972', 'HHS', 'insert', '洪湖市', '421083', 'region', '2015-01-19 15:59:00', '1', '', '421000', null, '1972', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洪湖市');
INSERT INTO `systemctl_location_info` VALUES ('1973', 'SZS', 'insert', '松滋市', '421087', 'region', '2015-01-19 15:59:00', '1', '', '421000', null, '1973', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松滋市');
INSERT INTO `systemctl_location_info` VALUES ('1974', 'HGS', 'insert', '黄冈市', '421100', 'city', '2015-01-19 15:59:00', '1', '114.906618,30.446109', '420000', null, '1974', '2015-01-19 15:59:00', 'system', 'A', '鄂J', '14', '', '黄冈市');
INSERT INTO `systemctl_location_info` VALUES ('1975', 'HZQ', 'insert', '黄州区', '421102', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1975', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄州区');
INSERT INTO `systemctl_location_info` VALUES ('1976', 'TFX', 'insert', '团风县', '421121', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1976', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '团风县');
INSERT INTO `systemctl_location_info` VALUES ('1977', 'HAX', 'insert', '红安县', '421122', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1977', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红安县');
INSERT INTO `systemctl_location_info` VALUES ('1978', 'LTX', 'insert', '罗田县', '421123', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1978', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗田县');
INSERT INTO `systemctl_location_info` VALUES ('1979', 'YSX', 'insert', '英山县', '421124', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1979', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '英山县');
INSERT INTO `systemctl_location_info` VALUES ('1980', 'XSX', 'insert', '浠水县', '421125', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1980', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浠水县');
INSERT INTO `systemctl_location_info` VALUES ('1981', 'QCX', 'insert', '蕲春县', '421126', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1981', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蕲春县');
INSERT INTO `systemctl_location_info` VALUES ('1982', 'HMX', 'insert', '黄梅县', '421127', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1982', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄梅县');
INSERT INTO `systemctl_location_info` VALUES ('1983', 'MCS', 'insert', '麻城市', '421181', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1983', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麻城市');
INSERT INTO `systemctl_location_info` VALUES ('1984', 'WXS', 'insert', '武穴市', '421182', 'region', '2015-01-19 15:59:00', '1', '', '421100', null, '1984', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武穴市');
INSERT INTO `systemctl_location_info` VALUES ('1985', 'XNS', 'insert', '咸宁市', '421200', 'city', '2015-01-19 15:59:00', '1', '114.300061,29.880657', '420000', null, '1985', '2015-01-19 15:59:00', 'system', 'A', '鄂L', '13', '', '咸宁市');
INSERT INTO `systemctl_location_info` VALUES ('1986', 'XAQ', 'insert', '咸安区', '421202', 'region', '2015-01-19 15:59:00', '1', '', '421200', null, '1986', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '咸安区');
INSERT INTO `systemctl_location_info` VALUES ('1987', 'JYX', 'insert', '嘉鱼县', '421221', 'region', '2015-01-19 15:59:00', '1', '', '421200', null, '1987', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉鱼县');
INSERT INTO `systemctl_location_info` VALUES ('1988', 'TCX', 'insert', '通城县', '421222', 'region', '2015-01-19 15:59:00', '1', '', '421200', null, '1988', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通城县');
INSERT INTO `systemctl_location_info` VALUES ('1989', 'CYX', 'insert', '崇阳县', '421223', 'region', '2015-01-19 15:59:00', '1', '', '421200', null, '1989', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇阳县');
INSERT INTO `systemctl_location_info` VALUES ('1990', 'TSX', 'insert', '通山县', '421224', 'region', '2015-01-19 15:59:00', '1', '', '421200', null, '1990', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通山县');
INSERT INTO `systemctl_location_info` VALUES ('1991', 'CBS', 'insert', '赤壁市', '421281', 'region', '2015-01-19 15:59:00', '1', '', '421200', null, '1991', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赤壁市');
INSERT INTO `systemctl_location_info` VALUES ('1992', 'SZS', 'insert', '随州市', '421300', 'city', '2015-01-19 15:59:00', '1', '113.379358,31.717858', '420000', null, '1992', '2015-01-19 15:59:00', 'system', 'A', '鄂S', '13', '', '随州市');
INSERT INTO `systemctl_location_info` VALUES ('1993', 'CDQ', 'insert', '曾都区', '421303', 'region', '2015-01-19 15:59:00', '1', '', '421300', null, '1993', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曾都区');
INSERT INTO `systemctl_location_info` VALUES ('1994', 'SX', 'insert', '随县', '421321', 'region', '2015-01-19 15:59:00', '1', '', '421300', null, '1994', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '随县');
INSERT INTO `systemctl_location_info` VALUES ('1995', 'GSS', 'insert', '广水市', '421381', 'region', '2015-01-19 15:59:00', '1', '', '421300', null, '1995', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广水市');
INSERT INTO `systemctl_location_info` VALUES ('1996', 'ESTJZMZZZZ', 'insert', '恩施土家族苗族自治州', '422800', 'city', '2015-01-19 15:59:00', '1', '109.517433,30.308978', '420000', null, '1996', '2015-01-19 15:59:00', 'system', 'A', '鄂Q', '14', '', '恩施土家族苗族自治州');
INSERT INTO `systemctl_location_info` VALUES ('1997', 'ESS', 'insert', '恩施市', '422801', 'region', '2015-01-19 15:59:00', '1', '', '422800', null, '1997', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '恩施市');
INSERT INTO `systemctl_location_info` VALUES ('1998', 'LCS', 'insert', '利川市', '422802', 'region', '2015-01-19 15:59:00', '1', '', '422800', null, '1998', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '利川市');
INSERT INTO `systemctl_location_info` VALUES ('1999', 'JSX', 'insert', '建始县', '422822', 'region', '2015-01-19 15:59:00', '1', '', '422800', null, '1999', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建始县');
INSERT INTO `systemctl_location_info` VALUES ('2000', 'BDX', 'insert', '巴东县', '422823', 'region', '2015-01-19 15:59:00', '1', '', '422800', null, '2000', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴东县');
INSERT INTO `systemctl_location_info` VALUES ('2001', 'XEX', 'insert', '宣恩县', '422825', 'region', '2015-01-19 15:59:00', '1', '', '422800', null, '2001', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宣恩县');
INSERT INTO `systemctl_location_info` VALUES ('2002', 'XFX', 'insert', '咸丰县', '422826', 'region', '2015-01-19 15:59:00', '1', '', '422800', null, '2002', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '咸丰县');
INSERT INTO `systemctl_location_info` VALUES ('2003', 'LFX', 'insert', '来凤县', '422827', 'region', '2015-01-19 15:59:00', '1', '', '422800', null, '2003', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '来凤县');
INSERT INTO `systemctl_location_info` VALUES ('2004', 'HFX', 'insert', '鹤峰县', '422828', 'region', '2015-01-19 15:59:00', '1', '', '422800', null, '2004', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹤峰县');
INSERT INTO `systemctl_location_info` VALUES ('2005', 'SZX', 'insert', '省直辖', '429000', 'city', '2015-01-19 15:59:00', '1', '', '420000', null, '2005', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '省直辖');
INSERT INTO `systemctl_location_info` VALUES ('2006', 'XTS', 'insert', '仙桃市', '429004', 'region', '2015-01-19 15:59:00', '1', '', '429000', null, '2006', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仙桃市');
INSERT INTO `systemctl_location_info` VALUES ('2007', 'QJS', 'insert', '潜江市', '429005', 'region', '2015-01-19 15:59:00', '1', '', '429000', null, '2007', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潜江市');
INSERT INTO `systemctl_location_info` VALUES ('2008', 'TMS', 'insert', '天门市', '429006', 'region', '2015-01-19 15:59:00', '1', '', '429000', null, '2008', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天门市');
INSERT INTO `systemctl_location_info` VALUES ('2009', 'SNJLQ', 'insert', '神农架林区', '429021', 'region', '2015-01-19 15:59:00', '1', '', '429000', null, '2009', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '神农架林区');
INSERT INTO `systemctl_location_info` VALUES ('2010', 'HNS', 'insert', '湖南省', '430000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2010', '2015-01-19 15:59:00', 'system', 'A', '湘', '', '', '湖南省');
INSERT INTO `systemctl_location_info` VALUES ('2011', 'ZSS', 'insert', '长沙市', '430100', 'city', '2015-01-19 15:59:00', '1', '112.979353,28.213478', '430000', null, '2011', '2015-01-19 15:59:00', 'system', 'A', '湘A', '12', '', '长沙市');
INSERT INTO `systemctl_location_info` VALUES ('2012', 'FRQ', 'insert', '芙蓉区', '430102', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2012', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芙蓉区');
INSERT INTO `systemctl_location_info` VALUES ('2013', 'TXQ', 'insert', '天心区', '430103', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2013', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天心区');
INSERT INTO `systemctl_location_info` VALUES ('2014', 'YLQ', 'insert', '岳麓区', '430104', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2014', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岳麓区');
INSERT INTO `systemctl_location_info` VALUES ('2015', 'KFQ', 'insert', '开福区', '430105', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2015', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开福区');
INSERT INTO `systemctl_location_info` VALUES ('2016', 'YHQ', 'insert', '雨花区', '430111', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2016', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雨花区');
INSERT INTO `systemctl_location_info` VALUES ('2017', 'WCQ', 'insert', '望城区', '430112', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2017', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '望城区');
INSERT INTO `systemctl_location_info` VALUES ('2018', 'ZSX', 'insert', '长沙县', '430121', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2018', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长沙县');
INSERT INTO `systemctl_location_info` VALUES ('2019', 'NXX', 'insert', '宁乡县', '430124', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2019', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁乡县');
INSERT INTO `systemctl_location_info` VALUES ('2020', 'LYS', 'insert', '浏阳市', '430181', 'region', '2015-01-19 15:59:00', '1', '', '430100', null, '2020', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浏阳市');
INSERT INTO `systemctl_location_info` VALUES ('2021', 'ZZS', 'insert', '株洲市', '430200', 'city', '2015-01-19 15:59:00', '1', '113.131695,27.827433', '430000', null, '2021', '2015-01-19 15:59:00', 'system', 'A', '湘B', '13', '', '株洲市');
INSERT INTO `systemctl_location_info` VALUES ('2022', 'HTQ', 'insert', '荷塘区', '430202', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2022', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荷塘区');
INSERT INTO `systemctl_location_info` VALUES ('2023', 'LSQ', 'insert', '芦淞区', '430203', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2023', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芦淞区');
INSERT INTO `systemctl_location_info` VALUES ('2024', 'SFQ', 'insert', '石峰区', '430204', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2024', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石峰区');
INSERT INTO `systemctl_location_info` VALUES ('2025', 'TYQ', 'insert', '天元区', '430211', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2025', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天元区');
INSERT INTO `systemctl_location_info` VALUES ('2026', 'ZZX', 'insert', '株洲县', '430221', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2026', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '株洲县');
INSERT INTO `systemctl_location_info` VALUES ('2027', 'YX', 'insert', '攸县', '430223', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2027', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '攸县');
INSERT INTO `systemctl_location_info` VALUES ('2028', 'CLX', 'insert', '茶陵县', '430224', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2028', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '茶陵县');
INSERT INTO `systemctl_location_info` VALUES ('2029', 'YLX', 'insert', '炎陵县', '430225', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2029', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '炎陵县');
INSERT INTO `systemctl_location_info` VALUES ('2030', 'LLS', 'insert', '醴陵市', '430281', 'region', '2015-01-19 15:59:00', '1', '', '430200', null, '2030', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '醴陵市');
INSERT INTO `systemctl_location_info` VALUES ('2031', 'XTS', 'insert', '湘潭市', '430300', 'city', '2015-01-19 15:59:00', '1', '112.935556,27.835095', '430000', null, '2031', '2015-01-19 15:59:00', 'system', 'A', '湘C', '13', '', '湘潭市');
INSERT INTO `systemctl_location_info` VALUES ('2032', 'YHQ', 'insert', '雨湖区', '430302', 'region', '2015-01-19 15:59:00', '1', '', '430300', null, '2032', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雨湖区');
INSERT INTO `systemctl_location_info` VALUES ('2033', 'YTQ', 'insert', '岳塘区', '430304', 'region', '2015-01-19 15:59:00', '1', '', '430300', null, '2033', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岳塘区');
INSERT INTO `systemctl_location_info` VALUES ('2034', 'XTX', 'insert', '湘潭县', '430321', 'region', '2015-01-19 15:59:00', '1', '', '430300', null, '2034', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湘潭县');
INSERT INTO `systemctl_location_info` VALUES ('2035', 'XXS', 'insert', '湘乡市', '430381', 'region', '2015-01-19 15:59:00', '1', '', '430300', null, '2035', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湘乡市');
INSERT INTO `systemctl_location_info` VALUES ('2036', 'SSS', 'insert', '韶山市', '430382', 'region', '2015-01-19 15:59:00', '1', '', '430300', null, '2036', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '韶山市');
INSERT INTO `systemctl_location_info` VALUES ('2037', 'HYS', 'insert', '衡阳市', '430400', 'city', '2015-01-19 15:59:00', '1', '112.583819,26.898164', '430000', null, '2037', '2015-01-19 15:59:00', 'system', 'A', '湘D', '13', '', '衡阳市');
INSERT INTO `systemctl_location_info` VALUES ('2038', 'ZHQ', 'insert', '珠晖区', '430405', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2038', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '珠晖区');
INSERT INTO `systemctl_location_info` VALUES ('2039', 'YFQ', 'insert', '雁峰区', '430406', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2039', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雁峰区');
INSERT INTO `systemctl_location_info` VALUES ('2040', 'SGQ', 'insert', '石鼓区', '430407', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2040', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石鼓区');
INSERT INTO `systemctl_location_info` VALUES ('2041', 'ZXQ', 'insert', '蒸湘区', '430408', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2041', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蒸湘区');
INSERT INTO `systemctl_location_info` VALUES ('2042', 'NYQ', 'insert', '南岳区', '430412', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2042', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南岳区');
INSERT INTO `systemctl_location_info` VALUES ('2043', 'HYX', 'insert', '衡阳县', '430421', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2043', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '衡阳县');
INSERT INTO `systemctl_location_info` VALUES ('2044', 'HNX', 'insert', '衡南县', '430422', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2044', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '衡南县');
INSERT INTO `systemctl_location_info` VALUES ('2045', 'HSX', 'insert', '衡山县', '430423', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2045', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '衡山县');
INSERT INTO `systemctl_location_info` VALUES ('2046', 'HDX', 'insert', '衡东县', '430424', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2046', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '衡东县');
INSERT INTO `systemctl_location_info` VALUES ('2047', 'QDX', 'insert', '祁东县', '430426', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2047', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '祁东县');
INSERT INTO `systemctl_location_info` VALUES ('2048', 'LYS', 'insert', '耒阳市', '430481', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2048', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '耒阳市');
INSERT INTO `systemctl_location_info` VALUES ('2049', 'CNS', 'insert', '常宁市', '430482', 'region', '2015-01-19 15:59:00', '1', '', '430400', null, '2049', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '常宁市');
INSERT INTO `systemctl_location_info` VALUES ('2050', 'SYS', 'insert', '邵阳市', '430500', 'city', '2015-01-19 15:59:00', '1', '111.461525,27.236811', '430000', null, '2050', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '邵阳市');
INSERT INTO `systemctl_location_info` VALUES ('2051', 'SQQ', 'insert', '双清区', '430502', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2051', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双清区');
INSERT INTO `systemctl_location_info` VALUES ('2052', 'DXQ', 'insert', '大祥区', '430503', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2052', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大祥区');
INSERT INTO `systemctl_location_info` VALUES ('2053', 'BTQ', 'insert', '北塔区', '430511', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2053', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北塔区');
INSERT INTO `systemctl_location_info` VALUES ('2054', 'SDX', 'insert', '邵东县', '430521', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2054', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邵东县');
INSERT INTO `systemctl_location_info` VALUES ('2055', 'XSX', 'insert', '新邵县', '430522', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2055', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新邵县');
INSERT INTO `systemctl_location_info` VALUES ('2056', 'SYX', 'insert', '邵阳县', '430523', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2056', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邵阳县');
INSERT INTO `systemctl_location_info` VALUES ('2057', 'LHX', 'insert', '隆回县', '430524', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2057', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆回县');
INSERT INTO `systemctl_location_info` VALUES ('2058', 'DKX', 'insert', '洞口县', '430525', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2058', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洞口县');
INSERT INTO `systemctl_location_info` VALUES ('2059', 'SNX', 'insert', '绥宁县', '430527', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2059', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绥宁县');
INSERT INTO `systemctl_location_info` VALUES ('2060', 'XNX', 'insert', '新宁县', '430528', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2060', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新宁县');
INSERT INTO `systemctl_location_info` VALUES ('2061', 'CBMZZZX', 'insert', '城步苗族自治县', '430529', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2061', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城步苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2062', 'WGS', 'insert', '武冈市', '430581', 'region', '2015-01-19 15:59:00', '1', '', '430500', null, '2062', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武冈市');
INSERT INTO `systemctl_location_info` VALUES ('2063', 'YYS', 'insert', '岳阳市', '430600', 'city', '2015-01-19 15:59:00', '1', '113.146196,29.378007', '430000', null, '2063', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '岳阳市');
INSERT INTO `systemctl_location_info` VALUES ('2064', 'YYLQ', 'insert', '岳阳楼区', '430602', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2064', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岳阳楼区');
INSERT INTO `systemctl_location_info` VALUES ('2065', 'YXQ', 'insert', '云溪区', '430603', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2065', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云溪区');
INSERT INTO `systemctl_location_info` VALUES ('2066', 'JSQ', 'insert', '君山区', '430611', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2066', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '君山区');
INSERT INTO `systemctl_location_info` VALUES ('2067', 'YYX', 'insert', '岳阳县', '430621', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2067', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岳阳县');
INSERT INTO `systemctl_location_info` VALUES ('2068', 'HRX', 'insert', '华容县', '430623', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2068', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华容县');
INSERT INTO `systemctl_location_info` VALUES ('2069', 'XYX', 'insert', '湘阴县', '430624', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2069', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湘阴县');
INSERT INTO `systemctl_location_info` VALUES ('2070', 'PJX', 'insert', '平江县', '430626', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2070', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平江县');
INSERT INTO `systemctl_location_info` VALUES ('2071', 'MLS', 'insert', '汨罗市', '430681', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2071', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汨罗市');
INSERT INTO `systemctl_location_info` VALUES ('2072', 'LXS', 'insert', '临湘市', '430682', 'region', '2015-01-19 15:59:00', '1', '', '430600', null, '2072', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临湘市');
INSERT INTO `systemctl_location_info` VALUES ('2073', 'CDS', 'insert', '常德市', '430700', 'city', '2015-01-19 15:59:00', '1', '111.653718,29.012149', '430000', null, '2073', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '常德市');
INSERT INTO `systemctl_location_info` VALUES ('2074', 'WLQ', 'insert', '武陵区', '430702', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2074', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武陵区');
INSERT INTO `systemctl_location_info` VALUES ('2075', 'DCQ', 'insert', '鼎城区', '430703', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2075', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鼎城区');
INSERT INTO `systemctl_location_info` VALUES ('2076', 'AXX', 'insert', '安乡县', '430721', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2076', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安乡县');
INSERT INTO `systemctl_location_info` VALUES ('2077', 'HSX', 'insert', '汉寿县', '430722', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2077', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汉寿县');
INSERT INTO `systemctl_location_info` VALUES ('2078', 'LX', 'insert', '澧县', '430723', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2078', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澧县');
INSERT INTO `systemctl_location_info` VALUES ('2079', 'LLX', 'insert', '临澧县', '430724', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2079', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临澧县');
INSERT INTO `systemctl_location_info` VALUES ('2080', 'TYX', 'insert', '桃源县', '430725', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2080', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桃源县');
INSERT INTO `systemctl_location_info` VALUES ('2081', 'SMX', 'insert', '石门县', '430726', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2081', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石门县');
INSERT INTO `systemctl_location_info` VALUES ('2082', 'JSS', 'insert', '津市市', '430781', 'region', '2015-01-19 15:59:00', '1', '', '430700', null, '2082', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '津市市');
INSERT INTO `systemctl_location_info` VALUES ('2083', 'ZJJS', 'insert', '张家界市', '430800', 'city', '2015-01-19 15:59:00', '1', '110.48162,29.124889', '430000', null, '2083', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '张家界市');
INSERT INTO `systemctl_location_info` VALUES ('2084', 'YDQ', 'insert', '永定区', '430802', 'region', '2015-01-19 15:59:00', '1', '', '430800', null, '2084', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永定区');
INSERT INTO `systemctl_location_info` VALUES ('2085', 'WLYQ', 'insert', '武陵源区', '430811', 'region', '2015-01-19 15:59:00', '1', '', '430800', null, '2085', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武陵源区');
INSERT INTO `systemctl_location_info` VALUES ('2086', 'CLX', 'insert', '慈利县', '430821', 'region', '2015-01-19 15:59:00', '1', '', '430800', null, '2086', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '慈利县');
INSERT INTO `systemctl_location_info` VALUES ('2087', 'SZX', 'insert', '桑植县', '430822', 'region', '2015-01-19 15:59:00', '1', '', '430800', null, '2087', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桑植县');
INSERT INTO `systemctl_location_info` VALUES ('2088', 'YYS', 'insert', '益阳市', '430900', 'city', '2015-01-19 15:59:00', '1', '112.366547,28.588088', '430000', null, '2088', '2015-01-19 15:59:00', 'system', 'A', '湘H', '13', '', '益阳市');
INSERT INTO `systemctl_location_info` VALUES ('2089', 'ZYQ', 'insert', '资阳区', '430902', 'region', '2015-01-19 15:59:00', '1', '', '430900', null, '2089', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '资阳区');
INSERT INTO `systemctl_location_info` VALUES ('2090', 'HSQ', 'insert', '赫山区', '430903', 'region', '2015-01-19 15:59:00', '1', '', '430900', null, '2090', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赫山区');
INSERT INTO `systemctl_location_info` VALUES ('2091', 'NX', 'insert', '南县', '430921', 'region', '2015-01-19 15:59:00', '1', '', '430900', null, '2091', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南县');
INSERT INTO `systemctl_location_info` VALUES ('2092', 'TJX', 'insert', '桃江县', '430922', 'region', '2015-01-19 15:59:00', '1', '', '430900', null, '2092', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桃江县');
INSERT INTO `systemctl_location_info` VALUES ('2093', 'AHX', 'insert', '安化县', '430923', 'region', '2015-01-19 15:59:00', '1', '', '430900', null, '2093', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安化县');
INSERT INTO `systemctl_location_info` VALUES ('2094', 'YJS', 'insert', '沅江市', '430981', 'region', '2015-01-19 15:59:00', '1', '', '430900', null, '2094', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沅江市');
INSERT INTO `systemctl_location_info` VALUES ('2095', 'CZS', 'insert', '郴州市', '431000', 'city', '2015-01-19 15:59:00', '1', '113.037704,25.782264', '430000', null, '2095', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '郴州市');
INSERT INTO `systemctl_location_info` VALUES ('2096', 'BHQ', 'insert', '北湖区', '431002', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2096', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北湖区');
INSERT INTO `systemctl_location_info` VALUES ('2097', 'SXQ', 'insert', '苏仙区', '431003', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2097', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苏仙区');
INSERT INTO `systemctl_location_info` VALUES ('2098', 'GYX', 'insert', '桂阳县', '431021', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2098', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桂阳县');
INSERT INTO `systemctl_location_info` VALUES ('2099', 'YZX', 'insert', '宜章县', '431022', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2099', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜章县');
INSERT INTO `systemctl_location_info` VALUES ('2100', 'YXX', 'insert', '永兴县', '431023', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2100', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永兴县');
INSERT INTO `systemctl_location_info` VALUES ('2101', 'JHX', 'insert', '嘉禾县', '431024', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2101', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉禾县');
INSERT INTO `systemctl_location_info` VALUES ('2102', 'LWX', 'insert', '临武县', '431025', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2102', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临武县');
INSERT INTO `systemctl_location_info` VALUES ('2103', 'RCX', 'insert', '汝城县', '431026', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2103', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汝城县');
INSERT INTO `systemctl_location_info` VALUES ('2104', 'GDX', 'insert', '桂东县', '431027', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2104', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桂东县');
INSERT INTO `systemctl_location_info` VALUES ('2105', 'ARX', 'insert', '安仁县', '431028', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2105', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安仁县');
INSERT INTO `systemctl_location_info` VALUES ('2106', 'ZXS', 'insert', '资兴市', '431081', 'region', '2015-01-19 15:59:00', '1', '', '431000', null, '2106', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '资兴市');
INSERT INTO `systemctl_location_info` VALUES ('2107', 'YZS', 'insert', '永州市', '431100', 'city', '2015-01-19 15:59:00', '1', '111.614648,26.435972', '430000', null, '2107', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '永州市');
INSERT INTO `systemctl_location_info` VALUES ('2108', 'LLQ', 'insert', '零陵区', '431102', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2108', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '零陵区');
INSERT INTO `systemctl_location_info` VALUES ('2109', 'LSTQ', 'insert', '冷水滩区', '431103', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2109', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '冷水滩区');
INSERT INTO `systemctl_location_info` VALUES ('2110', 'QYX', 'insert', '祁阳县', '431121', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2110', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '祁阳县');
INSERT INTO `systemctl_location_info` VALUES ('2111', 'DAX', 'insert', '东安县', '431122', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2111', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东安县');
INSERT INTO `systemctl_location_info` VALUES ('2112', 'SPX', 'insert', '双牌县', '431123', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2112', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双牌县');
INSERT INTO `systemctl_location_info` VALUES ('2113', 'DX', 'insert', '道县', '431124', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2113', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '道县');
INSERT INTO `systemctl_location_info` VALUES ('2114', 'JYX', 'insert', '江永县', '431125', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2114', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江永县');
INSERT INTO `systemctl_location_info` VALUES ('2115', 'NYX', 'insert', '宁远县', '431126', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2115', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁远县');
INSERT INTO `systemctl_location_info` VALUES ('2116', 'LSX', 'insert', '蓝山县', '431127', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2116', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蓝山县');
INSERT INTO `systemctl_location_info` VALUES ('2117', 'XTX', 'insert', '新田县', '431128', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2117', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新田县');
INSERT INTO `systemctl_location_info` VALUES ('2118', 'JHYZZZX', 'insert', '江华瑶族自治县', '431129', 'region', '2015-01-19 15:59:00', '1', '', '431100', null, '2118', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江华瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2119', 'HHS', 'insert', '怀化市', '431200', 'city', '2015-01-19 15:59:00', '1', '109.986959,27.557483', '430000', null, '2119', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '怀化市');
INSERT INTO `systemctl_location_info` VALUES ('2120', 'HCQ', 'insert', '鹤城区', '431202', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2120', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹤城区');
INSERT INTO `systemctl_location_info` VALUES ('2121', 'ZFX', 'insert', '中方县', '431221', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2121', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中方县');
INSERT INTO `systemctl_location_info` VALUES ('2122', 'YLX', 'insert', '沅陵县', '431222', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2122', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沅陵县');
INSERT INTO `systemctl_location_info` VALUES ('2123', 'CXX', 'insert', '辰溪县', '431223', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2123', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '辰溪县');
INSERT INTO `systemctl_location_info` VALUES ('2124', 'XPX', 'insert', '溆浦县', '431224', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2124', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '溆浦县');
INSERT INTO `systemctl_location_info` VALUES ('2125', 'HTX', 'insert', '会同县', '431225', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2125', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '会同县');
INSERT INTO `systemctl_location_info` VALUES ('2126', 'MYMZZZX', 'insert', '麻阳苗族自治县', '431226', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2126', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麻阳苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2127', 'XHDZZZX', 'insert', '新晃侗族自治县', '431227', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2127', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新晃侗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2128', 'ZJDZZZX', 'insert', '芷江侗族自治县', '431228', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2128', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芷江侗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2129', 'JZMZDZZZX', 'insert', '靖州苗族侗族自治县', '431229', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2129', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '靖州苗族侗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2130', 'TDDZZZX', 'insert', '通道侗族自治县', '431230', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2130', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通道侗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2131', 'HJS', 'insert', '洪江市', '431281', 'region', '2015-01-19 15:59:00', '1', '', '431200', null, '2131', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洪江市');
INSERT INTO `systemctl_location_info` VALUES ('2132', 'LDS', 'insert', '娄底市', '431300', 'city', '2015-01-19 15:59:00', '1', '111.996396,27.741073', '430000', null, '2132', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '娄底市');
INSERT INTO `systemctl_location_info` VALUES ('2133', 'LXQ', 'insert', '娄星区', '431302', 'region', '2015-01-19 15:59:00', '1', '', '431300', null, '2133', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '娄星区');
INSERT INTO `systemctl_location_info` VALUES ('2134', 'SFX', 'insert', '双峰县', '431321', 'region', '2015-01-19 15:59:00', '1', '', '431300', null, '2134', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双峰县');
INSERT INTO `systemctl_location_info` VALUES ('2135', 'XHX', 'insert', '新化县', '431322', 'region', '2015-01-19 15:59:00', '1', '', '431300', null, '2135', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新化县');
INSERT INTO `systemctl_location_info` VALUES ('2136', 'LSJS', 'insert', '冷水江市', '431381', 'region', '2015-01-19 15:59:00', '1', '', '431300', null, '2136', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '冷水江市');
INSERT INTO `systemctl_location_info` VALUES ('2137', 'LYS', 'insert', '涟源市', '431382', 'region', '2015-01-19 15:59:00', '1', '', '431300', null, '2137', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涟源市');
INSERT INTO `systemctl_location_info` VALUES ('2138', 'XXTJZMZZZZ', 'insert', '湘西土家族苗族自治州', '433100', 'city', '2015-01-19 15:59:00', '1', '', '430000', null, '2138', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湘西土家族苗族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2139', 'JSS', 'insert', '吉首市', '433101', 'region', '2015-01-19 15:59:00', '1', '', '433100', null, '2139', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉首市');
INSERT INTO `systemctl_location_info` VALUES ('2140', 'LXX', 'insert', '泸溪县', '433122', 'region', '2015-01-19 15:59:00', '1', '', '433100', null, '2140', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泸溪县');
INSERT INTO `systemctl_location_info` VALUES ('2141', 'FHX', 'insert', '凤凰县', '433123', 'region', '2015-01-19 15:59:00', '1', '', '433100', null, '2141', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤凰县');
INSERT INTO `systemctl_location_info` VALUES ('2142', 'HYX', 'insert', '花垣县', '433124', 'region', '2015-01-19 15:59:00', '1', '', '433100', null, '2142', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '花垣县');
INSERT INTO `systemctl_location_info` VALUES ('2143', 'BJX', 'insert', '保靖县', '433125', 'region', '2015-01-19 15:59:00', '1', '', '433100', null, '2143', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '保靖县');
INSERT INTO `systemctl_location_info` VALUES ('2144', 'GZX', 'insert', '古丈县', '433126', 'region', '2015-01-19 15:59:00', '1', '', '433100', null, '2144', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古丈县');
INSERT INTO `systemctl_location_info` VALUES ('2145', 'YSX', 'insert', '永顺县', '433127', 'region', '2015-01-19 15:59:00', '1', '', '433100', null, '2145', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永顺县');
INSERT INTO `systemctl_location_info` VALUES ('2146', 'LSX', 'insert', '龙山县', '433130', 'region', '2015-01-19 15:59:00', '1', '', '433100', null, '2146', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙山县');
INSERT INTO `systemctl_location_info` VALUES ('2147', 'GDS', 'insert', '广东省', '440000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2147', '2015-01-19 15:59:00', 'system', 'A', '粤', '', '', '广东省');
INSERT INTO `systemctl_location_info` VALUES ('2148', 'GZS', 'insert', '广州市', '440100', 'city', '2015-01-19 15:59:00', '1', '113.30765,23.120049', '440000', null, '2148', '2015-01-19 15:59:00', 'system', 'A', '粤A', '12', '', '广州市');
INSERT INTO `systemctl_location_info` VALUES ('2149', 'LWQ', 'insert', '荔湾区', '440103', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2149', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荔湾区');
INSERT INTO `systemctl_location_info` VALUES ('2150', 'YXQ', 'insert', '越秀区', '440104', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2150', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '越秀区');
INSERT INTO `systemctl_location_info` VALUES ('2151', 'HZQ', 'insert', '海珠区', '440105', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2151', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海珠区');
INSERT INTO `systemctl_location_info` VALUES ('2152', 'THQ', 'insert', '天河区', '440106', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2152', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天河区');
INSERT INTO `systemctl_location_info` VALUES ('2153', 'BYQ', 'insert', '白云区', '440111', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2153', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白云区');
INSERT INTO `systemctl_location_info` VALUES ('2154', 'HPQ', 'insert', '黄埔区', '440112', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2154', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄埔区');
INSERT INTO `systemctl_location_info` VALUES ('2155', 'FYQ', 'insert', '番禺区', '440113', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2155', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '番禺区');
INSERT INTO `systemctl_location_info` VALUES ('2156', 'HDQ', 'insert', '花都区', '440114', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2156', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '花都区');
INSERT INTO `systemctl_location_info` VALUES ('2157', 'NSQ', 'insert', '南沙区', '440115', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2157', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南沙区');
INSERT INTO `systemctl_location_info` VALUES ('2158', 'LGQ', 'insert', '萝岗区', '440116', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2158', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '萝岗区');
INSERT INTO `systemctl_location_info` VALUES ('2159', 'ZCS', 'insert', '增城市', '440183', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2159', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '增城市');
INSERT INTO `systemctl_location_info` VALUES ('2160', 'CHS', 'insert', '从化市', '440184', 'region', '2015-01-19 15:59:00', '1', '', '440100', null, '2160', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '从化市');
INSERT INTO `systemctl_location_info` VALUES ('2161', 'SGS', 'insert', '韶关市', '440200', 'city', '2015-01-19 15:59:00', '1', '113.594461,24.80296', '440000', null, '2161', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '韶关市');
INSERT INTO `systemctl_location_info` VALUES ('2162', 'WJQ', 'insert', '武江区', '440203', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2162', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武江区');
INSERT INTO `systemctl_location_info` VALUES ('2163', 'ZJQ', 'insert', '浈江区', '440204', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2163', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浈江区');
INSERT INTO `systemctl_location_info` VALUES ('2164', 'QJQ', 'insert', '曲江区', '440205', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2164', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曲江区');
INSERT INTO `systemctl_location_info` VALUES ('2165', 'SXX', 'insert', '始兴县', '440222', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2165', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '始兴县');
INSERT INTO `systemctl_location_info` VALUES ('2166', 'RHX', 'insert', '仁化县', '440224', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2166', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仁化县');
INSERT INTO `systemctl_location_info` VALUES ('2167', 'WYX', 'insert', '翁源县', '440229', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2167', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '翁源县');
INSERT INTO `systemctl_location_info` VALUES ('2168', 'RYYZZZX', 'insert', '乳源瑶族自治县', '440232', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2168', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乳源瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2169', 'XFX', 'insert', '新丰县', '440233', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2169', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新丰县');
INSERT INTO `systemctl_location_info` VALUES ('2170', 'LCS', 'insert', '乐昌市', '440281', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2170', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐昌市');
INSERT INTO `systemctl_location_info` VALUES ('2171', 'NXS', 'insert', '南雄市', '440282', 'region', '2015-01-19 15:59:00', '1', '', '440200', null, '2171', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南雄市');
INSERT INTO `systemctl_location_info` VALUES ('2172', 'SZS', 'insert', '深圳市', '440300', 'city', '2015-01-19 15:59:00', '1', '114.025974,22.546054', '440000', null, '2172', '2015-01-19 15:59:00', 'system', 'A', '粤B', '12', '', '深圳市');
INSERT INTO `systemctl_location_info` VALUES ('2173', 'LHQ', 'insert', '罗湖区', '440303', 'region', '2015-01-19 15:59:00', '1', '', '440300', null, '2173', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗湖区');
INSERT INTO `systemctl_location_info` VALUES ('2174', 'FTQ', 'insert', '福田区', '440304', 'region', '2015-01-19 15:59:00', '1', '', '440300', null, '2174', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '福田区');
INSERT INTO `systemctl_location_info` VALUES ('2175', 'NSQ', 'insert', '南山区', '440305', 'region', '2015-01-19 15:59:00', '1', '', '440300', null, '2175', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南山区');
INSERT INTO `systemctl_location_info` VALUES ('2176', 'BAQ', 'insert', '宝安区', '440306', 'region', '2015-01-19 15:59:00', '1', '', '440300', null, '2176', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝安区');
INSERT INTO `systemctl_location_info` VALUES ('2177', 'LGQ', 'insert', '龙岗区', '440307', 'region', '2015-01-19 15:59:00', '1', '', '440300', null, '2177', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙岗区');
INSERT INTO `systemctl_location_info` VALUES ('2178', 'YTQ', 'insert', '盐田区', '440308', 'region', '2015-01-19 15:59:00', '1', '', '440300', null, '2178', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐田区');
INSERT INTO `systemctl_location_info` VALUES ('2179', 'ZHS', 'insert', '珠海市', '440400', 'city', '2015-01-19 15:59:00', '1', '113.562447,22.256915', '440000', null, '2179', '2015-01-19 15:59:00', 'system', 'A', '粤C', '13', '', '珠海市');
INSERT INTO `systemctl_location_info` VALUES ('2180', 'XZQ', 'insert', '香洲区', '440402', 'region', '2015-01-19 15:59:00', '1', '', '440400', null, '2180', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '香洲区');
INSERT INTO `systemctl_location_info` VALUES ('2181', 'DMQ', 'insert', '斗门区', '440403', 'region', '2015-01-19 15:59:00', '1', '', '440400', null, '2181', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '斗门区');
INSERT INTO `systemctl_location_info` VALUES ('2182', 'JWQ', 'insert', '金湾区', '440404', 'region', '2015-01-19 15:59:00', '1', '', '440400', null, '2182', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金湾区');
INSERT INTO `systemctl_location_info` VALUES ('2183', 'STS', 'insert', '汕头市', '440500', 'city', '2015-01-19 15:59:00', '1', '116.72865,23.383908', '440000', null, '2183', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '汕头市');
INSERT INTO `systemctl_location_info` VALUES ('2184', 'LHQ', 'insert', '龙湖区', '440507', 'region', '2015-01-19 15:59:00', '1', '', '440500', null, '2184', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙湖区');
INSERT INTO `systemctl_location_info` VALUES ('2185', 'JPQ', 'insert', '金平区', '440511', 'region', '2015-01-19 15:59:00', '1', '', '440500', null, '2185', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金平区');
INSERT INTO `systemctl_location_info` VALUES ('2186', 'HJQ', 'insert', '濠江区', '440512', 'region', '2015-01-19 15:59:00', '1', '', '440500', null, '2186', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '濠江区');
INSERT INTO `systemctl_location_info` VALUES ('2187', 'CYQ', 'insert', '潮阳区', '440513', 'region', '2015-01-19 15:59:00', '1', '', '440500', null, '2187', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潮阳区');
INSERT INTO `systemctl_location_info` VALUES ('2188', 'CNQ', 'insert', '潮南区', '440514', 'region', '2015-01-19 15:59:00', '1', '', '440500', null, '2188', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潮南区');
INSERT INTO `systemctl_location_info` VALUES ('2189', 'CHQ', 'insert', '澄海区', '440515', 'region', '2015-01-19 15:59:00', '1', '', '440500', null, '2189', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澄海区');
INSERT INTO `systemctl_location_info` VALUES ('2190', 'NAX', 'insert', '南澳县', '440523', 'region', '2015-01-19 15:59:00', '1', '', '440500', null, '2190', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南澳县');
INSERT INTO `systemctl_location_info` VALUES ('2191', 'FSS', 'insert', '佛山市', '440600', 'city', '2015-01-19 15:59:00', '1', '113.134026,23.035095', '440000', null, '2191', '2015-01-19 15:59:00', 'system', 'A', '粤E', '13', '', '佛山市');
INSERT INTO `systemctl_location_info` VALUES ('2192', 'SCQ', 'insert', '禅城区', '440604', 'region', '2015-01-19 15:59:00', '1', '', '440600', null, '2192', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '禅城区');
INSERT INTO `systemctl_location_info` VALUES ('2193', 'NHQ', 'insert', '南海区', '440605', 'region', '2015-01-19 15:59:00', '1', '', '440600', null, '2193', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南海区');
INSERT INTO `systemctl_location_info` VALUES ('2194', 'SDQ', 'insert', '顺德区', '440606', 'region', '2015-01-19 15:59:00', '1', '', '440600', null, '2194', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '顺德区');
INSERT INTO `systemctl_location_info` VALUES ('2195', 'SSQ', 'insert', '三水区', '440607', 'region', '2015-01-19 15:59:00', '1', '', '440600', null, '2195', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三水区');
INSERT INTO `systemctl_location_info` VALUES ('2196', 'GMQ', 'insert', '高明区', '440608', 'region', '2015-01-19 15:59:00', '1', '', '440600', null, '2196', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高明区');
INSERT INTO `systemctl_location_info` VALUES ('2197', 'JMS', 'insert', '江门市', '440700', 'city', '2015-01-19 15:59:00', '1', '113.078125,22.575117', '440000', null, '2197', '2015-01-19 15:59:00', 'system', 'A', '粤J', '13', '', '江门市');
INSERT INTO `systemctl_location_info` VALUES ('2198', 'PJQ', 'insert', '蓬江区', '440703', 'region', '2015-01-19 15:59:00', '1', '', '440700', null, '2198', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蓬江区');
INSERT INTO `systemctl_location_info` VALUES ('2199', 'JHQ', 'insert', '江海区', '440704', 'region', '2015-01-19 15:59:00', '1', '', '440700', null, '2199', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江海区');
INSERT INTO `systemctl_location_info` VALUES ('2200', 'XHQ', 'insert', '新会区', '440705', 'region', '2015-01-19 15:59:00', '1', '', '440700', null, '2200', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新会区');
INSERT INTO `systemctl_location_info` VALUES ('2201', 'TSS', 'insert', '台山市', '440781', 'region', '2015-01-19 15:59:00', '1', '', '440700', null, '2201', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台山市');
INSERT INTO `systemctl_location_info` VALUES ('2202', 'KPS', 'insert', '开平市', '440783', 'region', '2015-01-19 15:59:00', '1', '', '440700', null, '2202', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开平市');
INSERT INTO `systemctl_location_info` VALUES ('2203', 'HSS', 'insert', '鹤山市', '440784', 'region', '2015-01-19 15:59:00', '1', '', '440700', null, '2203', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹤山市');
INSERT INTO `systemctl_location_info` VALUES ('2204', 'EPS', 'insert', '恩平市', '440785', 'region', '2015-01-19 15:59:00', '1', '', '440700', null, '2204', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '恩平市');
INSERT INTO `systemctl_location_info` VALUES ('2205', 'ZJS', 'insert', '湛江市', '440800', 'city', '2015-01-19 15:59:00', '1', '110.365067,21.257463', '440000', null, '2205', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '湛江市');
INSERT INTO `systemctl_location_info` VALUES ('2206', 'CKQ', 'insert', '赤坎区', '440802', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2206', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '赤坎区');
INSERT INTO `systemctl_location_info` VALUES ('2207', 'XSQ', 'insert', '霞山区', '440803', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2207', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '霞山区');
INSERT INTO `systemctl_location_info` VALUES ('2208', 'PTQ', 'insert', '坡头区', '440804', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2208', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '坡头区');
INSERT INTO `systemctl_location_info` VALUES ('2209', 'MZQ', 'insert', '麻章区', '440811', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2209', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麻章区');
INSERT INTO `systemctl_location_info` VALUES ('2210', 'SXX', 'insert', '遂溪县', '440823', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2210', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '遂溪县');
INSERT INTO `systemctl_location_info` VALUES ('2211', 'XWX', 'insert', '徐闻县', '440825', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2211', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '徐闻县');
INSERT INTO `systemctl_location_info` VALUES ('2212', 'LJS', 'insert', '廉江市', '440881', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2212', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '廉江市');
INSERT INTO `systemctl_location_info` VALUES ('2213', 'LZS', 'insert', '雷州市', '440882', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2213', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雷州市');
INSERT INTO `systemctl_location_info` VALUES ('2214', 'WCS', 'insert', '吴川市', '440883', 'region', '2015-01-19 15:59:00', '1', '', '440800', null, '2214', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吴川市');
INSERT INTO `systemctl_location_info` VALUES ('2215', 'MMS', 'insert', '茂名市', '440900', 'city', '2015-01-19 15:59:00', '1', '110.931245,21.668226', '440000', null, '2215', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '茂名市');
INSERT INTO `systemctl_location_info` VALUES ('2216', 'MNQ', 'insert', '茂南区', '440902', 'region', '2015-01-19 15:59:00', '1', '', '440900', null, '2216', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '茂南区');
INSERT INTO `systemctl_location_info` VALUES ('2217', 'MGQ', 'insert', '茂港区', '440903', 'region', '2015-01-19 15:59:00', '1', '', '440900', null, '2217', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '茂港区');
INSERT INTO `systemctl_location_info` VALUES ('2218', 'DBX', 'insert', '电白县', '440923', 'region', '2015-01-19 15:59:00', '1', '', '440900', null, '2218', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '电白县');
INSERT INTO `systemctl_location_info` VALUES ('2219', 'GZS', 'insert', '高州市', '440981', 'region', '2015-01-19 15:59:00', '1', '', '440900', null, '2219', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高州市');
INSERT INTO `systemctl_location_info` VALUES ('2220', 'HZS', 'insert', '化州市', '440982', 'region', '2015-01-19 15:59:00', '1', '', '440900', null, '2220', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '化州市');
INSERT INTO `systemctl_location_info` VALUES ('2221', 'XYS', 'insert', '信宜市', '440983', 'region', '2015-01-19 15:59:00', '1', '', '440900', null, '2221', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '信宜市');
INSERT INTO `systemctl_location_info` VALUES ('2222', 'ZQS', 'insert', '肇庆市', '441200', 'city', '2015-01-19 15:59:00', '1', '112.479653,23.078663', '440000', null, '2222', '2015-01-19 15:59:00', 'system', 'A', '粤H', '13', '', '肇庆市');
INSERT INTO `systemctl_location_info` VALUES ('2223', 'DZQ', 'insert', '端州区', '441202', 'region', '2015-01-19 15:59:00', '1', '', '441200', null, '2223', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '端州区');
INSERT INTO `systemctl_location_info` VALUES ('2224', 'DHQ', 'insert', '鼎湖区', '441203', 'region', '2015-01-19 15:59:00', '1', '', '441200', null, '2224', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鼎湖区');
INSERT INTO `systemctl_location_info` VALUES ('2225', 'GNX', 'insert', '广宁县', '441223', 'region', '2015-01-19 15:59:00', '1', '', '441200', null, '2225', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广宁县');
INSERT INTO `systemctl_location_info` VALUES ('2226', 'HJX', 'insert', '怀集县', '441224', 'region', '2015-01-19 15:59:00', '1', '', '441200', null, '2226', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '怀集县');
INSERT INTO `systemctl_location_info` VALUES ('2227', 'FKX', 'insert', '封开县', '441225', 'region', '2015-01-19 15:59:00', '1', '', '441200', null, '2227', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '封开县');
INSERT INTO `systemctl_location_info` VALUES ('2228', 'DQX', 'insert', '德庆县', '441226', 'region', '2015-01-19 15:59:00', '1', '', '441200', null, '2228', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德庆县');
INSERT INTO `systemctl_location_info` VALUES ('2229', 'GYS', 'insert', '高要市', '441283', 'region', '2015-01-19 15:59:00', '1', '', '441200', null, '2229', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高要市');
INSERT INTO `systemctl_location_info` VALUES ('2230', 'SHS', 'insert', '四会市', '441284', 'region', '2015-01-19 15:59:00', '1', '', '441200', null, '2230', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '四会市');
INSERT INTO `systemctl_location_info` VALUES ('2231', 'HZS', 'insert', '惠州市', '441300', 'city', '2015-01-19 15:59:00', '1', '114.410658,23.11354', '440000', null, '2231', '2015-01-19 15:59:00', 'system', 'A', '粤L', '12', '', '惠州市');
INSERT INTO `systemctl_location_info` VALUES ('2232', 'HCQ', 'insert', '惠城区', '441302', 'region', '2015-01-19 15:59:00', '1', '', '441300', null, '2232', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠城区');
INSERT INTO `systemctl_location_info` VALUES ('2233', 'HYQ', 'insert', '惠阳区', '441303', 'region', '2015-01-19 15:59:00', '1', '', '441300', null, '2233', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠阳区');
INSERT INTO `systemctl_location_info` VALUES ('2234', 'BLX', 'insert', '博罗县', '441322', 'region', '2015-01-19 15:59:00', '1', '', '441300', null, '2234', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博罗县');
INSERT INTO `systemctl_location_info` VALUES ('2235', 'HDX', 'insert', '惠东县', '441323', 'region', '2015-01-19 15:59:00', '1', '', '441300', null, '2235', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠东县');
INSERT INTO `systemctl_location_info` VALUES ('2236', 'LMX', 'insert', '龙门县', '441324', 'region', '2015-01-19 15:59:00', '1', '', '441300', null, '2236', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙门县');
INSERT INTO `systemctl_location_info` VALUES ('2237', 'MZS', 'insert', '梅州市', '441400', 'city', '2015-01-19 15:59:00', '1', '116.126403,24.304571', '440000', null, '2237', '2015-01-19 15:59:00', 'system', 'A', '粤M', '13', '', '梅州市');
INSERT INTO `systemctl_location_info` VALUES ('2238', 'MJQ', 'insert', '梅江区', '441402', 'region', '2015-01-19 15:59:00', '1', '', '441400', null, '2238', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梅江区');
INSERT INTO `systemctl_location_info` VALUES ('2239', 'MX', 'insert', '梅县', '441421', 'region', '2015-01-19 15:59:00', '1', '', '441400', null, '2239', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梅县');
INSERT INTO `systemctl_location_info` VALUES ('2240', 'DPX', 'insert', '大埔县', '441422', 'region', '2015-01-19 15:59:00', '1', '', '441400', null, '2240', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大埔县');
INSERT INTO `systemctl_location_info` VALUES ('2241', 'FSX', 'insert', '丰顺县', '441423', 'region', '2015-01-19 15:59:00', '1', '', '441400', null, '2241', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰顺县');
INSERT INTO `systemctl_location_info` VALUES ('2242', 'WHX', 'insert', '五华县', '441424', 'region', '2015-01-19 15:59:00', '1', '', '441400', null, '2242', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五华县');
INSERT INTO `systemctl_location_info` VALUES ('2243', 'PYX', 'insert', '平远县', '441426', 'region', '2015-01-19 15:59:00', '1', '', '441400', null, '2243', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平远县');
INSERT INTO `systemctl_location_info` VALUES ('2244', 'JLX', 'insert', '蕉岭县', '441427', 'region', '2015-01-19 15:59:00', '1', '', '441400', null, '2244', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蕉岭县');
INSERT INTO `systemctl_location_info` VALUES ('2245', 'XNS', 'insert', '兴宁市', '441481', 'region', '2015-01-19 15:59:00', '1', '', '441400', null, '2245', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴宁市');
INSERT INTO `systemctl_location_info` VALUES ('2246', 'SWS', 'insert', '汕尾市', '441500', 'city', '2015-01-19 15:59:00', '1', '115.372924,22.778731', '440000', null, '2246', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '汕尾市');
INSERT INTO `systemctl_location_info` VALUES ('2247', 'CQ', 'insert', '城区', '441502', 'region', '2015-01-19 15:59:00', '1', '', '441500', null, '2247', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城区');
INSERT INTO `systemctl_location_info` VALUES ('2248', 'HFX', 'insert', '海丰县', '441521', 'region', '2015-01-19 15:59:00', '1', '', '441500', null, '2248', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海丰县');
INSERT INTO `systemctl_location_info` VALUES ('2249', 'LHX', 'insert', '陆河县', '441523', 'region', '2015-01-19 15:59:00', '1', '', '441500', null, '2249', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陆河县');
INSERT INTO `systemctl_location_info` VALUES ('2250', 'LFS', 'insert', '陆丰市', '441581', 'region', '2015-01-19 15:59:00', '1', '', '441500', null, '2250', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陆丰市');
INSERT INTO `systemctl_location_info` VALUES ('2251', 'HYS', 'insert', '河源市', '441600', 'city', '2015-01-19 15:59:00', '1', '114.713721,23.757251', '440000', null, '2251', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '河源市');
INSERT INTO `systemctl_location_info` VALUES ('2252', 'YCQ', 'insert', '源城区', '441602', 'region', '2015-01-19 15:59:00', '1', '', '441600', null, '2252', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '源城区');
INSERT INTO `systemctl_location_info` VALUES ('2253', 'ZJX', 'insert', '紫金县', '441621', 'region', '2015-01-19 15:59:00', '1', '', '441600', null, '2253', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '紫金县');
INSERT INTO `systemctl_location_info` VALUES ('2254', 'LCX', 'insert', '龙川县', '441622', 'region', '2015-01-19 15:59:00', '1', '', '441600', null, '2254', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙川县');
INSERT INTO `systemctl_location_info` VALUES ('2255', 'LPX', 'insert', '连平县', '441623', 'region', '2015-01-19 15:59:00', '1', '', '441600', null, '2255', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '连平县');
INSERT INTO `systemctl_location_info` VALUES ('2256', 'HPX', 'insert', '和平县', '441624', 'region', '2015-01-19 15:59:00', '1', '', '441600', null, '2256', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和平县');
INSERT INTO `systemctl_location_info` VALUES ('2257', 'DYX', 'insert', '东源县', '441625', 'region', '2015-01-19 15:59:00', '1', '', '441600', null, '2257', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东源县');
INSERT INTO `systemctl_location_info` VALUES ('2258', 'YJS', 'insert', '阳江市', '441700', 'city', '2015-01-19 15:59:00', '1', '111.97701,21.871517', '440000', null, '2258', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '阳江市');
INSERT INTO `systemctl_location_info` VALUES ('2259', 'JCQ', 'insert', '江城区', '441702', 'region', '2015-01-19 15:59:00', '1', '', '441700', null, '2259', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江城区');
INSERT INTO `systemctl_location_info` VALUES ('2260', 'YXX', 'insert', '阳西县', '441721', 'region', '2015-01-19 15:59:00', '1', '', '441700', null, '2260', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳西县');
INSERT INTO `systemctl_location_info` VALUES ('2261', 'YDX', 'insert', '阳东县', '441723', 'region', '2015-01-19 15:59:00', '1', '', '441700', null, '2261', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳东县');
INSERT INTO `systemctl_location_info` VALUES ('2262', 'YCS', 'insert', '阳春市', '441781', 'region', '2015-01-19 15:59:00', '1', '', '441700', null, '2262', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳春市');
INSERT INTO `systemctl_location_info` VALUES ('2263', 'QYS', 'insert', '清远市', '441800', 'city', '2015-01-19 15:59:00', '1', '113.040773,23.698469', '440000', null, '2263', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '清远市');
INSERT INTO `systemctl_location_info` VALUES ('2264', 'QCQ', 'insert', '清城区', '441802', 'region', '2015-01-19 15:59:00', '1', '', '441800', null, '2264', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清城区');
INSERT INTO `systemctl_location_info` VALUES ('2265', 'FGX', 'insert', '佛冈县', '441821', 'region', '2015-01-19 15:59:00', '1', '', '441800', null, '2265', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '佛冈县');
INSERT INTO `systemctl_location_info` VALUES ('2266', 'YSX', 'insert', '阳山县', '441823', 'region', '2015-01-19 15:59:00', '1', '', '441800', null, '2266', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳山县');
INSERT INTO `systemctl_location_info` VALUES ('2267', 'LSZZYZZZX', 'insert', '连山壮族瑶族自治县', '441825', 'region', '2015-01-19 15:59:00', '1', '', '441800', null, '2267', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '连山壮族瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2268', 'LNYZZZX', 'insert', '连南瑶族自治县', '441826', 'region', '2015-01-19 15:59:00', '1', '', '441800', null, '2268', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '连南瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2269', 'QXX', 'insert', '清新县', '441827', 'region', '2015-01-19 15:59:00', '1', '', '441800', null, '2269', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清新县');
INSERT INTO `systemctl_location_info` VALUES ('2270', 'YDS', 'insert', '英德市', '441881', 'region', '2015-01-19 15:59:00', '1', '', '441800', null, '2270', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '英德市');
INSERT INTO `systemctl_location_info` VALUES ('2271', 'LZS', 'insert', '连州市', '441882', 'region', '2015-01-19 15:59:00', '1', '', '441800', null, '2271', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '连州市');
INSERT INTO `systemctl_location_info` VALUES ('2272', 'DGS', 'insert', '东莞市', '441900', 'city', '2015-01-19 15:59:00', '1', '113.763434,23.043024', '440000', null, '2272', '2015-01-19 15:59:00', 'system', 'A', '粤S', '12', '', '东莞市');
INSERT INTO `systemctl_location_info` VALUES ('2273', 'DGS', 'insert', '东莞市', '441901', 'region', '2015-01-19 15:59:00', '1', '', '441900', null, '2273', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东莞市');
INSERT INTO `systemctl_location_info` VALUES ('2274', 'ZSS', 'insert', '中山市', '442000', 'city', '2015-01-19 15:59:00', '1', '113.42206,22.545178', '440000', null, '2274', '2015-01-19 15:59:00', 'system', 'A', '粤T', '12', '', '中山市');
INSERT INTO `systemctl_location_info` VALUES ('2275', 'ZSS', 'insert', '中山市', '442001', 'region', '2015-01-19 15:59:00', '1', '', '442000', null, '2275', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中山市');
INSERT INTO `systemctl_location_info` VALUES ('2276', 'CZS', 'insert', '潮州市', '445100', 'city', '2015-01-19 15:59:00', '1', '116.630076,23.661812', '440000', null, '2276', '2015-01-19 15:59:00', 'system', 'A', '粤U', '13', '', '潮州市');
INSERT INTO `systemctl_location_info` VALUES ('2277', 'XQQ', 'insert', '湘桥区', '445102', 'region', '2015-01-19 15:59:00', '1', '', '445100', null, '2277', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湘桥区');
INSERT INTO `systemctl_location_info` VALUES ('2278', 'CAX', 'insert', '潮安县', '445121', 'region', '2015-01-19 15:59:00', '1', '', '445100', null, '2278', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潮安县');
INSERT INTO `systemctl_location_info` VALUES ('2279', 'RPX', 'insert', '饶平县', '445122', 'region', '2015-01-19 15:59:00', '1', '', '445100', null, '2279', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '饶平县');
INSERT INTO `systemctl_location_info` VALUES ('2280', 'JYS', 'insert', '揭阳市', '445200', 'city', '2015-01-19 15:59:00', '1', '116.379501,23.547999', '440000', null, '2280', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '揭阳市');
INSERT INTO `systemctl_location_info` VALUES ('2281', 'RCQ', 'insert', '榕城区', '445202', 'region', '2015-01-19 15:59:00', '1', '', '445200', null, '2281', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '榕城区');
INSERT INTO `systemctl_location_info` VALUES ('2282', 'JDX', 'insert', '揭东县', '445221', 'region', '2015-01-19 15:59:00', '1', '', '445200', null, '2282', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '揭东县');
INSERT INTO `systemctl_location_info` VALUES ('2283', 'JXX', 'insert', '揭西县', '445222', 'region', '2015-01-19 15:59:00', '1', '', '445200', null, '2283', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '揭西县');
INSERT INTO `systemctl_location_info` VALUES ('2284', 'HLX', 'insert', '惠来县', '445224', 'region', '2015-01-19 15:59:00', '1', '', '445200', null, '2284', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠来县');
INSERT INTO `systemctl_location_info` VALUES ('2285', 'PNS', 'insert', '普宁市', '445281', 'region', '2015-01-19 15:59:00', '1', '', '445200', null, '2285', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '普宁市');
INSERT INTO `systemctl_location_info` VALUES ('2286', 'YFS', 'insert', '云浮市', '445300', 'city', '2015-01-19 15:59:00', '1', '112.050946,22.937976', '440000', null, '2286', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '云浮市');
INSERT INTO `systemctl_location_info` VALUES ('2287', 'YCQ', 'insert', '云城区', '445302', 'region', '2015-01-19 15:59:00', '1', '', '445300', null, '2287', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云城区');
INSERT INTO `systemctl_location_info` VALUES ('2288', 'XXX', 'insert', '新兴县', '445321', 'region', '2015-01-19 15:59:00', '1', '', '445300', null, '2288', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新兴县');
INSERT INTO `systemctl_location_info` VALUES ('2289', 'YNX', 'insert', '郁南县', '445322', 'region', '2015-01-19 15:59:00', '1', '', '445300', null, '2289', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郁南县');
INSERT INTO `systemctl_location_info` VALUES ('2290', 'YAX', 'insert', '云安县', '445323', 'region', '2015-01-19 15:59:00', '1', '', '445300', null, '2290', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云安县');
INSERT INTO `systemctl_location_info` VALUES ('2291', 'LDS', 'insert', '罗定市', '445381', 'region', '2015-01-19 15:59:00', '1', '', '445300', null, '2291', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗定市');
INSERT INTO `systemctl_location_info` VALUES ('2292', 'GXZZZZQ', 'insert', '广西省', '450000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2292', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广西壮族自治区');
INSERT INTO `systemctl_location_info` VALUES ('2293', 'NNS', 'insert', '南宁市', '450100', 'city', '2015-01-19 15:59:00', '1', '108.297234,22.806493', '450000', null, '2293', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '南宁市');
INSERT INTO `systemctl_location_info` VALUES ('2294', 'XNQ', 'insert', '兴宁区', '450102', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2294', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴宁区');
INSERT INTO `systemctl_location_info` VALUES ('2295', 'QXQ', 'insert', '青秀区', '450103', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2295', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青秀区');
INSERT INTO `systemctl_location_info` VALUES ('2296', 'JNQ', 'insert', '江南区', '450105', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2296', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江南区');
INSERT INTO `systemctl_location_info` VALUES ('2297', 'XXTQ', 'insert', '西乡塘区', '450107', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2297', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西乡塘区');
INSERT INTO `systemctl_location_info` VALUES ('2298', 'LQQ', 'insert', '良庆区', '450108', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2298', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '良庆区');
INSERT INTO `systemctl_location_info` VALUES ('2299', 'YNQ', 'insert', '邕宁区', '450109', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2299', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邕宁区');
INSERT INTO `systemctl_location_info` VALUES ('2300', 'WMX', 'insert', '武鸣县', '450122', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2300', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武鸣县');
INSERT INTO `systemctl_location_info` VALUES ('2301', 'LAX', 'insert', '隆安县', '450123', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2301', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆安县');
INSERT INTO `systemctl_location_info` VALUES ('2302', 'MSX', 'insert', '马山县', '450124', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2302', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '马山县');
INSERT INTO `systemctl_location_info` VALUES ('2303', 'SLX', 'insert', '上林县', '450125', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2303', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上林县');
INSERT INTO `systemctl_location_info` VALUES ('2304', 'BYX', 'insert', '宾阳县', '450126', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2304', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宾阳县');
INSERT INTO `systemctl_location_info` VALUES ('2305', 'HX', 'insert', '横县', '450127', 'region', '2015-01-19 15:59:00', '1', '', '450100', null, '2305', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '横县');
INSERT INTO `systemctl_location_info` VALUES ('2306', 'LZS', 'insert', '柳州市', '450200', 'city', '2015-01-19 15:59:00', '1', '109.422402,24.329053', '450000', null, '2306', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '柳州市');
INSERT INTO `systemctl_location_info` VALUES ('2307', 'CZQ', 'insert', '城中区', '450202', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2307', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城中区');
INSERT INTO `systemctl_location_info` VALUES ('2308', 'YFQ', 'insert', '鱼峰区', '450203', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2308', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鱼峰区');
INSERT INTO `systemctl_location_info` VALUES ('2309', 'LNQ', 'insert', '柳南区', '450204', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2309', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柳南区');
INSERT INTO `systemctl_location_info` VALUES ('2310', 'LBQ', 'insert', '柳北区', '450205', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2310', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柳北区');
INSERT INTO `systemctl_location_info` VALUES ('2311', 'LJX', 'insert', '柳江县', '450221', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2311', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柳江县');
INSERT INTO `systemctl_location_info` VALUES ('2312', 'LCX', 'insert', '柳城县', '450222', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2312', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柳城县');
INSERT INTO `systemctl_location_info` VALUES ('2313', 'LZX', 'insert', '鹿寨县', '450223', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2313', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹿寨县');
INSERT INTO `systemctl_location_info` VALUES ('2314', 'RAX', 'insert', '融安县', '450224', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2314', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '融安县');
INSERT INTO `systemctl_location_info` VALUES ('2315', 'RSMZZZX', 'insert', '融水苗族自治县', '450225', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2315', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '融水苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2316', 'SJDZZZX', 'insert', '三江侗族自治县', '450226', 'region', '2015-01-19 15:59:00', '1', '', '450200', null, '2316', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三江侗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2317', 'GLS', 'insert', '桂林市', '450300', 'city', '2015-01-19 15:59:00', '1', '110.26092,25.262901', '450000', null, '2317', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '桂林市');
INSERT INTO `systemctl_location_info` VALUES ('2318', 'XFQ', 'insert', '秀峰区', '450302', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2318', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秀峰区');
INSERT INTO `systemctl_location_info` VALUES ('2319', 'DCQ', 'insert', '叠彩区', '450303', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2319', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '叠彩区');
INSERT INTO `systemctl_location_info` VALUES ('2320', 'XSQ', 'insert', '象山区', '450304', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2320', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '象山区');
INSERT INTO `systemctl_location_info` VALUES ('2321', 'QXQ', 'insert', '七星区', '450305', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2321', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '七星区');
INSERT INTO `systemctl_location_info` VALUES ('2322', 'YSQ', 'insert', '雁山区', '450311', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2322', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雁山区');
INSERT INTO `systemctl_location_info` VALUES ('2323', 'YSX', 'insert', '阳朔县', '450321', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2323', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阳朔县');
INSERT INTO `systemctl_location_info` VALUES ('2324', 'LGX', 'insert', '临桂县', '450322', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2324', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临桂县');
INSERT INTO `systemctl_location_info` VALUES ('2325', 'LCX', 'insert', '灵川县', '450323', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2325', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵川县');
INSERT INTO `systemctl_location_info` VALUES ('2326', 'QZX', 'insert', '全州县', '450324', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2326', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '全州县');
INSERT INTO `systemctl_location_info` VALUES ('2327', 'XAX', 'insert', '兴安县', '450325', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2327', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴安县');
INSERT INTO `systemctl_location_info` VALUES ('2328', 'YFX', 'insert', '永福县', '450326', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2328', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永福县');
INSERT INTO `systemctl_location_info` VALUES ('2329', 'GYX', 'insert', '灌阳县', '450327', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2329', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灌阳县');
INSERT INTO `systemctl_location_info` VALUES ('2330', 'LSGZZZX', 'insert', '龙胜各族自治县', '450328', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2330', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙胜各族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2331', 'ZYX', 'insert', '资源县', '450329', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2331', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '资源县');
INSERT INTO `systemctl_location_info` VALUES ('2332', 'PLX', 'insert', '平乐县', '450330', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2332', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平乐县');
INSERT INTO `systemctl_location_info` VALUES ('2333', 'LPX', 'insert', '荔蒲县', '450331', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2333', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荔蒲县');
INSERT INTO `systemctl_location_info` VALUES ('2334', 'GCYZZZX', 'insert', '恭城瑶族自治县', '450332', 'region', '2015-01-19 15:59:00', '1', '', '450300', null, '2334', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '恭城瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2335', 'WZS', 'insert', '梧州市', '450400', 'city', '2015-01-19 15:59:00', '1', '111.305472,23.485395', '450000', null, '2335', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '梧州市');
INSERT INTO `systemctl_location_info` VALUES ('2336', 'WXQ', 'insert', '万秀区', '450403', 'region', '2015-01-19 15:59:00', '1', '', '450400', null, '2336', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万秀区');
INSERT INTO `systemctl_location_info` VALUES ('2337', 'DSQ', 'insert', '蝶山区', '450404', 'region', '2015-01-19 15:59:00', '1', '', '450400', null, '2337', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蝶山区');
INSERT INTO `systemctl_location_info` VALUES ('2338', 'ZZQ', 'insert', '长洲区', '450405', 'region', '2015-01-19 15:59:00', '1', '', '450400', null, '2338', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长洲区');
INSERT INTO `systemctl_location_info` VALUES ('2339', 'CWX', 'insert', '苍梧县', '450421', 'region', '2015-01-19 15:59:00', '1', '', '450400', null, '2339', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苍梧县');
INSERT INTO `systemctl_location_info` VALUES ('2340', 'TX', 'insert', '藤县', '450422', 'region', '2015-01-19 15:59:00', '1', '', '450400', null, '2340', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '藤县');
INSERT INTO `systemctl_location_info` VALUES ('2341', 'MSX', 'insert', '蒙山县', '450423', 'region', '2015-01-19 15:59:00', '1', '', '450400', null, '2341', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蒙山县');
INSERT INTO `systemctl_location_info` VALUES ('2342', 'CXS', 'insert', '岑溪市', '450481', 'region', '2015-01-19 15:59:00', '1', '', '450400', null, '2342', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岑溪市');
INSERT INTO `systemctl_location_info` VALUES ('2343', 'BHS', 'insert', '北海市', '450500', 'city', '2015-01-19 15:59:00', '1', '109.122628,21.472718', '450000', null, '2343', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '北海市');
INSERT INTO `systemctl_location_info` VALUES ('2344', 'HCQ', 'insert', '海城区', '450502', 'region', '2015-01-19 15:59:00', '1', '', '450500', null, '2344', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海城区');
INSERT INTO `systemctl_location_info` VALUES ('2345', 'YHQ', 'insert', '银海区', '450503', 'region', '2015-01-19 15:59:00', '1', '', '450500', null, '2345', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '银海区');
INSERT INTO `systemctl_location_info` VALUES ('2346', 'TSGQ', 'insert', '铁山港区', '450512', 'region', '2015-01-19 15:59:00', '1', '', '450500', null, '2346', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铁山港区');
INSERT INTO `systemctl_location_info` VALUES ('2347', 'HPX', 'insert', '合浦县', '450521', 'region', '2015-01-19 15:59:00', '1', '', '450500', null, '2347', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '合浦县');
INSERT INTO `systemctl_location_info` VALUES ('2348', 'FCGS', 'insert', '防城港市', '450600', 'city', '2015-01-19 15:59:00', '1', '108.351791,21.617398', '450000', null, '2348', '2015-01-19 15:59:00', 'system', 'A', '', '15', '', '防城港市');
INSERT INTO `systemctl_location_info` VALUES ('2349', 'GKQ', 'insert', '港口区', '450602', 'region', '2015-01-19 15:59:00', '1', '', '450600', null, '2349', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '港口区');
INSERT INTO `systemctl_location_info` VALUES ('2350', 'FCQ', 'insert', '防城区', '450603', 'region', '2015-01-19 15:59:00', '1', '', '450600', null, '2350', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '防城区');
INSERT INTO `systemctl_location_info` VALUES ('2351', 'SSX', 'insert', '上思县', '450621', 'region', '2015-01-19 15:59:00', '1', '', '450600', null, '2351', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '上思县');
INSERT INTO `systemctl_location_info` VALUES ('2352', 'DXS', 'insert', '东兴市', '450681', 'region', '2015-01-19 15:59:00', '1', '', '450600', null, '2352', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东兴市');
INSERT INTO `systemctl_location_info` VALUES ('2353', 'QZS', 'insert', '钦州市', '450700', 'city', '2015-01-19 15:59:00', '1', '108.638798,21.97335', '450000', null, '2353', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '钦州市');
INSERT INTO `systemctl_location_info` VALUES ('2354', 'QNQ', 'insert', '钦南区', '450702', 'region', '2015-01-19 15:59:00', '1', '', '450700', null, '2354', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '钦南区');
INSERT INTO `systemctl_location_info` VALUES ('2355', 'QBQ', 'insert', '钦北区', '450703', 'region', '2015-01-19 15:59:00', '1', '', '450700', null, '2355', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '钦北区');
INSERT INTO `systemctl_location_info` VALUES ('2356', 'LSX', 'insert', '灵山县', '450721', 'region', '2015-01-19 15:59:00', '1', '', '450700', null, '2356', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵山县');
INSERT INTO `systemctl_location_info` VALUES ('2357', 'PBX', 'insert', '浦北县', '450722', 'region', '2015-01-19 15:59:00', '1', '', '450700', null, '2357', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浦北县');
INSERT INTO `systemctl_location_info` VALUES ('2358', 'GGS', 'insert', '贵港市', '450800', 'city', '2015-01-19 15:59:00', '1', '109.613708,23.103373', '450000', null, '2358', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '贵港市');
INSERT INTO `systemctl_location_info` VALUES ('2359', 'GBQ', 'insert', '港北区', '450802', 'region', '2015-01-19 15:59:00', '1', '', '450800', null, '2359', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '港北区');
INSERT INTO `systemctl_location_info` VALUES ('2360', 'GNQ', 'insert', '港南区', '450803', 'region', '2015-01-19 15:59:00', '1', '', '450800', null, '2360', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '港南区');
INSERT INTO `systemctl_location_info` VALUES ('2361', 'TTQ', 'insert', '覃塘区', '450804', 'region', '2015-01-19 15:59:00', '1', '', '450800', null, '2361', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '覃塘区');
INSERT INTO `systemctl_location_info` VALUES ('2362', 'PNX', 'insert', '平南县', '450821', 'region', '2015-01-19 15:59:00', '1', '', '450800', null, '2362', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平南县');
INSERT INTO `systemctl_location_info` VALUES ('2363', 'GPS', 'insert', '桂平市', '450881', 'region', '2015-01-19 15:59:00', '1', '', '450800', null, '2363', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桂平市');
INSERT INTO `systemctl_location_info` VALUES ('2364', 'YLS', 'insert', '玉林市', '450900', 'city', '2015-01-19 15:59:00', '1', '110.151676,22.643974', '450000', null, '2364', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '玉林市');
INSERT INTO `systemctl_location_info` VALUES ('2365', 'YZQ', 'insert', '玉州区', '450902', 'region', '2015-01-19 15:59:00', '1', '', '450900', null, '2365', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉州区');
INSERT INTO `systemctl_location_info` VALUES ('2366', 'RX', 'insert', '容县', '450921', 'region', '2015-01-19 15:59:00', '1', '', '450900', null, '2366', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '容县');
INSERT INTO `systemctl_location_info` VALUES ('2367', 'LCX', 'insert', '陆川县', '450922', 'region', '2015-01-19 15:59:00', '1', '', '450900', null, '2367', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陆川县');
INSERT INTO `systemctl_location_info` VALUES ('2368', 'BBX', 'insert', '博白县', '450923', 'region', '2015-01-19 15:59:00', '1', '', '450900', null, '2368', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博白县');
INSERT INTO `systemctl_location_info` VALUES ('2369', 'XYX', 'insert', '兴业县', '450924', 'region', '2015-01-19 15:59:00', '1', '', '450900', null, '2369', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴业县');
INSERT INTO `systemctl_location_info` VALUES ('2370', 'BLS', 'insert', '北流市', '450981', 'region', '2015-01-19 15:59:00', '1', '', '450900', null, '2370', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北流市');
INSERT INTO `systemctl_location_info` VALUES ('2371', 'BSS', 'insert', '百色市', '451000', 'city', '2015-01-19 15:59:00', '1', '106.631821,23.901512', '450000', null, '2371', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '百色市');
INSERT INTO `systemctl_location_info` VALUES ('2372', 'YJQ', 'insert', '右江区', '451002', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2372', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '右江区');
INSERT INTO `systemctl_location_info` VALUES ('2373', 'TYX', 'insert', '田阳县', '451021', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2373', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '田阳县');
INSERT INTO `systemctl_location_info` VALUES ('2374', 'TDX', 'insert', '田东县', '451022', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2374', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '田东县');
INSERT INTO `systemctl_location_info` VALUES ('2375', 'PGX', 'insert', '平果县', '451023', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2375', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平果县');
INSERT INTO `systemctl_location_info` VALUES ('2376', 'DBX', 'insert', '德保县', '451024', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2376', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德保县');
INSERT INTO `systemctl_location_info` VALUES ('2377', 'JXX', 'insert', '靖西县', '451025', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2377', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '靖西县');
INSERT INTO `systemctl_location_info` VALUES ('2378', 'NPX', 'insert', '那坡县', '451026', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2378', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '那坡县');
INSERT INTO `systemctl_location_info` VALUES ('2379', 'LYX', 'insert', '凌云县', '451027', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2379', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凌云县');
INSERT INTO `systemctl_location_info` VALUES ('2380', 'LYX', 'insert', '乐业县', '451028', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2380', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐业县');
INSERT INTO `systemctl_location_info` VALUES ('2381', 'TLX', 'insert', '田林县', '451029', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2381', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '田林县');
INSERT INTO `systemctl_location_info` VALUES ('2382', 'XLX', 'insert', '西林县', '451030', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2382', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西林县');
INSERT INTO `systemctl_location_info` VALUES ('2383', 'LLGZZZX', 'insert', '隆林各族自治县', '451031', 'region', '2015-01-19 15:59:00', '1', '', '451000', null, '2383', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆林各族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2384', 'HZS', 'insert', '贺州市', '451100', 'city', '2015-01-19 15:59:00', '1', '111.552594,24.411054', '450000', null, '2384', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '贺州市');
INSERT INTO `systemctl_location_info` VALUES ('2385', 'BBQ', 'insert', '八步区', '451102', 'region', '2015-01-19 15:59:00', '1', '', '451100', null, '2385', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '八步区');
INSERT INTO `systemctl_location_info` VALUES ('2386', 'PGGLQ', 'insert', '平桂管理区', '451119', 'region', '2015-01-19 15:59:00', '1', '', '451100', null, '2386', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平桂管理区');
INSERT INTO `systemctl_location_info` VALUES ('2387', 'ZPX', 'insert', '昭平县', '451121', 'region', '2015-01-19 15:59:00', '1', '', '451100', null, '2387', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昭平县');
INSERT INTO `systemctl_location_info` VALUES ('2388', 'ZSX', 'insert', '钟山县', '451122', 'region', '2015-01-19 15:59:00', '1', '', '451100', null, '2388', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '钟山县');
INSERT INTO `systemctl_location_info` VALUES ('2389', 'FCYZZZX', 'insert', '富川瑶族自治县', '451123', 'region', '2015-01-19 15:59:00', '1', '', '451100', null, '2389', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富川瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2390', 'HCS', 'insert', '河池市', '451200', 'city', '2015-01-19 15:59:00', '1', '108.069948,24.699521', '450000', null, '2390', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '河池市');
INSERT INTO `systemctl_location_info` VALUES ('2391', 'JCJQ', 'insert', '金城江区', '451202', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2391', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金城江区');
INSERT INTO `systemctl_location_info` VALUES ('2392', 'NDX', 'insert', '南丹县', '451221', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2392', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南丹县');
INSERT INTO `systemctl_location_info` VALUES ('2393', 'TEX', 'insert', '天峨县', '451222', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2393', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天峨县');
INSERT INTO `systemctl_location_info` VALUES ('2394', 'FSX', 'insert', '凤山县', '451223', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2394', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤山县');
INSERT INTO `systemctl_location_info` VALUES ('2395', 'DLX', 'insert', '东兰县', '451224', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2395', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东兰县');
INSERT INTO `systemctl_location_info` VALUES ('2396', 'LCMLZZZX', 'insert', '罗城仫佬族自治县', '451225', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2396', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗城仫佬族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2397', 'HJMNZZZX', 'insert', '环江毛南族自治县', '451226', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2397', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '环江毛南族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2398', 'BMYZZZX', 'insert', '巴马瑶族自治县', '451227', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2398', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴马瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2399', 'DAYZZZX', 'insert', '都安瑶族自治县', '451228', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2399', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '都安瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2400', 'DHYZZZX', 'insert', '大化瑶族自治县', '451229', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2400', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大化瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2401', 'YZS', 'insert', '宜州市', '451281', 'region', '2015-01-19 15:59:00', '1', '', '451200', null, '2401', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜州市');
INSERT INTO `systemctl_location_info` VALUES ('2402', 'LBS', 'insert', '来宾市', '451300', 'city', '2015-01-19 15:59:00', '1', '109.231817,23.741166', '450000', null, '2402', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '来宾市');
INSERT INTO `systemctl_location_info` VALUES ('2403', 'XBQ', 'insert', '兴宾区', '451302', 'region', '2015-01-19 15:59:00', '1', '', '451300', null, '2403', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴宾区');
INSERT INTO `systemctl_location_info` VALUES ('2404', 'XCX', 'insert', '忻城县', '451321', 'region', '2015-01-19 15:59:00', '1', '', '451300', null, '2404', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '忻城县');
INSERT INTO `systemctl_location_info` VALUES ('2405', 'XZX', 'insert', '象州县', '451322', 'region', '2015-01-19 15:59:00', '1', '', '451300', null, '2405', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '象州县');
INSERT INTO `systemctl_location_info` VALUES ('2406', 'WXX', 'insert', '武宣县', '451323', 'region', '2015-01-19 15:59:00', '1', '', '451300', null, '2406', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武宣县');
INSERT INTO `systemctl_location_info` VALUES ('2407', 'JXYZZZX', 'insert', '金秀瑶族自治县', '451324', 'region', '2015-01-19 15:59:00', '1', '', '451300', null, '2407', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金秀瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2408', 'HSS', 'insert', '合山市', '451381', 'region', '2015-01-19 15:59:00', '1', '', '451300', null, '2408', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '合山市');
INSERT INTO `systemctl_location_info` VALUES ('2409', 'CZS', 'insert', '崇左市', '451400', 'city', '2015-01-19 15:59:00', '1', '107.357322,22.415455', '450000', null, '2409', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '崇左市');
INSERT INTO `systemctl_location_info` VALUES ('2410', 'JZQ', 'insert', '江洲区', '451402', 'region', '2015-01-19 15:59:00', '1', '', '451400', null, '2410', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江洲区');
INSERT INTO `systemctl_location_info` VALUES ('2411', 'FSX', 'insert', '扶绥县', '451421', 'region', '2015-01-19 15:59:00', '1', '', '451400', null, '2411', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扶绥县');
INSERT INTO `systemctl_location_info` VALUES ('2412', 'NMX', 'insert', '宁明县', '451422', 'region', '2015-01-19 15:59:00', '1', '', '451400', null, '2412', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁明县');
INSERT INTO `systemctl_location_info` VALUES ('2413', 'TDX', 'insert', '天等县', '451425', 'region', '2015-01-19 15:59:00', '1', '', '451400', null, '2413', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天等县');
INSERT INTO `systemctl_location_info` VALUES ('2414', 'PXS', 'insert', '凭祥市', '451481', 'region', '2015-01-19 15:59:00', '1', '', '451400', null, '2414', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凭祥市');
INSERT INTO `systemctl_location_info` VALUES ('2415', 'HNS', 'insert', '海南省', '460000', 'province', '2015-01-19 15:59:00', '1', '100.624066,36.284364', '0', null, '2415', '2015-01-19 15:59:00', 'system', 'A', '琼', '11', '', '海南省');
INSERT INTO `systemctl_location_info` VALUES ('2416', 'LZX', 'insert', '龙州县', '451423', 'region', '2015-01-19 15:59:00', '1', '', '451400', null, '2416', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙州县');
INSERT INTO `systemctl_location_info` VALUES ('2417', 'DXX', 'insert', '大新县', '451424', 'region', '2015-01-19 15:59:00', '1', '', '451400', null, '2417', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大新县');
INSERT INTO `systemctl_location_info` VALUES ('2418', 'HKS', 'insert', '海口市', '460100', 'city', '2015-01-19 15:59:00', '1', '110.330802,20.022071', '460000', null, '2418', '2015-01-19 15:59:00', 'system', 'A', '琼A', '13', '', '海口市');
INSERT INTO `systemctl_location_info` VALUES ('2419', 'XYQ', 'insert', '秀英区', '460105', 'region', '2015-01-19 15:59:00', '1', '', '460100', null, '2419', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秀英区');
INSERT INTO `systemctl_location_info` VALUES ('2420', 'LHQ', 'insert', '龙华区', '460106', 'region', '2015-01-19 15:59:00', '1', '', '460100', null, '2420', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙华区');
INSERT INTO `systemctl_location_info` VALUES ('2421', 'QSQ', 'insert', '琼山区', '460107', 'region', '2015-01-19 15:59:00', '1', '', '460100', null, '2421', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '琼山区');
INSERT INTO `systemctl_location_info` VALUES ('2422', 'MLQ', 'insert', '美兰区', '460108', 'region', '2015-01-19 15:59:00', '1', '', '460100', null, '2422', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '美兰区');
INSERT INTO `systemctl_location_info` VALUES ('2423', 'SYS', 'insert', '三亚市', '460200', 'city', '2015-01-19 15:59:00', '1', '109.522771,18.257776', '460000', null, '2423', '2015-01-19 15:59:00', 'system', 'A', '琼B', '12', '', '三亚市');
INSERT INTO `systemctl_location_info` VALUES ('2424', 'SYS', 'insert', '三亚市', '460201', 'region', '2015-01-19 15:59:00', '1', '', '460200', null, '2424', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三亚市');
INSERT INTO `systemctl_location_info` VALUES ('2425', 'SSS', 'insert', '三沙市', '460300', 'city', '2015-01-19 15:59:00', '1', '', '460000', null, '2425', '2015-01-19 15:59:00', 'system', 'A', '琼', '', '', '三沙市');
INSERT INTO `systemctl_location_info` VALUES ('2426', 'XSQD', 'insert', '西沙群岛', '460321', 'region', '2015-01-19 15:59:00', '1', '', '460300', null, '2426', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西沙群岛');
INSERT INTO `systemctl_location_info` VALUES ('2427', 'NSQD', 'insert', '南沙群岛', '460322', 'region', '2015-01-19 15:59:00', '1', '', '460300', null, '2427', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南沙群岛');
INSERT INTO `systemctl_location_info` VALUES ('2428', 'ZSQD', 'insert', '中沙群岛', '460323', 'region', '2015-01-19 15:59:00', '1', '', '460300', null, '2428', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中沙群岛');
INSERT INTO `systemctl_location_info` VALUES ('2429', 'SZX', 'insert', '省直辖', '469000', 'city', '2015-01-19 15:59:00', '1', '', '460000', null, '2429', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '省直辖');
INSERT INTO `systemctl_location_info` VALUES ('2430', 'WZSS', 'insert', '五指山市', '469001', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2430', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五指山市');
INSERT INTO `systemctl_location_info` VALUES ('2431', 'QHS', 'insert', '琼海市', '469002', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2431', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '琼海市');
INSERT INTO `systemctl_location_info` VALUES ('2432', 'DZS', 'insert', '儋州市', '469003', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2432', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '儋州市');
INSERT INTO `systemctl_location_info` VALUES ('2433', 'WCS', 'insert', '文昌市', '469005', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2433', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文昌市');
INSERT INTO `systemctl_location_info` VALUES ('2434', 'WNS', 'insert', '万宁市', '469006', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2434', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万宁市');
INSERT INTO `systemctl_location_info` VALUES ('2435', 'DFS', 'insert', '东方市', '469007', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2435', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东方市');
INSERT INTO `systemctl_location_info` VALUES ('2436', 'DAX', 'insert', '定安县', '469021', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2436', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定安县');
INSERT INTO `systemctl_location_info` VALUES ('2437', 'TCX', 'insert', '屯昌县', '469022', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2437', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '屯昌县');
INSERT INTO `systemctl_location_info` VALUES ('2438', 'CMX', 'insert', '澄迈县', '469023', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2438', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澄迈县');
INSERT INTO `systemctl_location_info` VALUES ('2439', 'LGX', 'insert', '临高县', '469024', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2439', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临高县');
INSERT INTO `systemctl_location_info` VALUES ('2440', 'BSLZZZX', 'insert', '白沙黎族自治县', '469025', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2440', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白沙黎族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2441', 'CJLZZZX', 'insert', '昌江黎族自治县', '469026', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2441', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌江黎族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2442', 'LDLZZZX', 'insert', '乐东黎族自治县', '469027', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2442', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐东黎族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2443', 'LSLZZZX', 'insert', '陵水黎族自治县', '469028', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2443', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陵水黎族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2444', 'BTLZMZZZX', 'insert', '保亭黎族苗族自治县', '469029', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2444', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '保亭黎族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2445', 'QZLZMZZZX', 'insert', '琼中黎族苗族自治县', '469030', 'region', '2015-01-19 15:59:00', '1', '', '469000', null, '2445', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '琼中黎族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2446', 'ZQS', 'insert', '重庆市', '500000', 'city', '2015-01-19 15:59:00', '1', '106.530635,29.544606', '100003', null, '2446', '2015-01-19 15:59:00', 'system', 'A', '渝', '12', '', '重庆市');
INSERT INTO `systemctl_location_info` VALUES ('2447', 'WZQ', 'insert', '万州区', '500101', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2447', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万州区');
INSERT INTO `systemctl_location_info` VALUES ('2448', 'FLQ', 'insert', '涪陵区', '500102', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2448', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涪陵区');
INSERT INTO `systemctl_location_info` VALUES ('2449', 'YZQ', 'insert', '渝中区', '500103', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2449', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '渝中区');
INSERT INTO `systemctl_location_info` VALUES ('2450', 'DDKQ', 'insert', '大渡口区', '500104', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2450', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大渡口区');
INSERT INTO `systemctl_location_info` VALUES ('2451', 'JBQ', 'insert', '江北区', '500105', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2451', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江北区');
INSERT INTO `systemctl_location_info` VALUES ('2452', 'SPBQ', 'insert', '沙坪坝区', '500106', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2452', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙坪坝区');
INSERT INTO `systemctl_location_info` VALUES ('2453', 'JLPQ', 'insert', '九龙坡区', '500107', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2453', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '九龙坡区');
INSERT INTO `systemctl_location_info` VALUES ('2454', 'NAQ', 'insert', '南岸区', '500108', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2454', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南岸区');
INSERT INTO `systemctl_location_info` VALUES ('2455', 'BBQ', 'insert', '北碚区', '500109', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2455', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北碚区');
INSERT INTO `systemctl_location_info` VALUES ('2456', 'QJQ', 'insert', '綦江区', '500110', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2456', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '綦江区');
INSERT INTO `systemctl_location_info` VALUES ('2457', 'DZQ', 'insert', '大足区', '500111', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2457', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大足区');
INSERT INTO `systemctl_location_info` VALUES ('2458', 'YBQ', 'insert', '渝北区', '500112', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2458', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '渝北区');
INSERT INTO `systemctl_location_info` VALUES ('2459', 'BNQ', 'insert', '巴南区', '500113', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2459', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴南区');
INSERT INTO `systemctl_location_info` VALUES ('2460', 'QJQ', 'insert', '黔江区', '500114', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2460', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黔江区');
INSERT INTO `systemctl_location_info` VALUES ('2461', 'ZSQ', 'insert', '长寿区', '500115', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2461', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长寿区');
INSERT INTO `systemctl_location_info` VALUES ('2462', 'JJQ', 'insert', '江津区', '500116', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2462', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江津区');
INSERT INTO `systemctl_location_info` VALUES ('2463', 'HCQ', 'insert', '合川区', '500117', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2463', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '合川区');
INSERT INTO `systemctl_location_info` VALUES ('2464', 'YCQ', 'insert', '永川区', '500118', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2464', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永川区');
INSERT INTO `systemctl_location_info` VALUES ('2465', 'NCQ', 'insert', '南川区', '500119', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2465', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南川区');
INSERT INTO `systemctl_location_info` VALUES ('2466', 'TNX', 'insert', '潼南县', '500223', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2466', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潼南县');
INSERT INTO `systemctl_location_info` VALUES ('2467', 'TLX', 'insert', '铜梁县', '500224', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2467', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '铜梁县');
INSERT INTO `systemctl_location_info` VALUES ('2468', 'RCX', 'insert', '荣昌县', '500226', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2468', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荣昌县');
INSERT INTO `systemctl_location_info` VALUES ('2469', 'BSX', 'insert', '璧山县', '500227', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2469', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '璧山县');
INSERT INTO `systemctl_location_info` VALUES ('2470', 'LPX', 'insert', '梁平县', '500228', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2470', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梁平县');
INSERT INTO `systemctl_location_info` VALUES ('2471', 'CKX', 'insert', '城口县', '500229', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2471', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城口县');
INSERT INTO `systemctl_location_info` VALUES ('2472', 'FDX', 'insert', '丰都县', '500230', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2472', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丰都县');
INSERT INTO `systemctl_location_info` VALUES ('2473', 'DJX', 'insert', '垫江县', '500231', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2473', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '垫江县');
INSERT INTO `systemctl_location_info` VALUES ('2474', 'WLX', 'insert', '武隆县', '500232', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2474', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武隆县');
INSERT INTO `systemctl_location_info` VALUES ('2475', 'ZX', 'insert', '忠县', '500233', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2475', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '忠县');
INSERT INTO `systemctl_location_info` VALUES ('2476', 'KX', 'insert', '开县', '500234', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2476', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开县');
INSERT INTO `systemctl_location_info` VALUES ('2477', 'YYX', 'insert', '云阳县', '500235', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2477', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云阳县');
INSERT INTO `systemctl_location_info` VALUES ('2478', 'FJX', 'insert', '奉节县', '500236', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2478', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '奉节县');
INSERT INTO `systemctl_location_info` VALUES ('2479', 'WSX', 'insert', '巫山县', '500237', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2479', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巫山县');
INSERT INTO `systemctl_location_info` VALUES ('2480', 'WXX', 'insert', '巫溪县', '500238', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2480', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巫溪县');
INSERT INTO `systemctl_location_info` VALUES ('2481', 'SZTJZZZX', 'insert', '石柱土家族自治县', '500240', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2481', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石柱土家族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2482', 'XSTJZMZZZX', 'insert', '秀山土家族苗族自治县', '500241', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2482', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秀山土家族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2483', 'YYTJZMZZZX', 'insert', '酉阳土家族苗族自治县', '500242', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2483', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '酉阳土家族苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2484', 'PSMZTJZZZX', 'insert', '彭水苗族土家族自治县', '500243', 'region', '2015-01-19 15:59:00', '1', '', '500000', null, '2484', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彭水苗族土家族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2485', 'SCS', 'insert', '四川省', '510000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2485', '2015-01-19 15:59:00', 'system', 'A', '川', '', '', '四川省');
INSERT INTO `systemctl_location_info` VALUES ('2486', 'CDS', 'insert', '成都市', '510100', 'city', '2015-01-19 15:59:00', '1', '104.067923,30.679943', '510000', null, '2486', '2015-01-19 15:59:00', 'system', 'A', '川A', '12', '', '成都市');
INSERT INTO `systemctl_location_info` VALUES ('2487', 'JJQ', 'insert', '锦江区', '510104', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2487', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '锦江区');
INSERT INTO `systemctl_location_info` VALUES ('2488', 'QYQ', 'insert', '青羊区', '510105', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2488', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青羊区');
INSERT INTO `systemctl_location_info` VALUES ('2489', 'JNQ', 'insert', '金牛区', '510106', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2489', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金牛区');
INSERT INTO `systemctl_location_info` VALUES ('2490', 'WHQ', 'insert', '武侯区', '510107', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2490', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武侯区');
INSERT INTO `systemctl_location_info` VALUES ('2491', 'CHQ', 'insert', '成华区', '510108', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2491', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '成华区');
INSERT INTO `systemctl_location_info` VALUES ('2492', 'LQYQ', 'insert', '龙泉驿区', '510112', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2492', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙泉驿区');
INSERT INTO `systemctl_location_info` VALUES ('2493', 'QBJQ', 'insert', '青白江区', '510113', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2493', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青白江区');
INSERT INTO `systemctl_location_info` VALUES ('2494', 'XDQ', 'insert', '新都区', '510114', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2494', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新都区');
INSERT INTO `systemctl_location_info` VALUES ('2495', 'WJQ', 'insert', '温江区', '510115', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2495', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '温江区');
INSERT INTO `systemctl_location_info` VALUES ('2496', 'JTX', 'insert', '金堂县', '510121', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2496', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金堂县');
INSERT INTO `systemctl_location_info` VALUES ('2497', 'SLX', 'insert', '双流县', '510122', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2497', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双流县');
INSERT INTO `systemctl_location_info` VALUES ('2498', 'PX', 'insert', '郫县', '510124', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2498', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '郫县');
INSERT INTO `systemctl_location_info` VALUES ('2499', 'DYX', 'insert', '大邑县', '510129', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2499', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大邑县');
INSERT INTO `systemctl_location_info` VALUES ('2500', 'PJX', 'insert', '蒲江县', '510131', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2500', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蒲江县');
INSERT INTO `systemctl_location_info` VALUES ('2501', 'XJX', 'insert', '新津县', '510132', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2501', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新津县');
INSERT INTO `systemctl_location_info` VALUES ('2502', 'DJYS', 'insert', '都江堰市', '510181', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2502', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '都江堰市');
INSERT INTO `systemctl_location_info` VALUES ('2503', 'PZS', 'insert', '彭州市', '510182', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2503', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彭州市');
INSERT INTO `systemctl_location_info` VALUES ('2504', 'QLS', 'insert', '邛崃市', '510183', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2504', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邛崃市');
INSERT INTO `systemctl_location_info` VALUES ('2505', 'CZS', 'insert', '崇州市', '510184', 'region', '2015-01-19 15:59:00', '1', '', '510100', null, '2505', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇州市');
INSERT INTO `systemctl_location_info` VALUES ('2506', 'ZGS', 'insert', '自贡市', '510300', 'city', '2015-01-19 15:59:00', '1', '104.776071,29.359157', '510000', null, '2506', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '自贡市');
INSERT INTO `systemctl_location_info` VALUES ('2507', 'ZLJQ', 'insert', '自流井区', '510302', 'region', '2015-01-19 15:59:00', '1', '', '510300', null, '2507', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '自流井区');
INSERT INTO `systemctl_location_info` VALUES ('2508', 'GJQ', 'insert', '贡井区', '510303', 'region', '2015-01-19 15:59:00', '1', '', '510300', null, '2508', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贡井区');
INSERT INTO `systemctl_location_info` VALUES ('2509', 'DAQ', 'insert', '大安区', '510304', 'region', '2015-01-19 15:59:00', '1', '', '510300', null, '2509', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大安区');
INSERT INTO `systemctl_location_info` VALUES ('2510', 'YTQ', 'insert', '沿滩区', '510311', 'region', '2015-01-19 15:59:00', '1', '', '510300', null, '2510', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沿滩区');
INSERT INTO `systemctl_location_info` VALUES ('2511', 'RX', 'insert', '荣县', '510321', 'region', '2015-01-19 15:59:00', '1', '', '510300', null, '2511', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荣县');
INSERT INTO `systemctl_location_info` VALUES ('2512', 'FSX', 'insert', '富顺县', '510322', 'region', '2015-01-19 15:59:00', '1', '', '510300', null, '2512', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富顺县');
INSERT INTO `systemctl_location_info` VALUES ('2513', 'PZHS', 'insert', '攀枝花市', '510400', 'city', '2015-01-19 15:59:00', '1', '101.722423,26.587571', '510000', null, '2513', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '攀枝花市');
INSERT INTO `systemctl_location_info` VALUES ('2514', 'DQ', 'insert', '东区', '510402', 'region', '2015-01-19 15:59:00', '1', '', '510400', null, '2514', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东区');
INSERT INTO `systemctl_location_info` VALUES ('2515', 'XQ', 'insert', '西区', '510403', 'region', '2015-01-19 15:59:00', '1', '', '510400', null, '2515', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西区');
INSERT INTO `systemctl_location_info` VALUES ('2516', 'RHQ', 'insert', '仁和区', '510411', 'region', '2015-01-19 15:59:00', '1', '', '510400', null, '2516', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仁和区');
INSERT INTO `systemctl_location_info` VALUES ('2517', 'MYX', 'insert', '米易县', '510421', 'region', '2015-01-19 15:59:00', '1', '', '510400', null, '2517', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '米易县');
INSERT INTO `systemctl_location_info` VALUES ('2518', 'YBX', 'insert', '盐边县', '510422', 'region', '2015-01-19 15:59:00', '1', '', '510400', null, '2518', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐边县');
INSERT INTO `systemctl_location_info` VALUES ('2519', 'LZS', 'insert', '泸州市', '510500', 'city', '2015-01-19 15:59:00', '1', '105.44397,28.89593', '510000', null, '2519', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '泸州市');
INSERT INTO `systemctl_location_info` VALUES ('2520', 'JYQ', 'insert', '江阳区', '510502', 'region', '2015-01-19 15:59:00', '1', '', '510500', null, '2520', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江阳区');
INSERT INTO `systemctl_location_info` VALUES ('2521', 'NXQ', 'insert', '纳溪区', '510503', 'region', '2015-01-19 15:59:00', '1', '', '510500', null, '2521', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '纳溪区');
INSERT INTO `systemctl_location_info` VALUES ('2522', 'LMTQ', 'insert', '龙马潭区', '510504', 'region', '2015-01-19 15:59:00', '1', '', '510500', null, '2522', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙马潭区');
INSERT INTO `systemctl_location_info` VALUES ('2523', 'LX', 'insert', '泸县', '510521', 'region', '2015-01-19 15:59:00', '1', '', '510500', null, '2523', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泸县');
INSERT INTO `systemctl_location_info` VALUES ('2524', 'HJX', 'insert', '合江县', '510522', 'region', '2015-01-19 15:59:00', '1', '', '510500', null, '2524', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '合江县');
INSERT INTO `systemctl_location_info` VALUES ('2525', 'XYX', 'insert', '叙永县', '510524', 'region', '2015-01-19 15:59:00', '1', '', '510500', null, '2525', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '叙永县');
INSERT INTO `systemctl_location_info` VALUES ('2526', 'GLX', 'insert', '古蔺县', '510525', 'region', '2015-01-19 15:59:00', '1', '', '510500', null, '2526', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古蔺县');
INSERT INTO `systemctl_location_info` VALUES ('2527', 'DYS', 'insert', '德阳市', '510600', 'city', '2015-01-19 15:59:00', '1', '104.402398,31.13114', '510000', null, '2527', '2015-01-19 15:59:00', 'system', 'A', '川F', '13', '', '德阳市');
INSERT INTO `systemctl_location_info` VALUES ('2528', 'JYQ', 'insert', '旌阳区', '510603', 'region', '2015-01-19 15:59:00', '1', '', '510600', null, '2528', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '旌阳区');
INSERT INTO `systemctl_location_info` VALUES ('2529', 'ZJX', 'insert', '中江县', '510623', 'region', '2015-01-19 15:59:00', '1', '', '510600', null, '2529', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中江县');
INSERT INTO `systemctl_location_info` VALUES ('2530', 'LJX', 'insert', '罗江县', '510626', 'region', '2015-01-19 15:59:00', '1', '', '510600', null, '2530', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '罗江县');
INSERT INTO `systemctl_location_info` VALUES ('2531', 'GHS', 'insert', '广汉市', '510681', 'region', '2015-01-19 15:59:00', '1', '', '510600', null, '2531', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广汉市');
INSERT INTO `systemctl_location_info` VALUES ('2532', 'SFS', 'insert', '什邡市', '510682', 'region', '2015-01-19 15:59:00', '1', '', '510600', null, '2532', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '什邡市');
INSERT INTO `systemctl_location_info` VALUES ('2533', 'MZS', 'insert', '绵竹市', '510683', 'region', '2015-01-19 15:59:00', '1', '', '510600', null, '2533', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绵竹市');
INSERT INTO `systemctl_location_info` VALUES ('2534', 'MYS', 'insert', '绵阳市', '510700', 'city', '2015-01-19 15:59:00', '1', '104.705519,31.504701', '510000', null, '2534', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '绵阳市');
INSERT INTO `systemctl_location_info` VALUES ('2535', 'FCQ', 'insert', '涪城区', '510703', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2535', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '涪城区');
INSERT INTO `systemctl_location_info` VALUES ('2536', 'YXQ', 'insert', '游仙区', '510704', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2536', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '游仙区');
INSERT INTO `systemctl_location_info` VALUES ('2537', 'STX', 'insert', '三台县', '510722', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2537', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三台县');
INSERT INTO `systemctl_location_info` VALUES ('2538', 'YTX', 'insert', '盐亭县', '510723', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2538', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐亭县');
INSERT INTO `systemctl_location_info` VALUES ('2539', 'AX', 'insert', '安县', '510724', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2539', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安县');
INSERT INTO `systemctl_location_info` VALUES ('2540', 'ZTX', 'insert', '梓潼县', '510725', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2540', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梓潼县');
INSERT INTO `systemctl_location_info` VALUES ('2541', 'BCQZZZX', 'insert', '北川羌族自治县', '510726', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2541', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北川羌族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2542', 'PWX', 'insert', '平武县', '510727', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2542', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平武县');
INSERT INTO `systemctl_location_info` VALUES ('2543', 'JYS', 'insert', '江油市', '510781', 'region', '2015-01-19 15:59:00', '1', '', '510700', null, '2543', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江油市');
INSERT INTO `systemctl_location_info` VALUES ('2544', 'GYS', 'insert', '广元市', '510800', 'city', '2015-01-19 15:59:00', '1', '105.819687,32.44104', '510000', null, '2544', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '广元市');
INSERT INTO `systemctl_location_info` VALUES ('2545', 'LZQ', 'insert', '利州区', '510802', 'region', '2015-01-19 15:59:00', '1', '', '510800', null, '2545', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '利州区');
INSERT INTO `systemctl_location_info` VALUES ('2546', 'YBQ', 'insert', '元坝区', '510811', 'region', '2015-01-19 15:59:00', '1', '', '510800', null, '2546', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '元坝区');
INSERT INTO `systemctl_location_info` VALUES ('2547', 'CTQ', 'insert', '朝天区', '510812', 'region', '2015-01-19 15:59:00', '1', '', '510800', null, '2547', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '朝天区');
INSERT INTO `systemctl_location_info` VALUES ('2548', 'WCX', 'insert', '旺苍县', '510821', 'region', '2015-01-19 15:59:00', '1', '', '510800', null, '2548', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '旺苍县');
INSERT INTO `systemctl_location_info` VALUES ('2549', 'QCX', 'insert', '青川县', '510822', 'region', '2015-01-19 15:59:00', '1', '', '510800', null, '2549', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青川县');
INSERT INTO `systemctl_location_info` VALUES ('2550', 'JGX', 'insert', '剑阁县', '510823', 'region', '2015-01-19 15:59:00', '1', '', '510800', null, '2550', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '剑阁县');
INSERT INTO `systemctl_location_info` VALUES ('2551', 'CXX', 'insert', '苍溪县', '510824', 'region', '2015-01-19 15:59:00', '1', '', '510800', null, '2551', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苍溪县');
INSERT INTO `systemctl_location_info` VALUES ('2552', 'SNS', 'insert', '遂宁市', '510900', 'city', '2015-01-19 15:59:00', '1', '105.564888,30.557491', '510000', null, '2552', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '遂宁市');
INSERT INTO `systemctl_location_info` VALUES ('2553', 'CSQ', 'insert', '船山区', '510903', 'region', '2015-01-19 15:59:00', '1', '', '510900', null, '2553', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '船山区');
INSERT INTO `systemctl_location_info` VALUES ('2554', 'AJQ', 'insert', '安居区', '510904', 'region', '2015-01-19 15:59:00', '1', '', '510900', null, '2554', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安居区');
INSERT INTO `systemctl_location_info` VALUES ('2555', 'PXX', 'insert', '蓬溪县', '510921', 'region', '2015-01-19 15:59:00', '1', '', '510900', null, '2555', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蓬溪县');
INSERT INTO `systemctl_location_info` VALUES ('2556', 'SHX', 'insert', '射洪县', '510922', 'region', '2015-01-19 15:59:00', '1', '', '510900', null, '2556', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '射洪县');
INSERT INTO `systemctl_location_info` VALUES ('2557', 'DYX', 'insert', '大英县', '510923', 'region', '2015-01-19 15:59:00', '1', '', '510900', null, '2557', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大英县');
INSERT INTO `systemctl_location_info` VALUES ('2558', 'NJS', 'insert', '内江市', '511000', 'city', '2015-01-19 15:59:00', '1', '105.073056,29.599462', '510000', null, '2558', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '内江市');
INSERT INTO `systemctl_location_info` VALUES ('2559', 'SZQ', 'insert', '市中区', '511002', 'region', '2015-01-19 15:59:00', '1', '', '511000', null, '2559', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '市中区');
INSERT INTO `systemctl_location_info` VALUES ('2560', 'DXQ', 'insert', '东兴区', '511011', 'region', '2015-01-19 15:59:00', '1', '', '511000', null, '2560', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东兴区');
INSERT INTO `systemctl_location_info` VALUES ('2561', 'WYX', 'insert', '威远县', '511024', 'region', '2015-01-19 15:59:00', '1', '', '511000', null, '2561', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '威远县');
INSERT INTO `systemctl_location_info` VALUES ('2562', 'ZZX', 'insert', '资中县', '511025', 'region', '2015-01-19 15:59:00', '1', '', '511000', null, '2562', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '资中县');
INSERT INTO `systemctl_location_info` VALUES ('2563', 'LCX', 'insert', '隆昌县', '511028', 'region', '2015-01-19 15:59:00', '1', '', '511000', null, '2563', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆昌县');
INSERT INTO `systemctl_location_info` VALUES ('2564', 'LSS', 'insert', '乐山市', '511100', 'city', '2015-01-19 15:59:00', '1', '103.760824,29.600958', '510000', null, '2564', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '乐山市');
INSERT INTO `systemctl_location_info` VALUES ('2565', 'SZQ', 'insert', '市中区', '511102', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2565', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '市中区');
INSERT INTO `systemctl_location_info` VALUES ('2566', 'SWQ', 'insert', '沙湾区', '511111', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2566', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙湾区');
INSERT INTO `systemctl_location_info` VALUES ('2567', 'WTQQ', 'insert', '五通桥区', '511112', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2567', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五通桥区');
INSERT INTO `systemctl_location_info` VALUES ('2568', 'JKHQ', 'insert', '金口河区', '511113', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2568', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金口河区');
INSERT INTO `systemctl_location_info` VALUES ('2569', 'JWX', 'insert', '犍为县', '511123', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2569', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '犍为县');
INSERT INTO `systemctl_location_info` VALUES ('2570', 'JYX', 'insert', '井研县', '511124', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2570', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '井研县');
INSERT INTO `systemctl_location_info` VALUES ('2571', 'JJX', 'insert', '夹江县', '511126', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2571', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '夹江县');
INSERT INTO `systemctl_location_info` VALUES ('2572', 'MCX', 'insert', '沐川县', '511129', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2572', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沐川县');
INSERT INTO `systemctl_location_info` VALUES ('2573', 'EBYZZZX', 'insert', '峨边彝族自治县', '511132', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2573', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '峨边彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2574', 'MBYZZZX', 'insert', '马边彝族自治县', '511133', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2574', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '马边彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2575', 'EMSS', 'insert', '峨眉山市', '511181', 'region', '2015-01-19 15:59:00', '1', '', '511100', null, '2575', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '峨眉山市');
INSERT INTO `systemctl_location_info` VALUES ('2576', 'NCS', 'insert', '南充市', '511300', 'city', '2015-01-19 15:59:00', '1', '106.105554,30.800965', '510000', null, '2576', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '南充市');
INSERT INTO `systemctl_location_info` VALUES ('2577', 'SQQ', 'insert', '顺庆区', '511302', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2577', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '顺庆区');
INSERT INTO `systemctl_location_info` VALUES ('2578', 'GPQ', 'insert', '高坪区', '511303', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2578', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高坪区');
INSERT INTO `systemctl_location_info` VALUES ('2579', 'JLQ', 'insert', '嘉陵区', '511304', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2579', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉陵区');
INSERT INTO `systemctl_location_info` VALUES ('2580', 'NBX', 'insert', '南部县', '511321', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2580', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南部县');
INSERT INTO `systemctl_location_info` VALUES ('2581', 'YSX', 'insert', '营山县', '511322', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2581', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '营山县');
INSERT INTO `systemctl_location_info` VALUES ('2582', 'PAX', 'insert', '蓬安县', '511323', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2582', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蓬安县');
INSERT INTO `systemctl_location_info` VALUES ('2583', 'YLX', 'insert', '仪陇县', '511324', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2583', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仪陇县');
INSERT INTO `systemctl_location_info` VALUES ('2584', 'XCX', 'insert', '西充县', '511325', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2584', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西充县');
INSERT INTO `systemctl_location_info` VALUES ('2585', 'LZS', 'insert', '阆中市', '511381', 'region', '2015-01-19 15:59:00', '1', '', '511300', null, '2585', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阆中市');
INSERT INTO `systemctl_location_info` VALUES ('2586', 'MSS', 'insert', '眉山市', '511400', 'city', '2015-01-19 15:59:00', '1', '103.84143,30.061115', '510000', null, '2586', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '眉山市');
INSERT INTO `systemctl_location_info` VALUES ('2587', 'DPQ', 'insert', '东坡区', '511402', 'region', '2015-01-19 15:59:00', '1', '', '511400', null, '2587', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东坡区');
INSERT INTO `systemctl_location_info` VALUES ('2588', 'RSX', 'insert', '仁寿县', '511421', 'region', '2015-01-19 15:59:00', '1', '', '511400', null, '2588', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仁寿县');
INSERT INTO `systemctl_location_info` VALUES ('2589', 'PSX', 'insert', '彭山县', '511422', 'region', '2015-01-19 15:59:00', '1', '', '511400', null, '2589', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彭山县');
INSERT INTO `systemctl_location_info` VALUES ('2590', 'HYX', 'insert', '洪雅县', '511423', 'region', '2015-01-19 15:59:00', '1', '', '511400', null, '2590', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洪雅县');
INSERT INTO `systemctl_location_info` VALUES ('2591', 'DLX', 'insert', '丹棱县', '511424', 'region', '2015-01-19 15:59:00', '1', '', '511400', null, '2591', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丹棱县');
INSERT INTO `systemctl_location_info` VALUES ('2592', 'QSX', 'insert', '青神县', '511425', 'region', '2015-01-19 15:59:00', '1', '', '511400', null, '2592', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青神县');
INSERT INTO `systemctl_location_info` VALUES ('2593', 'YBS', 'insert', '宜宾市', '511500', 'city', '2015-01-19 15:59:00', '1', '104.633019,28.769675', '510000', null, '2593', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '宜宾市');
INSERT INTO `systemctl_location_info` VALUES ('2594', 'CPQ', 'insert', '翠屏区', '511502', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2594', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '翠屏区');
INSERT INTO `systemctl_location_info` VALUES ('2595', 'YBX', 'insert', '宜宾县', '511521', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2595', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜宾县');
INSERT INTO `systemctl_location_info` VALUES ('2596', 'NXQ', 'insert', '南溪区', '511522', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2596', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南溪区');
INSERT INTO `systemctl_location_info` VALUES ('2597', 'JAX', 'insert', '江安县', '511523', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2597', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江安县');
INSERT INTO `systemctl_location_info` VALUES ('2598', 'ZNX', 'insert', '长宁县', '511524', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2598', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长宁县');
INSERT INTO `systemctl_location_info` VALUES ('2599', 'GX', 'insert', '高县', '511525', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2599', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高县');
INSERT INTO `systemctl_location_info` VALUES ('2600', 'GX', 'insert', '珙县', '511526', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2600', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '珙县');
INSERT INTO `systemctl_location_info` VALUES ('2601', 'YLX', 'insert', '筠连县', '511527', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2601', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '筠连县');
INSERT INTO `systemctl_location_info` VALUES ('2602', 'XWX', 'insert', '兴文县', '511528', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2602', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴文县');
INSERT INTO `systemctl_location_info` VALUES ('2603', 'PSX', 'insert', '屏山县', '511529', 'region', '2015-01-19 15:59:00', '1', '', '511500', null, '2603', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '屏山县');
INSERT INTO `systemctl_location_info` VALUES ('2604', 'GAS', 'insert', '广安市', '511600', 'city', '2015-01-19 15:59:00', '1', '106.63572,30.463984', '510000', null, '2604', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '广安市');
INSERT INTO `systemctl_location_info` VALUES ('2605', 'GAQ', 'insert', '广安区', '511602', 'region', '2015-01-19 15:59:00', '1', '', '511600', null, '2605', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广安区');
INSERT INTO `systemctl_location_info` VALUES ('2606', 'YCX', 'insert', '岳池县', '511621', 'region', '2015-01-19 15:59:00', '1', '', '511600', null, '2606', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岳池县');
INSERT INTO `systemctl_location_info` VALUES ('2607', 'WSX', 'insert', '武胜县', '511622', 'region', '2015-01-19 15:59:00', '1', '', '511600', null, '2607', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武胜县');
INSERT INTO `systemctl_location_info` VALUES ('2608', 'LSX', 'insert', '邻水县', '511623', 'region', '2015-01-19 15:59:00', '1', '', '511600', null, '2608', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '邻水县');
INSERT INTO `systemctl_location_info` VALUES ('2609', 'HYS', 'insert', '华蓥市', '511681', 'region', '2015-01-19 15:59:00', '1', '', '511600', null, '2609', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华蓥市');
INSERT INTO `systemctl_location_info` VALUES ('2610', 'DZS', 'insert', '达州市', '511700', 'city', '2015-01-19 15:59:00', '1', '107.494973,31.214199', '510000', null, '2610', '2015-01-19 15:59:00', 'system', 'A', '川S', '14', '', '达州市');
INSERT INTO `systemctl_location_info` VALUES ('2611', 'TCQ', 'insert', '通川区', '511702', 'region', '2015-01-19 15:59:00', '1', '', '511700', null, '2611', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通川区');
INSERT INTO `systemctl_location_info` VALUES ('2612', 'DX', 'insert', '达县', '511721', 'region', '2015-01-19 15:59:00', '1', '', '511700', null, '2612', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '达县');
INSERT INTO `systemctl_location_info` VALUES ('2613', 'XHX', 'insert', '宣汉县', '511722', 'region', '2015-01-19 15:59:00', '1', '', '511700', null, '2613', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宣汉县');
INSERT INTO `systemctl_location_info` VALUES ('2614', 'ZYX', 'insert', '沾益县', '530328', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '2614', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沾益县');
INSERT INTO `systemctl_location_info` VALUES ('2615', 'GJX', 'insert', '革吉县', '542525', 'region', '2015-01-19 15:59:00', '1', '', '542500', null, '2615', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '革吉县');
INSERT INTO `systemctl_location_info` VALUES ('2616', 'GZX', 'insert', '改则县', '542526', 'region', '2015-01-19 15:59:00', '1', '', '542500', null, '2616', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '改则县');
INSERT INTO `systemctl_location_info` VALUES ('2617', 'CQX', 'insert', '措勤县', '542527', 'region', '2015-01-19 15:59:00', '1', '', '542500', null, '2617', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '措勤县');
INSERT INTO `systemctl_location_info` VALUES ('2618', 'LZDQ', 'insert', '林芝地区', '542600', 'city', '2015-01-19 15:59:00', '1', '94.349985,29.666941', '540000', null, '2618', '2015-01-19 15:59:00', 'system', 'A', '', '11', '', '林芝地区');
INSERT INTO `systemctl_location_info` VALUES ('2619', 'LZX', 'insert', '林芝县', '542621', 'region', '2015-01-19 15:59:00', '1', '', '542600', null, '2619', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '林芝县');
INSERT INTO `systemctl_location_info` VALUES ('2620', 'GBJDX', 'insert', '工布江达县', '542622', 'region', '2015-01-19 15:59:00', '1', '', '542600', null, '2620', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '工布江达县');
INSERT INTO `systemctl_location_info` VALUES ('2621', 'MLX', 'insert', '米林县', '542623', 'region', '2015-01-19 15:59:00', '1', '', '542600', null, '2621', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '米林县');
INSERT INTO `systemctl_location_info` VALUES ('2622', 'MTX', 'insert', '墨脱县', '542624', 'region', '2015-01-19 15:59:00', '1', '', '542600', null, '2622', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '墨脱县');
INSERT INTO `systemctl_location_info` VALUES ('2623', 'BMX', 'insert', '波密县', '542625', 'region', '2015-01-19 15:59:00', '1', '', '542600', null, '2623', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '波密县');
INSERT INTO `systemctl_location_info` VALUES ('2624', 'CYX', 'insert', '察隅县', '542626', 'region', '2015-01-19 15:59:00', '1', '', '542600', null, '2624', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '察隅县');
INSERT INTO `systemctl_location_info` VALUES ('2625', 'LX', 'insert', '朗县', '542627', 'region', '2015-01-19 15:59:00', '1', '', '542600', null, '2625', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '朗县');
INSERT INTO `systemctl_location_info` VALUES ('2626', 'SXS', 'insert', '陕西省', '610000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2626', '2015-01-19 15:59:00', 'system', 'A', '陕', '', '', '陕西省');
INSERT INTO `systemctl_location_info` VALUES ('2627', 'XAS', 'insert', '西安市', '610100', 'city', '2015-01-19 15:59:00', '1', '108.953098,34.2778', '610000', null, '2627', '2015-01-19 15:59:00', 'system', 'A', '陕A', '12', '', '西安市');
INSERT INTO `systemctl_location_info` VALUES ('2628', 'XCQ', 'insert', '新城区', '610102', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2628', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新城区');
INSERT INTO `systemctl_location_info` VALUES ('2629', 'BLQ', 'insert', '碑林区', '610103', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2629', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '碑林区');
INSERT INTO `systemctl_location_info` VALUES ('2630', 'LHQ', 'insert', '莲湖区', '610104', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2630', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莲湖区');
INSERT INTO `systemctl_location_info` VALUES ('2631', 'BQQ', 'insert', '灞桥区', '610111', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2631', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灞桥区');
INSERT INTO `systemctl_location_info` VALUES ('2632', 'WYQ', 'insert', '未央区', '610112', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2632', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '未央区');
INSERT INTO `systemctl_location_info` VALUES ('2633', 'YTQ', 'insert', '雁塔区', '610113', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2633', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '雁塔区');
INSERT INTO `systemctl_location_info` VALUES ('2634', 'YLQ', 'insert', '阎良区', '610114', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2634', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阎良区');
INSERT INTO `systemctl_location_info` VALUES ('2635', 'LTQ', 'insert', '临潼区', '610115', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2635', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临潼区');
INSERT INTO `systemctl_location_info` VALUES ('2636', 'ZAQ', 'insert', '长安区', '610116', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2636', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长安区');
INSERT INTO `systemctl_location_info` VALUES ('2637', 'LTX', 'insert', '蓝田县', '610122', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2637', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蓝田县');
INSERT INTO `systemctl_location_info` VALUES ('2638', 'ZZX', 'insert', '周至县', '610124', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2638', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '周至县');
INSERT INTO `systemctl_location_info` VALUES ('2639', 'HX', 'insert', '户县', '610125', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2639', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '户县');
INSERT INTO `systemctl_location_info` VALUES ('2640', 'GLX', 'insert', '高陵县', '610126', 'region', '2015-01-19 15:59:00', '1', '', '610100', null, '2640', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高陵县');
INSERT INTO `systemctl_location_info` VALUES ('2641', 'TCS', 'insert', '铜川市', '610200', 'city', '2015-01-19 15:59:00', '1', '108.968067,34.908368', '610000', null, '2641', '2015-01-19 15:59:00', 'system', 'A', '陕B', '13', '', '铜川市');
INSERT INTO `systemctl_location_info` VALUES ('2642', 'WYQ', 'insert', '王益区', '610202', 'region', '2015-01-19 15:59:00', '1', '', '610200', null, '2642', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '王益区');
INSERT INTO `systemctl_location_info` VALUES ('2643', 'YTQ', 'insert', '印台区', '610203', 'region', '2015-01-19 15:59:00', '1', '', '610200', null, '2643', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '印台区');
INSERT INTO `systemctl_location_info` VALUES ('2644', 'YZQ', 'insert', '耀州区', '610204', 'region', '2015-01-19 15:59:00', '1', '', '610200', null, '2644', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '耀州区');
INSERT INTO `systemctl_location_info` VALUES ('2645', 'YJX', 'insert', '宜君县', '610222', 'region', '2015-01-19 15:59:00', '1', '', '610200', null, '2645', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜君县');
INSERT INTO `systemctl_location_info` VALUES ('2646', 'BJS', 'insert', '宝鸡市', '610300', 'city', '2015-01-19 15:59:00', '1', '107.170645,34.364081', '610000', null, '2646', '2015-01-19 15:59:00', 'system', 'A', '陕C', '12', '', '宝鸡市');
INSERT INTO `systemctl_location_info` VALUES ('2647', 'WBQ', 'insert', '渭滨区', '610302', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2647', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '渭滨区');
INSERT INTO `systemctl_location_info` VALUES ('2648', 'JTQ', 'insert', '金台区', '610303', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2648', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金台区');
INSERT INTO `systemctl_location_info` VALUES ('2649', 'CCQ', 'insert', '陈仓区', '610304', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2649', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陈仓区');
INSERT INTO `systemctl_location_info` VALUES ('2650', 'FXX', 'insert', '凤翔县', '610322', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2650', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤翔县');
INSERT INTO `systemctl_location_info` VALUES ('2651', 'QSX', 'insert', '岐山县', '610323', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2651', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岐山县');
INSERT INTO `systemctl_location_info` VALUES ('2652', 'FFX', 'insert', '扶风县', '610324', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2652', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扶风县');
INSERT INTO `systemctl_location_info` VALUES ('2653', 'MX', 'insert', '眉县', '610326', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2653', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '眉县');
INSERT INTO `systemctl_location_info` VALUES ('2654', 'LX', 'insert', '陇县', '610327', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2654', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陇县');
INSERT INTO `systemctl_location_info` VALUES ('2655', 'QYX', 'insert', '千阳县', '610328', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2655', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '千阳县');
INSERT INTO `systemctl_location_info` VALUES ('2656', 'LYX', 'insert', '麟游县', '610329', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2656', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麟游县');
INSERT INTO `systemctl_location_info` VALUES ('2657', 'FX', 'insert', '凤县', '610330', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2657', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤县');
INSERT INTO `systemctl_location_info` VALUES ('2658', 'TBX', 'insert', '太白县', '610331', 'region', '2015-01-19 15:59:00', '1', '', '610300', null, '2658', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '太白县');
INSERT INTO `systemctl_location_info` VALUES ('2659', 'XYS', 'insert', '咸阳市', '610400', 'city', '2015-01-19 15:59:00', '1', '108.707509,34.345373', '610000', null, '2659', '2015-01-19 15:59:00', 'system', 'A', '陕D', '13', '', '咸阳市');
INSERT INTO `systemctl_location_info` VALUES ('2660', 'QDQ', 'insert', '秦都区', '610402', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2660', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秦都区');
INSERT INTO `systemctl_location_info` VALUES ('2661', 'YLQ', 'insert', '杨陵区', '610403', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2661', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杨陵区');
INSERT INTO `systemctl_location_info` VALUES ('2662', 'WCQ', 'insert', '渭城区', '610404', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2662', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '渭城区');
INSERT INTO `systemctl_location_info` VALUES ('2663', 'SYX', 'insert', '三原县', '610422', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2663', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三原县');
INSERT INTO `systemctl_location_info` VALUES ('2664', 'JYX', 'insert', '泾阳县', '610423', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2664', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泾阳县');
INSERT INTO `systemctl_location_info` VALUES ('2665', 'QX', 'insert', '乾县', '610424', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2665', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乾县');
INSERT INTO `systemctl_location_info` VALUES ('2666', 'LQX', 'insert', '礼泉县', '610425', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2666', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '礼泉县');
INSERT INTO `systemctl_location_info` VALUES ('2667', 'YSX', 'insert', '永寿县', '610426', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2667', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永寿县');
INSERT INTO `systemctl_location_info` VALUES ('2668', 'BX', 'insert', '彬县', '610427', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2668', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彬县');
INSERT INTO `systemctl_location_info` VALUES ('2669', 'ZWX', 'insert', '长武县', '610428', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2669', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '长武县');
INSERT INTO `systemctl_location_info` VALUES ('2670', 'XYX', 'insert', '旬邑县', '610429', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2670', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '旬邑县');
INSERT INTO `systemctl_location_info` VALUES ('2671', 'CHX', 'insert', '淳化县', '610430', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2671', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '淳化县');
INSERT INTO `systemctl_location_info` VALUES ('2672', 'WGX', 'insert', '武功县', '610431', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2672', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武功县');
INSERT INTO `systemctl_location_info` VALUES ('2673', 'XPS', 'insert', '兴平市', '610481', 'region', '2015-01-19 15:59:00', '1', '', '610400', null, '2673', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴平市');
INSERT INTO `systemctl_location_info` VALUES ('2674', 'WNS', 'insert', '渭南市', '610500', 'city', '2015-01-19 15:59:00', '1', '109.483933,34.502358', '610000', null, '2674', '2015-01-19 15:59:00', 'system', 'A', '陕E', '13', '', '渭南市');
INSERT INTO `systemctl_location_info` VALUES ('2675', 'LWQ', 'insert', '临渭区', '610502', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2675', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临渭区');
INSERT INTO `systemctl_location_info` VALUES ('2676', 'HX', 'insert', '华县', '610521', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2676', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华县');
INSERT INTO `systemctl_location_info` VALUES ('2677', 'TGX', 'insert', '潼关县', '610522', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2677', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '潼关县');
INSERT INTO `systemctl_location_info` VALUES ('2678', 'DLX', 'insert', '大荔县', '610523', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2678', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大荔县');
INSERT INTO `systemctl_location_info` VALUES ('2679', 'HYX', 'insert', '合阳县', '610524', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2679', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '合阳县');
INSERT INTO `systemctl_location_info` VALUES ('2680', 'CCX', 'insert', '澄城县', '610525', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2680', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澄城县');
INSERT INTO `systemctl_location_info` VALUES ('2681', 'PCX', 'insert', '蒲城县', '610526', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2681', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蒲城县');
INSERT INTO `systemctl_location_info` VALUES ('2682', 'BSX', 'insert', '白水县', '610527', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2682', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白水县');
INSERT INTO `systemctl_location_info` VALUES ('2683', 'FPX', 'insert', '富平县', '610528', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2683', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富平县');
INSERT INTO `systemctl_location_info` VALUES ('2684', 'HCS', 'insert', '韩城市', '610581', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2684', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '韩城市');
INSERT INTO `systemctl_location_info` VALUES ('2685', 'HYS', 'insert', '华阴市', '610582', 'region', '2015-01-19 15:59:00', '1', '', '610500', null, '2685', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华阴市');
INSERT INTO `systemctl_location_info` VALUES ('2686', 'YAS', 'insert', '延安市', '610600', 'city', '2015-01-19 15:59:00', '1', '109.50051,36.60332', '610000', null, '2686', '2015-01-19 15:59:00', 'system', 'A', '陕J', '13', '', '延安市');
INSERT INTO `systemctl_location_info` VALUES ('2687', 'BTQ', 'insert', '宝塔区', '610602', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2687', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宝塔区');
INSERT INTO `systemctl_location_info` VALUES ('2688', 'YZX', 'insert', '延长县', '610621', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2688', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '延长县');
INSERT INTO `systemctl_location_info` VALUES ('2689', 'YCX', 'insert', '延川县', '610622', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2689', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '延川县');
INSERT INTO `systemctl_location_info` VALUES ('2690', 'ZZX', 'insert', '子长县', '610623', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2690', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '子长县');
INSERT INTO `systemctl_location_info` VALUES ('2691', 'ASX', 'insert', '安塞县', '610624', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2691', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安塞县');
INSERT INTO `systemctl_location_info` VALUES ('2692', 'ZDX', 'insert', '志丹县', '610625', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2692', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '志丹县');
INSERT INTO `systemctl_location_info` VALUES ('2693', 'WQX', 'insert', '吴起县', '610626', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2693', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吴起县');
INSERT INTO `systemctl_location_info` VALUES ('2694', 'GQX', 'insert', '甘泉县', '610627', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2694', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘泉县');
INSERT INTO `systemctl_location_info` VALUES ('2695', 'FX', 'insert', '富县', '610628', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2695', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富县');
INSERT INTO `systemctl_location_info` VALUES ('2696', 'LCX', 'insert', '洛川县', '610629', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2696', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洛川县');
INSERT INTO `systemctl_location_info` VALUES ('2697', 'YCX', 'insert', '宜川县', '610630', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2697', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜川县');
INSERT INTO `systemctl_location_info` VALUES ('2698', 'HLX', 'insert', '黄龙县', '610631', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2698', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄龙县');
INSERT INTO `systemctl_location_info` VALUES ('2699', 'HLX', 'insert', '黄陵县', '610632', 'region', '2015-01-19 15:59:00', '1', '', '610600', null, '2699', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄陵县');
INSERT INTO `systemctl_location_info` VALUES ('2700', 'HZS', 'insert', '汉中市', '610700', 'city', '2015-01-19 15:59:00', '1', '107.045478,33.081569', '610000', null, '2700', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '汉中市');
INSERT INTO `systemctl_location_info` VALUES ('2701', 'HTQ', 'insert', '汉台区', '610702', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2701', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汉台区');
INSERT INTO `systemctl_location_info` VALUES ('2702', 'NZX', 'insert', '南郑县', '610721', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2702', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南郑县');
INSERT INTO `systemctl_location_info` VALUES ('2703', 'CGX', 'insert', '城固县', '610722', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2703', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城固县');
INSERT INTO `systemctl_location_info` VALUES ('2704', 'YX', 'insert', '洋县', '610723', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2704', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洋县');
INSERT INTO `systemctl_location_info` VALUES ('2705', 'XXX', 'insert', '西乡县', '610724', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2705', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西乡县');
INSERT INTO `systemctl_location_info` VALUES ('2706', 'MX', 'insert', '勉县', '610725', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2706', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '勉县');
INSERT INTO `systemctl_location_info` VALUES ('2707', 'NQX', 'insert', '宁强县', '610726', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2707', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁强县');
INSERT INTO `systemctl_location_info` VALUES ('2708', 'LYX', 'insert', '略阳县', '610727', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2708', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '略阳县');
INSERT INTO `systemctl_location_info` VALUES ('2709', 'ZBX', 'insert', '镇巴县', '610728', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2709', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇巴县');
INSERT INTO `systemctl_location_info` VALUES ('2710', 'LBX', 'insert', '留坝县', '610729', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2710', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '留坝县');
INSERT INTO `systemctl_location_info` VALUES ('2711', 'FPX', 'insert', '佛坪县', '610730', 'region', '2015-01-19 15:59:00', '1', '', '610700', null, '2711', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '佛坪县');
INSERT INTO `systemctl_location_info` VALUES ('2712', 'YLS', 'insert', '榆林市', '610800', 'city', '2015-01-19 15:59:00', '1', '109.745926,38.279439', '610000', null, '2712', '2015-01-19 15:59:00', 'system', 'A', '', '12', '', '榆林市');
INSERT INTO `systemctl_location_info` VALUES ('2713', 'YYQ', 'insert', '榆阳区', '610802', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2713', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '榆阳区');
INSERT INTO `systemctl_location_info` VALUES ('2714', 'SMX', 'insert', '神木县', '610821', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2714', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '神木县');
INSERT INTO `systemctl_location_info` VALUES ('2715', 'FGX', 'insert', '府谷县', '610822', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2715', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '府谷县');
INSERT INTO `systemctl_location_info` VALUES ('2716', 'HSX', 'insert', '横山县', '610823', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2716', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '横山县');
INSERT INTO `systemctl_location_info` VALUES ('2717', 'JBX', 'insert', '靖边县', '610824', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2717', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '靖边县');
INSERT INTO `systemctl_location_info` VALUES ('2718', 'DBX', 'insert', '定边县', '610825', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2718', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定边县');
INSERT INTO `systemctl_location_info` VALUES ('2719', 'SDX', 'insert', '绥德县', '610826', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2719', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绥德县');
INSERT INTO `systemctl_location_info` VALUES ('2720', 'MZX', 'insert', '米脂县', '610827', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2720', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '米脂县');
INSERT INTO `systemctl_location_info` VALUES ('2721', 'JX', 'insert', '佳县', '610828', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2721', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '佳县');
INSERT INTO `systemctl_location_info` VALUES ('2722', 'WBX', 'insert', '吴堡县', '610829', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2722', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吴堡县');
INSERT INTO `systemctl_location_info` VALUES ('2723', 'QJX', 'insert', '清涧县', '610830', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2723', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清涧县');
INSERT INTO `systemctl_location_info` VALUES ('2724', 'ZZX', 'insert', '子洲县', '610831', 'region', '2015-01-19 15:59:00', '1', '', '610800', null, '2724', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '子洲县');
INSERT INTO `systemctl_location_info` VALUES ('2725', 'AKS', 'insert', '安康市', '610900', 'city', '2015-01-19 15:59:00', '1', '109.038045,32.70437', '610000', null, '2725', '2015-01-19 15:59:00', 'system', 'A', '陕G', '13', '', '安康市');
INSERT INTO `systemctl_location_info` VALUES ('2726', 'HBQ', 'insert', '汉滨区', '610902', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2726', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汉滨区');
INSERT INTO `systemctl_location_info` VALUES ('2727', 'HYX', 'insert', '汉阴县', '610921', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2727', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '汉阴县');
INSERT INTO `systemctl_location_info` VALUES ('2728', 'SQX', 'insert', '石泉县', '610922', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2728', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石泉县');
INSERT INTO `systemctl_location_info` VALUES ('2729', 'NSX', 'insert', '宁陕县', '610923', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2729', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁陕县');
INSERT INTO `systemctl_location_info` VALUES ('2730', 'ZYX', 'insert', '紫阳县', '610924', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2730', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '紫阳县');
INSERT INTO `systemctl_location_info` VALUES ('2731', 'LGX', 'insert', '岚皋县', '610925', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2731', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岚皋县');
INSERT INTO `systemctl_location_info` VALUES ('2732', 'PLX', 'insert', '平利县', '610926', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2732', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平利县');
INSERT INTO `systemctl_location_info` VALUES ('2733', 'ZPX', 'insert', '镇坪县', '610927', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2733', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇坪县');
INSERT INTO `systemctl_location_info` VALUES ('2734', 'XYX', 'insert', '旬阳县', '610928', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2734', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '旬阳县');
INSERT INTO `systemctl_location_info` VALUES ('2735', 'BHX', 'insert', '白河县', '610929', 'region', '2015-01-19 15:59:00', '1', '', '610900', null, '2735', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白河县');
INSERT INTO `systemctl_location_info` VALUES ('2736', 'SLS', 'insert', '商洛市', '611000', 'city', '2015-01-19 15:59:00', '1', '109.934208,33.873907', '610000', null, '2736', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '商洛市');
INSERT INTO `systemctl_location_info` VALUES ('2737', 'SZQ', 'insert', '商州区', '611002', 'region', '2015-01-19 15:59:00', '1', '', '611000', null, '2737', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '商州区');
INSERT INTO `systemctl_location_info` VALUES ('2738', 'LNX', 'insert', '洛南县', '611021', 'region', '2015-01-19 15:59:00', '1', '', '611000', null, '2738', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洛南县');
INSERT INTO `systemctl_location_info` VALUES ('2739', 'DFX', 'insert', '丹凤县', '611022', 'region', '2015-01-19 15:59:00', '1', '', '611000', null, '2739', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丹凤县');
INSERT INTO `systemctl_location_info` VALUES ('2740', 'SNX', 'insert', '商南县', '611023', 'region', '2015-01-19 15:59:00', '1', '', '611000', null, '2740', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '商南县');
INSERT INTO `systemctl_location_info` VALUES ('2741', 'SYX', 'insert', '山阳县', '611024', 'region', '2015-01-19 15:59:00', '1', '', '611000', null, '2741', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '山阳县');
INSERT INTO `systemctl_location_info` VALUES ('2742', 'ZAX', 'insert', '镇安县', '611025', 'region', '2015-01-19 15:59:00', '1', '', '611000', null, '2742', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇安县');
INSERT INTO `systemctl_location_info` VALUES ('2743', 'ZSX', 'insert', '柞水县', '611026', 'region', '2015-01-19 15:59:00', '1', '', '611000', null, '2743', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柞水县');
INSERT INTO `systemctl_location_info` VALUES ('2744', 'GSS', 'insert', '甘肃省', '620000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2744', '2015-01-19 15:59:00', 'system', 'A', '甘', '', '', '甘肃省');
INSERT INTO `systemctl_location_info` VALUES ('2745', 'LZS', 'insert', '兰州市', '620100', 'city', '2015-01-19 15:59:00', '1', '103.823305,36.064226', '620000', null, '2745', '2015-01-19 15:59:00', 'system', 'A', '甘A', '12', '', '兰州市');
INSERT INTO `systemctl_location_info` VALUES ('2746', 'CGQ', 'insert', '城关区', '620102', 'region', '2015-01-19 15:59:00', '1', '', '620100', null, '2746', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城关区');
INSERT INTO `systemctl_location_info` VALUES ('2747', 'QLHQ', 'insert', '七里河区', '620103', 'region', '2015-01-19 15:59:00', '1', '', '620100', null, '2747', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '七里河区');
INSERT INTO `systemctl_location_info` VALUES ('2748', 'XGQ', 'insert', '西固区', '620104', 'region', '2015-01-19 15:59:00', '1', '', '620100', null, '2748', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西固区');
INSERT INTO `systemctl_location_info` VALUES ('2749', 'ANQ', 'insert', '安宁区', '620105', 'region', '2015-01-19 15:59:00', '1', '', '620100', null, '2749', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安宁区');
INSERT INTO `systemctl_location_info` VALUES ('2750', 'HGQ', 'insert', '红古区', '620111', 'region', '2015-01-19 15:59:00', '1', '', '620100', null, '2750', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红古区');
INSERT INTO `systemctl_location_info` VALUES ('2751', 'YDX', 'insert', '永登县', '620121', 'region', '2015-01-19 15:59:00', '1', '', '620100', null, '2751', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永登县');
INSERT INTO `systemctl_location_info` VALUES ('2752', 'GLX', 'insert', '皋兰县', '620122', 'region', '2015-01-19 15:59:00', '1', '', '620100', null, '2752', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '皋兰县');
INSERT INTO `systemctl_location_info` VALUES ('2753', 'YZX', 'insert', '榆中县', '620123', 'region', '2015-01-19 15:59:00', '1', '', '620100', null, '2753', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '榆中县');
INSERT INTO `systemctl_location_info` VALUES ('2754', 'JYGS', 'insert', '嘉峪关市', '620200', 'city', '2015-01-19 15:59:00', '1', '98.281635,39.802397', '620000', null, '2754', '2015-01-19 15:59:00', 'system', 'A', '甘B', '13', '', '嘉峪关市');
INSERT INTO `systemctl_location_info` VALUES ('2755', 'JYGS', 'insert', '嘉峪关市', '620201', 'region', '2015-01-19 15:59:00', '1', '', '620200', null, '2755', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉峪关市');
INSERT INTO `systemctl_location_info` VALUES ('2756', 'JCS', 'insert', '金昌市', '620300', 'city', '2015-01-19 15:59:00', '1', '102.208126,38.516072', '620000', null, '2756', '2015-01-19 15:59:00', 'system', 'A', '甘C', '13', '', '金昌市');
INSERT INTO `systemctl_location_info` VALUES ('2757', 'JCQ', 'insert', '金川区', '620302', 'region', '2015-01-19 15:59:00', '1', '', '620300', null, '2757', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金川区');
INSERT INTO `systemctl_location_info` VALUES ('2758', 'YCX', 'insert', '永昌县', '620321', 'region', '2015-01-19 15:59:00', '1', '', '620300', null, '2758', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永昌县');
INSERT INTO `systemctl_location_info` VALUES ('2759', 'BYS', 'insert', '白银市', '620400', 'city', '2015-01-19 15:59:00', '1', '104.171241,36.546682', '620000', null, '2759', '2015-01-19 15:59:00', 'system', 'A', '甘D', '13', '', '白银市');
INSERT INTO `systemctl_location_info` VALUES ('2760', 'BYQ', 'insert', '白银区', '620402', 'region', '2015-01-19 15:59:00', '1', '', '620400', null, '2760', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白银区');
INSERT INTO `systemctl_location_info` VALUES ('2761', 'PCQ', 'insert', '平川区', '620403', 'region', '2015-01-19 15:59:00', '1', '', '620400', null, '2761', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平川区');
INSERT INTO `systemctl_location_info` VALUES ('2762', 'JYX', 'insert', '靖远县', '620421', 'region', '2015-01-19 15:59:00', '1', '', '620400', null, '2762', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '靖远县');
INSERT INTO `systemctl_location_info` VALUES ('2763', 'HNX', 'insert', '会宁县', '620422', 'region', '2015-01-19 15:59:00', '1', '', '620400', null, '2763', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '会宁县');
INSERT INTO `systemctl_location_info` VALUES ('2764', 'JTX', 'insert', '景泰县', '620423', 'region', '2015-01-19 15:59:00', '1', '', '620400', null, '2764', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '景泰县');
INSERT INTO `systemctl_location_info` VALUES ('2765', 'TSS', 'insert', '天水市', '620500', 'city', '2015-01-19 15:59:00', '1', '105.736932,34.584319', '620000', null, '2765', '2015-01-19 15:59:00', 'system', 'A', '甘E', '13', '', '天水市');
INSERT INTO `systemctl_location_info` VALUES ('2766', 'QZQ', 'insert', '秦州区', '620502', 'region', '2015-01-19 15:59:00', '1', '', '620500', null, '2766', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秦州区');
INSERT INTO `systemctl_location_info` VALUES ('2767', 'MJQ', 'insert', '麦积区', '620503', 'region', '2015-01-19 15:59:00', '1', '', '620500', null, '2767', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麦积区');
INSERT INTO `systemctl_location_info` VALUES ('2768', 'QSX', 'insert', '清水县', '620521', 'region', '2015-01-19 15:59:00', '1', '', '620500', null, '2768', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '清水县');
INSERT INTO `systemctl_location_info` VALUES ('2769', 'QAX', 'insert', '秦安县', '620522', 'region', '2015-01-19 15:59:00', '1', '', '620500', null, '2769', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '秦安县');
INSERT INTO `systemctl_location_info` VALUES ('2770', 'GGX', 'insert', '甘谷县', '620523', 'region', '2015-01-19 15:59:00', '1', '', '620500', null, '2770', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘谷县');
INSERT INTO `systemctl_location_info` VALUES ('2771', 'WSX', 'insert', '武山县', '620524', 'region', '2015-01-19 15:59:00', '1', '', '620500', null, '2771', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武山县');
INSERT INTO `systemctl_location_info` VALUES ('2772', 'ZJCHZZZX', 'insert', '张家川回族自治县', '620525', 'region', '2015-01-19 15:59:00', '1', '', '620500', null, '2772', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '张家川回族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2773', 'WWS', 'insert', '武威市', '620600', 'city', '2015-01-19 15:59:00', '1', '102.640147,37.933172', '620000', null, '2773', '2015-01-19 15:59:00', 'system', 'A', '甘H', '13', '', '武威市');
INSERT INTO `systemctl_location_info` VALUES ('2774', 'LZQ', 'insert', '凉州区', '620602', 'region', '2015-01-19 15:59:00', '1', '', '620600', null, '2774', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凉州区');
INSERT INTO `systemctl_location_info` VALUES ('2775', 'MQX', 'insert', '民勤县', '620621', 'region', '2015-01-19 15:59:00', '1', '', '620600', null, '2775', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '民勤县');
INSERT INTO `systemctl_location_info` VALUES ('2776', 'GLX', 'insert', '古浪县', '620622', 'region', '2015-01-19 15:59:00', '1', '', '620600', null, '2776', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古浪县');
INSERT INTO `systemctl_location_info` VALUES ('2777', 'TZZZZZX', 'insert', '天祝藏族自治县', '620623', 'region', '2015-01-19 15:59:00', '1', '', '620600', null, '2777', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天祝藏族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2778', 'ZYS', 'insert', '张掖市', '620700', 'city', '2015-01-19 15:59:00', '1', '100.459892,38.93932', '620000', null, '2778', '2015-01-19 15:59:00', 'system', 'A', '甘G', '13', '', '张掖市');
INSERT INTO `systemctl_location_info` VALUES ('2779', 'GZQ', 'insert', '甘州区', '620702', 'region', '2015-01-19 15:59:00', '1', '', '620700', null, '2779', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘州区');
INSERT INTO `systemctl_location_info` VALUES ('2780', 'SNYGZZZX', 'insert', '肃南裕固族自治县', '620721', 'region', '2015-01-19 15:59:00', '1', '', '620700', null, '2780', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肃南裕固族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2781', 'MLX', 'insert', '民乐县', '620722', 'region', '2015-01-19 15:59:00', '1', '', '620700', null, '2781', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '民乐县');
INSERT INTO `systemctl_location_info` VALUES ('2782', 'LZX', 'insert', '临泽县', '620723', 'region', '2015-01-19 15:59:00', '1', '', '620700', null, '2782', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临泽县');
INSERT INTO `systemctl_location_info` VALUES ('2783', 'GTX', 'insert', '高台县', '620724', 'region', '2015-01-19 15:59:00', '1', '', '620700', null, '2783', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高台县');
INSERT INTO `systemctl_location_info` VALUES ('2784', 'SDX', 'insert', '山丹县', '620725', 'region', '2015-01-19 15:59:00', '1', '', '620700', null, '2784', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '山丹县');
INSERT INTO `systemctl_location_info` VALUES ('2785', 'PLS', 'insert', '平凉市', '620800', 'city', '2015-01-19 15:59:00', '1', '106.688911,35.55011', '620000', null, '2785', '2015-01-19 15:59:00', 'system', 'A', '甘L', '13', '', '平凉市');
INSERT INTO `systemctl_location_info` VALUES ('2786', 'KTQ', 'insert', '崆峒区', '620802', 'region', '2015-01-19 15:59:00', '1', '', '620800', null, '2786', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崆峒区');
INSERT INTO `systemctl_location_info` VALUES ('2787', 'JCX', 'insert', '泾川县', '620821', 'region', '2015-01-19 15:59:00', '1', '', '620800', null, '2787', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泾川县');
INSERT INTO `systemctl_location_info` VALUES ('2788', 'LTX', 'insert', '灵台县', '620822', 'region', '2015-01-19 15:59:00', '1', '', '620800', null, '2788', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵台县');
INSERT INTO `systemctl_location_info` VALUES ('2789', 'CXX', 'insert', '崇信县', '620823', 'region', '2015-01-19 15:59:00', '1', '', '620800', null, '2789', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '崇信县');
INSERT INTO `systemctl_location_info` VALUES ('2790', 'HTX', 'insert', '华亭县', '620824', 'region', '2015-01-19 15:59:00', '1', '', '620800', null, '2790', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华亭县');
INSERT INTO `systemctl_location_info` VALUES ('2791', 'ZLX', 'insert', '庄浪县', '620825', 'region', '2015-01-19 15:59:00', '1', '', '620800', null, '2791', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庄浪县');
INSERT INTO `systemctl_location_info` VALUES ('2792', 'JNX', 'insert', '静宁县', '620826', 'region', '2015-01-19 15:59:00', '1', '', '620800', null, '2792', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '静宁县');
INSERT INTO `systemctl_location_info` VALUES ('2793', 'JQS', 'insert', '酒泉市', '620900', 'city', '2015-01-19 15:59:00', '1', '98.508415,39.741474', '620000', null, '2793', '2015-01-19 15:59:00', 'system', 'A', '甘F', '13', '', '酒泉市');
INSERT INTO `systemctl_location_info` VALUES ('2794', 'SZQ', 'insert', '肃州区', '620902', 'region', '2015-01-19 15:59:00', '1', '', '620900', null, '2794', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肃州区');
INSERT INTO `systemctl_location_info` VALUES ('2795', 'JTX', 'insert', '金塔县', '620921', 'region', '2015-01-19 15:59:00', '1', '', '620900', null, '2795', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金塔县');
INSERT INTO `systemctl_location_info` VALUES ('2796', 'GZX', 'insert', '瓜州县', '620922', 'region', '2015-01-19 15:59:00', '1', '', '620900', null, '2796', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瓜州县');
INSERT INTO `systemctl_location_info` VALUES ('2797', 'SBMGZZZX', 'insert', '肃北蒙古族自治县', '620923', 'region', '2015-01-19 15:59:00', '1', '', '620900', null, '2797', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '肃北蒙古族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2798', 'AKSHSKZZZX', 'insert', '阿克塞哈萨克族自治县', '620924', 'region', '2015-01-19 15:59:00', '1', '', '620900', null, '2798', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿克塞哈萨克族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2799', 'YMS', 'insert', '玉门市', '620981', 'region', '2015-01-19 15:59:00', '1', '', '620900', null, '2799', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉门市');
INSERT INTO `systemctl_location_info` VALUES ('2800', 'DHS', 'insert', '敦煌市', '620982', 'region', '2015-01-19 15:59:00', '1', '', '620900', null, '2800', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '敦煌市');
INSERT INTO `systemctl_location_info` VALUES ('2801', 'QYS', 'insert', '庆阳市', '621000', 'city', '2015-01-19 15:59:00', '1', '107.644227,35.726801', '620000', null, '2801', '2015-01-19 15:59:00', 'system', 'A', '甘M', '13', '', '庆阳市');
INSERT INTO `systemctl_location_info` VALUES ('2802', 'XFQ', 'insert', '西峰区', '621002', 'region', '2015-01-19 15:59:00', '1', '', '621000', null, '2802', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西峰区');
INSERT INTO `systemctl_location_info` VALUES ('2803', 'QCX', 'insert', '庆城县', '621021', 'region', '2015-01-19 15:59:00', '1', '', '621000', null, '2803', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '庆城县');
INSERT INTO `systemctl_location_info` VALUES ('2804', 'HX', 'insert', '环县', '621022', 'region', '2015-01-19 15:59:00', '1', '', '621000', null, '2804', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '环县');
INSERT INTO `systemctl_location_info` VALUES ('2805', 'HCX', 'insert', '华池县', '621023', 'region', '2015-01-19 15:59:00', '1', '', '621000', null, '2805', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华池县');
INSERT INTO `systemctl_location_info` VALUES ('2806', 'HSX', 'insert', '合水县', '621024', 'region', '2015-01-19 15:59:00', '1', '', '621000', null, '2806', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '合水县');
INSERT INTO `systemctl_location_info` VALUES ('2807', 'ZNX', 'insert', '正宁县', '621025', 'region', '2015-01-19 15:59:00', '1', '', '621000', null, '2807', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '正宁县');
INSERT INTO `systemctl_location_info` VALUES ('2808', 'NX', 'insert', '宁县', '621026', 'region', '2015-01-19 15:59:00', '1', '', '621000', null, '2808', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁县');
INSERT INTO `systemctl_location_info` VALUES ('2809', 'ZYX', 'insert', '镇原县', '621027', 'region', '2015-01-19 15:59:00', '1', '', '621000', null, '2809', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇原县');
INSERT INTO `systemctl_location_info` VALUES ('2810', 'DXS', 'insert', '定西市', '621100', 'city', '2015-01-19 15:59:00', '1', '104.626638,35.586056', '620000', null, '2810', '2015-01-19 15:59:00', 'system', 'A', '甘J', '13', '', '定西市');
INSERT INTO `systemctl_location_info` VALUES ('2811', 'ADQ', 'insert', '安定区', '621102', 'region', '2015-01-19 15:59:00', '1', '', '621100', null, '2811', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安定区');
INSERT INTO `systemctl_location_info` VALUES ('2812', 'TWX', 'insert', '通渭县', '621121', 'region', '2015-01-19 15:59:00', '1', '', '621100', null, '2812', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通渭县');
INSERT INTO `systemctl_location_info` VALUES ('2813', 'LXX', 'insert', '陇西县', '621122', 'region', '2015-01-19 15:59:00', '1', '', '621100', null, '2813', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陇西县');
INSERT INTO `systemctl_location_info` VALUES ('2814', 'WYX', 'insert', '渭源县', '621123', 'region', '2015-01-19 15:59:00', '1', '', '621100', null, '2814', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '渭源县');
INSERT INTO `systemctl_location_info` VALUES ('2815', 'LTX', 'insert', '临洮县', '621124', 'region', '2015-01-19 15:59:00', '1', '', '621100', null, '2815', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临洮县');
INSERT INTO `systemctl_location_info` VALUES ('2816', 'ZX', 'insert', '漳县', '621125', 'region', '2015-01-19 15:59:00', '1', '', '621100', null, '2816', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '漳县');
INSERT INTO `systemctl_location_info` VALUES ('2817', 'MX', 'insert', '岷县', '621126', 'region', '2015-01-19 15:59:00', '1', '', '621100', null, '2817', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岷县');
INSERT INTO `systemctl_location_info` VALUES ('2818', 'LNS', 'insert', '陇南市', '621200', 'city', '2015-01-19 15:59:00', '1', '104.934573,33.39448', '620000', null, '2818', '2015-01-19 15:59:00', 'system', 'A', '甘K', '14', '', '陇南市');
INSERT INTO `systemctl_location_info` VALUES ('2819', 'WDQ', 'insert', '武都区', '621202', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2819', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武都区');
INSERT INTO `systemctl_location_info` VALUES ('2820', 'CX', 'insert', '成县', '621221', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2820', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '成县');
INSERT INTO `systemctl_location_info` VALUES ('2821', 'WX', 'insert', '文县', '621222', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2821', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文县');
INSERT INTO `systemctl_location_info` VALUES ('2822', 'DCX', 'insert', '宕昌县', '621223', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2822', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宕昌县');
INSERT INTO `systemctl_location_info` VALUES ('2823', 'KX', 'insert', '康县', '621224', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2823', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '康县');
INSERT INTO `systemctl_location_info` VALUES ('2824', 'XHX', 'insert', '西和县', '621225', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2824', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西和县');
INSERT INTO `systemctl_location_info` VALUES ('2825', 'LX', 'insert', '礼县', '621226', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2825', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '礼县');
INSERT INTO `systemctl_location_info` VALUES ('2826', 'HX', 'insert', '徽县', '621227', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2826', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '徽县');
INSERT INTO `systemctl_location_info` VALUES ('2827', 'LDX', 'insert', '两当县', '621228', 'region', '2015-01-19 15:59:00', '1', '', '621200', null, '2827', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '两当县');
INSERT INTO `systemctl_location_info` VALUES ('2828', 'LXHZZZZ', 'insert', '临夏回族自治州', '622900', 'city', '2015-01-19 15:59:00', '1', '', '620000', null, '2828', '2015-01-19 15:59:00', 'system', 'A', '甘N', '', '', '临夏回族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2829', 'LXS', 'insert', '临夏市', '622901', 'region', '2015-01-19 15:59:00', '1', '', '622900', null, '2829', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临夏市');
INSERT INTO `systemctl_location_info` VALUES ('2830', 'LXX', 'insert', '临夏县', '622921', 'region', '2015-01-19 15:59:00', '1', '', '622900', null, '2830', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临夏县');
INSERT INTO `systemctl_location_info` VALUES ('2831', 'KLX', 'insert', '康乐县', '622922', 'region', '2015-01-19 15:59:00', '1', '', '622900', null, '2831', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '康乐县');
INSERT INTO `systemctl_location_info` VALUES ('2832', 'YJX', 'insert', '永靖县', '622923', 'region', '2015-01-19 15:59:00', '1', '', '622900', null, '2832', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永靖县');
INSERT INTO `systemctl_location_info` VALUES ('2833', 'GHX', 'insert', '广河县', '622924', 'region', '2015-01-19 15:59:00', '1', '', '622900', null, '2833', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广河县');
INSERT INTO `systemctl_location_info` VALUES ('2834', 'HZX', 'insert', '和政县', '622925', 'region', '2015-01-19 15:59:00', '1', '', '622900', null, '2834', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和政县');
INSERT INTO `systemctl_location_info` VALUES ('2835', 'DXZZZX', 'insert', '东乡族自治县', '622926', 'region', '2015-01-19 15:59:00', '1', '', '622900', null, '2835', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东乡族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2836', 'JSSBAZDXZSLZZZX', 'insert', '积石山保安族东乡族撒拉族自治县', '622927', 'region', '2015-01-19 15:59:00', '1', '', '622900', null, '2836', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '积石山保安族东乡族撒拉族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2837', 'GNZZZZZ', 'insert', '甘南藏族自治州', '623000', 'city', '2015-01-19 15:59:00', '1', '', '620000', null, '2837', '2015-01-19 15:59:00', 'system', 'A', '甘P', '', '', '甘南藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2838', 'HZS', 'insert', '合作市', '623001', 'region', '2015-01-19 15:59:00', '1', '', '623000', null, '2838', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '合作市');
INSERT INTO `systemctl_location_info` VALUES ('2839', 'LTX', 'insert', '临潭县', '623021', 'region', '2015-01-19 15:59:00', '1', '', '623000', null, '2839', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临潭县');
INSERT INTO `systemctl_location_info` VALUES ('2840', 'ZNX', 'insert', '卓尼县', '623022', 'region', '2015-01-19 15:59:00', '1', '', '623000', null, '2840', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '卓尼县');
INSERT INTO `systemctl_location_info` VALUES ('2841', 'ZQX', 'insert', '舟曲县', '623023', 'region', '2015-01-19 15:59:00', '1', '', '623000', null, '2841', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '舟曲县');
INSERT INTO `systemctl_location_info` VALUES ('2842', 'DBX', 'insert', '迭部县', '623024', 'region', '2015-01-19 15:59:00', '1', '', '623000', null, '2842', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '迭部县');
INSERT INTO `systemctl_location_info` VALUES ('2843', 'MQX', 'insert', '玛曲县', '623025', 'region', '2015-01-19 15:59:00', '1', '', '623000', null, '2843', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玛曲县');
INSERT INTO `systemctl_location_info` VALUES ('2844', 'LQX', 'insert', '碌曲县', '623026', 'region', '2015-01-19 15:59:00', '1', '', '623000', null, '2844', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '碌曲县');
INSERT INTO `systemctl_location_info` VALUES ('2845', 'XHX', 'insert', '夏河县', '623027', 'region', '2015-01-19 15:59:00', '1', '', '623000', null, '2845', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '夏河县');
INSERT INTO `systemctl_location_info` VALUES ('2846', 'QHS', 'insert', '青海省', '630000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2846', '2015-01-19 15:59:00', 'system', 'A', '青', '', '', '青海省');
INSERT INTO `systemctl_location_info` VALUES ('2847', 'XNS', 'insert', '西宁市', '630100', 'city', '2015-01-19 15:59:00', '1', '101.767921,36.640739', '630000', null, '2847', '2015-01-19 15:59:00', 'system', 'A', '青A', '12', '', '西宁市');
INSERT INTO `systemctl_location_info` VALUES ('2848', 'CDQ', 'insert', '城东区', '630102', 'region', '2015-01-19 15:59:00', '1', '', '630100', null, '2848', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城东区');
INSERT INTO `systemctl_location_info` VALUES ('2849', 'CZQ', 'insert', '城中区', '630103', 'region', '2015-01-19 15:59:00', '1', '', '630100', null, '2849', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城中区');
INSERT INTO `systemctl_location_info` VALUES ('2850', 'CXQ', 'insert', '城西区', '630104', 'region', '2015-01-19 15:59:00', '1', '', '630100', null, '2850', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城西区');
INSERT INTO `systemctl_location_info` VALUES ('2851', 'CBQ', 'insert', '城北区', '630105', 'region', '2015-01-19 15:59:00', '1', '', '630100', null, '2851', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城北区');
INSERT INTO `systemctl_location_info` VALUES ('2852', 'DTHZTZZZX', 'insert', '大通回族土族自治县', '630121', 'region', '2015-01-19 15:59:00', '1', '', '630100', null, '2852', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大通回族土族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2853', 'HZX', 'insert', '湟中县', '630122', 'region', '2015-01-19 15:59:00', '1', '', '630100', null, '2853', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湟中县');
INSERT INTO `systemctl_location_info` VALUES ('2854', 'HYX', 'insert', '湟源县', '630123', 'region', '2015-01-19 15:59:00', '1', '', '630100', null, '2854', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湟源县');
INSERT INTO `systemctl_location_info` VALUES ('2855', 'HDDQ', 'insert', '海东地区', '632100', 'city', '2015-01-19 15:59:00', '1', '102.085207,36.51761', '630000', null, '2855', '2015-01-19 15:59:00', 'system', 'A', '', '11', '', '海东地区');
INSERT INTO `systemctl_location_info` VALUES ('2856', 'PAX', 'insert', '平安县', '632121', 'region', '2015-01-19 15:59:00', '1', '', '632100', null, '2856', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平安县');
INSERT INTO `systemctl_location_info` VALUES ('2857', 'MHHZTZZZX', 'insert', '民和回族土族自治县', '632122', 'region', '2015-01-19 15:59:00', '1', '', '632100', null, '2857', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '民和回族土族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2858', 'LDX', 'insert', '乐都县', '632123', 'region', '2015-01-19 15:59:00', '1', '', '632100', null, '2858', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乐都县');
INSERT INTO `systemctl_location_info` VALUES ('2859', 'HZTZZZX', 'insert', '互助土族自治县', '632126', 'region', '2015-01-19 15:59:00', '1', '', '632100', null, '2859', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '互助土族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2860', 'HLHZZZX', 'insert', '化隆回族自治县', '632127', 'region', '2015-01-19 15:59:00', '1', '', '632100', null, '2860', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '化隆回族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2861', 'XHSLZZZX', 'insert', '循化撒拉族自治县', '632128', 'region', '2015-01-19 15:59:00', '1', '', '632100', null, '2861', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '循化撒拉族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2862', 'HBZZZZZ', 'insert', '海北藏族自治州', '632200', 'city', '2015-01-19 15:59:00', '1', '', '630000', null, '2862', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海北藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2863', 'MYHZZZX', 'insert', '门源回族自治县', '632221', 'region', '2015-01-19 15:59:00', '1', '', '632200', null, '2863', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '门源回族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2864', 'QLX', 'insert', '祁连县', '632222', 'region', '2015-01-19 15:59:00', '1', '', '632200', null, '2864', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '祁连县');
INSERT INTO `systemctl_location_info` VALUES ('2865', 'HYX', 'insert', '海晏县', '632223', 'region', '2015-01-19 15:59:00', '1', '', '632200', null, '2865', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海晏县');
INSERT INTO `systemctl_location_info` VALUES ('2866', 'GCX', 'insert', '刚察县', '632224', 'region', '2015-01-19 15:59:00', '1', '', '632200', null, '2866', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '刚察县');
INSERT INTO `systemctl_location_info` VALUES ('2867', 'HNZZZZZ', 'insert', '黄南藏族自治州', '632300', 'city', '2015-01-19 15:59:00', '1', '', '630000', null, '2867', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄南藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2868', 'TRX', 'insert', '同仁县', '632321', 'region', '2015-01-19 15:59:00', '1', '', '632300', null, '2868', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '同仁县');
INSERT INTO `systemctl_location_info` VALUES ('2869', 'JZX', 'insert', '尖扎县', '632322', 'region', '2015-01-19 15:59:00', '1', '', '632300', null, '2869', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尖扎县');
INSERT INTO `systemctl_location_info` VALUES ('2870', 'ZKX', 'insert', '泽库县', '632323', 'region', '2015-01-19 15:59:00', '1', '', '632300', null, '2870', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泽库县');
INSERT INTO `systemctl_location_info` VALUES ('2871', 'HNMGZZZX', 'insert', '河南蒙古族自治县', '632324', 'region', '2015-01-19 15:59:00', '1', '', '632300', null, '2871', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河南蒙古族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2872', 'HNZZZZZ', 'insert', '海南藏族自治州', '632500', 'city', '2015-01-19 15:59:00', '1', '', '630000', null, '2872', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海南藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2873', 'GHX', 'insert', '共和县', '632521', 'region', '2015-01-19 15:59:00', '1', '', '632500', null, '2873', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '共和县');
INSERT INTO `systemctl_location_info` VALUES ('2874', 'TDX', 'insert', '同德县', '632522', 'region', '2015-01-19 15:59:00', '1', '', '632500', null, '2874', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '同德县');
INSERT INTO `systemctl_location_info` VALUES ('2875', 'GDX', 'insert', '贵德县', '632523', 'region', '2015-01-19 15:59:00', '1', '', '632500', null, '2875', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贵德县');
INSERT INTO `systemctl_location_info` VALUES ('2876', 'XHX', 'insert', '兴海县', '632524', 'region', '2015-01-19 15:59:00', '1', '', '632500', null, '2876', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴海县');
INSERT INTO `systemctl_location_info` VALUES ('2877', 'GNX', 'insert', '贵南县', '632525', 'region', '2015-01-19 15:59:00', '1', '', '632500', null, '2877', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贵南县');
INSERT INTO `systemctl_location_info` VALUES ('2878', 'GLZZZZZ', 'insert', '果洛藏族自治州', '632600', 'city', '2015-01-19 15:59:00', '1', '', '630000', null, '2878', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '果洛藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2879', 'MQX', 'insert', '玛沁县', '632621', 'region', '2015-01-19 15:59:00', '1', '', '632600', null, '2879', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玛沁县');
INSERT INTO `systemctl_location_info` VALUES ('2880', 'BMX', 'insert', '班玛县', '632622', 'region', '2015-01-19 15:59:00', '1', '', '632600', null, '2880', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '班玛县');
INSERT INTO `systemctl_location_info` VALUES ('2881', 'GDX', 'insert', '甘德县', '632623', 'region', '2015-01-19 15:59:00', '1', '', '632600', null, '2881', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '甘德县');
INSERT INTO `systemctl_location_info` VALUES ('2882', 'DRX', 'insert', '达日县', '632624', 'region', '2015-01-19 15:59:00', '1', '', '632600', null, '2882', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '达日县');
INSERT INTO `systemctl_location_info` VALUES ('2883', 'JZX', 'insert', '久治县', '632625', 'region', '2015-01-19 15:59:00', '1', '', '632600', null, '2883', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '久治县');
INSERT INTO `systemctl_location_info` VALUES ('2884', 'MDX', 'insert', '玛多县', '632626', 'region', '2015-01-19 15:59:00', '1', '', '632600', null, '2884', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玛多县');
INSERT INTO `systemctl_location_info` VALUES ('2885', 'YSZZZZZ', 'insert', '玉树藏族自治州', '632700', 'city', '2015-01-19 15:59:00', '1', '', '630000', null, '2885', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉树藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2886', 'YSX', 'insert', '玉树县', '632721', 'region', '2015-01-19 15:59:00', '1', '', '632700', null, '2886', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉树县');
INSERT INTO `systemctl_location_info` VALUES ('2887', 'ZDX', 'insert', '杂多县', '632722', 'region', '2015-01-19 15:59:00', '1', '', '632700', null, '2887', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '杂多县');
INSERT INTO `systemctl_location_info` VALUES ('2888', 'CDX', 'insert', '称多县', '632723', 'region', '2015-01-19 15:59:00', '1', '', '632700', null, '2888', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '称多县');
INSERT INTO `systemctl_location_info` VALUES ('2889', 'ZDX', 'insert', '治多县', '632724', 'region', '2015-01-19 15:59:00', '1', '', '632700', null, '2889', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '治多县');
INSERT INTO `systemctl_location_info` VALUES ('2890', 'NQX', 'insert', '囊谦县', '632725', 'region', '2015-01-19 15:59:00', '1', '', '632700', null, '2890', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '囊谦县');
INSERT INTO `systemctl_location_info` VALUES ('2891', 'QMLX', 'insert', '曲麻莱县', '632726', 'region', '2015-01-19 15:59:00', '1', '', '632700', null, '2891', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曲麻莱县');
INSERT INTO `systemctl_location_info` VALUES ('2892', 'HXMGZZZZZZ', 'insert', '海西蒙古族藏族自治州', '632800', 'city', '2015-01-19 15:59:00', '1', '', '630000', null, '2892', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海西蒙古族藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2893', 'GEMS', 'insert', '格尔木市', '632801', 'region', '2015-01-19 15:59:00', '1', '', '632800', null, '2893', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '格尔木市');
INSERT INTO `systemctl_location_info` VALUES ('2894', 'DLHS', 'insert', '德令哈市', '632802', 'region', '2015-01-19 15:59:00', '1', '', '632800', null, '2894', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德令哈市');
INSERT INTO `systemctl_location_info` VALUES ('2895', 'WLX', 'insert', '乌兰县', '632821', 'region', '2015-01-19 15:59:00', '1', '', '632800', null, '2895', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌兰县');
INSERT INTO `systemctl_location_info` VALUES ('2896', 'DLX', 'insert', '都兰县', '632822', 'region', '2015-01-19 15:59:00', '1', '', '632800', null, '2896', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '都兰县');
INSERT INTO `systemctl_location_info` VALUES ('2897', 'TJX', 'insert', '天峻县', '632823', 'region', '2015-01-19 15:59:00', '1', '', '632800', null, '2897', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天峻县');
INSERT INTO `systemctl_location_info` VALUES ('2898', 'NXHZZZQ', 'insert', '宁夏省', '640000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2898', '2015-01-19 15:59:00', 'system', 'A', '宁', '', '', '宁夏回族自治区');
INSERT INTO `systemctl_location_info` VALUES ('2899', 'YCS', 'insert', '银川市', '640100', 'city', '2015-01-19 15:59:00', '1', '106.206479,38.502621', '640000', null, '2899', '2015-01-19 15:59:00', 'system', 'A', '宁A', '12', '', '银川市');
INSERT INTO `systemctl_location_info` VALUES ('2900', 'XQQ', 'insert', '兴庆区', '640104', 'region', '2015-01-19 15:59:00', '1', '', '640100', null, '2900', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兴庆区');
INSERT INTO `systemctl_location_info` VALUES ('2901', 'XXQ', 'insert', '西夏区', '640105', 'region', '2015-01-19 15:59:00', '1', '', '640100', null, '2901', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西夏区');
INSERT INTO `systemctl_location_info` VALUES ('2902', 'JFQ', 'insert', '金凤区', '640106', 'region', '2015-01-19 15:59:00', '1', '', '640100', null, '2902', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金凤区');
INSERT INTO `systemctl_location_info` VALUES ('2903', 'YNX', 'insert', '永宁县', '640121', 'region', '2015-01-19 15:59:00', '1', '', '640100', null, '2903', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永宁县');
INSERT INTO `systemctl_location_info` VALUES ('2904', 'HLX', 'insert', '贺兰县', '640122', 'region', '2015-01-19 15:59:00', '1', '', '640100', null, '2904', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贺兰县');
INSERT INTO `systemctl_location_info` VALUES ('2905', 'LWS', 'insert', '灵武市', '640181', 'region', '2015-01-19 15:59:00', '1', '', '640100', null, '2905', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '灵武市');
INSERT INTO `systemctl_location_info` VALUES ('2906', 'SZSS', 'insert', '石嘴山市', '640200', 'city', '2015-01-19 15:59:00', '1', '106.379337,39.020223', '640000', null, '2906', '2015-01-19 15:59:00', 'system', 'A', '宁B', '13', '', '石嘴山市');
INSERT INTO `systemctl_location_info` VALUES ('2907', 'DWKQ', 'insert', '大武口区', '640202', 'region', '2015-01-19 15:59:00', '1', '', '640200', null, '2907', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大武口区');
INSERT INTO `systemctl_location_info` VALUES ('2908', 'HNQ', 'insert', '惠农区', '640205', 'region', '2015-01-19 15:59:00', '1', '', '640200', null, '2908', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '惠农区');
INSERT INTO `systemctl_location_info` VALUES ('2909', 'PLX', 'insert', '平罗县', '640221', 'region', '2015-01-19 15:59:00', '1', '', '640200', null, '2909', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '平罗县');
INSERT INTO `systemctl_location_info` VALUES ('2910', 'WZS', 'insert', '吴忠市', '640300', 'city', '2015-01-19 15:59:00', '1', '106.208254,37.993561', '640000', null, '2910', '2015-01-19 15:59:00', 'system', 'A', '宁C', '14', '', '吴忠市');
INSERT INTO `systemctl_location_info` VALUES ('2911', 'LTQ', 'insert', '利通区', '640302', 'region', '2015-01-19 15:59:00', '1', '', '640300', null, '2911', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '利通区');
INSERT INTO `systemctl_location_info` VALUES ('2912', 'HSBQ', 'insert', '红寺堡区', '640303', 'region', '2015-01-19 15:59:00', '1', '', '640300', null, '2912', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红寺堡区');
INSERT INTO `systemctl_location_info` VALUES ('2913', 'YCX', 'insert', '盐池县', '640323', 'region', '2015-01-19 15:59:00', '1', '', '640300', null, '2913', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐池县');
INSERT INTO `systemctl_location_info` VALUES ('2914', 'TXX', 'insert', '同心县', '640324', 'region', '2015-01-19 15:59:00', '1', '', '640300', null, '2914', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '同心县');
INSERT INTO `systemctl_location_info` VALUES ('2915', 'QTXS', 'insert', '青铜峡市', '640381', 'region', '2015-01-19 15:59:00', '1', '', '640300', null, '2915', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青铜峡市');
INSERT INTO `systemctl_location_info` VALUES ('2916', 'GYS', 'insert', '固原市', '640400', 'city', '2015-01-19 15:59:00', '1', '106.285268,36.021523', '640000', null, '2916', '2015-01-19 15:59:00', 'system', 'A', '宁D', '13', '', '固原市');
INSERT INTO `systemctl_location_info` VALUES ('2917', 'YZQ', 'insert', '原州区', '640402', 'region', '2015-01-19 15:59:00', '1', '', '640400', null, '2917', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '原州区');
INSERT INTO `systemctl_location_info` VALUES ('2918', 'XJX', 'insert', '西吉县', '640422', 'region', '2015-01-19 15:59:00', '1', '', '640400', null, '2918', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西吉县');
INSERT INTO `systemctl_location_info` VALUES ('2919', 'LDX', 'insert', '隆德县', '640423', 'region', '2015-01-19 15:59:00', '1', '', '640400', null, '2919', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆德县');
INSERT INTO `systemctl_location_info` VALUES ('2920', 'JYX', 'insert', '泾源县', '640424', 'region', '2015-01-19 15:59:00', '1', '', '640400', null, '2920', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泾源县');
INSERT INTO `systemctl_location_info` VALUES ('2921', 'PYX', 'insert', '彭阳县', '640425', 'region', '2015-01-19 15:59:00', '1', '', '640400', null, '2921', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彭阳县');
INSERT INTO `systemctl_location_info` VALUES ('2922', 'ZWS', 'insert', '中卫市', '640500', 'city', '2015-01-19 15:59:00', '1', '105.196754,37.521124', '640000', null, '2922', '2015-01-19 15:59:00', 'system', 'A', '宁E', '14', '', '中卫市');
INSERT INTO `systemctl_location_info` VALUES ('2923', 'SPTQ', 'insert', '沙坡头区', '640502', 'region', '2015-01-19 15:59:00', '1', '', '640500', null, '2923', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙坡头区');
INSERT INTO `systemctl_location_info` VALUES ('2924', 'ZNX', 'insert', '中宁县', '640521', 'region', '2015-01-19 15:59:00', '1', '', '640500', null, '2924', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中宁县');
INSERT INTO `systemctl_location_info` VALUES ('2925', 'HYX', 'insert', '海原县', '640522', 'region', '2015-01-19 15:59:00', '1', '', '640500', null, '2925', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '海原县');
INSERT INTO `systemctl_location_info` VALUES ('2926', 'XJWWEZZQ', 'insert', '新疆省', '650000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '2926', '2015-01-19 15:59:00', 'system', 'A', '新', '', '', '新疆维吾尔自治区');
INSERT INTO `systemctl_location_info` VALUES ('2927', 'WLMQS', 'insert', '乌鲁木齐市', '650100', 'city', '2015-01-19 15:59:00', '1', '87.564988,43.84038', '650000', null, '2927', '2015-01-19 15:59:00', 'system', 'A', '新A', '12', '', '乌鲁木齐市');
INSERT INTO `systemctl_location_info` VALUES ('2928', 'TSQ', 'insert', '天山区', '650102', 'region', '2015-01-19 15:59:00', '1', '', '650100', null, '2928', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '天山区');
INSERT INTO `systemctl_location_info` VALUES ('2929', 'SYBKQ', 'insert', '沙依巴克区', '650103', 'region', '2015-01-19 15:59:00', '1', '', '650100', null, '2929', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙依巴克区');
INSERT INTO `systemctl_location_info` VALUES ('2930', 'XSQ', 'insert', '新市区', '650104', 'region', '2015-01-19 15:59:00', '1', '', '650100', null, '2930', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新市区');
INSERT INTO `systemctl_location_info` VALUES ('2931', 'SMGQ', 'insert', '水磨沟区', '650105', 'region', '2015-01-19 15:59:00', '1', '', '650100', null, '2931', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '水磨沟区');
INSERT INTO `systemctl_location_info` VALUES ('2932', 'TTHQ', 'insert', '头屯河区', '650106', 'region', '2015-01-19 15:59:00', '1', '', '650100', null, '2932', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '头屯河区');
INSERT INTO `systemctl_location_info` VALUES ('2933', 'DBCQ', 'insert', '达坂城区', '650107', 'region', '2015-01-19 15:59:00', '1', '', '650100', null, '2933', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '达坂城区');
INSERT INTO `systemctl_location_info` VALUES ('2934', 'MDQ', 'insert', '米东区', '650109', 'region', '2015-01-19 15:59:00', '1', '', '650100', null, '2934', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '米东区');
INSERT INTO `systemctl_location_info` VALUES ('2935', 'WLMQX', 'insert', '乌鲁木齐县', '650121', 'region', '2015-01-19 15:59:00', '1', '', '650100', null, '2935', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌鲁木齐县');
INSERT INTO `systemctl_location_info` VALUES ('2936', 'KLMYS', 'insert', '克拉玛依市', '650200', 'city', '2015-01-19 15:59:00', '1', '84.88118,45.594331', '650000', null, '2936', '2015-01-19 15:59:00', 'system', 'A', '新J', '13', '', '克拉玛依市');
INSERT INTO `systemctl_location_info` VALUES ('2937', 'DSZQ', 'insert', '独山子区', '650202', 'region', '2015-01-19 15:59:00', '1', '', '650200', null, '2937', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '独山子区');
INSERT INTO `systemctl_location_info` VALUES ('2938', 'KLMYQ', 'insert', '克拉玛依区', '650203', 'region', '2015-01-19 15:59:00', '1', '', '650200', null, '2938', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '克拉玛依区');
INSERT INTO `systemctl_location_info` VALUES ('2939', 'BJTQ', 'insert', '白碱滩区', '650204', 'region', '2015-01-19 15:59:00', '1', '', '650200', null, '2939', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白碱滩区');
INSERT INTO `systemctl_location_info` VALUES ('2940', 'WEHQ', 'insert', '乌尔禾区', '650205', 'region', '2015-01-19 15:59:00', '1', '', '650200', null, '2940', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌尔禾区');
INSERT INTO `systemctl_location_info` VALUES ('2941', 'TLFDQ', 'insert', '吐鲁番地区', '652100', 'city', '2015-01-19 15:59:00', '1', '89.181595,42.96047', '650000', null, '2941', '2015-01-19 15:59:00', 'system', 'A', '新K', '13', '', '吐鲁番地区');
INSERT INTO `systemctl_location_info` VALUES ('2942', 'TLFS', 'insert', '吐鲁番市', '652101', 'region', '2015-01-19 15:59:00', '1', '', '652100', null, '2942', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吐鲁番市');
INSERT INTO `systemctl_location_info` VALUES ('2943', 'SSX', 'insert', '鄯善县', '652122', 'region', '2015-01-19 15:59:00', '1', '', '652100', null, '2943', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鄯善县');
INSERT INTO `systemctl_location_info` VALUES ('2944', 'TKXX', 'insert', '托克逊县', '652123', 'region', '2015-01-19 15:59:00', '1', '', '652100', null, '2944', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '托克逊县');
INSERT INTO `systemctl_location_info` VALUES ('2945', 'HMDQ', 'insert', '哈密地区', '652200', 'city', '2015-01-19 15:59:00', '1', '93.528355,42.858596', '650000', null, '2945', '2015-01-19 15:59:00', 'system', 'A', '新', '13', '', '哈密地区');
INSERT INTO `systemctl_location_info` VALUES ('2946', 'HMS', 'insert', '哈密市', '652201', 'region', '2015-01-19 15:59:00', '1', '', '652200', null, '2946', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '哈密市');
INSERT INTO `systemctl_location_info` VALUES ('2947', 'BLKHSKZZX', 'insert', '巴里坤哈萨克自治县', '652222', 'region', '2015-01-19 15:59:00', '1', '', '652200', null, '2947', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴里坤哈萨克自治县');
INSERT INTO `systemctl_location_info` VALUES ('2948', 'YWX', 'insert', '伊吾县', '652223', 'region', '2015-01-19 15:59:00', '1', '', '652200', null, '2948', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伊吾县');
INSERT INTO `systemctl_location_info` VALUES ('2949', 'CJHZZZZ', 'insert', '昌吉回族自治州', '652300', 'city', '2015-01-19 15:59:00', '1', '', '650000', null, '2949', '2015-01-19 15:59:00', 'system', 'A', '新B', '', '', '昌吉回族自治州');
INSERT INTO `systemctl_location_info` VALUES ('2950', 'CJS', 'insert', '昌吉市', '652301', 'region', '2015-01-19 15:59:00', '1', '', '652300', null, '2950', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌吉市');
INSERT INTO `systemctl_location_info` VALUES ('2951', 'FKS', 'insert', '阜康市', '652302', 'region', '2015-01-19 15:59:00', '1', '', '652300', null, '2951', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阜康市');
INSERT INTO `systemctl_location_info` VALUES ('2952', 'HTBX', 'insert', '呼图壁县', '652323', 'region', '2015-01-19 15:59:00', '1', '', '652300', null, '2952', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '呼图壁县');
INSERT INTO `systemctl_location_info` VALUES ('2953', 'MNSX', 'insert', '玛纳斯县', '652324', 'region', '2015-01-19 15:59:00', '1', '', '652300', null, '2953', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玛纳斯县');
INSERT INTO `systemctl_location_info` VALUES ('2954', 'QTX', 'insert', '奇台县', '652325', 'region', '2015-01-19 15:59:00', '1', '', '652300', null, '2954', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '奇台县');
INSERT INTO `systemctl_location_info` VALUES ('2955', 'JMSEX', 'insert', '吉木萨尔县', '652327', 'region', '2015-01-19 15:59:00', '1', '', '652300', null, '2955', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉木萨尔县');
INSERT INTO `systemctl_location_info` VALUES ('2956', 'MLHSKZZX', 'insert', '木垒哈萨克自治县', '652328', 'region', '2015-01-19 15:59:00', '1', '', '652300', null, '2956', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '木垒哈萨克自治县');
INSERT INTO `systemctl_location_info` VALUES ('2957', 'BETLMGZZZ', 'insert', '博尔塔拉蒙古自治州', '652700', 'city', '2015-01-19 15:59:00', '1', '', '650000', null, '2957', '2015-01-19 15:59:00', 'system', 'A', '新E', '', '', '博尔塔拉蒙古自治州');
INSERT INTO `systemctl_location_info` VALUES ('2958', 'BLS', 'insert', '博乐市', '652701', 'region', '2015-01-19 15:59:00', '1', '', '652700', null, '2958', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博乐市');
INSERT INTO `systemctl_location_info` VALUES ('2959', 'JHX', 'insert', '精河县', '652722', 'region', '2015-01-19 15:59:00', '1', '', '652700', null, '2959', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '精河县');
INSERT INTO `systemctl_location_info` VALUES ('2960', 'WQX', 'insert', '温泉县', '652723', 'region', '2015-01-19 15:59:00', '1', '', '652700', null, '2960', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '温泉县');
INSERT INTO `systemctl_location_info` VALUES ('2961', 'BYGLMGZZZ', 'insert', '巴音郭楞蒙古自治州', '652800', 'city', '2015-01-19 15:59:00', '1', '86.121688,41.771362', '650000', null, '2961', '2015-01-19 15:59:00', 'system', 'A', '新M', '12', '', '巴音郭楞蒙古自治州');
INSERT INTO `systemctl_location_info` VALUES ('2962', 'KELS', 'insert', '库尔勒市', '652801', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2962', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '库尔勒市');
INSERT INTO `systemctl_location_info` VALUES ('2963', 'LTX', 'insert', '轮台县', '652822', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2963', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '轮台县');
INSERT INTO `systemctl_location_info` VALUES ('2964', 'WLX', 'insert', '尉犁县', '652823', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2964', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尉犁县');
INSERT INTO `systemctl_location_info` VALUES ('2965', 'RQX', 'insert', '若羌县', '652824', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2965', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '若羌县');
INSERT INTO `systemctl_location_info` VALUES ('2966', 'QMX', 'insert', '且末县', '652825', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2966', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '且末县');
INSERT INTO `systemctl_location_info` VALUES ('2967', 'YQHZZZX', 'insert', '焉耆回族自治县', '652826', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2967', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '焉耆回族自治县');
INSERT INTO `systemctl_location_info` VALUES ('2968', 'HJX', 'insert', '和静县', '652827', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2968', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和静县');
INSERT INTO `systemctl_location_info` VALUES ('2969', 'HSX', 'insert', '和硕县', '652828', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2969', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和硕县');
INSERT INTO `systemctl_location_info` VALUES ('2970', 'BHX', 'insert', '博湖县', '652829', 'region', '2015-01-19 15:59:00', '1', '', '652800', null, '2970', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '博湖县');
INSERT INTO `systemctl_location_info` VALUES ('2971', 'AKSDQ', 'insert', '阿克苏地区', '652900', 'city', '2015-01-19 15:59:00', '1', '80.269846,41.171731', '650000', null, '2971', '2015-01-19 15:59:00', 'system', 'A', '新N', '12', '', '阿克苏地区');
INSERT INTO `systemctl_location_info` VALUES ('2972', 'AKSS', 'insert', '阿克苏市', '652901', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2972', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿克苏市');
INSERT INTO `systemctl_location_info` VALUES ('2973', 'WSX', 'insert', '温宿县', '652922', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2973', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '温宿县');
INSERT INTO `systemctl_location_info` VALUES ('2974', 'KCX', 'insert', '库车县', '652923', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2974', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '库车县');
INSERT INTO `systemctl_location_info` VALUES ('2975', 'SYX', 'insert', '沙雅县', '652924', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2975', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙雅县');
INSERT INTO `systemctl_location_info` VALUES ('2976', 'XHX', 'insert', '新和县', '652925', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2976', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新和县');
INSERT INTO `systemctl_location_info` VALUES ('2977', 'BCX', 'insert', '拜城县', '652926', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2977', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '拜城县');
INSERT INTO `systemctl_location_info` VALUES ('2978', 'WSX', 'insert', '乌什县', '652927', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2978', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌什县');
INSERT INTO `systemctl_location_info` VALUES ('2979', 'AWTX', 'insert', '阿瓦提县', '652928', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2979', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿瓦提县');
INSERT INTO `systemctl_location_info` VALUES ('2980', 'KPX', 'insert', '柯坪县', '652929', 'region', '2015-01-19 15:59:00', '1', '', '652900', null, '2980', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '柯坪县');
INSERT INTO `systemctl_location_info` VALUES ('2981', 'KZLSKEKZZZZ', 'insert', '克孜勒苏柯尔克孜自治州', '653000', 'city', '2015-01-19 15:59:00', '1', '', '650000', null, '2981', '2015-01-19 15:59:00', 'system', 'A', '新P', '', '', '克孜勒苏柯尔克孜自治州');
INSERT INTO `systemctl_location_info` VALUES ('2982', 'ATSS', 'insert', '阿图什市', '653001', 'region', '2015-01-19 15:59:00', '1', '', '653000', null, '2982', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿图什市');
INSERT INTO `systemctl_location_info` VALUES ('2983', 'AKTX', 'insert', '阿克陶县', '653022', 'region', '2015-01-19 15:59:00', '1', '', '653000', null, '2983', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿克陶县');
INSERT INTO `systemctl_location_info` VALUES ('2984', 'AHQX', 'insert', '阿合奇县', '653023', 'region', '2015-01-19 15:59:00', '1', '', '653000', null, '2984', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿合奇县');
INSERT INTO `systemctl_location_info` VALUES ('2985', 'WQX', 'insert', '乌恰县', '653024', 'region', '2015-01-19 15:59:00', '1', '', '653000', null, '2985', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌恰县');
INSERT INTO `systemctl_location_info` VALUES ('2986', 'KSDQ', 'insert', '喀什地区', '653100', 'city', '2015-01-19 15:59:00', '1', '75.992973,39.470627', '650000', null, '2986', '2015-01-19 15:59:00', 'system', 'A', '新Q', '12', '', '喀什地区');
INSERT INTO `systemctl_location_info` VALUES ('2987', 'KSS', 'insert', '喀什市', '653101', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2987', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '喀什市');
INSERT INTO `systemctl_location_info` VALUES ('2988', 'SFX', 'insert', '疏附县', '653121', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2988', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '疏附县');
INSERT INTO `systemctl_location_info` VALUES ('2989', 'SLX', 'insert', '疏勒县', '653122', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2989', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '疏勒县');
INSERT INTO `systemctl_location_info` VALUES ('2990', 'YJSX', 'insert', '英吉沙县', '653123', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2990', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '英吉沙县');
INSERT INTO `systemctl_location_info` VALUES ('2991', 'ZPX', 'insert', '泽普县', '653124', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2991', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泽普县');
INSERT INTO `systemctl_location_info` VALUES ('2992', 'SCX', 'insert', '莎车县', '653125', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2992', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '莎车县');
INSERT INTO `systemctl_location_info` VALUES ('2993', 'YCX', 'insert', '叶城县', '653126', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2993', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '叶城县');
INSERT INTO `systemctl_location_info` VALUES ('2994', 'MGTX', 'insert', '麦盖提县', '653127', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2994', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麦盖提县');
INSERT INTO `systemctl_location_info` VALUES ('2995', 'YPHX', 'insert', '岳普湖县', '653128', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2995', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岳普湖县');
INSERT INTO `systemctl_location_info` VALUES ('2996', 'JSX', 'insert', '伽师县', '653129', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2996', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伽师县');
INSERT INTO `systemctl_location_info` VALUES ('2997', 'BCX', 'insert', '巴楚县', '653130', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2997', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴楚县');
INSERT INTO `systemctl_location_info` VALUES ('2998', 'TSKEGTJKZZX', 'insert', '塔什库尔干塔吉克自治县', '653131', 'region', '2015-01-19 15:59:00', '1', '', '653100', null, '2998', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '塔什库尔干塔吉克自治县');
INSERT INTO `systemctl_location_info` VALUES ('2999', 'HTDQ', 'insert', '和田地区', '653200', 'city', '2015-01-19 15:59:00', '1', '79.930239,37.116774', '650000', null, '2999', '2015-01-19 15:59:00', 'system', 'A', '新R', '13', '', '和田地区');
INSERT INTO `systemctl_location_info` VALUES ('3000', 'HTS', 'insert', '和田市', '653201', 'region', '2015-01-19 15:59:00', '1', '', '653200', null, '3000', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和田市');
INSERT INTO `systemctl_location_info` VALUES ('3001', 'HTX', 'insert', '和田县', '653221', 'region', '2015-01-19 15:59:00', '1', '', '653200', null, '3001', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和田县');
INSERT INTO `systemctl_location_info` VALUES ('3002', 'MYX', 'insert', '墨玉县', '653222', 'region', '2015-01-19 15:59:00', '1', '', '653200', null, '3002', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '墨玉县');
INSERT INTO `systemctl_location_info` VALUES ('3003', 'PSX', 'insert', '皮山县', '653223', 'region', '2015-01-19 15:59:00', '1', '', '653200', null, '3003', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '皮山县');
INSERT INTO `systemctl_location_info` VALUES ('3004', 'LPX', 'insert', '洛浦县', '653224', 'region', '2015-01-19 15:59:00', '1', '', '653200', null, '3004', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洛浦县');
INSERT INTO `systemctl_location_info` VALUES ('3005', 'CLX', 'insert', '策勒县', '653225', 'region', '2015-01-19 15:59:00', '1', '', '653200', null, '3005', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '策勒县');
INSERT INTO `systemctl_location_info` VALUES ('3006', 'YTX', 'insert', '于田县', '653226', 'region', '2015-01-19 15:59:00', '1', '', '653200', null, '3006', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '于田县');
INSERT INTO `systemctl_location_info` VALUES ('3007', 'MFX', 'insert', '民丰县', '653227', 'region', '2015-01-19 15:59:00', '1', '', '653200', null, '3007', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '民丰县');
INSERT INTO `systemctl_location_info` VALUES ('3008', 'YLHSKZZZ', 'insert', '伊犁哈萨克自治州', '654000', 'city', '2015-01-19 15:59:00', '1', '', '650000', null, '3008', '2015-01-19 15:59:00', 'system', 'A', '新F', '', '', '伊犁哈萨克自治州');
INSERT INTO `systemctl_location_info` VALUES ('3009', 'YNS', 'insert', '伊宁市', '654002', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3009', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伊宁市');
INSERT INTO `systemctl_location_info` VALUES ('3010', 'KTS', 'insert', '奎屯市', '654003', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3010', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '奎屯市');
INSERT INTO `systemctl_location_info` VALUES ('3011', 'HCX', 'insert', '霍城县', '654023', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3011', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '霍城县');
INSERT INTO `systemctl_location_info` VALUES ('3012', 'GLX', 'insert', '巩留县', '654024', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3012', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巩留县');
INSERT INTO `systemctl_location_info` VALUES ('3013', 'XYX', 'insert', '新源县', '654025', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3013', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新源县');
INSERT INTO `systemctl_location_info` VALUES ('3014', 'ZSX', 'insert', '昭苏县', '654026', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3014', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昭苏县');
INSERT INTO `systemctl_location_info` VALUES ('3015', 'TKSX', 'insert', '特克斯县', '654027', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3015', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '特克斯县');
INSERT INTO `systemctl_location_info` VALUES ('3016', 'NLKX', 'insert', '尼勒克县', '654028', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3016', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尼勒克县');
INSERT INTO `systemctl_location_info` VALUES ('3017', 'TCDQ', 'insert', '塔城地区', '654200', 'city', '2015-01-19 15:59:00', '1', '82.974881,46.758684', '650000', null, '3017', '2015-01-19 15:59:00', 'system', 'A', '新G', '12', '', '塔城地区');
INSERT INTO `systemctl_location_info` VALUES ('3018', 'TCS', 'insert', '塔城市', '654201', 'region', '2015-01-19 15:59:00', '1', '', '654200', null, '3018', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '塔城市');
INSERT INTO `systemctl_location_info` VALUES ('3019', 'WSS', 'insert', '乌苏市', '654202', 'region', '2015-01-19 15:59:00', '1', '', '654200', null, '3019', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乌苏市');
INSERT INTO `systemctl_location_info` VALUES ('3020', 'EMX', 'insert', '额敏县', '654221', 'region', '2015-01-19 15:59:00', '1', '', '654200', null, '3020', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '额敏县');
INSERT INTO `systemctl_location_info` VALUES ('3021', 'SWX', 'insert', '沙湾县', '654223', 'region', '2015-01-19 15:59:00', '1', '', '654200', null, '3021', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙湾县');
INSERT INTO `systemctl_location_info` VALUES ('3022', 'TLX', 'insert', '托里县', '654224', 'region', '2015-01-19 15:59:00', '1', '', '654200', null, '3022', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '托里县');
INSERT INTO `systemctl_location_info` VALUES ('3023', 'YMX', 'insert', '裕民县', '654225', 'region', '2015-01-19 15:59:00', '1', '', '654200', null, '3023', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '裕民县');
INSERT INTO `systemctl_location_info` VALUES ('3024', 'HBKSEMGZZX', 'insert', '和布克赛尔蒙古自治县', '654226', 'region', '2015-01-19 15:59:00', '1', '', '654200', null, '3024', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '和布克赛尔蒙古自治县');
INSERT INTO `systemctl_location_info` VALUES ('3025', 'ALTDQ', 'insert', '阿勒泰地区', '654300', 'city', '2015-01-19 15:59:00', '1', '88.137915,47.839744', '650000', null, '3025', '2015-01-19 15:59:00', 'system', 'A', '新H', '13', '', '阿勒泰地区');
INSERT INTO `systemctl_location_info` VALUES ('3026', 'ALTS', 'insert', '阿勒泰市', '654301', 'region', '2015-01-19 15:59:00', '1', '', '654300', null, '3026', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿勒泰市');
INSERT INTO `systemctl_location_info` VALUES ('3027', 'BEJX', 'insert', '布尔津县', '654321', 'region', '2015-01-19 15:59:00', '1', '', '654300', null, '3027', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '布尔津县');
INSERT INTO `systemctl_location_info` VALUES ('3028', 'FYX', 'insert', '富蕴县', '654322', 'region', '2015-01-19 15:59:00', '1', '', '654300', null, '3028', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富蕴县');
INSERT INTO `systemctl_location_info` VALUES ('3029', 'FHX', 'insert', '福海县', '654323', 'region', '2015-01-19 15:59:00', '1', '', '654300', null, '3029', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '福海县');
INSERT INTO `systemctl_location_info` VALUES ('3030', 'HBHX', 'insert', '哈巴河县', '654324', 'region', '2015-01-19 15:59:00', '1', '', '654300', null, '3030', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '哈巴河县');
INSERT INTO `systemctl_location_info` VALUES ('3031', 'QHX', 'insert', '青河县', '654325', 'region', '2015-01-19 15:59:00', '1', '', '654300', null, '3031', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '青河县');
INSERT INTO `systemctl_location_info` VALUES ('3032', 'JMNX', 'insert', '吉木乃县', '654326', 'region', '2015-01-19 15:59:00', '1', '', '654300', null, '3032', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉木乃县');
INSERT INTO `systemctl_location_info` VALUES ('3033', 'ZZQZX', 'insert', '自治区直辖', '659000', 'city', '2015-01-19 15:59:00', '1', '', '650000', null, '3033', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '自治区直辖');
INSERT INTO `systemctl_location_info` VALUES ('3034', 'SHZS', 'insert', '石河子市', '659001', 'region', '2015-01-19 15:59:00', '1', '', '659000', null, '3034', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石河子市');
INSERT INTO `systemctl_location_info` VALUES ('3035', 'ALES', 'insert', '阿拉尔市', '659002', 'region', '2015-01-19 15:59:00', '1', '', '659000', null, '3035', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '阿拉尔市');
INSERT INTO `systemctl_location_info` VALUES ('3036', 'TMSKS', 'insert', '图木舒克市', '659003', 'region', '2015-01-19 15:59:00', '1', '', '659000', null, '3036', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '图木舒克市');
INSERT INTO `systemctl_location_info` VALUES ('3037', 'WJQS', 'insert', '五家渠市', '659004', 'region', '2015-01-19 15:59:00', '1', '', '659000', null, '3037', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '五家渠市');
INSERT INTO `systemctl_location_info` VALUES ('3038', 'TWS', 'insert', '台湾省', '710000', 'province', '2015-01-19 15:59:00', '1', '120.961454,23.80406', '0', null, '3038', '2015-01-19 15:59:00', 'system', 'A', '', '8', '', '台湾省');
INSERT INTO `systemctl_location_info` VALUES ('3039', 'TBS', 'insert', '台北市', '710100', 'city', '2015-01-19 15:59:00', '1', '', '710000', null, '3039', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台北市');
INSERT INTO `systemctl_location_info` VALUES ('3040', 'ZZQ', 'insert', '中正区', '710101', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3040', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中正区');
INSERT INTO `systemctl_location_info` VALUES ('3041', 'DTQ', 'insert', '大同区', '710102', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3041', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大同区');
INSERT INTO `systemctl_location_info` VALUES ('3042', 'ZSQ', 'insert', '中山区', '710103', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3042', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中山区');
INSERT INTO `systemctl_location_info` VALUES ('3043', 'SSQ', 'insert', '松山区', '710104', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3043', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '松山区');
INSERT INTO `systemctl_location_info` VALUES ('3044', 'DAQ', 'insert', '大安区', '710105', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3044', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大安区');
INSERT INTO `systemctl_location_info` VALUES ('3045', 'WHQ', 'insert', '万华区', '710106', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3045', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '万华区');
INSERT INTO `systemctl_location_info` VALUES ('3046', 'XYQ', 'insert', '信义区', '710107', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3046', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '信义区');
INSERT INTO `systemctl_location_info` VALUES ('3047', 'SLQ', 'insert', '士林区', '710108', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3047', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '士林区');
INSERT INTO `systemctl_location_info` VALUES ('3048', 'BTQ', 'insert', '北投区', '710109', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3048', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北投区');
INSERT INTO `systemctl_location_info` VALUES ('3049', 'NHQ', 'insert', '内湖区', '710110', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3049', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '内湖区');
INSERT INTO `systemctl_location_info` VALUES ('3050', 'NGQ', 'insert', '南港区', '710111', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3050', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南港区');
INSERT INTO `systemctl_location_info` VALUES ('3051', 'WSQ', 'insert', '文山区', '710112', 'region', '2015-01-19 15:59:00', '1', '', '710100', null, '3051', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文山区');
INSERT INTO `systemctl_location_info` VALUES ('3052', 'GXS', 'insert', '高雄市', '710200', 'city', '2015-01-19 15:59:00', '1', '', '710000', null, '3052', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高雄市');
INSERT INTO `systemctl_location_info` VALUES ('3053', 'XXQ', 'insert', '新兴区', '710201', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3053', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新兴区');
INSERT INTO `systemctl_location_info` VALUES ('3054', 'QJQ', 'insert', '前金区', '710202', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3054', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '前金区');
INSERT INTO `systemctl_location_info` VALUES ('3055', 'QYQ', 'insert', '芩雅区', '710203', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3055', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芩雅区');
INSERT INTO `systemctl_location_info` VALUES ('3056', 'YCQ', 'insert', '盐埕区', '710204', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3056', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐埕区');
INSERT INTO `systemctl_location_info` VALUES ('3057', 'GSQ', 'insert', '鼓山区', '710205', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3057', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鼓山区');
INSERT INTO `systemctl_location_info` VALUES ('3058', 'QJQ', 'insert', '旗津区', '710206', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3058', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '旗津区');
INSERT INTO `systemctl_location_info` VALUES ('3059', 'QZQ', 'insert', '前镇区', '710207', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3059', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '前镇区');
INSERT INTO `systemctl_location_info` VALUES ('3060', 'SMQ', 'insert', '三民区', '710208', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3060', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '三民区');
INSERT INTO `systemctl_location_info` VALUES ('3061', 'ZYQ', 'insert', '左营区', '710209', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3061', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '左营区');
INSERT INTO `systemctl_location_info` VALUES ('3062', 'NZQ', 'insert', '楠梓区', '710210', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3062', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '楠梓区');
INSERT INTO `systemctl_location_info` VALUES ('3063', 'XGQ', 'insert', '小港区', '710211', 'region', '2015-01-19 15:59:00', '1', '', '710200', null, '3063', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '小港区');
INSERT INTO `systemctl_location_info` VALUES ('3064', 'JLS', 'insert', '基隆市', '710300', 'city', '2015-01-19 15:59:00', '1', '', '710000', null, '3064', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '基隆市');
INSERT INTO `systemctl_location_info` VALUES ('3065', 'RAQ', 'insert', '仁爱区', '710301', 'region', '2015-01-19 15:59:00', '1', '', '710300', null, '3065', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仁爱区');
INSERT INTO `systemctl_location_info` VALUES ('3066', 'XYQ', 'insert', '信义区', '710302', 'region', '2015-01-19 15:59:00', '1', '', '710300', null, '3066', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '信义区');
INSERT INTO `systemctl_location_info` VALUES ('3067', 'ZZQ', 'insert', '中正区', '710303', 'region', '2015-01-19 15:59:00', '1', '', '710300', null, '3067', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中正区');
INSERT INTO `systemctl_location_info` VALUES ('3068', 'ZSQ', 'insert', '中山区', '710304', 'region', '2015-01-19 15:59:00', '1', '', '710300', null, '3068', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中山区');
INSERT INTO `systemctl_location_info` VALUES ('3069', 'ALQ', 'insert', '安乐区', '710305', 'region', '2015-01-19 15:59:00', '1', '', '710300', null, '3069', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安乐区');
INSERT INTO `systemctl_location_info` VALUES ('3070', 'NNQ', 'insert', '暖暖区', '710306', 'region', '2015-01-19 15:59:00', '1', '', '710300', null, '3070', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '暖暖区');
INSERT INTO `systemctl_location_info` VALUES ('3071', 'QDQ', 'insert', '七堵区', '710307', 'region', '2015-01-19 15:59:00', '1', '', '710300', null, '3071', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '七堵区');
INSERT INTO `systemctl_location_info` VALUES ('3072', 'TZS', 'insert', '台中市', '710400', 'city', '2015-01-19 15:59:00', '1', '', '710000', null, '3072', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台中市');
INSERT INTO `systemctl_location_info` VALUES ('3073', 'ZQ', 'insert', '中区', '710401', 'region', '2015-01-19 15:59:00', '1', '', '710400', null, '3073', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中区');
INSERT INTO `systemctl_location_info` VALUES ('3074', 'DQ', 'insert', '东区', '710402', 'region', '2015-01-19 15:59:00', '1', '', '710400', null, '3074', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东区');
INSERT INTO `systemctl_location_info` VALUES ('3075', 'NQ', 'insert', '南区', '710403', 'region', '2015-01-19 15:59:00', '1', '', '710400', null, '3075', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南区');
INSERT INTO `systemctl_location_info` VALUES ('3076', 'XQ', 'insert', '西区', '710404', 'region', '2015-01-19 15:59:00', '1', '', '710400', null, '3076', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西区');
INSERT INTO `systemctl_location_info` VALUES ('3077', 'YNX', 'insert', '伊宁县', '654021', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3077', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '伊宁县');
INSERT INTO `systemctl_location_info` VALUES ('3078', 'CBCEXBZZX', 'insert', '察布查尔锡伯自治县', '654022', 'region', '2015-01-19 15:59:00', '1', '', '654000', null, '3078', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '察布查尔锡伯自治县');
INSERT INTO `systemctl_location_info` VALUES ('3079', 'BQ', 'insert', '北区', '710405', 'region', '2015-01-19 15:59:00', '1', '', '710400', null, '3079', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北区');
INSERT INTO `systemctl_location_info` VALUES ('3080', 'BTQ', 'insert', '北屯区', '710406', 'region', '2015-01-19 15:59:00', '1', '', '710400', null, '3080', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北屯区');
INSERT INTO `systemctl_location_info` VALUES ('3081', 'XTQ', 'insert', '西屯区', '710407', 'region', '2015-01-19 15:59:00', '1', '', '710400', null, '3081', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西屯区');
INSERT INTO `systemctl_location_info` VALUES ('3082', 'NTQ', 'insert', '南屯区', '710408', 'region', '2015-01-19 15:59:00', '1', '', '710400', null, '3082', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南屯区');
INSERT INTO `systemctl_location_info` VALUES ('3083', 'TNS', 'insert', '台南市', '710500', 'city', '2015-01-19 15:59:00', '1', '', '710000', null, '3083', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台南市');
INSERT INTO `systemctl_location_info` VALUES ('3084', 'ZXQ', 'insert', '中西区', '710501', 'region', '2015-01-19 15:59:00', '1', '', '710500', null, '3084', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中西区');
INSERT INTO `systemctl_location_info` VALUES ('3085', 'DQ', 'insert', '东区', '710502', 'region', '2015-01-19 15:59:00', '1', '', '710500', null, '3085', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东区');
INSERT INTO `systemctl_location_info` VALUES ('3086', 'NQ', 'insert', '南区', '710503', 'region', '2015-01-19 15:59:00', '1', '', '710500', null, '3086', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南区');
INSERT INTO `systemctl_location_info` VALUES ('3087', 'BQ', 'insert', '北区', '710504', 'region', '2015-01-19 15:59:00', '1', '', '710500', null, '3087', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北区');
INSERT INTO `systemctl_location_info` VALUES ('3088', 'APQ', 'insert', '安平区', '710505', 'region', '2015-01-19 15:59:00', '1', '', '710500', null, '3088', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安平区');
INSERT INTO `systemctl_location_info` VALUES ('3089', 'ANQ', 'insert', '安南区', '710506', 'region', '2015-01-19 15:59:00', '1', '', '710500', null, '3089', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安南区');
INSERT INTO `systemctl_location_info` VALUES ('3090', 'XZS', 'insert', '新竹市', '710600', 'city', '2015-01-19 15:59:00', '1', '', '710000', null, '3090', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新竹市');
INSERT INTO `systemctl_location_info` VALUES ('3091', 'DQ', 'insert', '东区', '710601', 'region', '2015-01-19 15:59:00', '1', '', '710600', null, '3091', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东区');
INSERT INTO `systemctl_location_info` VALUES ('3092', 'BQ', 'insert', '北区', '710602', 'region', '2015-01-19 15:59:00', '1', '', '710600', null, '3092', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北区');
INSERT INTO `systemctl_location_info` VALUES ('3093', 'XSQ', 'insert', '香山区', '710603', 'region', '2015-01-19 15:59:00', '1', '', '710600', null, '3093', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '香山区');
INSERT INTO `systemctl_location_info` VALUES ('3094', 'JYS', 'insert', '嘉义市', '710700', 'city', '2015-01-19 15:59:00', '1', '', '710000', null, '3094', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉义市');
INSERT INTO `systemctl_location_info` VALUES ('3095', 'DQ', 'insert', '东区', '710701', 'region', '2015-01-19 15:59:00', '1', '', '710700', null, '3095', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东区');
INSERT INTO `systemctl_location_info` VALUES ('3096', 'XQ', 'insert', '西区', '710702', 'region', '2015-01-19 15:59:00', '1', '', '710700', null, '3096', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西区');
INSERT INTO `systemctl_location_info` VALUES ('3097', 'SZX', 'insert', '省直辖', '719000', 'city', '2015-01-19 15:59:00', '1', '', '710000', null, '3097', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '省直辖');
INSERT INTO `systemctl_location_info` VALUES ('3098', 'TBX', 'insert', '台北县', '719001', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3098', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台北县');
INSERT INTO `systemctl_location_info` VALUES ('3099', 'YLX', 'insert', '宜兰县', '719002', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3099', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宜兰县');
INSERT INTO `systemctl_location_info` VALUES ('3100', 'XZX', 'insert', '新竹县', '719003', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3100', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新竹县');
INSERT INTO `systemctl_location_info` VALUES ('3101', 'TYX', 'insert', '桃园县', '719004', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3101', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桃园县');
INSERT INTO `systemctl_location_info` VALUES ('3102', 'MLX', 'insert', '苗栗县', '719005', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3102', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '苗栗县');
INSERT INTO `systemctl_location_info` VALUES ('3103', 'TZX', 'insert', '台中县', '719006', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3103', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台中县');
INSERT INTO `systemctl_location_info` VALUES ('3104', 'ZHX', 'insert', '彰化县', '719007', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3104', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彰化县');
INSERT INTO `systemctl_location_info` VALUES ('3105', 'NTX', 'insert', '南投县', '719008', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3105', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南投县');
INSERT INTO `systemctl_location_info` VALUES ('3106', 'JYX', 'insert', '嘉义县', '719009', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3106', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉义县');
INSERT INTO `systemctl_location_info` VALUES ('3107', 'YLX', 'insert', '云林县', '719010', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3107', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云林县');
INSERT INTO `systemctl_location_info` VALUES ('3108', 'TNX', 'insert', '台南县', '719011', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3108', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台南县');
INSERT INTO `systemctl_location_info` VALUES ('3109', 'GXX', 'insert', '高雄县', '719012', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3109', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '高雄县');
INSERT INTO `systemctl_location_info` VALUES ('3110', 'PDX', 'insert', '屏东县', '719013', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3110', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '屏东县');
INSERT INTO `systemctl_location_info` VALUES ('3111', 'TDX', 'insert', '台东县', '719014', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3111', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '台东县');
INSERT INTO `systemctl_location_info` VALUES ('3112', 'HLX', 'insert', '花莲县', '719015', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3112', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '花莲县');
INSERT INTO `systemctl_location_info` VALUES ('3113', 'PHX', 'insert', '澎湖县', '719016', 'region', '2015-01-19 15:59:00', '1', '', '719000', null, '3113', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澎湖县');
INSERT INTO `systemctl_location_info` VALUES ('3114', 'XGTBXZQ', 'insert', '香港特别行政区', '810000', 'sar', '2015-01-19 15:59:00', '1', '114.186124,22.293586', '0', null, '3114', '2015-01-19 15:59:00', 'system', 'A', '', '11', '', '香港特别行政区');
INSERT INTO `systemctl_location_info` VALUES ('3115', 'XGD', 'insert', '香港岛', '810100', 'region', '2015-01-19 15:59:00', '1', '', '810000', null, '3115', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '香港岛');
INSERT INTO `systemctl_location_info` VALUES ('3116', 'ZXQ', 'insert', '中西区', '810101', 'baidu', '2015-01-19 15:59:00', '1', '', '810100', null, '3116', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '中西区');
INSERT INTO `systemctl_location_info` VALUES ('3117', 'WZQ', 'insert', '湾仔区', '810102', 'baidu', '2015-01-19 15:59:00', '1', '', '810100', null, '3117', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '湾仔区');
INSERT INTO `systemctl_location_info` VALUES ('3118', 'DQ', 'insert', '东区', '810103', 'baidu', '2015-01-19 15:59:00', '1', '', '810100', null, '3118', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '东区');
INSERT INTO `systemctl_location_info` VALUES ('3119', 'NQ', 'insert', '南区', '810104', 'baidu', '2015-01-19 15:59:00', '1', '', '810100', null, '3119', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南区');
INSERT INTO `systemctl_location_info` VALUES ('3120', 'JL', 'insert', '九龙', '810200', 'region', '2015-01-19 15:59:00', '1', '', '810000', null, '3120', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '九龙');
INSERT INTO `systemctl_location_info` VALUES ('3121', 'YJWQ', 'insert', '油尖旺区', '810201', 'baidu', '2015-01-19 15:59:00', '1', '', '810200', null, '3121', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '油尖旺区');
INSERT INTO `systemctl_location_info` VALUES ('3122', 'SSBQ', 'insert', '深水埗区', '810202', 'baidu', '2015-01-19 15:59:00', '1', '', '810200', null, '3122', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '深水埗区');
INSERT INTO `systemctl_location_info` VALUES ('3123', 'JLCQ', 'insert', '九龙城区', '810203', 'baidu', '2015-01-19 15:59:00', '1', '', '810200', null, '3123', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '九龙城区');
INSERT INTO `systemctl_location_info` VALUES ('3124', 'HDXQ', 'insert', '黄大仙区', '810204', 'baidu', '2015-01-19 15:59:00', '1', '', '810200', null, '3124', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '黄大仙区');
INSERT INTO `systemctl_location_info` VALUES ('3125', 'GTQ', 'insert', '观塘区', '810205', 'baidu', '2015-01-19 15:59:00', '1', '', '810200', null, '3125', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '观塘区');
INSERT INTO `systemctl_location_info` VALUES ('3126', 'XJ', 'insert', '新界', '810300', 'region', '2015-01-19 15:59:00', '1', '', '810000', null, '3126', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新界');
INSERT INTO `systemctl_location_info` VALUES ('3127', 'BQ', 'insert', '北区', '810301', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3127', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '北区');
INSERT INTO `systemctl_location_info` VALUES ('3128', 'DPQ', 'insert', '大埔区', '810302', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3128', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大埔区');
INSERT INTO `systemctl_location_info` VALUES ('3129', 'STQ', 'insert', '沙田区', '810303', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3129', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沙田区');
INSERT INTO `systemctl_location_info` VALUES ('3130', 'XGQ', 'insert', '西贡区', '810304', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3130', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西贡区');
INSERT INTO `systemctl_location_info` VALUES ('3131', 'QWQ', 'insert', '荃湾区', '810305', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3131', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '荃湾区');
INSERT INTO `systemctl_location_info` VALUES ('3132', 'TMQ', 'insert', '屯门区', '810306', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3132', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '屯门区');
INSERT INTO `systemctl_location_info` VALUES ('3133', 'YLQ', 'insert', '元朗区', '810307', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3133', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '元朗区');
INSERT INTO `systemctl_location_info` VALUES ('3134', 'KQQ', 'insert', '葵青区', '810308', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3134', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '葵青区');
INSERT INTO `systemctl_location_info` VALUES ('3135', 'LDQ', 'insert', '离岛区', '810309', 'baidu', '2015-01-19 15:59:00', '1', '', '810300', null, '3135', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '离岛区');
INSERT INTO `systemctl_location_info` VALUES ('3136', 'AMTBXZQ', 'insert', '澳门特别行政区', '820000', 'sar', '2015-01-19 15:59:00', '1', '113.557519,22.204118', '0', null, '3136', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '澳门特别行政区');
INSERT INTO `systemctl_location_info` VALUES ('3137', 'AMBD', 'insert', '澳门半岛', '820100', 'region', '2015-01-19 15:59:00', '1', '', '820000', null, '3137', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澳门半岛');
INSERT INTO `systemctl_location_info` VALUES ('3138', 'HDMTQ', 'insert', '花地玛堂区', '820101', 'baidu', '2015-01-19 15:59:00', '1', '', '820100', null, '3138', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '花地玛堂区');
INSERT INTO `systemctl_location_info` VALUES ('3139', 'SADNTQ', 'insert', '圣安多尼堂区', '820102', 'baidu', '2015-01-19 15:59:00', '1', '', '820100', null, '3139', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '圣安多尼堂区');
INSERT INTO `systemctl_location_info` VALUES ('3140', 'DTQ', 'insert', '大堂区', '820103', 'baidu', '2015-01-19 15:59:00', '1', '', '820100', null, '3140', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大堂区');
INSERT INTO `systemctl_location_info` VALUES ('3141', 'WDTQ', 'insert', '望德堂区', '820104', 'baidu', '2015-01-19 15:59:00', '1', '', '820100', null, '3141', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '望德堂区');
INSERT INTO `systemctl_location_info` VALUES ('3142', 'FSTQ', 'insert', '风顺堂区', '820105', 'baidu', '2015-01-19 15:59:00', '1', '', '820100', null, '3142', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '风顺堂区');
INSERT INTO `systemctl_location_info` VALUES ('3143', 'AMLD', 'insert', '澳门离岛', '820200', 'region', '2015-01-19 15:59:00', '1', '', '820000', null, '3143', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澳门离岛');
INSERT INTO `systemctl_location_info` VALUES ('3144', 'JMTQ', 'insert', '嘉模堂区', '820201', 'baidu', '2015-01-19 15:59:00', '1', '', '820200', null, '3144', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉模堂区');
INSERT INTO `systemctl_location_info` VALUES ('3145', 'SFJGTQ', 'insert', '圣方济各堂区', '820202', 'baidu', '2015-01-19 15:59:00', '1', '', '820200', null, '3145', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '圣方济各堂区');
INSERT INTO `systemctl_location_info` VALUES ('3146', 'WTQHFQY', 'insert', '无堂区划分区域', '820300', 'region', '2015-01-19 15:59:00', '1', '', '820000', null, '3146', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '无堂区划分区域');
INSERT INTO `systemctl_location_info` VALUES ('3147', 'LDC', 'insert', '路氹城', '820301', 'baidu', '2015-01-19 15:59:00', '1', '', '820300', null, '3147', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '路氹城');
INSERT INTO `systemctl_location_info` VALUES ('3148', 'XWS', 'insert', '宣威市', '530381', 'region', '2015-01-19 15:59:00', '1', '', '530300', null, '3148', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宣威市');
INSERT INTO `systemctl_location_info` VALUES ('3149', 'YXS', 'insert', '玉溪市', '530400', 'city', '2015-01-19 15:59:00', '1', '102.545068,24.370447', '530000', null, '3149', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '玉溪市');
INSERT INTO `systemctl_location_info` VALUES ('3150', 'HTQ', 'insert', '红塔区', '530402', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3150', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红塔区');
INSERT INTO `systemctl_location_info` VALUES ('3151', 'JCX', 'insert', '江川县', '530421', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3151', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江川县');
INSERT INTO `systemctl_location_info` VALUES ('3152', 'CJX', 'insert', '澄江县', '530422', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3152', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澄江县');
INSERT INTO `systemctl_location_info` VALUES ('3153', 'THX', 'insert', '通海县', '530423', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3153', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '通海县');
INSERT INTO `systemctl_location_info` VALUES ('3154', 'HNX', 'insert', '华宁县', '530424', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3154', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华宁县');
INSERT INTO `systemctl_location_info` VALUES ('3155', 'YMX', 'insert', '易门县', '530425', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3155', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '易门县');
INSERT INTO `systemctl_location_info` VALUES ('3156', 'ESYZZZX', 'insert', '峨山彝族自治县', '530426', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3156', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '峨山彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3157', 'XPYZDZZZX', 'insert', '新平彝族傣族自治县', '530427', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3157', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '新平彝族傣族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3158', 'YJHNZYZDZZZX', 'insert', '元江哈尼族彝族傣族自治县', '530428', 'region', '2015-01-19 15:59:00', '1', '', '530400', null, '3158', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '元江哈尼族彝族傣族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3159', 'BSS', 'insert', '保山市', '530500', 'city', '2015-01-19 15:59:00', '1', '99.177996,25.120489', '530000', null, '3159', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '保山市');
INSERT INTO `systemctl_location_info` VALUES ('3160', 'LYQ', 'insert', '隆阳区', '530502', 'region', '2015-01-19 15:59:00', '1', '', '530500', null, '3160', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆阳区');
INSERT INTO `systemctl_location_info` VALUES ('3161', 'SDX', 'insert', '施甸县', '530521', 'region', '2015-01-19 15:59:00', '1', '', '530500', null, '3161', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '施甸县');
INSERT INTO `systemctl_location_info` VALUES ('3162', 'TCX', 'insert', '腾冲县', '530522', 'region', '2015-01-19 15:59:00', '1', '', '530500', null, '3162', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '腾冲县');
INSERT INTO `systemctl_location_info` VALUES ('3163', 'LLX', 'insert', '龙陵县', '530523', 'region', '2015-01-19 15:59:00', '1', '', '530500', null, '3163', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '龙陵县');
INSERT INTO `systemctl_location_info` VALUES ('3164', 'CNX', 'insert', '昌宁县', '530524', 'region', '2015-01-19 15:59:00', '1', '', '530500', null, '3164', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌宁县');
INSERT INTO `systemctl_location_info` VALUES ('3165', 'ZTS', 'insert', '昭通市', '530600', 'city', '2015-01-19 15:59:00', '1', '103.725021,27.340633', '530000', null, '3165', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '昭通市');
INSERT INTO `systemctl_location_info` VALUES ('3166', 'ZYQ', 'insert', '昭阳区', '530602', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3166', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昭阳区');
INSERT INTO `systemctl_location_info` VALUES ('3167', 'LDX', 'insert', '鲁甸县', '530621', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3167', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鲁甸县');
INSERT INTO `systemctl_location_info` VALUES ('3168', 'QJX', 'insert', '巧家县', '530622', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3168', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巧家县');
INSERT INTO `systemctl_location_info` VALUES ('3169', 'YJX', 'insert', '盐津县', '530623', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3169', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盐津县');
INSERT INTO `systemctl_location_info` VALUES ('3170', 'DGX', 'insert', '大关县', '530624', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3170', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大关县');
INSERT INTO `systemctl_location_info` VALUES ('3171', 'YSX', 'insert', '永善县', '530625', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3171', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永善县');
INSERT INTO `systemctl_location_info` VALUES ('3172', 'SJX', 'insert', '绥江县', '530626', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3172', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绥江县');
INSERT INTO `systemctl_location_info` VALUES ('3173', 'ZXX', 'insert', '镇雄县', '530627', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3173', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇雄县');
INSERT INTO `systemctl_location_info` VALUES ('3174', 'YLX', 'insert', '彝良县', '530628', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3174', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '彝良县');
INSERT INTO `systemctl_location_info` VALUES ('3175', 'WXX', 'insert', '威信县', '530629', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3175', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '威信县');
INSERT INTO `systemctl_location_info` VALUES ('3176', 'SFX', 'insert', '水富县', '530630', 'region', '2015-01-19 15:59:00', '1', '', '530600', null, '3176', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '水富县');
INSERT INTO `systemctl_location_info` VALUES ('3177', 'LJS', 'insert', '丽江市', '530700', 'city', '2015-01-19 15:59:00', '1', '100.229628,26.875351', '530000', null, '3177', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '丽江市');
INSERT INTO `systemctl_location_info` VALUES ('3178', 'GCQ', 'insert', '古城区', '530702', 'region', '2015-01-19 15:59:00', '1', '', '530700', null, '3178', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '古城区');
INSERT INTO `systemctl_location_info` VALUES ('3179', 'YLNXZZZX', 'insert', '玉龙纳西族自治县', '530721', 'region', '2015-01-19 15:59:00', '1', '', '530700', null, '3179', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '玉龙纳西族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3180', 'YSX', 'insert', '永胜县', '530722', 'region', '2015-01-19 15:59:00', '1', '', '530700', null, '3180', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永胜县');
INSERT INTO `systemctl_location_info` VALUES ('3181', 'HPX', 'insert', '华坪县', '530723', 'region', '2015-01-19 15:59:00', '1', '', '530700', null, '3181', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '华坪县');
INSERT INTO `systemctl_location_info` VALUES ('3182', 'NLYZZZX', 'insert', '宁蒗彝族自治县', '530724', 'region', '2015-01-19 15:59:00', '1', '', '530700', null, '3182', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁蒗彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3183', 'PES', 'insert', '普洱市', '530800', 'city', '2015-01-19 15:59:00', '1', '100.980058,22.788778', '530000', null, '3183', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '普洱市');
INSERT INTO `systemctl_location_info` VALUES ('3184', 'SMQ', 'insert', '思茅区', '530802', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3184', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '思茅区');
INSERT INTO `systemctl_location_info` VALUES ('3185', 'NEHNZYZZZX', 'insert', '宁洱哈尼族彝族自治县', '530821', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3185', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宁洱哈尼族彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3186', 'MJHNZZZX', 'insert', '墨江哈尼族自治县', '530822', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3186', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '墨江哈尼族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3187', 'JDYZZZX', 'insert', '景东彝族自治县', '530823', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3187', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '景东彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3188', 'JGDZYZZZX', 'insert', '景谷傣族彝族自治县', '530824', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3188', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '景谷傣族彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3189', 'ZYYZHNZLHZZZX', 'insert', '镇沅彝族哈尼族拉祜族自治县', '530825', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3189', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇沅彝族哈尼族拉祜族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3190', 'JCHNZYZZZX', 'insert', '江城哈尼族彝族自治县', '530826', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3190', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江城哈尼族彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3191', 'MLDZLHZWZZZX', 'insert', '孟连傣族拉祜族佤族自治县', '530827', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3191', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '孟连傣族拉祜族佤族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3192', 'LCLHZZZX', 'insert', '澜沧拉祜族自治县', '530828', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3192', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '澜沧拉祜族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3193', 'XMWZZZX', 'insert', '西盟佤族自治县', '530829', 'region', '2015-01-19 15:59:00', '1', '', '530800', null, '3193', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西盟佤族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3194', 'LCS', 'insert', '临沧市', '530900', 'city', '2015-01-19 15:59:00', '1', '100.092613,23.887806', '530000', null, '3194', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '临沧市');
INSERT INTO `systemctl_location_info` VALUES ('3195', 'LXQ', 'insert', '临翔区', '530902', 'region', '2015-01-19 15:59:00', '1', '', '530900', null, '3195', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '临翔区');
INSERT INTO `systemctl_location_info` VALUES ('3196', 'FQX', 'insert', '凤庆县', '530921', 'region', '2015-01-19 15:59:00', '1', '', '530900', null, '3196', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '凤庆县');
INSERT INTO `systemctl_location_info` VALUES ('3197', 'YX', 'insert', '云县', '530922', 'region', '2015-01-19 15:59:00', '1', '', '530900', null, '3197', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云县');
INSERT INTO `systemctl_location_info` VALUES ('3198', 'YDX', 'insert', '永德县', '530923', 'region', '2015-01-19 15:59:00', '1', '', '530900', null, '3198', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永德县');
INSERT INTO `systemctl_location_info` VALUES ('3199', 'ZKX', 'insert', '镇康县', '530924', 'region', '2015-01-19 15:59:00', '1', '', '530900', null, '3199', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '镇康县');
INSERT INTO `systemctl_location_info` VALUES ('3200', 'SJLHZWZBLZDZZZX', 'insert', '双江拉祜族佤族布朗族傣族自治县', '530925', 'region', '2015-01-19 15:59:00', '1', '', '530900', null, '3200', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双江拉祜族佤族布朗族傣族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3201', 'GMDZWZZZX', 'insert', '耿马傣族佤族自治县', '530926', 'region', '2015-01-19 15:59:00', '1', '', '530900', null, '3201', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '耿马傣族佤族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3202', 'CYWZZZX', 'insert', '沧源佤族自治县', '530927', 'region', '2015-01-19 15:59:00', '1', '', '530900', null, '3202', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '沧源佤族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3203', 'CXYZZZZ', 'insert', '楚雄彝族自治州', '532300', 'city', '2015-01-19 15:59:00', '1', '', '530000', null, '3203', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '楚雄彝族自治州');
INSERT INTO `systemctl_location_info` VALUES ('3204', 'CXS', 'insert', '楚雄市', '532301', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3204', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '楚雄市');
INSERT INTO `systemctl_location_info` VALUES ('3205', 'SBX', 'insert', '双柏县', '532322', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3205', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '双柏县');
INSERT INTO `systemctl_location_info` VALUES ('3206', 'MDX', 'insert', '牟定县', '532323', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3206', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '牟定县');
INSERT INTO `systemctl_location_info` VALUES ('3207', 'NHX', 'insert', '南华县', '532324', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3207', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南华县');
INSERT INTO `systemctl_location_info` VALUES ('3208', 'YAX', 'insert', '姚安县', '532325', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3208', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '姚安县');
INSERT INTO `systemctl_location_info` VALUES ('3209', 'DYX', 'insert', '大姚县', '532326', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3209', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大姚县');
INSERT INTO `systemctl_location_info` VALUES ('3210', 'YRX', 'insert', '永仁县', '532327', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3210', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永仁县');
INSERT INTO `systemctl_location_info` VALUES ('3211', 'YMX', 'insert', '元谋县', '532328', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3211', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '元谋县');
INSERT INTO `systemctl_location_info` VALUES ('3212', 'WDX', 'insert', '武定县', '532329', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3212', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '武定县');
INSERT INTO `systemctl_location_info` VALUES ('3213', 'LFX', 'insert', '禄丰县', '532331', 'region', '2015-01-19 15:59:00', '1', '', '532300', null, '3213', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '禄丰县');
INSERT INTO `systemctl_location_info` VALUES ('3214', 'HHHNZYZZZZ', 'insert', '红河哈尼族彝族自治州', '532500', 'city', '2015-01-19 15:59:00', '1', '', '530000', null, '3214', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红河哈尼族彝族自治州');
INSERT INTO `systemctl_location_info` VALUES ('3215', 'GJS', 'insert', '个旧市', '532501', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3215', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '个旧市');
INSERT INTO `systemctl_location_info` VALUES ('3216', 'KYS', 'insert', '开远市', '532502', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3216', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '开远市');
INSERT INTO `systemctl_location_info` VALUES ('3217', 'MZS', 'insert', '蒙自市', '532503', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3217', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '蒙自市');
INSERT INTO `systemctl_location_info` VALUES ('3218', 'PBMZZZX', 'insert', '屏边苗族自治县', '532523', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3218', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '屏边苗族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3219', 'JSX', 'insert', '建水县', '532524', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3219', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '建水县');
INSERT INTO `systemctl_location_info` VALUES ('3220', 'SPX', 'insert', '石屏县', '532525', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3220', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '石屏县');
INSERT INTO `systemctl_location_info` VALUES ('3221', 'MLX', 'insert', '弥勒县', '532526', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3221', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '弥勒县');
INSERT INTO `systemctl_location_info` VALUES ('3222', 'LXX', 'insert', '泸西县', '532527', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3222', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泸西县');
INSERT INTO `systemctl_location_info` VALUES ('3223', 'YYX', 'insert', '元阳县', '532528', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3223', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '元阳县');
INSERT INTO `systemctl_location_info` VALUES ('3224', 'HHX', 'insert', '红河县', '532529', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3224', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '红河县');
INSERT INTO `systemctl_location_info` VALUES ('3225', 'JPMZYZDZZZX', 'insert', '金平苗族瑶族傣族自治县', '532530', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3225', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '金平苗族瑶族傣族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3226', 'LCX', 'insert', '绿春县', '532531', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3226', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '绿春县');
INSERT INTO `systemctl_location_info` VALUES ('3227', 'HKYZZZX', 'insert', '河口瑶族自治县', '532532', 'region', '2015-01-19 15:59:00', '1', '', '532500', null, '3227', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '河口瑶族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3228', 'WSZZMZZZZ', 'insert', '文山壮族苗族自治州', '532600', 'city', '2015-01-19 15:59:00', '1', '104.089112,23.401781', '530000', null, '3228', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '文山壮族苗族自治州');
INSERT INTO `systemctl_location_info` VALUES ('3229', 'WSS', 'insert', '文山市', '532621', 'region', '2015-01-19 15:59:00', '1', '', '532600', null, '3229', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '文山市');
INSERT INTO `systemctl_location_info` VALUES ('3230', 'YSX', 'insert', '砚山县', '532622', 'region', '2015-01-19 15:59:00', '1', '', '532600', null, '3230', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '砚山县');
INSERT INTO `systemctl_location_info` VALUES ('3231', 'XCX', 'insert', '西畴县', '532623', 'region', '2015-01-19 15:59:00', '1', '', '532600', null, '3231', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西畴县');
INSERT INTO `systemctl_location_info` VALUES ('3232', 'MLPX', 'insert', '麻栗坡县', '532624', 'region', '2015-01-19 15:59:00', '1', '', '532600', null, '3232', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '麻栗坡县');
INSERT INTO `systemctl_location_info` VALUES ('3233', 'MGX', 'insert', '马关县', '532625', 'region', '2015-01-19 15:59:00', '1', '', '532600', null, '3233', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '马关县');
INSERT INTO `systemctl_location_info` VALUES ('3234', 'QBX', 'insert', '丘北县', '532626', 'region', '2015-01-19 15:59:00', '1', '', '532600', null, '3234', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丘北县');
INSERT INTO `systemctl_location_info` VALUES ('3235', 'GNX', 'insert', '广南县', '532627', 'region', '2015-01-19 15:59:00', '1', '', '532600', null, '3235', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '广南县');
INSERT INTO `systemctl_location_info` VALUES ('3236', 'FNX', 'insert', '富宁县', '532628', 'region', '2015-01-19 15:59:00', '1', '', '532600', null, '3236', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '富宁县');
INSERT INTO `systemctl_location_info` VALUES ('3237', 'XSBNDZZZZ', 'insert', '西双版纳傣族自治州', '532800', 'city', '2015-01-19 15:59:00', '1', '100.803038,22.009433', '530000', null, '3237', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '西双版纳傣族自治州');
INSERT INTO `systemctl_location_info` VALUES ('3238', 'JHS', 'insert', '景洪市', '532801', 'region', '2015-01-19 15:59:00', '1', '', '532800', null, '3238', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '景洪市');
INSERT INTO `systemctl_location_info` VALUES ('3239', 'MHX', 'insert', '勐海县', '532822', 'region', '2015-01-19 15:59:00', '1', '', '532800', null, '3239', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '勐海县');
INSERT INTO `systemctl_location_info` VALUES ('3240', 'MLX', 'insert', '勐腊县', '532823', 'region', '2015-01-19 15:59:00', '1', '', '532800', null, '3240', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '勐腊县');
INSERT INTO `systemctl_location_info` VALUES ('3241', 'DLBZZZZ', 'insert', '大理白族自治州', '532900', 'city', '2015-01-19 15:59:00', '1', '', '530000', null, '3241', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大理白族自治州');
INSERT INTO `systemctl_location_info` VALUES ('3242', 'DLS', 'insert', '大理市', '532901', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3242', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '大理市');
INSERT INTO `systemctl_location_info` VALUES ('3243', 'YBYZZZX', 'insert', '漾濞彝族自治县', '532922', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3243', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '漾濞彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3244', 'XYX', 'insert', '祥云县', '532923', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3244', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '祥云县');
INSERT INTO `systemctl_location_info` VALUES ('3245', 'BCX', 'insert', '宾川县', '532924', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3245', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '宾川县');
INSERT INTO `systemctl_location_info` VALUES ('3246', 'MDX', 'insert', '弥渡县', '532925', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3246', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '弥渡县');
INSERT INTO `systemctl_location_info` VALUES ('3247', 'NJYZZZX', 'insert', '南涧彝族自治县', '532926', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3247', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南涧彝族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3248', 'WSYZHZZZX', 'insert', '巍山彝族回族自治县', '532927', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3248', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巍山彝族回族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3249', 'YPX', 'insert', '永平县', '532928', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3249', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '永平县');
INSERT INTO `systemctl_location_info` VALUES ('3250', 'YLX', 'insert', '云龙县', '532929', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3250', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '云龙县');
INSERT INTO `systemctl_location_info` VALUES ('3251', 'EYX', 'insert', '洱源县', '532930', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3251', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洱源县');
INSERT INTO `systemctl_location_info` VALUES ('3252', 'JCX', 'insert', '剑川县', '532931', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3252', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '剑川县');
INSERT INTO `systemctl_location_info` VALUES ('3253', 'HQX', 'insert', '鹤庆县', '532932', 'region', '2015-01-19 15:59:00', '1', '', '532900', null, '3253', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '鹤庆县');
INSERT INTO `systemctl_location_info` VALUES ('3254', 'DHDZJPZZZZ', 'insert', '德宏傣族景颇族自治州', '533100', 'city', '2015-01-19 15:59:00', '1', '', '530000', null, '3254', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德宏傣族景颇族自治州');
INSERT INTO `systemctl_location_info` VALUES ('3255', 'RLS', 'insert', '瑞丽市', '533102', 'region', '2015-01-19 15:59:00', '1', '', '533100', null, '3255', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '瑞丽市');
INSERT INTO `systemctl_location_info` VALUES ('3256', 'MS', 'insert', '芒市', '533103', 'region', '2015-01-19 15:59:00', '1', '', '533100', null, '3256', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芒市');
INSERT INTO `systemctl_location_info` VALUES ('3257', 'LHX', 'insert', '梁河县', '533122', 'region', '2015-01-19 15:59:00', '1', '', '533100', null, '3257', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '梁河县');
INSERT INTO `systemctl_location_info` VALUES ('3258', 'YJX', 'insert', '盈江县', '533123', 'region', '2015-01-19 15:59:00', '1', '', '533100', null, '3258', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '盈江县');
INSERT INTO `systemctl_location_info` VALUES ('3259', 'LCX', 'insert', '陇川县', '533124', 'region', '2015-01-19 15:59:00', '1', '', '533100', null, '3259', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '陇川县');
INSERT INTO `systemctl_location_info` VALUES ('3260', 'NJLSZZZZ', 'insert', '怒江傈僳族自治州', '533300', 'city', '2015-01-19 15:59:00', '1', '', '530000', null, '3260', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '怒江傈僳族自治州');
INSERT INTO `systemctl_location_info` VALUES ('3261', 'LSX', 'insert', '泸水县', '533321', 'region', '2015-01-19 15:59:00', '1', '', '533300', null, '3261', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '泸水县');
INSERT INTO `systemctl_location_info` VALUES ('3262', 'FGX', 'insert', '福贡县', '533323', 'region', '2015-01-19 15:59:00', '1', '', '533300', null, '3262', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '福贡县');
INSERT INTO `systemctl_location_info` VALUES ('3263', 'GSDLZNZZZX', 'insert', '贡山独龙族怒族自治县', '533324', 'region', '2015-01-19 15:59:00', '1', '', '533300', null, '3263', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贡山独龙族怒族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3264', 'LPBZPMZZZX', 'insert', '兰坪白族普米族自治县', '533325', 'region', '2015-01-19 15:59:00', '1', '', '533300', null, '3264', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '兰坪白族普米族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3265', 'DQZZZZZ', 'insert', '迪庆藏族自治州', '533400', 'city', '2015-01-19 15:59:00', '1', '', '530000', null, '3265', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '迪庆藏族自治州');
INSERT INTO `systemctl_location_info` VALUES ('3266', 'XGLLX', 'insert', '香格里拉县', '533421', 'region', '2015-01-19 15:59:00', '1', '', '533400', null, '3266', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '香格里拉县');
INSERT INTO `systemctl_location_info` VALUES ('3267', 'DQX', 'insert', '德钦县', '533422', 'region', '2015-01-19 15:59:00', '1', '', '533400', null, '3267', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '德钦县');
INSERT INTO `systemctl_location_info` VALUES ('3268', 'WXLSZZZX', 'insert', '维西傈僳族自治县', '533423', 'region', '2015-01-19 15:59:00', '1', '', '533400', null, '3268', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '维西傈僳族自治县');
INSERT INTO `systemctl_location_info` VALUES ('3269', 'XZZZQ', 'insert', '西藏自治区', '540000', 'province', '2015-01-19 15:59:00', '1', '', '0', null, '3269', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '西藏自治区');
INSERT INTO `systemctl_location_info` VALUES ('3270', 'LSS', 'insert', '拉萨市', '540100', 'city', '2015-01-19 15:59:00', '1', '91.111891,29.662557', '540000', null, '3270', '2015-01-19 15:59:00', 'system', 'A', '', '13', '', '拉萨市');
INSERT INTO `systemctl_location_info` VALUES ('3271', 'CGQ', 'insert', '城关区', '540102', 'region', '2015-01-19 15:59:00', '1', '', '540100', null, '3271', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '城关区');
INSERT INTO `systemctl_location_info` VALUES ('3272', 'LZX', 'insert', '林周县', '540121', 'region', '2015-01-19 15:59:00', '1', '', '540100', null, '3272', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '林周县');
INSERT INTO `systemctl_location_info` VALUES ('3273', 'DXX', 'insert', '当雄县', '540122', 'region', '2015-01-19 15:59:00', '1', '', '540100', null, '3273', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '当雄县');
INSERT INTO `systemctl_location_info` VALUES ('3274', 'NMX', 'insert', '尼木县', '540123', 'region', '2015-01-19 15:59:00', '1', '', '540100', null, '3274', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尼木县');
INSERT INTO `systemctl_location_info` VALUES ('3275', 'QSX', 'insert', '曲水县', '540124', 'region', '2015-01-19 15:59:00', '1', '', '540100', null, '3275', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曲水县');
INSERT INTO `systemctl_location_info` VALUES ('3276', 'DLDQX', 'insert', '堆龙德庆县', '540125', 'region', '2015-01-19 15:59:00', '1', '', '540100', null, '3276', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '堆龙德庆县');
INSERT INTO `systemctl_location_info` VALUES ('3277', 'DZX', 'insert', '达孜县', '540126', 'region', '2015-01-19 15:59:00', '1', '', '540100', null, '3277', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '达孜县');
INSERT INTO `systemctl_location_info` VALUES ('3278', 'MZGKX', 'insert', '墨竹工卡县', '540127', 'region', '2015-01-19 15:59:00', '1', '', '540100', null, '3278', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '墨竹工卡县');
INSERT INTO `systemctl_location_info` VALUES ('3279', 'CDDQ', 'insert', '昌都地区', '542100', 'city', '2015-01-19 15:59:00', '1', '97.185582,31.140576', '540000', null, '3279', '2015-01-19 15:59:00', 'system', 'A', '', '15', '', '昌都地区');
INSERT INTO `systemctl_location_info` VALUES ('3280', 'CDX', 'insert', '昌都县', '542121', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3280', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昌都县');
INSERT INTO `systemctl_location_info` VALUES ('3281', 'JDX', 'insert', '江达县', '542122', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3281', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江达县');
INSERT INTO `systemctl_location_info` VALUES ('3282', 'GJX', 'insert', '贡觉县', '542123', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3282', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贡觉县');
INSERT INTO `systemctl_location_info` VALUES ('3283', 'LWQX', 'insert', '类乌齐县', '542124', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3283', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '类乌齐县');
INSERT INTO `systemctl_location_info` VALUES ('3284', 'DQX', 'insert', '丁青县', '542125', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3284', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '丁青县');
INSERT INTO `systemctl_location_info` VALUES ('3285', 'CYX', 'insert', '察雅县', '542126', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3285', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '察雅县');
INSERT INTO `systemctl_location_info` VALUES ('3286', 'BSX', 'insert', '八宿县', '542127', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3286', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '八宿县');
INSERT INTO `systemctl_location_info` VALUES ('3287', 'ZGX', 'insert', '左贡县', '542128', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3287', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '左贡县');
INSERT INTO `systemctl_location_info` VALUES ('3288', 'MKX', 'insert', '芒康县', '542129', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3288', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '芒康县');
INSERT INTO `systemctl_location_info` VALUES ('3289', 'LLX', 'insert', '洛隆县', '542132', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3289', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洛隆县');
INSERT INTO `systemctl_location_info` VALUES ('3290', 'BBX', 'insert', '边坝县', '542133', 'region', '2015-01-19 15:59:00', '1', '', '542100', null, '3290', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '边坝县');
INSERT INTO `systemctl_location_info` VALUES ('3291', 'SNDQ', 'insert', '山南地区', '542200', 'city', '2015-01-19 15:59:00', '1', '91.750644,29.229027', '540000', null, '3291', '2015-01-19 15:59:00', 'system', 'A', '', '11', '', '山南地区');
INSERT INTO `systemctl_location_info` VALUES ('3292', 'NDX', 'insert', '乃东县', '542221', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3292', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '乃东县');
INSERT INTO `systemctl_location_info` VALUES ('3293', 'ZNX', 'insert', '扎囊县', '542222', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3293', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '扎囊县');
INSERT INTO `systemctl_location_info` VALUES ('3294', 'GGX', 'insert', '贡嘎县', '542223', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3294', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '贡嘎县');
INSERT INTO `systemctl_location_info` VALUES ('3295', 'SRX', 'insert', '桑日县', '542224', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3295', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '桑日县');
INSERT INTO `systemctl_location_info` VALUES ('3296', 'QJX', 'insert', '琼结县', '542225', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3296', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '琼结县');
INSERT INTO `systemctl_location_info` VALUES ('3297', 'QSX', 'insert', '曲松县', '542226', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3297', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '曲松县');
INSERT INTO `systemctl_location_info` VALUES ('3298', 'CMX', 'insert', '措美县', '542227', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3298', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '措美县');
INSERT INTO `systemctl_location_info` VALUES ('3299', 'LZX', 'insert', '洛扎县', '542228', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3299', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '洛扎县');
INSERT INTO `systemctl_location_info` VALUES ('3300', 'JCX', 'insert', '加查县', '542229', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3300', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '加查县');
INSERT INTO `systemctl_location_info` VALUES ('3301', 'LZX', 'insert', '隆子县', '542231', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3301', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '隆子县');
INSERT INTO `systemctl_location_info` VALUES ('3302', 'CNX', 'insert', '错那县', '542232', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3302', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '错那县');
INSERT INTO `systemctl_location_info` VALUES ('3303', 'LKZX', 'insert', '浪卡子县', '542233', 'region', '2015-01-19 15:59:00', '1', '', '542200', null, '3303', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '浪卡子县');
INSERT INTO `systemctl_location_info` VALUES ('3304', 'RKZDQ', 'insert', '日喀则地区', '542300', 'city', '2015-01-19 15:59:00', '1', '88.891486,29.269023', '540000', null, '3304', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '日喀则地区');
INSERT INTO `systemctl_location_info` VALUES ('3305', 'RKZS', 'insert', '日喀则市', '542301', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3305', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '日喀则市');
INSERT INTO `systemctl_location_info` VALUES ('3306', 'NMLX', 'insert', '南木林县', '542322', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3306', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '南木林县');
INSERT INTO `systemctl_location_info` VALUES ('3307', 'JZX', 'insert', '江孜县', '542323', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3307', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '江孜县');
INSERT INTO `systemctl_location_info` VALUES ('3308', 'DRX', 'insert', '定日县', '542324', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3308', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定日县');
INSERT INTO `systemctl_location_info` VALUES ('3309', 'SJX', 'insert', '萨迦县', '542325', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3309', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '萨迦县');
INSERT INTO `systemctl_location_info` VALUES ('3310', 'LZX', 'insert', '拉孜县', '542326', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3310', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '拉孜县');
INSERT INTO `systemctl_location_info` VALUES ('3311', 'ARX', 'insert', '昂仁县', '542327', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3311', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '昂仁县');
INSERT INTO `systemctl_location_info` VALUES ('3312', 'XTMX', 'insert', '谢通门县', '542328', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3312', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '谢通门县');
INSERT INTO `systemctl_location_info` VALUES ('3313', 'BLX', 'insert', '白朗县', '542329', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3313', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '白朗县');
INSERT INTO `systemctl_location_info` VALUES ('3314', 'RBX', 'insert', '仁布县', '542330', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3314', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仁布县');
INSERT INTO `systemctl_location_info` VALUES ('3315', 'KMX', 'insert', '康马县', '542331', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3315', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '康马县');
INSERT INTO `systemctl_location_info` VALUES ('3316', 'DJX', 'insert', '定结县', '542332', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3316', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '定结县');
INSERT INTO `systemctl_location_info` VALUES ('3317', 'ZBX', 'insert', '仲巴县', '542333', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3317', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '仲巴县');
INSERT INTO `systemctl_location_info` VALUES ('3318', 'YDX', 'insert', '亚东县', '542334', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3318', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '亚东县');
INSERT INTO `systemctl_location_info` VALUES ('3319', 'JLX', 'insert', '吉隆县', '542335', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3319', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '吉隆县');
INSERT INTO `systemctl_location_info` VALUES ('3320', 'NLMX', 'insert', '聂拉木县', '542336', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3320', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '聂拉木县');
INSERT INTO `systemctl_location_info` VALUES ('3321', 'SGX', 'insert', '萨嘎县', '542337', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3321', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '萨嘎县');
INSERT INTO `systemctl_location_info` VALUES ('3322', 'GBX', 'insert', '岗巴县', '542338', 'region', '2015-01-19 15:59:00', '1', '', '542300', null, '3322', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '岗巴县');
INSERT INTO `systemctl_location_info` VALUES ('3323', 'NQDQ', 'insert', '那曲地区', '542400', 'city', '2015-01-19 15:59:00', '1', '92.067018,31.48068', '540000', null, '3323', '2015-01-19 15:59:00', 'system', 'A', '', '14', '', '那曲地区');
INSERT INTO `systemctl_location_info` VALUES ('3324', 'NQX', 'insert', '那曲县', '542421', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3324', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '那曲县');
INSERT INTO `systemctl_location_info` VALUES ('3325', 'JLX', 'insert', '嘉黎县', '542422', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3325', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '嘉黎县');
INSERT INTO `systemctl_location_info` VALUES ('3326', 'BRX', 'insert', '比如县', '542423', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3326', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '比如县');
INSERT INTO `systemctl_location_info` VALUES ('3327', 'NRX', 'insert', '聂荣县', '542424', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3327', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '聂荣县');
INSERT INTO `systemctl_location_info` VALUES ('3328', 'ADX', 'insert', '安多县', '542425', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3328', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '安多县');
INSERT INTO `systemctl_location_info` VALUES ('3329', 'SZX', 'insert', '申扎县', '542426', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3329', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '申扎县');
INSERT INTO `systemctl_location_info` VALUES ('3330', 'SX', 'insert', '索县', '542427', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3330', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '索县');
INSERT INTO `systemctl_location_info` VALUES ('3331', 'BGX', 'insert', '班戈县', '542428', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3331', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '班戈县');
INSERT INTO `systemctl_location_info` VALUES ('3332', 'BQX', 'insert', '巴青县', '542429', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3332', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '巴青县');
INSERT INTO `systemctl_location_info` VALUES ('3333', 'NMX', 'insert', '尼玛县', '542430', 'region', '2015-01-19 15:59:00', '1', '', '542400', null, '3333', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '尼玛县');
INSERT INTO `systemctl_location_info` VALUES ('3334', 'ALDQ', 'insert', '阿里地区', '542500', 'city', '2015-01-19 15:59:00', '1', '81.107669,30.404557', '540000', null, '3334', '2015-01-19 15:59:00', 'system', 'A', '', '11', '', '阿里地区');
INSERT INTO `systemctl_location_info` VALUES ('3335', 'PLX', 'insert', '普兰县', '542521', 'region', '2015-01-19 15:59:00', '1', '', '542500', null, '3335', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '普兰县');
INSERT INTO `systemctl_location_info` VALUES ('3336', 'ZDX', 'insert', '札达县', '542522', 'region', '2015-01-19 15:59:00', '1', '', '542500', null, '3336', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '札达县');
INSERT INTO `systemctl_location_info` VALUES ('3337', 'GEX', 'insert', '噶尔县', '542523', 'region', '2015-01-19 15:59:00', '1', '', '542500', null, '3337', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '噶尔县');
INSERT INTO `systemctl_location_info` VALUES ('3338', 'RTX', 'insert', '日土县', '542524', 'region', '2015-01-19 15:59:00', '1', '', '542500', null, '3338', '2015-01-19 15:59:00', 'system', 'A', '', '', '', '日土县');
INSERT INTO `systemctl_location_info` VALUES ('3339', 'BJ', 'insert', '北京', '100000', 'municipality', '2016-12-06 15:59:00', '1', '116.395645,39.929986', '0', null, '197', '2016-12-06 15:59:00', 'system', 'A', '京', '12', '', '北京');
INSERT INTO `systemctl_location_info` VALUES ('4000', 'TJ', 'insert', '天津', '100001', 'municipality', '2016-12-06 15:59:00', '1', '117.210813,39.14393', '0', null, '214', '2016-12-06 15:59:00', 'system', 'A', '津', '12', '', '天津');
INSERT INTO `systemctl_location_info` VALUES ('4001', 'SH', 'insert', '上海', '100002', 'municipality', '2016-12-06 15:59:00', '1', '121.487899,31.249162', '0', null, '991', '2016-12-06 15:59:00', 'system', 'A', '沪', '12', '', '上海');
INSERT INTO `systemctl_location_info` VALUES ('4002', 'ZQ', 'insert', '重庆', '100003', 'municipality', '2016-12-06 15:59:00', '1', '106.530635,29.544606', '0', null, '2446', '2016-12-06 15:59:00', 'system', 'A', '渝', '12', '', '重庆');
