/*
  Issue Description:  CDM-40342
   Category/ Module  :  Application
   Root cause: User  requested to modify the service plan end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update serviceplan 
set targetenddate  = '2025-01-19 04:00:00.000', updatedby = 'CDM-40342', updatedon = now()
where serviceplanid ='3c152ed6-7a91-403c-9ded-97be3f84dfae' and activeflag = 1;

