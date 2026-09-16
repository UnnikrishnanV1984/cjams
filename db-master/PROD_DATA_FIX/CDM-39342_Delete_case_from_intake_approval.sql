/*
   Issue Description: CDM-39342
   Category/ Module  : SDM 
   Root cause: Needed to delete case from approval inbox.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing
set activeflag=0, updatedby='CDM-39342', updatedon=now()
where routingid='6c7b6379-f3e8-40c8-9f16-1a5fbc3331d2' and activeflag= 1;