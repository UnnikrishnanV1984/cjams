/*
   Issue Description: CDM-34476
   Category/ Module  : User Profile Phone Number
   Root cause: User requested to change the worker phone number from 916-420-7793 with 443-615-1158
   Fix Privided: 
*/
--yosef.webbcohen@maryland.gov
UPDATE cjams.userprofilephonenumber
SET phonenumber='443-615-1158', updatedby='CDM-34476', updatedon=now()
WHERE userprofilephonenumberid='b0ae0642-1a11-4020-9186-7d0b6cb28863' and securityusersid='af17f8e6-721c-4060-aa8a-c212efefb3c2';
