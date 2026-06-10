-- Databricks notebook source
--SQL UNION & UNION ALL EXERCISE 
--CREATING ALL THE TABLES 

--QUESTION 1 (UNION)
--
CREATE OR REPLACE TABLE Branch_Sandton_Accounts(
    account_id STRING,
    account_holder STRING
);

    INSERT INTO Branch_Sandton_Accounts VALUES
('A001','Nomvula Dlamini'),
('A002','David Mokoena'),
('A003','Lerato Sithole'),
('A004','Peter Nkosi');

CREATE OR REPLACE TABLE Branch_Rosebank_Accounts(
    account_id STRING,
    account_holder STRING

);

INSERT INTO Branch_Rosebank_Accounts VALUES
('A003','Lerato Sithole'),
('A004','Peter Nkosi'),
('A005','Zanele Khumalo'),
('A006','Thabo Motha');

--Combining the account holders from both branches into one unique list.
SELECT account_id, account_holder
FROM Branch_Sandton_Accounts
UNION
SELECT account_id, account_holder
FROM Branch_Rosebank_Accounts;


--QUESTION 2


CREATE OR REPLACE TABLE Savings_products(
    product_code STRING,
    product_name STRING
);

    INSERT INTO Savings_products VALUES
('SV01','Basic Savings'),
('SV02','Premium Savings'),
('SV03','Youth Savings'),
('SV04','Business Savings');

CREATE OR REPLACE TABLE Current_Products(
    product_code STRING,
    product_name STRING

);

INSERT INTO Current_products VALUES
('CR01','Standard Current'),
('CR02','Gold Current'),
('SV03','Youth Savings'),
('CR03','Business Current');

--Building a unique product catalogue that shows every product the bank offers, without repeating any product that appears in both lists.
SELECT product_code, product_name, 'Savings' AS product_type
FROM savings_products
UNION
SELECT product_code, product_name, 'Current' AS product_type
FROM current_products;


--QUESTION 3
--Creating all the tables

CREATE OR REPLACE TABLE Retail_Banking_Staff(
    staff_id STRING,
    staff_name STRING,
    Email_Address STRING
);

    INSERT INTO Retail_Banking_Staff VALUES
('S001','Mpho Radebe','MphoR2gmail.com'),
('S002','Brian Tshabalala','BrianT@gmail.com'),
('S003','Aisha Patel','AishaP22GMail.com'),
('S004','Kabelo Moabelo','KabeloM@gmail.com');

CREATE OR REPLACE TABLE Corporate_Banking_Staff(
    staff_id STRING,
    staff_name STRING,
    Email_Address STRING

);

INSERT INTO Corporate_Banking_Staff VALUES
('S003','Aisha Patel','AishaP22GMail.com'),
('S005','Nandi Dube','NandiD2gmail.com'),
('S006','Sipho Khumalo','Siphok2gmail.com'),
('S004','Kabelo Moabelo','KabeloM@gmail.com');

--This show a unique list of all staff who work in either Retail Banking or Corporate Banking. Some staff are assigned to both. Each staff member should appear only once.
SELECT staff_id, staff_name,Email_Address
FROM Retail_Banking_Staff
UNION
FROM Corporate_Banking_Staff;


--QUESTION 4
CREATE OR REPLACE TABLE Mobile_Branch_Cities(
    city_code STRING,
    city_name STRING
);

    INSERT INTO Mobile_Branch_Cities VALUES
('C01','Johannesburg'),
('C02','Pretoria'),
('C03','Cape Town'),
('C04','Durban');

CREATE OR REPLACE TABLE Digital_Branch_Cities(
     city_code STRING,
    city_name STRING

);

INSERT INTO Digital_Branch_Cities VALUES
('C03','Cape Town'),
('C05','Polokwane'),
('C06','Port Elizabeth'),
('C01','Johannesburg');

--It shows a unique list of all cities where NexBank serves customers — either through its mobile branches or its digital branch (which serves customers online regardless of city).
SELECT city_code, city_name, 'Mobile' AS region
FROM mobile_branch_cities
UNION
SELECT city_code, city_name, 'Digital' AS region
FROM digital_branch_cities;

--QUESTION 5
--Building a unique list of every customer who was targeted.
CREATE OR REPLACE TABLE Push_notification_targets(
     customer_id STRING,
    customer_name STRING

);

INSERT INTO push_notification_targets VALUES
('C1001','Nomsa Zwane'),
('C1002','Andile Buthelezi'),
('C1003','Fatima Mahomed'),
('C1004','Ryno Van Zyl');

CREATE OR REPLACE TABLE inapp_banner_targets(
     customer_id STRING,
    customer_name STRING

);

INSERT INTO inapp_banner_targets VALUES
('C1003','Fatima Mahomed'),
('C1005','Thandeka Cele'),
('C1006','Samuel Nkosi'),
('C1002','Andile Buthelezi');

--Answer: 
SELECT customer_id,
       customer_name,
       'Push Notification' AS segment
FROM push_notification_targets

UNION

SELECT customer_id,
       customer_name,
       'In-App Banner' AS segment
FROM inapp_banner_targets;

