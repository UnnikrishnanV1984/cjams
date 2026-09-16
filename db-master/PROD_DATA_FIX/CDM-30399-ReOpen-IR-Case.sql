/*
   Issue Description: CDM-30399
   Category/ Module  : reopen the case
   Root cause: user closed case in error have ssa approval to reopen the case
   Pull request# for code fix: 8692
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
updatedon= now(), updatedby='CDM-30399'
where intakeserviceid = '710b4689-e089-499a-8a4b-4a6d952f7ead';


UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-30399',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '8b2bec69-ed18-49e2-a5cd-bcfaac361939';