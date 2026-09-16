/*
   Issue Description: CDM-34924
   Category/ Module  : User Profile Phone Number
   Root cause: User requested to change the worker phone number to 410-271-5481
   Fix Privided: 
*/
--jalesa.byes@maryland.gov


UPDATE cjams.userprofilephonenumber
SET phonenumber='410-271-5481', updatedby='CDM-34924', updatedon=now()
WHERE userprofilephonenumberid='f3a41298-5452-4e2f-bdaa-65dc1b26cc35' and securityusersid='384f227c-9fee-4c95-bb00-744e0d2c08f1';