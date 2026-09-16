/*
  Issue Description: CDM-32485
  Root cause: Isprimary is set to false
  Fix provided : Fix has been done to update the isprimary flag to true for the role which is in service case
   Pull request# for code fix: Code fix has been done using CIDM-7358
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update intakeservicerequestactor 
set isprimary = true, updatedby = 'CDM-32485', updatedon = now() 
where intakeservicerequestactorid = '45b332fb-476b-4b1a-b7cb-25136f8fca45';

update intakeservicerequestactor 
set isprimary = false, updatedby = 'CDM-32485', updatedon = now() 
where intakeservicerequestactorid = '4b9aafe3-b8af-44b5-bd51-9ebae52d184f';