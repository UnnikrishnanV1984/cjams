/*
  Issue Description:  CDM-42545
   Category/ Module  :  Assignments
   Root cause: Not able to replicate the issue. Working fine for other cases.
   Data fix done to remove the case from the supervisor to be assigned dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update routing set activeflag = 0, updatedby = 'CDM-42545', updatedon = now()
where routingid = '4784b8d7-7235-4aa5-b5ba-f2c4f75edb9b' 
and activeflag = 1;