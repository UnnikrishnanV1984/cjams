/*
   Issue Description: CDM-33453
   Category/ Module  : Approval inbox 
   Root cause:  User request to delte approval from inbox
   Fix Provide: Did data fix to remove that record 
*/

update cjams.routing set activeflag =0, updatedby ='CDM-33453', updatedon = now()
where routingid ='0ad034b7-2491-40ea-b808-58ce7984e659';