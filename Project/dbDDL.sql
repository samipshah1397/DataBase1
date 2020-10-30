DROP DATABASE IF EXISTS AIRWAYS;
CREATE DATABASE IF NOT EXISTS AIRWAYS;

DROP TABLE IF EXISTS AIRWAYS.PASSENGER;
CREATE TABLE AIRWAYS.PASSENGER
(SSN bigint(10) NOT NULL,Name varchar(255) NOT NULL,ADDRESS varchar(255) NOT NULL,EMAILID varchar(255) NOT NULL,PHONENUMBER bigint(10) NOT NULL, PRIMARY KEY(SSN));

DROP TABLE IF EXISTS AIRWAYS.TICKET;
CREATE TABLE AIRWAYS.TICKET
(TICKETID bigint(7) NOT NULL,SEATNUMBER bigint(3) NOT NULL,SSN bigint(10) NOT NULL,FLIGHTNUMBER bigint(5) NOT NULL, PRIMARY KEY(TICKETID),FOREIGN KEY(SSN) REFERENCES PASSENGER(SSN),FOREIGN KEY(FLIGHTNUMBER) REFERENCES FLIGHT(FLIGHTNUMBER));

DROP TABLE IF EXISTS AIRWAYS.PAYMENT;
CREATE TABLE AIRWAYS.PAYMENT
(PAYMENTID bigint(10) NOT NULL,PAYMENTAMOUNT bigint NOT NULL,SSN bigint(10) NOT NULL,TICKETID bigint(7) NOT NULL, PRIMARY KEY(PAYMENTID),FOREIGN KEY(SSN) REFERENCES PASSENGER(SSN),FOREIGN KEY(TICKETID) REFERENCES TICKET(TICKETID));

DROP TABLE IF EXISTS AIRWAYS.CARDDETAILS;
CREATE TABLE AIRWAYS.CARDDETAILS
(CARDNUMBER bigint(12) NOT NULL,EXPIRATIONDATE date NOT NULL,CVV bigint(4) NOT NULL,PAYMENTID bigint(10) NOT NULL, PRIMARY KEY(CARDNUMBER),FOREIGN KEY(PAYMENTID) REFERENCES PAYMENT(PAYMENTID));

DROP TABLE IF EXISTS AIRWAYS.FLIGHT;
CREATE TABLE AIRWAYS.FLIGHT
(FLIGHTNUMBER bigint(5) NOT NULL,FLIGHTTYPE varchar(255) NOT NULL,CAPACITY bigint(3) NOT NULL,SSN bigint(10) NOT NULL,EMPLOYEEID bigint(7) NOT NULL, PRIMARY KEY(FLIGHTNUMBER),FOREIGN KEY(SSN) REFERENCES EMPLOYEE(SSN),FOREIGN KEY(EMPLOYEEID) REFERENCES EMPLOYEE(EMPLOYEEID));

DROP TABLE IF EXISTS AIRWAYS.FLIGHTSCHEDULE;
CREATE TABLE AIRWAYS.FLIGHTSCHEDULE
(ARRIVALTIME time NOT NULL,DEPARTURETIME time NOT NULL,ARRIVALLOCATION varchar(255) NOT NULL,DEPARTURELOCATION varchar(255) NOT NULL,FLIGHTNUMBER bigint(5) NOT NULL,FOREIGN KEY(FLIGHTNUMBER) REFERENCES FLIGHT(FLIGHTNUMBER));

DROP TABLE IF EXISTS AIRWAYS.AIRPORT;
CREATE TABLE AIRWAYS.AIRPORT
(AIRPORTID bigint(4) NOT NULL,AIRPORTNAME varchar(255) NOT NULL,LOCATION varchar(255) NOT NULL,SSN bigint(10) NOT NULL,EMPLOYEEID bigint(7) NOT NULL,FLIGHTNUMBER bigint(5) NOT NULL, PRIMARY KEY(AIRPORTID),FOREIGN KEY(SSN) REFERENCES EMPLOYEE(SSN),FOREIGN KEY(EMPLOYEEID) REFERENCES EMPLOYEE(EMPLOYEEID),FOREIGN KEY(FLIGHTNUMBER) REFERENCES FLIGHT(FLIGHTNUMBER));

DROP TABLE IF EXISTS AIRWAYS.EMPLOYEE;
CREATE TABLE AIRWAYS.EMPLOYEE
(SSN bigint(10) NOT NULL,EMPLOYEEID bigint(7) NOT NULL,NAME varchar(255) NOT NULL,PHONENUMBER bigint(10) NOT NULL,EMAILID varchar(255) NOT NULL, PRIMARY KEY(SSN));

DROP VIEW IF EXISTS AIRWAYS.PASSENGERRECORD; 
CREATE VIEW AIRWAYS.PASSENGERRECORD AS SELECT SSN,COUNT(*) AS TIMES_PASSENGER_TRAVELLED FROM AIRWAYS.TICKET GROUP BY SSN;