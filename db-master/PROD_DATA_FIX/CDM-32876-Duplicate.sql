/*
   Issue Description: CDM-32876
   Category/ Module  :  Approval inbox 
   Root cause: due to securityuserid issue and multiclick functionality   
    Fix Provided: Did data fix to remove the extra approval record  
*/

update cjams.routing set activeflag =0, updatedby ='CDM-32876', updatedon = now()
where routingid ='f1fbed31-821c-4f52-a093-1399e934dd46';