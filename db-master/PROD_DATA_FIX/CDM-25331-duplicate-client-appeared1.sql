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
where intakeservicerequestactorid = '7d83b5f2-e26c-4e65-b96b-13d386bfd51f'
    and personid  = '105bfa12-1bc6-4cb0-b855-23767c837b3c'
    and activeflag = 1;