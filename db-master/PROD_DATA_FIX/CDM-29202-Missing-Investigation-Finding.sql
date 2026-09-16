/*
   Issue Description: CDM-29202
   Category/ Module  : Investigation Findings
   Root cause: user wants to add missing findings
   Pull request# for data fix:8175
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need data fix as the active flags where zero for roles
*/
update intakeservicerequestactor set activeflag = 1, updatedby = 'CDM-29202', 
updatedon = now() where intakeservicerequestactorid = 'ae9b07f7-9060-4337-9628-3d7e57a99964' and activeflag = 0;
