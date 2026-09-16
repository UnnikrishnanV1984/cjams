/*
   Issue Description: CDM-31839
   Category/ Module  :  Persons
   Root cause: Head of HouseHold was missing
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor set isprimary =true ,updatedby='CDM-31839',updatedon =now() where intakeservicerequestactorid ='bbb6de08-1e5c-4108-9cbc-d57ab5b50379';