
/*
   Issue Description: CDM-16300
   Category/ Module  : Case status changed 
   Root cause: user requeseted to update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservicerequest set exitdate = '2021-11-07 00:00:00.000', intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-16300'
where intakeserviceid = '819711f4-fbed-4722-af04-13ac0f65327e';

update intakeservicerequestdispositioncode set activeflag = 1, updatedon= NOW(), updatedby='CDM-16300' where intakeservicerequestdispositioncodeid  = 'c5bdb8ef-dc79-4df3-916c-497b64d3380b';
