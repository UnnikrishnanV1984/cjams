/*
   Issue Description: CDM-34469
   Category/ Module  : Routing   
   Root cause: User requested 
   Fix Provided: Did data fix to remove the record 
*/


update cjams.routing set activeflag  =0, updatedby  ='CDM-34469', updatedon  = now()
where routingid  ='d9f297f9-6a89-4890-ba9f-07c73ec4d0a0';