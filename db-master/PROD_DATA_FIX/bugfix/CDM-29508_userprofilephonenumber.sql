/*
   Issue Description: CDM-29508
   Category/ Module  : User Profile
   Root cause: As requested.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='443-757-2534', updatedby='CDM-29508', updatedon=now()
WHERE userprofilephonenumberid='231c1b04-aa00-449b-9c7c-e0bf8022c5b7' and securityusersid='a3378274-5a52-4025-a975-8788412f64df';
