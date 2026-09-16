/*
   Issue Description: CDM-38121
   Category/ Module  : User Profile
   Root cause: CIDM-8670 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='240-310-2490', updatedby='CDM-38121', updatedon=now()
WHERE userprofilephonenumberid='e37f5e36-349a-4a4c-ad78-289cd3868cfb' and securityusersid='288e289b-af16-487d-b8c9-0e192683cfde' and activeflag=1;
