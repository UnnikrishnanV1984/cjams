
/*
   Issue Description: CDM-14995
   Category/ Module  :  Re-opening CPS case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--null 642f18b0-ef6e-4d4b-9871-acc0734f3f5a
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-14995'
where intakeserviceid = '819711f4-fbed-4722-af04-13ac0f65327e';

update intakeservicerequestdispositioncode set activeflag = 0, updatedon= NOW(), updatedby='CDM-14995' where intakeservicerequestdispositioncodeid  = 'c5bdb8ef-dc79-4df3-916c-497b64d3380b'
