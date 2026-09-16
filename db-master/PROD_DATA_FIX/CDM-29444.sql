/*
   Issue Description: CDM-29444
   Category/ Module  : 
   Root cause: user want to remove Person from case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 

update actor set activeflag=0,updatedby='CDM-29444',updatedon=now() where actorid='0a52459b-2e73-4aa4-bfde-d7e7f5f1d051';

update intakeservicerequestactor set activeflag=0,updatedby='CDM-29444',updatedon=now() 
where intakeservicerequestactorid='65eb3fda-3d24-4e98-891e-b7f35ae6cab7';
