
/*
   Issue Description: CDM-20933
   Category/ Module  : End dating Gap suspension
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2022-01-07 17:34:47	7995cecb-062d-406c-8ea9-b1da4b1877d8
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-19699'
where intakeserviceid = 'e987f4db-fea9-4f82-b069-39ed01f6d6fc';

update intakeservicerequestdispositioncode set activeflag = 0, updatedon= NOW(), updatedby='CDM-19699' where intakeservicerequestdispositioncodeid  = 'fd7a2fd4-f41c-4cfc-bd91-136434d6922d';
