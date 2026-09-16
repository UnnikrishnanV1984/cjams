/*
   Issue Description: CDM-19800
   Category/ Module  : Approval screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
set activeflag = 0, updatedby = 'CDM-19800', updatedon = now()
where routingid = '1b0f5145-19bf-497a-a8c1-1df34ecf38e5';