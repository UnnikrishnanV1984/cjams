/*
  Issue Description: CDM-25331
   Category/ Module  : Duplicate client appeared
   Root cause: DUPLICATE PERSON
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/

update
  intakeservicerequestactor
set
  isprimary = false,
  updatedby = 'CDM-25331',
  updatedon = now()
where
  intakeservicerequestactorid = '8abe7dcb-9f98-4333-b3d6-f379c82ab17f'
  and activeflag = 1;
