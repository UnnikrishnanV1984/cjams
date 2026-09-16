/*
   Issue Description: CDM-28745
   Category/ Module  : revert intake supervisor decision 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 
*/


update routing set routingstatustypeid = 2 ,updatedby = 'CDM-28751', updatedon = now()
where routingid = '62bc6e69-46d4-4c35-9dc7-77a669386a3e';