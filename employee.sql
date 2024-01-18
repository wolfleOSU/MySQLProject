-- MySQL dump 10.16 Distrib 10.1.35-MariaDB, for Linux (x86_64)
--
-- Host: localhost Database: company_db
-- ------------------------------------------------------
-- Server version 10.1.35-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure and data for table `DEPARTMENT`
--

DROP TABLE IF EXISTS `DEPARTMENT`;
CREATE TABLE `DEPARTMENT` (
  `Dname` varchar(20) NOT NULL,
  `Dnumber` int(2) NOT NULL CHECK (Dnumber > 0 AND Dnumber < 21),  
  `Mgr_ssn` char(9) NOT NULL,   
  `Mgr_start_date` date NOT NULL, 
  PRIMARY KEY (`Dnumber`), 
  UNIQUE (`Dname`)
) ENGINE=INNODB;

--
-- Table structure and data for table `EMPLOYEE`
--

DROP TABLE IF EXISTS `EMPLOYEE`;
CREATE TABLE `EMPLOYEE` (
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `Ssn` char(9) NOT NULL,  
  `Bdate` date NOT NULL,
  `Address` varchar(30) NOT NULL,
  `Sex` char(1) NOT NULL,
  `Salary` decimal(10,2) NOT NULL,
  `Super_ssn` char(9),
  `Dno` int(2) NOT NULL,
  CONSTRAINT `Fullname` UNIQUE(`Fname`, `Lname`),  
  PRIMARY KEY (`Ssn`), 
  FOREIGN KEY (`Dno`) REFERENCES `DEPARTMENT`(`Dnumber`)
) ENGINE=INNODB;

--
-- Table structure and data for table `PROJECT`
--

DROP TABLE IF EXISTS `PROJECT`;
CREATE TABLE `PROJECT` (
  `Pname` varchar(20) NOT NULL,
  `Pnumber` int(4) NOT NULL,  
  `Plocation` varchar(20) NOT NULL,
  `Dnum` int(2) NOT NULL, 
  PRIMARY KEY (`Pnumber`), 
  UNIQUE (`Pname`), 
  FOREIGN KEY (`Dnum`) REFERENCES `DEPARTMENT`(`Dnumber`)
) ENGINE=INNODB;

--
-- Table structure and data for table `WORKS_ON`
--

DROP TABLE IF EXISTS `WORKS_ON`;
CREATE TABLE `WORKS_ON` (
  `Essn` char(9) NOT NULL,  
  `Pno` int(2) NOT NULL, 
  `Hours` decimal(3,1),  
  PRIMARY KEY (`Essn`, `Pno`), 
  FOREIGN KEY (`Essn`) REFERENCES `EMPLOYEE`(`Ssn`),
  FOREIGN KEY (`Pno`) REFERENCES `PROJECT`(`Pnumber`)
) ENGINE=INNODB;

--
-- Table structure and data for table `DEPENDENT`
--

DROP TABLE IF EXISTS `DEPENDENT`;
CREATE TABLE `DEPENDENT` (
  `Essn` char(9) NOT NULL,  
  `Dependent_name` varchar(15) NOT NULL,
  `Sex` char(1) NOT NULL,
  `Bdate` date NOT NULL,
  `Relationship` varchar(8) NOT NULL,
  PRIMARY KEY (`Essn`, `Dependent_name`),
  FOREIGN KEY (`Essn`) REFERENCES `EMPLOYEE`(`Ssn`)
) ENGINE=INNODB;

--
-- Table structure and data for table `DEPT_LOCATIONS`
--

DROP TABLE IF EXISTS `DEPT_LOCATIONS`;
CREATE TABLE DEPT_LOCATIONS (
  Dnumber int(2) not null,
  Dlocation varchar(15) not null,
  primary key (Dnumber, Dlocation), 
  foreign key (Dnumber) references DEPARTMENT(Dnumber)
)ENGINE = INNODB;


-- Inserting data into DEPARTMENT
LOCK TABLES `DEPARTMENT` WRITE;
INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES 
 ('Research', 5, '333445555', '2020-05-22'),
 ('Administration', 4, '987654321', '2012-01-01'),
 ('Headquarters', 1, '888665555', '2018-06-19');
