-- ============================================================
-- InstantRide_Setup.sql
-- Initial database setup for the InstantRide activities
-- MySQL 8.x
--
-- This file creates the ORIGINAL InstantRide database used before
-- Activity Set 1. The activity tables MAINTENANCE_TYPES,
-- MAINTENANCES, and ACTIVE_DRIVERS are intentionally NOT created
-- here because students create them in the activities.
-- ============================================================

DROP DATABASE IF EXISTS InstantRide;
CREATE DATABASE InstantRide;
USE InstantRide;

-- ============================================================
-- Table: CARS
-- ============================================================
CREATE TABLE CARS (
    CAR_ID CHAR(5) NOT NULL,
    CAR_PLATE VARCHAR(10) NOT NULL,
    CAR_MODEL VARCHAR(20) NOT NULL,
    CAR_YEAR YEAR NOT NULL,
    PRIMARY KEY (CAR_ID)
);

INSERT INTO CARS
    (CAR_ID, CAR_PLATE, CAR_MODEL, CAR_YEAR)
VALUES
    ('1001', 'BB-542-AB', 'TOYOTA PRIUS', 2021),
    ('1002', 'BB-883-EE', 'TESLA MODEL 3', 2022),
    ('1003', 'BB-451-ZN', 'TOYOTA AURIS', 2022),
    ('1004', 'BB-189-MM', 'MERCEDES E200', 2022);

-- ============================================================
-- Table: DRIVERS
-- ============================================================
CREATE TABLE DRIVERS (
    DRIVER_ID CHAR(5) NOT NULL,
    DRIVER_FIRST_NAME VARCHAR(20) NOT NULL,
    DRIVER_LAST_NAME VARCHAR(20) NOT NULL,
    DRIVER_DRIVING_LICENSE_ID VARCHAR(10) NOT NULL,
    DRIVER_START_DATE DATE NOT NULL,
    DRIVER_DRIVING_LICENSE_CHECKED TINYINT(1) NOT NULL,
    DRIVER_RATING DECIMAL(2,1) NOT NULL,
    PRIMARY KEY (DRIVER_ID)
);

INSERT INTO DRIVERS
    (DRIVER_ID,
     DRIVER_FIRST_NAME,
     DRIVER_LAST_NAME,
     DRIVER_DRIVING_LICENSE_ID,
     DRIVER_START_DATE,
     DRIVER_DRIVING_LICENSE_CHECKED,
     DRIVER_RATING)
VALUES
    ('2001', 'Willie',  'Butler', '1874501', '2022-09-12', 1, 4.4),
    ('2002', 'Justin',  'Howard', '1953853', '2022-09-09', 1, 4.8),
    ('2003', 'Anthony', 'Walker', '1735487', '2022-09-15', 1, 3.5),
    ('2004', 'Ece',     'Yilmaz', '1734747', '2022-08-15', 1, 0.0);

-- ============================================================
-- Table: USERS
-- ============================================================
CREATE TABLE USERS (
    USER_ID CHAR(5) NOT NULL,
    USER_FIRST_NAME VARCHAR(20) NOT NULL,
    USER_LAST_NAME VARCHAR(20) NOT NULL,
    USER_EMAIL VARCHAR(100) NOT NULL,
    PRIMARY KEY (USER_ID)
);

INSERT INTO USERS
    (USER_ID, USER_FIRST_NAME, USER_LAST_NAME, USER_EMAIL)
VALUES
    ('3001', 'Jack',   'Hill',    'j.hill@xmail.com'),
    ('3002', 'Ryan',   'Collins', 'r.collins@xmail.com'),
    ('3003', 'Nursin', 'Yilmaz',  'n.atak@gmail.com'),
    ('3004', 'Sarah',  'Price',   's.price@xmail.com'),
    ('3005', 'Bobby',  'Griffin', 'b.griffin@xmail.com'),
    ('3006', 'Randy',  'Clark',   'r.clark@xmail.com'),
    ('3007', 'Jose',   'Thomas',  'j.thomas@xmail.com'),
    ('3008', 'Nursin', 'Yilmaz',  'n.yilmaz@xmail.com');

-- ============================================================
-- Table: TRAVELS
-- ============================================================
CREATE TABLE TRAVELS (
    TRAVEL_ID CHAR(10) NOT NULL,
    TRAVEL_START_TIME DATETIME NOT NULL,
    TRAVEL_END_TIME DATETIME NOT NULL,
    TRAVEL_START_LOCATION CHAR(30) NOT NULL,
    TRAVEL_END_LOCATION CHAR(30) NOT NULL,
    TRAVEL_PRICE DECIMAL(5,2) NOT NULL,
    DRIVER_ID CHAR(5) NOT NULL,
    CAR_ID CHAR(5) NOT NULL,
    USER_ID CHAR(5) NOT NULL,
    TRAVEL_DISCOUNT DECIMAL(3,2) DEFAULT NULL,
    PRIMARY KEY (TRAVEL_ID)
);

INSERT INTO TRAVELS
    (TRAVEL_ID,
     TRAVEL_START_TIME,
     TRAVEL_END_TIME,
     TRAVEL_START_LOCATION,
     TRAVEL_END_LOCATION,
     TRAVEL_PRICE,
     DRIVER_ID,
     CAR_ID,
     USER_ID,
     TRAVEL_DISCOUNT)
VALUES
    ('5001', '2022-10-01 04:04:55', '2022-10-01 04:14:19',
     '9614 York Road', '84 Church Lane', 15.44, '2001', '1003', '3005', NULL),

    ('5002', '2022-10-01 05:57:33', '2022-10-01 06:12:33',
     '47 Church Street', '68 High Street', 20.56, '2001', '1003', '3006', NULL),

    ('5003', '2022-10-01 13:35:20', '2022-10-01 13:45:10',
     '2 Windsor Road', '95 West Street', 12.32, '2002', '1001', '3002', NULL),

    ('5004', '2022-10-02 08:44:48', '2022-10-02 09:15:28',
     '9060 Mill Lane', '27 Main Road', 30.49, '2003', '1002', '3001', 0.13),

    ('5005', '2022-10-02 16:38:54', '2022-10-02 16:48:10',
     '2 Queensway', '24 Mill Lane', 11.15, '2001', '1003', '3007', NULL),

    ('5006', '2022-10-03 19:12:14', '2022-10-03 19:23:45',
     '50 Main Road', '93 Broadway', 14.61, '2003', '1002', '3007', 0.10),

    ('5007', '2022-10-03 16:06:36', '2022-10-03 16:08:56',
     '39 Park Road', '91 West Street', 4.41, '2002', '1004', '3003', 0.14),

    ('5008', '2022-10-03 17:17:12', '2022-10-03 17:37:42',
     '37 The Drive', '17 Stanley Road', 25.12, '2001', '1003', '3001', 0.25),

    ('5009', '2022-10-03 21:16:48', '2022-10-03 21:26:18',
     '77 Mill Road', '724 Springfield Road', 13.55, '2001', '1003', '3005', NULL),

    ('5010', '2022-10-03 23:21:40', '2022-10-03 23:39:10',
     '16 Church Road', '30 North Road', 25.62, '2003', '1002', '3003', 0.20);

-- ============================================================
-- Verification
-- ============================================================
SHOW TABLES;

SELECT 'CARS' AS TABLE_NAME, COUNT(*) AS ROW_COUNT FROM CARS
UNION ALL
SELECT 'DRIVERS', COUNT(*) FROM DRIVERS
UNION ALL
SELECT 'USERS', COUNT(*) FROM USERS
UNION ALL
SELECT 'TRAVELS', COUNT(*) FROM TRAVELS;
