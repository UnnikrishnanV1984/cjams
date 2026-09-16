/*
   Issue Description: CDM-31033
   Category/ Module  :Person  
   Root cause: House of headhold missing 
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/


update intakeservicerequestactor set isprimary = true,updatedby ='CDM-31033',updatedon =now() 
where intakeservicerequestactorid ='534a4794-549e-436a-86c8-de601565800f';