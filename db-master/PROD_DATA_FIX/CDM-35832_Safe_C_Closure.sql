/*
  Issue Description: CDM-35832 unable to submit for closure
   Category/ Module  :  user management
   Root cause: 231021265034:Safe-C has been approved however when attempting to close the case, the safe-c box states it is not approved. Screen URL:
   Fix Provided: Datafix has been promoted to update the intakeservicerequestactorid in assessment actor table.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1 
*/
-- email:'rachel.rios@montgomerycountymd.gov'


select *from assessmentactor where intakeservicerequestactorid = 'd4237e8b-c64a-41b7-9bce-33f4a38723c3' and activeflag = 1;

update assessmentactor 
set 
intakeservicerequestactorid='39e860bc-7961-4e02-b1a4-1b2d3c16463e',
updatedon = now(), 
updatedby = 'CDM-35832'
where 
intakeservicerequestactorid='d4237e8b-c64a-41b7-9bce-33f4a38723c3'
and activeflag=1;
