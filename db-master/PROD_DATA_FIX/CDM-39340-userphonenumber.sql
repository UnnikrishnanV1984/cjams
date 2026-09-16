/*
   Issue Description: CDM-39340
   Category/ Module : User Management
   Root cause: Not able to change from sailpoint 
   Fix Provided: Did data fix to update user phone number 

*/
UPDATE cjams.userprofilephonenumber
SET phonenumber='4434803527', updatedby='CDM-39340', updatedon=now()
WHERE securityusersid='ef15b336-bc7c-45b1-a5a2-e7e2a819564b' and activeflag=1;
