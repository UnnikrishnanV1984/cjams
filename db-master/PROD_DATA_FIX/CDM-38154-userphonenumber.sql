/*
   Issue Description: CDM-38154
   Category/ Module  : User Profile
   Root cause: CIDM-8670 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='240-420-2360', updatedby='CDM-38154', updatedon=now()
WHERE userprofilephonenumberid='3e4093a9-a32c-4c0f-9516-86afddb3fcc9' and securityusersid='c87ede47-7c5b-45c0-aec4-1831f1ce0cfd' and activeflag=1;