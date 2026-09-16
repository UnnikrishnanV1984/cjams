/*
   Issue Description: CDM-23002
   Category/ Module  : AR case summary 
   Root cause: user wants to chnage the case status and reopen the case 
   Pull request# for code fix: 5712
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
updatedon= now(), updatedby='CDM-23002'
where intakeserviceid = '2203bad4-523c-41b1-97d1-b7ae60b719db';


UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-23002',
updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = 'cbd6fc8b-a5f4-4619-a4f8-5a356a55b8e0';