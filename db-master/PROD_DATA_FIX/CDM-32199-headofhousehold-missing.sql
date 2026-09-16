/*
   Issue Description: CDM-32199
   Category/ Module  :Persons 
   Root cause: Head of Household missing
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/
update intakeservicerequestactor
 set isprimary = true,
updatedby = 'CDM-32199',
updatedon =now() 
where intakeservicerequestactorid = '6a2fbb18-7977-4f5a-97a5-0cfe9ebf59d4';



update intakeservicerequestactor
 set isprimary = false,
updatedby = 'CDM-32199',
updatedon =now() 
where intakeservicerequestactorid = 'ef843b9f-2a45-4e07-9a61-249ee9b56cbe';