/*
   Issue Description: CDM-28497
   Category/ Module  :Person
   Pull request# for code fix: Remove case from users queue
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0,
updatedby = 'CDM-28497', 
updatedon = now() 
where routingid = 'f365b520-6c73-466c-94a6-2485622e2caa';