UNLOCK TABLES;


LOCK TABLES `EMPLOYEE` WRITE;
-- Inserting data into EMPLOYEE
INSERT INTO EMPLOYEE (Fname, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno) VALUES 
 ('John', 'Smith', '123456789', '1975-01-09', '731 Fondren, Houston TX', 'M', 80000, '333445555', 5),
 ('Franklin', 'Wong', '333445555', '1985-12-08', '638 Voss, Houston TX', 'M', 90000, '888665555', 5),
 ('Alicia', 'Zelaya', '999887777', '2000-01-19', '3321 Castle, Spring TX', 'F', 95000, '987654321', 4),
 ('Jennifer', 'Wallace', '987654321', '1990-06-20', '291 Berry, Bellaire TX', 'F', 83000, '888665555', 4),
 ('Ramesh', 'Narayan', '666884444', '1982-09-15', '975 Fire Oak, Humble TX', 'M', 78000, '333445555', 5),
 ('Joyce', 'English', '453453453', '1992-07-31', '5631 Rice, Houston TX', 'F', 75000, '333445555', 5),
 ('Ahmad', 'Jabbar', '987987987', '1989-03-29', '980 Dallas, Houston TX', 'M', 85000, '987654321', 4),
 ('James', 'Borg', '888665555', '1967-11-10', '450 Stone, Houston TX', 'M', 105000, NULL, 1);
UNLOCK TABLES;


LOCK TABLES `PROJECT` WRITE;
-- Inserting data into PROJECT
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum) VALUES 
 ('ProductX', 1, 'Bellaire', 5),
 ('ProductY', 2, 'Sugarland', 5),
 ('ProductZ', 3, 'Houston', 5),
 ('Computerization', 10, 'Stafford', 4),
 ('Reorganization', 20, 'Houston', 1),
 ('Newbenefits', 30, 'Stafford', 4);
UNLOCK TABLES;


LOCK TABLES `WORKS_ON` WRITE;
-- Inserting data into WORKS_ON
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES 
 ('123456789', 1, 32.5),
 ('123456789', 2, 7.5),
 ('666884444', 3, 40.0),
 ('453453453', 1, 20.0),
 ('453453453', 2, 20.0),
 ('333445555', 2, 10.0),
 ('333445555', 3, 10.0),
 ('333445555', 10, 10.0),
 ('333445555', 20, 10.0),
 ('999887777', 30, 30.0),
 ('999887777', 10, 10.0),
 ('987987987', 10, 35.0),
 ('987987987', 30, 5.0),
 ('987654321', 30, 20.0),
 ('987654321', 20, 15.0),
 ('888665555', 20, NULL);
UNLOCK TABLES;


LOCK TABLES `DEPENDENT` WRITE;
-- Inserting data into DEPENDENT
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES 
 ('333445555', 'Alice', 'F', '2013-04-04', 'Daughter'),
 ('333445555', 'Theodore', 'M', '2010-10-25', 'Son'),
 ('333445555', 'Joy', 'F', '1982-05-03', 'Spouse'),
 ('987654321', 'Abner', 'M', '1989-02-28', 'Spouse'),
 ('123456789', 'Michael', 'M', '2001-01-04', 'Son'),
 ('123456789', 'Alice', 'F', '2005-12-30', 'Daughter'),
 ('123456789', 'Elizabeth', 'F', '1978-05-05', 'Spouse');
UNLOCK TABLES;


LOCK TABLES `DEPT_LOCATIONS` WRITE;
-- Inserting data into DEPT_LOCATIONS
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES 
 (1, 'Houston'),
 (4, 'Stafford'),
 (5, 'Bellaire'),
 (5, 'Sugarland'),
 (5, 'Houston');
UNLOCK TABLES;


-- Add any ALTER TABLE statements for foreign keys if not already included
ALTER TABLE DEPARTMENT ADD CONSTRAINT depemp FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);
ALTER TABLE EMPLOYEE ADD CONSTRAINT empemp FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);
