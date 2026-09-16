/*
   Issue Description: CDM-32382
   Category/ Module  :Dashboard
   Root cause: user requested to remove pending approval for CPSresponsetimer
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update routing
 set 
  activeflag = 0,
  updatedby ='CDM-32382',
  updatedon = now() where routingid ='99f8d7aa-db76-4ffc-bf75-7304916a31da';