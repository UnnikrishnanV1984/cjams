/*
   Issue Description: CDM-33461
   Category/ Module  : Approval inbox 
   Root cause:  User request to delte approval from inbox
   Fix Provide: Did data fix to remove that record 
*/

update cjams.routing set activeflag =0, updatedby ='CDM-33461', updatedon = now()
where routingid in('5c5c51f9-2bed-4d26-8a77-3b894d8b63f0');