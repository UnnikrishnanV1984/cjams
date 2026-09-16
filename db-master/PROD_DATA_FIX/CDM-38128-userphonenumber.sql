/*
   Issue Description: CDM-38128
   Category/ Module  : User Profile
   Root cause: CIDM-8670 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='240-420-2362', updatedby='CDM-38128', updatedon=now()
WHERE userprofilephonenumberid='1e9e1719-b4c7-4231-8570-4fe4bc5a7a02' and securityusersid='a559b92f-9553-41ea-bc3c-37d1ab92f872' and activeflag=1;
