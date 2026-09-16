/*
   Issue Description: CDM-20827
   Category/ Module  : 

   Root cause: Reopen CPS AR cases
   
   Pull request# for code fix: N/A
   Reason why no related code fix:  N/A
   Status of the code fix if already submitted and expected prod fix date:  N/A
*/

--Case number: 221020178317 --
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-20827'
where intakeserviceid = '94a2807a-54d3-45a1-908a-264d469d0d04';


UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-20827',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '387b9b97-65ef-4af5-aba9-95908932772b';

--Case number: 221020175560 --

update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-20827'
where intakeserviceid = '86d0579a-f4fd-42f0-b355-93c965a5eb97';


UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-20827',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = 'f6a12b04-2cf4-4369-a7ae-75796867e383';