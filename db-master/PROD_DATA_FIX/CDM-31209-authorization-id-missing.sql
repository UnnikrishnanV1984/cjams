/*
   Issue Description: CDM-31207
   Category/ Module  :Service 
   Root cause: House of headhold missing , the purchase authorizatin was linked with the missing person. 
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor set isprimary = true,updatedby ='CDM-31209',updatedon =now() where intakeservicerequestactorid ='59cd2520-d8f9-4d25-b91d-790235ddc9e8';