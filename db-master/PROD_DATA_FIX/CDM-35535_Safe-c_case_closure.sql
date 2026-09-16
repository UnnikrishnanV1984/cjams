/*
  Issue Description: CDM-35535 unable to submit for closure
   Category/ Module  :  user management
   Root cause: I am unable to close case #231021265034. The closing checklist says a SAFE-C has not been completed, but 6 have been completed.
   Fix Provided: Datafix has been promoted to update the intakeservicerequestactorid in assessment actor table.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1 
*/
-- email:'julie.boyd@montgomerycountymd.gov'


select *from assessmentactor where assessmentid='7c6ba9c2-29b6-4d39-ab0c-dfd387c64b1b' and activeflag=1;


update assessmentactor 
set 
intakeservicerequestactorid='39e860bc-7961-4e02-b1a4-1b2d3c16463e',
updatedon = now(), 
updatedby = 'CDM-35535'
where 
assessmentactorid='5a8c585a-4ac1-4396-a434-516d5b9f1266'
and activeflag=1;