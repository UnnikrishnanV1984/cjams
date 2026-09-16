/*
   Issue Description: CDM-17540
   Category/ Module  : Perm plan
   Root cause: For one person  perm plan was not listed
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update permanencyplan 
set intakeservicerequestactorid = 'f01b00ed-80de-45fe-9876-4f7fabbfe06b', updatedby = 'CDM-17540', updatedon = now()
where permanencyplanid = '5bc2c44d-9cdd-4ff7-9422-0d4dd34239b1';