--QUESTION 6(UNION ALL)

CREATE OR REPLACE TABLE ATM01_Transactions(
     txn_id STRING,
    account_id STRING,
    amount STRING

);

INSERT INTO ATM01_Transactions VALUES
('T1001','A001','500.00'),
('T102','A002','1200.00'),
('T1003','A001','300.00'),
('T1004','A003','750.00');

--Table 2
CREATE OR REPLACE TABLE ATM02_Transactions(
     txn_id STRING,
    account_id STRING,
    amount STRING

);

INSERT INTO ATM02_Transactions VALUES
('T1003','A001','300.00'),
('T105','A004','900'),
('T1006','A002','450.00'),
('T1007','A005','150.00');

--Answer:
SELECT
    txn_id AS transaction_id,
    account_id,
    amount,
    CURRENT_DATE AS transaction_date
FROM atm01_transactions

UNION ALL

SELECT
    txn_id AS transaction_id,
    account_id,
    amount,
    CURRENT_DATE AS transaction_date
FROM atm02_transactions;

--QUESTION 7
--getting a full list of all loan applications received.
CREATE OR REPLACE TABLE Gauteng_Loan_Applications (
     app_id STRING,
    customer_id STRING,
    loan_type STRING

);

INSERT INTO Gauteng_loan_Applications VALUES
('LA001','C1001','Home Loan'),
('LA002','C1002','Vehicle Loan'),
('LA003','C1003','Personal'),
('LA004','C1004','Home Loan');

CREATE OR REPLACE TABLE Western_Cape_Loan_Applications (
     app_id STRING,
    customer_id STRING,
    loan_type STRING

);

INSERT INTO Western_Cape_Loan_Applications VALUES
('LA003','C1003','Personal'),
('LA005','C1005','Vehicle Loan'),
('LA006','C1006','Business'),
('LA007','C1007','Home Loan');

--Answer
SELECT app_id AS application_id,
       customer_id,
       loan_type,
       NULL AS amount_requested
FROM gauteng_loan_applications

UNION ALL

SELECT app_id,
       customer_id,
       loan_type,
       NULL
FROM western_cape_loan_applications;

--QUESTION 8

--This shows a full record of every complaint logged this month, whether it came via email or via the mobile app.
CREATE OR REPLACE TABLE email_complaints (
     complaint_id STRING,
    customer_id STRING


);

INSERT INTO email_complaints VALUES
('EC001','C2001'),
('EC002','C2002'),
('EC003','C2003'),
('EC004','C2004');

CREATE OR REPLACE TABLE app_complaints (
     complaint_id STRING,
    customer_id STRING
    

);

INSERT INTO app_complaints VALUES
('AC001','C2005'),
('AC002','C2001'),
('AC003','C2006'),
('AC004','C2007');

--Answer
SELECT complaint_id,
       customer_id,
       'Email' AS category,
       CURRENT_DATE AS logged_date
FROM email_complaints

UNION ALL

SELECT complaint_id,
       customer_id,
       'App',
       CURRENT_DATE
FROM app_complaints;


--QUESTION 9 
--This shows reconcile all payment records from April and May into one table for the half-year report.
CREATE OR REPLACE TABLE April_Payments (
     payment_id STRING,
    account_id STRING,
    amount String


);

INSERT INTO April_Payments VALUES
('PAY001','A001','12500.00'),
('PAY002','A002','4800.00'),
('PAY003','A003','9200.00'),
('PAY004','A004','3300.00');


CREATE OR REPLACE TABLE May_Payments (
     payments_id STRING,
    account_id STRING,
    amount STRING
    

);

INSERT INTO May_Payments VALUES
('PAY005','A001','12500.00'),
('PAY006','A005','7600.00'),
('PAY007','A002','5100.00'),
('PAY008','A006','2800.00');

--Answer
SELECT payment_id,
       account_id,
       amount,
       '2025-04-30' AS payment_date
FROM april_payments

UNION ALL

SELECT payments_id AS payment_id,
       account_id,
       amount,
       '2025-05-31'
FROM may_payments;


--QUESTION 10
--This Combines all entries into one general ledger for the audit.

CREATE OR REPLACE TABLE debit_entries (
     entry_id STRING,
    account_id STRING,
    entry_Type STRING
    

);

INSERT INTO debit_entries VALUES
('DR001','A001','Debit'),
('DR002','A002','Debit'),
('DR003','A003','Debit'),
('DR004','A004','Debit');


CREATE OR REPLACE TABLE credit_entries (
     entry_id STRING,
    account_id STRING,
    entry_Type STRING
    

);

INSERT INTO credit_entries VALUES
('CR001','A001','Credit'),
('CR002','A005','Credit'),
('DR003','A002','Credit'),
('DR004','A006','Credit');

--Answer
SELECT entry_id,
       account_id,
       entry_type,
       NULL AS amount,
       CURRENT_DATE AS entry_date
FROM debit_entries

UNION ALL

SELECT entry_id,
       account_id,
       entry_type,
       NULL,
       CURRENT_DATE
FROM credit_entries;



-- COMMAND ----------


