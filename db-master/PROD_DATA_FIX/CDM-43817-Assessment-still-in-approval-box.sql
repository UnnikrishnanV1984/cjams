/*
  Issue Description:  CDM-43817
   Category/ Module  :  Assignments
   Root cause: Request to remove aready approved request which was requested for approval again.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update routing
set activeflag = 0, updatedby ='CDM-43817', updatedon = now()
where routingid ='41f91e12-a317-4d86-9346-a104d9a1cc60' and activeflag = 1;