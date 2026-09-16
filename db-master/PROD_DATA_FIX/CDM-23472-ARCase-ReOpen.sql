/*
   Issue Description: CDM-23472
   Category/ Module  : Case Reopen
   Root cause: user wants reopen the case
   Pull request# for code fix: 5931
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed in error. Need to do data fix
*/
update intakeservicerequest 
set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-23472'
where intakeserviceid = '162e6ed4-747c-43b9-bfdb-42eb69c3f104';


UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-23472',
updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = 'f18e734b-6f8b-4ce2-b726-9c9462cc323f';