/*
  Issue Description:  CDM-42517
   Category/ Module  :  Assignments
   Root cause: Data fix done to remove the case from the supervisor to be assigned dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update routing set activeflag = 0, updatedby = 'CDM-42517', updatedon = now()
where routingid = 'b110f39e-5f4a-4176-989f-fd60aa182f28' 
and activeflag = 1;