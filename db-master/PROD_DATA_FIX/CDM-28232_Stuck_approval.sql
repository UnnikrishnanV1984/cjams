/*
   Issue Description: CDM-28232
   Category/ Module  : Stuck Approval
   Root cause:This case is stuck and does not need to be assigned. It is old and needs to be removed.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update routing set activeflag = 0, updatedby = 'CDM-28232', updatedon = now() where objectid = '78ab217d-6fa7-46f2-80d1-bd9bff5c2749';