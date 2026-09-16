/*
   Issue Description: CDM-16469
   Category/ Module  :  child welfare 
   Root cause: routing issue case plan 2
   Pull request# for code fix: 
   Reason why no related code fix: 
   record remaining in approval inbox 
*/
update routing
set activeflag = 1,
updatedby = 'CDM-16469',
updatedon = now()
where routingid = '63cc3a01-e351-4803-8f85-8b7280876353';