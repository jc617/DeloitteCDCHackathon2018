CREATE DATABASE Deloitte;

#Create a database Deloitte
USE Deloitte;

#Enable safe updates in MYSQL Workbench
SET SQL_SAFE_UPDATES = 0;
#DROP TABLE Account_Load;
#DROP TABLE Contact_Load;

#use import wizard and upload the data into tables (Create primary keys for ids)
#Correct the mobile number formatting in the table
UPDATE Contact_Load
SET MOBILEPHONE =REPLACE(MOBILEPHONE,'(','');

UPDATE Contact_Load
SET MOBILEPHONE =REPLACE(MOBILEPHONE,')','-');

UPDATE Contact_Load
SET MOBILEPHONE =REPLACE(MOBILEPHONE,' ','');


#SELECT * FROM Account_Load WHERE ID = '0011N00001CTXpEQAX';
#SELECT * FROM Contact_Load WHERE DEPARTMENT <> 'Administration';

#Create the VIEW with all the necessary filters
CREATE VIEW SourceData AS(
SELECT * FROM (
SELECT C.ID as CID,A.ID as AID,A.Name,A.Type,A.PARENTID,A.BILLINGSTREET,A.BILLINGCITY,A.BILLINGSTATE,A.BILLINGPOSTALCODE ,
A.BILLINGCOUNTRY,A.PHONE,A.ACCOUNTNUMBER,A.WEBSITE,A.ANNUALREVENUE,A.INDUSTRY,
C.ACCOUNTID,C.LASTNAME,C.FIRSTNAME,C.SALUTATION,C.NAME as CNAME,C.MAILINGCITY,C.MAILINGSTREET,C.MAILINGSTATE,C.MAILINGPOSTALCODE,
C.MAILINGCOUNTRY,C.PHONE as CPHONE,C.MOBILEPHONE,C.OTHERPHONE,C.ASSISTANTPHONE,C.EMAIL,C.TITLE,C.DEPARTMENT
FROM Contact_Load as C LEFT JOIN Account_Load as A  
ON A.ID = C.ACCOUNTID
UNION 
SELECT C.ID as CID,A.ID as AID,A.Name,A.Type,A.PARENTID,A.BILLINGSTREET,A.BILLINGCITY,A.BILLINGSTATE,A.BILLINGPOSTALCODE ,
A.BILLINGCOUNTRY,A.PHONE,A.ACCOUNTNUMBER,A.WEBSITE,A.ANNUALREVENUE,A.INDUSTRY,
C.ACCOUNTID,C.LASTNAME,C.FIRSTNAME,C.SALUTATION,C.NAME as CNAME,C.MAILINGCITY,C.MAILINGSTREET,C.MAILINGSTATE,C.MAILINGPOSTALCODE,
C.MAILINGCOUNTRY,C.PHONE as CPHONE,C.MOBILEPHONE,C.OTHERPHONE,C.ASSISTANTPHONE,C.EMAIL,C.TITLE,C.DEPARTMENT 
FROM Contact_Load as C RIGHT JOIN Account_Load as A  
ON A.ID = C.ACCOUNTID
) as T
WHERE T.INDUSTRY <>'' AND T.INDUSTRY IS NOT NULL
AND (T.BILLINGCITY<>'' OR T.BILLINGPOSTALCODE<>'')
AND T.TITLE NOT LIKE '%Administration%' 
AND T.DEPARTMENT <>'Administration'
);

#Return the records from the view
SELECT * FROM SourceData;


#Validation codes

#SELECT * FROM Account_Load WHERE ID NOT IN (SELECT ACCOUNTID FROM Contact_Load);




