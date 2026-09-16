/*
   Issue Description: CDM-31948
   Category/ Module  :  Persons
   Root cause: Person missing from case
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor 
set isprimary = true,
updatedby= 'CDM-31948',
updatedon= now() 
where intakeservicerequestactorid='cf217bf1-f236-48ac-99c4-2c33bab99241';