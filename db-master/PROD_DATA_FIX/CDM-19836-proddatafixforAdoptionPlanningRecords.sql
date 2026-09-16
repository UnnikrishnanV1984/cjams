
/*
   Issue Description: CDM-19836
   Category/ Module  : Adoption Planning with correct intakeservicerequestactor id
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--d34b4ffd-9340-4849-b03e-339fac7ab363
update adoptionplanning set intakeservicerequestactorid = '36d67093-9892-4a2b-9578-11c559410d73', updatedon = now(), updatedby = 'CDM-19836' where permanencyplanid = 'c742ff02-1f93-4d14-ae7d-01c026de13a0' and activeflag = 1;
