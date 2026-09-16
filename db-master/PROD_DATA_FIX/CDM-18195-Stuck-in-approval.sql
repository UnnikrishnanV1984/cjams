/*
   Issue Description: CDM-18195
   Category/ Module  : Approval screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing 
set activeflag = 0, updatedby = 'CDM-18195', updatedon = now()
where routingid = '4b6a318a-9697-4f84-a86d-def10d1c0eb4';
