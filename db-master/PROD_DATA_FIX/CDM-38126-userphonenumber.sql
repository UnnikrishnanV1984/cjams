/*
   Issue Description: CDM-38126
   Category/ Module  : User Profile
   Root cause: CIDM-8670 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='240-329-7828', updatedby='CDM-38126', updatedon=now()
WHERE userprofilephonenumberid='d9b8375a-3c0a-471b-9950-853d6e4fcf68' and securityusersid='49a1a523-f837-4998-9bc9-6d50847aa47e' and activeflag=1;
