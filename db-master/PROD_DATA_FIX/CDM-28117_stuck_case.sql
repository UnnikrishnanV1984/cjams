/*
   Issue Description: CDM-28117
   Category/ Module  : Stuck Case
   Root cause:This case is stuck and does not need to be assigned. It is old and needs to be removed.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/




update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-28117' where objectid = 'I202100332937';