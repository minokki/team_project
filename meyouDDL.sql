/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MariaDB
 Source Server Version : 100904
 Source Host           : localhost:3306
 Source Schema         : meyou

 Target Server Type    : MariaDB
 Target Server Version : 100904
 File Encoding         : 65001

 Date: 25/02/2023 11:36:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acnt_trnsf
-- ----------------------------
DROP TABLE IF EXISTS `acnt_trnsf`;
CREATE TABLE `acnt_trnsf`  (
  `DNTN_CODE` bigint(20) NOT NULL,
  `USER_NO` bigint(20) NOT NULL,
  `ACCOUNT_BANK` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ACCOUNT_NUM` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ACNT_PASS` int(11) NOT NULL,
  PRIMARY KEY (`DNTN_CODE`, `USER_NO`) USING BTREE,
  CONSTRAINT `FK_DNTN_MSTR_TO_ACNT_TRNSF` FOREIGN KEY (`DNTN_CODE`, `USER_NO`) REFERENCES `dntn_mstr` (`DNTN_CODE`, `USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of acnt_trnsf
-- ----------------------------

-- ----------------------------
-- Table structure for bank_code
-- ----------------------------
DROP TABLE IF EXISTS `bank_code`;
CREATE TABLE `bank_code`  (
  `COM_BANK_CODE` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `COM_ACCOUNT` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`COM_BANK_CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bank_code
-- ----------------------------
INSERT INTO `bank_code` VALUES ('KB_001', '국민은행 1111-1111-111111');
INSERT INTO `bank_code` VALUES ('NH_001', '농협 0000-0000-000000');
INSERT INTO `bank_code` VALUES ('SH_001', '신한은행 2222-2222-222222');

-- ----------------------------
-- Table structure for bank_trnsf
-- ----------------------------
DROP TABLE IF EXISTS `bank_trnsf`;
CREATE TABLE `bank_trnsf`  (
  `DNTN_CODE` bigint(20) NOT NULL,
  `USER_NO` bigint(20) NOT NULL,
  `COM_BANK_CODE` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DNTN_CODE`, `USER_NO`) USING BTREE,
  INDEX `FK_BANK_CODE_TO_BANK_TRNSF`(`COM_BANK_CODE`) USING BTREE,
  CONSTRAINT `FK_BANK_CODE_TO_BANK_TRNSF` FOREIGN KEY (`COM_BANK_CODE`) REFERENCES `bank_code` (`COM_BANK_CODE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_DNTN_MSTR_TO_BANK_TRNSF` FOREIGN KEY (`DNTN_CODE`, `USER_NO`) REFERENCES `dntn_mstr` (`DNTN_CODE`, `USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bank_trnsf
-- ----------------------------
INSERT INTO `bank_trnsf` VALUES (1, 2, 'KB_001');
INSERT INTO `bank_trnsf` VALUES (4, 2, 'KB_001');
INSERT INTO `bank_trnsf` VALUES (5, 2, 'KB_001');
INSERT INTO `bank_trnsf` VALUES (8, 2, 'KB_001');
INSERT INTO `bank_trnsf` VALUES (3, 2, 'NH_001');
INSERT INTO `bank_trnsf` VALUES (6, 2, 'NH_001');

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat`  (
  `USER_NO` bigint(20) NOT NULL,
  `NICK_NAME` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `MESSAGE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CHAT_DATE` datetime NOT NULL,
  PRIMARY KEY (`USER_NO`) USING BTREE,
  CONSTRAINT `FK_USER_MSTR_TO_CHAT` FOREIGN KEY (`USER_NO`) REFERENCES `user_mstr` (`USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat
-- ----------------------------

-- ----------------------------
-- Table structure for cmnty_cls
-- ----------------------------
DROP TABLE IF EXISTS `cmnty_cls`;
CREATE TABLE `cmnty_cls`  (
  `CMNTY_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CMNTY_TYPE` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CMNTY_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cmnty_cls
-- ----------------------------
INSERT INTO `cmnty_cls` VALUES ('ADP_ACT', '분양하기');
INSERT INTO `cmnty_cls` VALUES ('ADP_REV', '분양후기');
INSERT INTO `cmnty_cls` VALUES ('CAT_STR', '캣스타그램');
INSERT INTO `cmnty_cls` VALUES ('DON_HST', '후원내역');
INSERT INTO `cmnty_cls` VALUES ('FRE_SEL', '무료나눔');
INSERT INTO `cmnty_cls` VALUES ('USD_TRN', '중고거래');

-- ----------------------------
-- Table structure for cmnty_img
-- ----------------------------
DROP TABLE IF EXISTS `cmnty_img`;
CREATE TABLE `cmnty_img`  (
  `IMG_NO` bigint(20) NOT NULL,
  `POST_NO` bigint(20) NULL DEFAULT NULL,
  `USER_NO` bigint(20) NULL DEFAULT NULL,
  `IMG_ADR` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IMG_NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `IMG_ORGNAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`IMG_NO`) USING BTREE,
  INDEX `FK_CMNTY_MSTR_TO_CMNTY_IMG`(`POST_NO`) USING BTREE,
  INDEX `FK_USER_MSTR_TO_CMNTY_IMG`(`USER_NO`) USING BTREE,
  CONSTRAINT `FK_CMNTY_MSTR_TO_CMNTY_IMG` FOREIGN KEY (`POST_NO`) REFERENCES `cmnty_mstr` (`POST_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_USER_MSTR_TO_CMNTY_IMG` FOREIGN KEY (`USER_NO`) REFERENCES `user_mstr` (`USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cmnty_img
-- ----------------------------
INSERT INTO `cmnty_img` VALUES (1, 1, 2, '/files/40355a2e-746a-4732-a726-3e84a427ed92_casey-lovegrove-PXDy-dw4zW0-unsplash.jpg', '40355a2e-746a-4732-a726-3e84a427ed92_casey-lovegrove-PXDy-dw4zW0-unsplash.jpg', 'casey-lovegrove-PXDy-dw4zW0-unsplash.jpg');
INSERT INTO `cmnty_img` VALUES (2, 2, 2, '/files/d25e0bd7-1fbd-4292-89ec-f30cd1b982ea_cedric-vt-IuJc2qh2TcA-unsplash.jpg', 'd25e0bd7-1fbd-4292-89ec-f30cd1b982ea_cedric-vt-IuJc2qh2TcA-unsplash.jpg', 'cedric-vt-IuJc2qh2TcA-unsplash.jpg');
INSERT INTO `cmnty_img` VALUES (3, 3, 2, '/files/892c1338-c844-429d-a22a-f254cdf3626a_edgar-u2xzSFc05i0-unsplash.jpg', '892c1338-c844-429d-a22a-f254cdf3626a_edgar-u2xzSFc05i0-unsplash.jpg', 'edgar-u2xzSFc05i0-unsplash.jpg');
INSERT INTO `cmnty_img` VALUES (4, 4, 2, '/files/e232bae1-e1c4-42d3-a806-e78acd708172_casey-lovegrove-PXDy-dw4zW0-unsplash.jpg', 'e232bae1-e1c4-42d3-a806-e78acd708172_casey-lovegrove-PXDy-dw4zW0-unsplash.jpg', 'casey-lovegrove-PXDy-dw4zW0-unsplash.jpg');
INSERT INTO `cmnty_img` VALUES (5, 4, 2, '/files/26c9f484-e0b3-4c4f-9dc9-347025232483_cedric-vt-IuJc2qh2TcA-unsplash.jpg', '26c9f484-e0b3-4c4f-9dc9-347025232483_cedric-vt-IuJc2qh2TcA-unsplash.jpg', 'cedric-vt-IuJc2qh2TcA-unsplash.jpg');
INSERT INTO `cmnty_img` VALUES (6, 4, 2, '/files/57e6ec31-da7f-4e33-a5a8-eccd161df898_daniel-harmatiy-ggN5C3ySZzc-unsplash.jpg', '57e6ec31-da7f-4e33-a5a8-eccd161df898_daniel-harmatiy-ggN5C3ySZzc-unsplash.jpg', 'daniel-harmatiy-ggN5C3ySZzc-unsplash.jpg');
INSERT INTO `cmnty_img` VALUES (7, 4, 2, '/files/b9e4b74c-e921-4b6a-9ff7-0850f37dede7_d-ng-ph-c-h-i-tri-u-oATDDQ7dW1E-unsplash.jpg', 'b9e4b74c-e921-4b6a-9ff7-0850f37dede7_d-ng-ph-c-h-i-tri-u-oATDDQ7dW1E-unsplash.jpg', 'd-ng-ph-c-h-i-tri-u-oATDDQ7dW1E-unsplash.jpg');
INSERT INTO `cmnty_img` VALUES (8, 4, 2, '/files/46723392-39b0-46b9-b595-eb280b1d56bd_edgar-u2xzSFc05i0-unsplash.jpg', '46723392-39b0-46b9-b595-eb280b1d56bd_edgar-u2xzSFc05i0-unsplash.jpg', 'edgar-u2xzSFc05i0-unsplash.jpg');

-- ----------------------------
-- Table structure for cmnty_like
-- ----------------------------
DROP TABLE IF EXISTS `cmnty_like`;
CREATE TABLE `cmnty_like`  (
  `POST_NO` bigint(20) NOT NULL,
  `USER_NO` bigint(20) NOT NULL,
  INDEX `FK_CMNTY_MSTR_TO_CMNTY_LIKE`(`POST_NO`) USING BTREE,
  INDEX `FK_USER_MSTR_TO_CMNTY_LIKE`(`USER_NO`) USING BTREE,
  CONSTRAINT `FK_CMNTY_MSTR_TO_CMNTY_LIKE` FOREIGN KEY (`POST_NO`) REFERENCES `cmnty_mstr` (`POST_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_USER_MSTR_TO_CMNTY_LIKE` FOREIGN KEY (`USER_NO`) REFERENCES `user_mstr` (`USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cmnty_like
-- ----------------------------
INSERT INTO `cmnty_like` VALUES (20998, 2);

-- ----------------------------
-- Table structure for cmnty_mstr
-- ----------------------------
DROP TABLE IF EXISTS `cmnty_mstr`;
CREATE TABLE `cmnty_mstr`  (
  `POST_NO` bigint(20) NOT NULL,
  `USER_NO` bigint(20) NULL DEFAULT NULL,
  `CMNTY_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `POST_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SUBJECT` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CONTENT` varchar(1500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `CRT_DATE` datetime NOT NULL,
  `VIEW_COUNT` int(11) NOT NULL,
  `SUM_IMG` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`POST_NO`) USING BTREE,
  INDEX `FK_CMNTY_CLS_TO_CMNTY_MSTR`(`CMNTY_ID`) USING BTREE,
  INDEX `FK_POST_CLS_TO_CMNTY_MSTR`(`POST_ID`) USING BTREE,
  INDEX `FK_USER_MSTR_TO_CMNTY_MSTR`(`USER_NO`) USING BTREE,
  CONSTRAINT `FK_CMNTY_CLS_TO_CMNTY_MSTR` FOREIGN KEY (`CMNTY_ID`) REFERENCES `cmnty_cls` (`CMNTY_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_POST_CLS_TO_CMNTY_MSTR` FOREIGN KEY (`POST_ID`) REFERENCES `post_cls` (`POST_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_USER_MSTR_TO_CMNTY_MSTR` FOREIGN KEY (`USER_NO`) REFERENCES `user_mstr` (`USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cmnty_mstr
-- ----------------------------
INSERT INTO `cmnty_mstr` VALUES (1, 2, 'ADP_ACT', 'ADT_ING', '안녕하세요!', '분양합니다!', '2023-02-15 06:13:12', 0, '/files/40355a2e-746a-4732-a726-3e84a427ed92_casey-lovegrove-PXDy-dw4zW0-unsplash.jpg');
INSERT INTO `cmnty_mstr` VALUES (2, 2, 'ADP_ACT', 'ADT_ING', 'ㅁㄴㅇ', 'ㅁㄴㅇ', '2023-02-15 06:14:04', 0, '/files/d25e0bd7-1fbd-4292-89ec-f30cd1b982ea_cedric-vt-IuJc2qh2TcA-unsplash.jpg');
INSERT INTO `cmnty_mstr` VALUES (3, 2, 'ADP_ACT', 'ADT_ING', '반가워요!', '안녕하세요!', '2023-02-15 06:15:18', 0, '/files/892c1338-c844-429d-a22a-f254cdf3626a_edgar-u2xzSFc05i0-unsplash.jpg');
INSERT INTO `cmnty_mstr` VALUES (4, 2, 'ADP_ACT', 'ADT_ING', '분양합니다!', '안녕하세요 고양이 분양 중입니다!!', '2023-02-15 06:19:06', 6, '/files/46723392-39b0-46b9-b595-eb280b1d56bd_edgar-u2xzSFc05i0-unsplash.jpg');
INSERT INTO `cmnty_mstr` VALUES (5, 2, 'CAT_STR', 'FOOD_FREE', 'ㅎㅇ', 'ㅎㅇ', '2023-02-23 16:45:33', 2, NULL);
INSERT INTO `cmnty_mstr` VALUES (20994, 2, 'ADP_ACT', 'ADT_ING', '제목995', '내용995', '2023-02-14 18:01:18', 995, NULL);
INSERT INTO `cmnty_mstr` VALUES (20995, 2, 'ADP_ACT', 'ADT_ING', '제목996', '내용996', '2023-02-14 18:01:18', 996, NULL);
INSERT INTO `cmnty_mstr` VALUES (20996, 2, 'ADP_ACT', 'ADT_ING', '제목997', '내용997', '2023-02-14 18:01:18', 997, NULL);
INSERT INTO `cmnty_mstr` VALUES (20997, 2, 'ADP_ACT', 'ADT_ING', '제목998', '내용998', '2023-02-14 18:01:18', 998, NULL);
INSERT INTO `cmnty_mstr` VALUES (20998, 2, 'ADP_ACT', 'ADT_ING', '제목999', '내용999', '2023-02-14 18:01:18', 1002, NULL);
INSERT INTO `cmnty_mstr` VALUES (21000, 2, 'ADP_ACT', 'ADT_ING', '제목1001', '내용1001', '2023-02-14 18:01:18', 1001, NULL);

-- ----------------------------
-- Table structure for crcrd_pymnt
-- ----------------------------
DROP TABLE IF EXISTS `crcrd_pymnt`;
CREATE TABLE `crcrd_pymnt`  (
  `DNTN_CODE` bigint(20) NOT NULL,
  `USER_NO` bigint(20) NOT NULL,
  `CARD_COM` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CARD_NUM` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CVC` int(11) NOT NULL,
  `VLDT_PRD` int(11) NOT NULL,
  `CRCRD_PASS` int(11) NOT NULL,
  PRIMARY KEY (`DNTN_CODE`, `USER_NO`) USING BTREE,
  CONSTRAINT `FK_DNTN_MSTR_TO_CRCRD_PYMNT` FOREIGN KEY (`DNTN_CODE`, `USER_NO`) REFERENCES `dntn_mstr` (`DNTN_CODE`, `USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of crcrd_pymnt
-- ----------------------------
INSERT INTO `crcrd_pymnt` VALUES (2, 2, '국민카드', '1111-1111-1111-1111', 111, 1111, 11);

-- ----------------------------
-- Table structure for dntn_bsns_mstr
-- ----------------------------
DROP TABLE IF EXISTS `dntn_bsns_mstr`;
CREATE TABLE `dntn_bsns_mstr`  (
  `DNTN_BSNS_CODE` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DNTN_BSNS` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DNTN_BSNS_CODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dntn_bsns_mstr
-- ----------------------------
INSERT INTO `dntn_bsns_mstr` VALUES ('CURE_001', '치료사업001');
INSERT INTO `dntn_bsns_mstr` VALUES ('PRTC_001', '보호사업001');
INSERT INTO `dntn_bsns_mstr` VALUES ('STRUC_001', '구조사업001');

-- ----------------------------
-- Table structure for dntn_code_no_seq
-- ----------------------------
DROP TABLE IF EXISTS `dntn_code_no_seq`;
CREATE TABLE `dntn_code_no_seq`  (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of dntn_code_no_seq
-- ----------------------------
INSERT INTO `dntn_code_no_seq` VALUES (1001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

-- ----------------------------
-- Table structure for dntn_mstr
-- ----------------------------
DROP TABLE IF EXISTS `dntn_mstr`;
CREATE TABLE `dntn_mstr`  (
  `DNTN_CODE` bigint(20) NOT NULL,
  `DNTN_BSNS_CODE` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `USER_NO` bigint(20) NOT NULL,
  `DNTN_NAME` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DNTN_AMNT` int(11) NOT NULL,
  `DNTN_TYPE` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PHONE_TYPE` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PHONE_NUM` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BIRTH_DATE` date NOT NULL,
  `GENDER` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DNTN_WAYCODE` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DNTN_STATECODE` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `DNTN_DATE` date NOT NULL,
  PRIMARY KEY (`DNTN_CODE`, `USER_NO`) USING BTREE,
  INDEX `FK_USER_MSTR_TO_DNTN_MSTR`(`USER_NO`) USING BTREE,
  INDEX `FK_DNTN_BSNS_MSTR_TO_DNTN_MSTR`(`DNTN_BSNS_CODE`) USING BTREE,
  INDEX `FK_DNTN_STATECLS_TO_DNTN_MSTR`(`DNTN_STATECODE`) USING BTREE,
  INDEX `FK_DNTN_WAYCLS_TO_DNTN_MSTR`(`DNTN_WAYCODE`) USING BTREE,
  CONSTRAINT `FK_DNTN_BSNS_MSTR_TO_DNTN_MSTR` FOREIGN KEY (`DNTN_BSNS_CODE`) REFERENCES `dntn_bsns_mstr` (`DNTN_BSNS_CODE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_DNTN_STATECLS_TO_DNTN_MSTR` FOREIGN KEY (`DNTN_STATECODE`) REFERENCES `dntn_statecls` (`DNTN_STATECODE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_DNTN_WAYCLS_TO_DNTN_MSTR` FOREIGN KEY (`DNTN_WAYCODE`) REFERENCES `dntn_waycls` (`DNTN_WAYCODE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_USER_MSTR_TO_DNTN_MSTR` FOREIGN KEY (`USER_NO`) REFERENCES `user_mstr` (`USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dntn_mstr
-- ----------------------------
INSERT INTO `dntn_mstr` VALUES (1, 'PRTC_001', 2, '안준희', 30000, '정기후원', 'KT', '010-0000-0000', '1993-09-09', '남자', 'BANK', 'DONATE_CNFRM', '2023-02-14');
INSERT INTO `dntn_mstr` VALUES (2, 'CURE_001', 2, '안준희', 3000000, '정기후원', 'KT', '010-0000-0000', '1933-02-11', '여자', 'CRCRD', 'DONATE_CNFRM', '2023-02-15');
INSERT INTO `dntn_mstr` VALUES (3, 'PRTC_001', 2, '안준희', 3000000, '정기후원', 'KT', '010-0000-0000', '1933-02-01', '남자', 'BANK', 'DONATE_CNFRM', '2023-02-15');
INSERT INTO `dntn_mstr` VALUES (4, 'PRTC_001', 2, '고민호', 30000, '정기후원', 'KT', '010-0000-0000', '1933-04-11', '남자', 'BANK', 'DONATE_CNFRM', '2023-02-15');
INSERT INTO `dntn_mstr` VALUES (5, 'PRTC_001', 2, '안준희', 90000, '정기후원', 'KT', '010-0000-0000', '1933-04-11', '남자', 'BANK', 'DONATE_CNFRM', '2023-02-15');
INSERT INTO `dntn_mstr` VALUES (6, 'PRTC_001', 2, '안준희', 3000000, '정기후원', 'KT', '010-0000-0000', '1933-04-01', '남자', 'BANK', 'DONATE_CNFRM', '2023-02-15');
INSERT INTO `dntn_mstr` VALUES (8, 'STRUC_001', 2, '고민호', 28000, '정기후원', 'KT', '010-0000-0000', '1900-05-11', '남자', 'BANK', 'DONATE_CNFRM', '2023-02-15');

-- ----------------------------
-- Table structure for dntn_statecls
-- ----------------------------
DROP TABLE IF EXISTS `dntn_statecls`;
CREATE TABLE `dntn_statecls`  (
  `DNTN_STATECODE` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DNTN_STATE` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DNTN_STATECODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dntn_statecls
-- ----------------------------
INSERT INTO `dntn_statecls` VALUES ('BANK_WAIT', '입금대기');
INSERT INTO `dntn_statecls` VALUES ('DONATE_CNCL', '후원취소');
INSERT INTO `dntn_statecls` VALUES ('DONATE_CNFRM', '후원확정');
INSERT INTO `dntn_statecls` VALUES ('DONATE_CPL', '후원완료');
INSERT INTO `dntn_statecls` VALUES ('LCK_BLC', '계좌잔액부족');
INSERT INTO `dntn_statecls` VALUES ('LIMIT_EXCDD', '한도초과');

-- ----------------------------
-- Table structure for dntn_waycls
-- ----------------------------
DROP TABLE IF EXISTS `dntn_waycls`;
CREATE TABLE `dntn_waycls`  (
  `DNTN_WAYCODE` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DNTN_WAY` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`DNTN_WAYCODE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dntn_waycls
-- ----------------------------
INSERT INTO `dntn_waycls` VALUES ('ACNT', '계좌이체');
INSERT INTO `dntn_waycls` VALUES ('BANK', '무통장입금');
INSERT INTO `dntn_waycls` VALUES ('CRCRD', '신용카드');

-- ----------------------------
-- Table structure for img_no_seq
-- ----------------------------
DROP TABLE IF EXISTS `img_no_seq`;
CREATE TABLE `img_no_seq`  (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of img_no_seq
-- ----------------------------
INSERT INTO `img_no_seq` VALUES (1001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

-- ----------------------------
-- Table structure for post_cls
-- ----------------------------
DROP TABLE IF EXISTS `post_cls`;
CREATE TABLE `post_cls`  (
  `POST_ID` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `POST_TYPE` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`POST_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post_cls
-- ----------------------------
INSERT INTO `post_cls` VALUES ('ADT_CMPL', '분양완료');
INSERT INTO `post_cls` VALUES ('ADT_ING', '분양중');
INSERT INTO `post_cls` VALUES ('CTWR_FREE', '캣타워무료나눔');
INSERT INTO `post_cls` VALUES ('CTWR_SELL', '캣타워판매글');
INSERT INTO `post_cls` VALUES ('FDST_FREE', '식사용품무료나눔');
INSERT INTO `post_cls` VALUES ('FDST_SELL', '식사용품판매글');
INSERT INTO `post_cls` VALUES ('FOOD_FREE', '소모품(식사류)무료나눔');
INSERT INTO `post_cls` VALUES ('FOOD_SELL', '소모품(식사류)판매글');
INSERT INTO `post_cls` VALUES ('FREE_CMPL', '무료나눔완료');
INSERT INTO `post_cls` VALUES ('GNR_POST', '일반글');
INSERT INTO `post_cls` VALUES ('HSW_FREE', '집사용품무료나눔');
INSERT INTO `post_cls` VALUES ('HSW_SELL', '집사용품판매글');
INSERT INTO `post_cls` VALUES ('HYG_FREE', '위생용품무료나눔');
INSERT INTO `post_cls` VALUES ('HYG_SELL', '위생용품판매글');
INSERT INTO `post_cls` VALUES ('NTC_POST', '공지글');
INSERT INTO `post_cls` VALUES ('SELL_CMPL', '판매완료');
INSERT INTO `post_cls` VALUES ('WSH_SELL', '목욕용품판매글');

-- ----------------------------
-- Table structure for post_no_seq
-- ----------------------------
DROP TABLE IF EXISTS `post_no_seq`;
CREATE TABLE `post_no_seq`  (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of post_no_seq
-- ----------------------------
INSERT INTO `post_no_seq` VALUES (2001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `REPLY_NO` bigint(20) NOT NULL,
  `POST_NO` bigint(20) NULL DEFAULT NULL,
  `USER_NO` bigint(20) NULL DEFAULT NULL,
  `REPLY_CONTENT` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`REPLY_NO`) USING BTREE,
  INDEX `FK_CMNTY_MSTR_TO_REPLY`(`POST_NO`) USING BTREE,
  INDEX `FK_USER_MSTR_TO_REPLY`(`USER_NO`) USING BTREE,
  CONSTRAINT `FK_CMNTY_MSTR_TO_REPLY` FOREIGN KEY (`POST_NO`) REFERENCES `cmnty_mstr` (`POST_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_USER_MSTR_TO_REPLY` FOREIGN KEY (`USER_NO`) REFERENCES `user_mstr` (`USER_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES (2, 20998, 2, '안녕!');

-- ----------------------------
-- Table structure for reply_no_seq
-- ----------------------------
DROP TABLE IF EXISTS `reply_no_seq`;
CREATE TABLE `reply_no_seq`  (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of reply_no_seq
-- ----------------------------
INSERT INTO `reply_no_seq` VALUES (1001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

-- ----------------------------
-- Table structure for scnd_hndtr
-- ----------------------------
DROP TABLE IF EXISTS `scnd_hndtr`;
CREATE TABLE `scnd_hndtr`  (
  `POST_NO` bigint(20) NOT NULL,
  `PRICE` int(11) NOT NULL,
  PRIMARY KEY (`POST_NO`) USING BTREE,
  CONSTRAINT `FK_CMNTY_MSTR_TO_SCND_HNDTR` FOREIGN KEY (`POST_NO`) REFERENCES `cmnty_mstr` (`POST_NO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of scnd_hndtr
-- ----------------------------

-- ----------------------------
-- Table structure for user_cls
-- ----------------------------
DROP TABLE IF EXISTS `user_cls`;
CREATE TABLE `user_cls`  (
  `USER_TYPE` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `USER_DESC` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`USER_TYPE`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_cls
-- ----------------------------
INSERT INTO `user_cls` VALUES ('ADMIN', '관리자');
INSERT INTO `user_cls` VALUES ('MEMBER', '일반회원');

-- ----------------------------
-- Table structure for user_mstr
-- ----------------------------
DROP TABLE IF EXISTS `user_mstr`;
CREATE TABLE `user_mstr`  (
  `USER_NO` bigint(20) NOT NULL,
  `USER_TYPE` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `USER_ID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `USER_PW` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `USER_NAME` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NICK_NAME` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ADDR` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PHONE_TYPE` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PHONE_NUM` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `INTRODUCE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PRF_IMG_NAME` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `PRF_IMG_PATH` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `USER_JOIN_DATE` datetime NOT NULL,
  PRIMARY KEY (`USER_NO`) USING BTREE,
  INDEX `FK_USER_CLS_TO_USER_MSTR`(`USER_TYPE`) USING BTREE,
  CONSTRAINT `FK_USER_CLS_TO_USER_MSTR` FOREIGN KEY (`USER_TYPE`) REFERENCES `user_cls` (`USER_TYPE`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_mstr
-- ----------------------------
INSERT INTO `user_mstr` VALUES (1, 'ADMIN', 'meow@gmail.com', '1', '안준희', '미유미유', '서울', 'SKT', '010-1111-1111', '안녕하세요', '5318f917-6daa-4b69-8c73-7a53612f6d64_gantt chart.png', '/files/5318f917-6daa-4b69-8c73-7a53612f6d64_gantt chart.png', '2023-01-29 01:15:38');
INSERT INTO `user_mstr` VALUES (2, 'MEMBER', 'aaa@gmail.com', '1', '안주희', '리코더', '강동', 'KT', '010-2222-2222', '안녕못해요', '0cc2aebd-e0b0-4da3-ad4d-625387422e98_gantt chart.png', '/files/0cc2aebd-e0b0-4da3-ad4d-625387422e98_gantt chart.png', '2022-12-29 01:16:27');
INSERT INTO `user_mstr` VALUES (3, 'MEMBER', 'meow333@gmail.com', '33333', '고민호', '제주도폭격기', '제주', 'LG', '010-3333-3333', '혼저옵서예', NULL, NULL, '2022-11-01 01:17:31');
INSERT INTO `user_mstr` VALUES (4, 'ADMIN', 'meow444@gmail.com', '44444', '홍민우', '이클립스주주', '안양', 'SKT', '010-4444-4444', '채팅구현중', NULL, NULL, '2023-01-10 01:18:48');
INSERT INTO `user_mstr` VALUES (5, 'ADMIN', 'meow555@gmail.com', '55555', '박준성', '춤추는종이인형', '사당', 'KT', '010-5555-5555', '', NULL, NULL, '2023-05-05 05:05:05');
INSERT INTO `user_mstr` VALUES (6, 'MEMBER', 'monmon93@naver.com', 'Password1!', '안준희', '리코더2', '서울', 'SKT', '010-1111-1111', '', 'e9ae1001-03d0-4690-94e2-939cf661b5e7_', '/files/e9ae1001-03d0-4690-94e2-939cf661b5e7_', '2023-02-15 10:45:19');

-- ----------------------------
-- Table structure for user_no_seq
-- ----------------------------
DROP TABLE IF EXISTS `user_no_seq`;
CREATE TABLE `user_no_seq`  (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) UNSIGNED NOT NULL,
  `cycle_option` tinyint(1) UNSIGNED NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of user_no_seq
-- ----------------------------
INSERT INTO `user_no_seq` VALUES (1001, 1, 9223372036854775806, 1, 1, 1000, 0, 0);

SET FOREIGN_KEY_CHECKS = 1;
