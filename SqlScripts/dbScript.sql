create database preceptorMatching;
use preceptorMatching; 
CREATE TABLE `studentDetails`(
  `studentId` VARCHAR(10) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `contactNumber` varchar(20) NULL,
  `verified` int NOT NULL constraint ch_verified check (`verified` in (0, 1)) DEFAULT 0,
  `active` int NOT NULL constraint ch_active check (`active` in (0, 1)) DEFAULT 0,
  `createdAt` timestamp  DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`studentId`)	
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE TABLE student_seq
(
  `studentId` INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE preceptor_seq
(
  `studentId` INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE `studentDetails`(
  `studentId` VARCHAR(10) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `contactNumber` varchar(20) NULL,
  `verified` int NOT NULL constraint ch_verified_student check (`verified` in (0, 1)) DEFAULT 0,
  `active` int NOT NULL constraint ch_active_student check (`active` in (0, 1)) DEFAULT 0,
  `createdAt` timestamp  DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`studentId`)	
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `preceptorDetails`(
  `preceptorId` VARCHAR(10) NOT NULL DEFAULT '0',
  `email` varchar(50) NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `contactNumber` varchar(20) NULL,
  `rotationCode` varchar(20) NOT NULL,
  `verified` int NOT NULL constraint ch_verified_preceptor check (`verified` in (0, 1)) DEFAULT 0,
  `active` int NOT NULL constraint ch_active_preceptor check (`active` in (0, 1)) DEFAULT 0,
  `total_seats` int(11) NOT NULL ,
  `price` decimal(6, 2) NOT NULL,
  `occupiedSeats` int(11) NOT NULL,
  `availableUntil` timestamp NOT NULL,
  `createdAt` timestamp  DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`preceptorId`),
  UNIQUE(`rotationCode`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DELIMITER $$
CREATE TRIGGER tg_table1_insert
BEFORE INSERT ON studentDetails
FOR EACH ROW
BEGIN
  INSERT INTO `student_seq` VALUES (NULL);
  SET NEW.studentId = CONCAT('stu', LPAD(LAST_INSERT_ID(), 6, '0'));
END$$;
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tg_table2_insert
BEFORE INSERT ON preceptorDetails
FOR EACH ROW
BEGIN
  INSERT INTO `preceptor_seq` VALUES (NULL);
  SET NEW.preceptorId = CONCAT('precep', LPAD(LAST_INSERT_ID(), 6, '0'));
END$$;
DELIMITER ;

CREATE TABLE `bookingDetails`(
  `bookingId` int(11) NOT NULL AUTO_INCREMENT,
  `studentId` varchar(20) NOT NULL,
  `preceptorId` VARCHAR(20) NOT NULL,
  `rotationCode` varchar(20) NOT NULL,
  `bookingStatus` ENUM ('completed','inProgress') NOT NULL,
  `paymentMethod` varchar(20) NOT NULL,
  `total_hrs` int(11) NOT NULL ,
  `startDate` timestamp NOT NULL,
  `endDate` timestamp NOT NULL,
  `dueDate` timestamp NOT NULL,
  `createdAt` timestamp  DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bookingId`),
  UNIQUE(`rotationCode`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `rating` (
	`id` varchar(20) NOT NULL,
	`rating` decimal(2,1) 
	CONSTRAINT chk_rating CHECK (`rating` >= 0 AND `rating` <= 5),
	PRIMARY KEY(`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


CREATE TABLE `enquiry` (
	`email` varchar(20) NOT NULL,
	`contactNumber` varchar(20) NOT NULL ,
	`query` TEXT NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;





