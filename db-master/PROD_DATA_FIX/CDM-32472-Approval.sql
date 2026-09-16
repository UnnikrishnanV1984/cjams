/*
  Issue Description: CDM-32472
  Root cause: CP record is approved but still on approval inbox 
  Fix provided : updated routing table to inactivate this approval request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/



update cjams.routing 
set activeflag =0, updatedby ='CDM-32472', updatedon = now()
where routingid ='16a797cc-b85e-44d8-a477-9cba83ee4342';