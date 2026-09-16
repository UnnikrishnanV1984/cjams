/*
   Issue Description: CDM-22792
   Category/ Module  : Reopening the case 
   Root cause: user wants reopen the case as it was not closed properly
   Pull request# for code fix: 5595
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed. Need to do data fix
*/



update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-22792'
where intakeserviceid = '59114900-cc53-4ac4-9931-a8a836dad271';

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-22792',
updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = '32a55b01-50c0-4be5-b823-271888ad46f3';