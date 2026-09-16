/*
   Issue Description: CDM-31713
   Category/ Module  : 
   Root cause: user want to remove Person 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 

update actor set activeflag=0,updatedby='CDM-31713',updatedon=now() where actorid='ad8822c9-cb13-47e9-9d07-3bd90e4746b7';

update intakeservicerequestactor set activeflag=0,updatedby='CDM-31713',updatedon=now() 
where intakeservicerequestactorid in ('7d879f60-9f0b-4ff9-a3a1-c35c90b5c2f8','84d4d009-7f98-43e8-b571-608616af9254','e3b505f9-e686-40cf-a3ec-4e9596d83770');