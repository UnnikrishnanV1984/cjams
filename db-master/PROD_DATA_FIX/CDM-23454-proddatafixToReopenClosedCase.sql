/*
   Issue Description: CDM-23456
   Category/ Module  : Prod data fix to reopen closed case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 0bdda2ab-b74f-4d74-ba17-3b9b37a9ca19
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
updatedon= now(), updatedby='CDM-23454'
where intakeserviceid = 'a458f652-0128-4ff8-ba38-f0f403b3d905';


UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-23454',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '807591bd-1d3d-4b56-b1e4-638bc9d3d7f0';
