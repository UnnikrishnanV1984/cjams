/*
   Issue Description: CDM-38122
   Category/ Module  : User Profile
   Root cause: CIDM-8670 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='240-420-2357', updatedby='CDM-38122', updatedon=now()
WHERE userprofilephonenumberid='6741b28d-c7a8-4e81-94fa-7c32d7edd4ce' and securityusersid='1b22ed17-fee6-4b52-ad10-ece560c9d6d2' and activeflag=1;
