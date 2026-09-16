/*
  Issue Description: CDM-34671
  Root cause: Isprimary is set to false
  Fix provided : Fix has been done to update the isprimary flag to true for the role which is in service case
   Pull request# for code fix: Code fix has been done using CIDM-7358
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update intakeservicerequestactor 
set isprimary = true, updatedby = 'CDM-34671', updatedon = now() 
where intakeservicerequestactorid = 'f34c5bd0-c7e7-47eb-a1d5-14df01c70518';

update intakeservicerequestactor 
set isprimary = false, updatedby = 'CDM-34671', updatedon = now() 
where intakeservicerequestactorid = 'b4196ab7-3374-403b-b7d8-9793196d21c2';