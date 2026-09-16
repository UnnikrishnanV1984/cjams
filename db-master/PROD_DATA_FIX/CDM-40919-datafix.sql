/*
  Issue Description:CDM-40919
Category/ Module:Application
Root cause: User  requested to end date program assignment
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/


update personprogramarea
set activeflag =0,
updatedby='CDM-40919',
updatedon = now()
where personprogramid in ( 'ae58ceb2-078d-45aa-b58b-f790affb5aaa','94cb0f5a-ab80-49db-9d0a-17bc9376e5f2') and activeflag=1;
