/*
   Issue Description: CDM-42187
   Category/ Module  : Prod data fix to update cps ar details
   Root cause: Action type missing
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing 
set routingstatustypeid = 2,
    activeflag = 1,
    supervisordecision = 'scrnin',
    updatedon = now(),
    updatedby = 'CDM-42187'
where routingid = 'e1893110-b79e-4029-801b-49a40820c78d'
and objectid = 'I241013157650';


update intakeservicerequest set actiontype = 'IR', 
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', updatedon = now(),updatedby = 'CDM-42187' 
where intakeserviceid = 'c3add108-043a-4ec4-8b46-fe2cd4b90d97';


update intakeservicerequestdispositioncode
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
    servicerequesttypeconfigiddispostionid = '9a333c30-8043-4732-9f9a-622b8d8038da',
    updatedby = 'CDM-42187',
    updatedon = now()
WHERE intakeserviceid = 'c3add108-043a-4ec4-8b46-fe2cd4b90d97';