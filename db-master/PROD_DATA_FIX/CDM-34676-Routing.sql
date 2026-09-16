/*
   Issue Description: CDM-34676
   Category/ Module  : Routing 
   Root cause: Due to enable button on status dispostion multple records might insert did code fix CDM-34632
   Fix Privided: Did data fix to remove the duplicate record 
*/


update cjams.routing set activeflag  =0,
updatedby  ='CDM-34676', updatedon = now()
where routingid  ='372be2e2-d90e-4f47-99e2-c27c711f2453';