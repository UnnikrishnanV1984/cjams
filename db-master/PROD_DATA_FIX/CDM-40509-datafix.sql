/*
  Issue Description:  CDM-40509
   Category/ Module  :  Application
   Root cause: User  requested to modify the service plan end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update serviceplan 
set targetenddate  = '2025-01-20 04:00:00.000', updatedby = 'CDM-40509', updatedon = now()
where serviceplanid ='4bd53a1c-9742-4b14-bf76-17a32016f85d' and activeflag = 1;