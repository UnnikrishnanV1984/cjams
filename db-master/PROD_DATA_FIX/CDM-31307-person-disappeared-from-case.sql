/*
   Issue Description: CDM-31307
   Category/ Module  :Person  
   Root cause: House of headhold missing ,servicelog associated with that person also missing
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor set isprimary = true,updatedby ='CDM-31307',updatedon =now() where intakeservicerequestactorid ='e0365dab-fb45-402c-84f1-954a06b76ac8';