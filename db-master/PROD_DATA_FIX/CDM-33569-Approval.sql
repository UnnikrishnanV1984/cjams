/*
   Issue Description: CDM-33569
   Category/ Module  : Approval inbox 
   Root cause: approved record not removed from inbox 
   Fix Provide: Did data fix to remove that record 
*/

update cjams.routing set activeflag =0, updatedby ='CDM-33569', updatedon = now()
where routingid ='0aed6226-f833-4f65-b28b-25986813ed63';