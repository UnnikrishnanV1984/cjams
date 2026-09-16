/*
   Issue Description: CDM-33460
   Category/ Module  : Approval inbox 
   Root cause:  User request to delte approval from inbox
   Fix Provide: Did data fix to remove that record 
*/


update cjams.routing set activeflag =0, updatedby ='CDM-33460', updatedon = now()
where routingid ='e16df0c2-51f7-4a96-b3c2-fdf720e5a9c4';