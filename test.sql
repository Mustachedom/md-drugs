
CREATE TABLE IF NOT EXISTS `deliveriesdealer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(50) NOT NULL,
  `itemdata` varchar(50) NOT NULL,
  `timestart` varchar(50) NOT NULL,
  `timestop` varchar(50) DEFAULT NULL,
  `maxtime` varchar(50) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE IF NOT EXISTS `drugrep` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(50) DEFAULT NULL,
  `drugrep` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
