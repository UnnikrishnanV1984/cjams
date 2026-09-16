/*
   Issue Description: CDM-41075
      Category/ Module  : Approval inbox
   Root cause: User asked to remove the related case from the approval dashboard.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing
set activeflag=0, updatedby='CDM-41075', updatedon=now()
where routingid='aec2a408-bdcb-4dbe-9faa-9fb2b9384056' and activeflag=1;