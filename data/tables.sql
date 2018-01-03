-- Semantic Scuttle - Tables creation SQL script
-- ! Dont forget to change table names according to $tableprefix defined in config.php !

-- 
-- Table structure for table `sc_bookmarks`
-- 

CREATE TABLE `sc_bookmarks` (
  `bId`          INT(11)       NOT NULL AUTO_INCREMENT,
  `uId`          INT(11)       NOT NULL DEFAULT '0',
  `bIp`          VARCHAR(40)            DEFAULT NULL,
  `bStatus`      TINYINT(1)    NOT NULL DEFAULT '0',
  `bDatetime`    DATETIME      NOT NULL,
  `bModified`    DATETIME      NOT NULL,
  `bTitle`       VARCHAR(255)  NOT NULL DEFAULT '',
  `bAddress`     VARCHAR(1500) NOT NULL,
  `bDescription` TEXT                   DEFAULT NULL,
  `bPrivateNote` TEXT                   DEFAULT NULL,
  `bHash`        VARCHAR(32)   NOT NULL DEFAULT '',
  `bVotes`       INT(11)       NOT NULL,
  `bVoting`      INT(11)       NOT NULL,
  `bShort`       VARCHAR(16)            DEFAULT NULL,
  PRIMARY KEY (`bId`),
  KEY `sc_bookmarks_usd` (`uId`, `bStatus`, `bDatetime`),
  KEY `sc_bookmarks_hui` (`bHash`, `uId`, `bId`),
  KEY `sc_bookmarks_du` (`bDatetime`, `uId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `sc_tags`
-- 

CREATE TABLE `sc_tags` (
  `tId`          INT(11)      NOT NULL AUTO_INCREMENT,
  `tag`          VARCHAR(100) NOT NULL DEFAULT '',
  `uId`          INT(11)      NOT NULL DEFAULT '0',
  `tDescription` TEXT                  DEFAULT NULL,
  PRIMARY KEY (`tId`),
  UNIQUE KEY `sc_tags_tag_uId` (`tag`, `uId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `sc_bookmarks2tags`
-- 

CREATE TABLE `sc_bookmarks2tags` (
  `id`  INT(11)      NOT NULL AUTO_INCREMENT,
  `bId` INT(11)      NOT NULL DEFAULT '0',
  `tag` VARCHAR(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sc_bookmarks2tags_tag_bId` (`tag`, `bId`),
  KEY `sc_bookmarks2tags_bId` (`bId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `sc_users`
-- 

CREATE TABLE `sc_users` (
  `uId`        INT(11)     NOT NULL AUTO_INCREMENT,
  `username`   VARCHAR(25) NOT NULL DEFAULT '',
  `password`   VARCHAR(40) NOT NULL DEFAULT '',
  `uDatetime`  DATETIME    NOT NULL,
  `uModified`  DATETIME    NOT NULL,
  `name`       VARCHAR(50)          DEFAULT NULL,
  `email`      VARCHAR(50) NOT NULL DEFAULT '',
  `homepage`   VARCHAR(255)         DEFAULT NULL,
  `uContent`   TEXT,
  `privateKey` VARCHAR(33)          DEFAULT NULL,
  PRIMARY KEY (`uId`),
  UNIQUE KEY `privateKey` (`privateKey`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

CREATE TABLE `sc_users_sslclientcerts` (
  `id`                INT           NOT NULL AUTO_INCREMENT,
  `uId`               INT           NOT NULL,
  `sslSerial`         VARCHAR(32)   NOT NULL,
  `sslClientIssuerDn` VARCHAR(1024) NOT NULL,
  `sslName`           VARCHAR(64)   NOT NULL,
  `sslEmail`          VARCHAR(64)   NOT NULL,
  PRIMARY KEY (`id`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- 
-- Table structure for table `sc_watched`
-- 

CREATE TABLE `sc_watched` (
  `wId`     INT(11) NOT NULL AUTO_INCREMENT,
  `uId`     INT(11) NOT NULL DEFAULT '0',
  `watched` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`wId`),
  KEY `sc_watched_uId` (`uId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `sc_tags2tags`
-- 

CREATE TABLE `sc_tags2tags` (
  `ttId`         INT(11)      NOT NULL AUTO_INCREMENT,
  `tag1`         VARCHAR(100) NOT NULL DEFAULT '',
  `tag2`         VARCHAR(100) NOT NULL DEFAULT '',
  `relationType` VARCHAR(32)  NOT NULL DEFAULT '',
  `uId`          INT(11)      NOT NULL DEFAULT '0',
  PRIMARY KEY (`ttId`),
  UNIQUE KEY `sc_tags2tags_tag1_tag2_uId` (`tag1`, `tag2`, `relationType`, `uId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `sc_tagsstats`
-- 

CREATE TABLE `sc_tagsstats` (
  `tstId`        INT(11)      NOT NULL AUTO_INCREMENT,
  `tag1`         VARCHAR(100) NOT NULL DEFAULT '',
  `relationType` VARCHAR(32)  NOT NULL DEFAULT '',
  `uId`          INT(11)      NOT NULL DEFAULT '0',
  `nb`           INT(11)      NOT NULL DEFAULT '0',
  `depth`        INT(11)      NOT NULL DEFAULT '0',
  `nbupdate`     INT(11)      NOT NULL DEFAULT '0',
  PRIMARY KEY (`tstId`),
  UNIQUE KEY `sc_tagsstats_tag1_type_uId` (`tag1`, `relationType`, `uId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `sc_tagscache`
-- 

CREATE TABLE `sc_tagscache` (
  `tcId`         INT(11)      NOT NULL AUTO_INCREMENT,
  `tag1`         VARCHAR(100) NOT NULL DEFAULT '',
  `tag2`         VARCHAR(100) NOT NULL DEFAULT '',
  `relationType` VARCHAR(32)  NOT NULL DEFAULT '',
  `uId`          INT(11)      NOT NULL DEFAULT '0',
  PRIMARY KEY (`tcId`),
  UNIQUE KEY `sc_tagscache_tag1_tag2_type_uId` (`tag1`, `tag2`, `relationType`, `uId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `sc_commondescription`
-- 

CREATE TABLE `sc_commondescription` (
  `cdId`          INT(11)      NOT NULL AUTO_INCREMENT,
  `uId`           INT(11)      NOT NULL DEFAULT '0',
  `tag`           VARCHAR(100) NOT NULL DEFAULT '',
  `bHash`         VARCHAR(32)  NOT NULL DEFAULT '',
  `cdTitle`       VARCHAR(255) NOT NULL DEFAULT '',
  `cdDescription` TEXT                  DEFAULT NULL,
  `cdDatetime`    DATETIME     NOT NULL,
  PRIMARY KEY (`cdId`),
  UNIQUE KEY `sc_commondescription_tag_datetime` (`tag`, `cdDatetime`),
  UNIQUE KEY `sc_commondescription_bookmark_datetime` (`bHash`, `cdDatetime`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

-- --------------------------------------------------------

-- 
-- Table structure for table `sc_searchhistory`
-- 

CREATE TABLE `sc_searchhistory` (
  `shId`        INT(11)      NOT NULL AUTO_INCREMENT,
  `shTerms`     VARCHAR(255) NOT NULL DEFAULT '',
  `shRange`     VARCHAR(32)  NOT NULL DEFAULT '',
  `shDatetime`  DATETIME     NOT NULL,
  `shNbResults` INT(6)       NOT NULL DEFAULT '0',
  `uId`         INT(11)      NOT NULL DEFAULT '0',
  PRIMARY KEY (`shId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;


CREATE TABLE `sc_votes` (
  `bId`  INT    NOT NULL,
  `uId`  INT    NOT NULL,
  `vote` INT(2) NOT NULL,
  UNIQUE KEY `bid_2` (`bId`, `uId`),
  KEY `bid` (`bId`),
  KEY `uid` (`uId`)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;


CREATE TABLE `sc_version` (
  `schema_version` INT(11) NOT NULL
)
  DEFAULT CHARSET = utf8;
INSERT INTO `sc_version` (`schema_version`) VALUES ('6');
