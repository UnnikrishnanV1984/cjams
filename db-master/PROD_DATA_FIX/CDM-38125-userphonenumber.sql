/*
   Issue Description: CDM-38125
   Category/ Module  : User Profile
   Root cause: CIDM-8670 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='240-329-7663', updatedby='CDM-38125', updatedon=now()
WHERE userprofilephonenumberid='ae5df0fd-f967-4779-b4a3-8583948e9735' and securityusersid='9653d06f-d4a6-4ac2-8cfe-1373aa6a1198' and activeflag=1;
