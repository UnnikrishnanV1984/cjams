/*
   Issue Description: CDM-31330
   Category/ Module  :Person Tab 
   Root cause: House of headhold missing
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor  set isheadofhousehold = true,updatedby ='CDM-31330' , updatedon =now() where intakeservicerequestactorid ='f430f58f-03de-4e9c-89bd-bb21117cac09';