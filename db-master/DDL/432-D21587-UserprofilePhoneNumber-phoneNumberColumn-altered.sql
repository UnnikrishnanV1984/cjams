/* Need to Execute DML cjams-portal-db\DML\279-D21587-RemovingExtraDigitsInPhoneNumber before executing the DDL */

/* Restricting Phone number to 10 digits */

ALTER TABLE cjams.userprofilephonenumber ALTER COLUMN phonenumber TYPE varchar(10);

