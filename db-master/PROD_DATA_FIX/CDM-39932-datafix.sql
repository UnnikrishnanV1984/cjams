/*
  Issue Description:  CDM-39932
   Category/ Module  :  Dashboard
   Root cause: user requested to remove the Case Plan Review request from the supervisor pending approval dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update routing set activeflag = 0, updatedby = 'CDM-39932', updatedon = now()
where routingid = '27e57919-85a7-4cde-8c94-fe1e0924da9a' and activeflag = 1;