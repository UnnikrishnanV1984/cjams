/*
   Issue Description: CDM-30516
   Category/ Module  :Person  
   Root cause: House of headhold missing 
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/


update intakeservicerequestactor set isprimary = true,updatedby ='CDM-30516',updatedon =now() 
where intakeservicerequestactorid ='cc78ff84-4b2e-4879-aaa9-22356adf0ba8';