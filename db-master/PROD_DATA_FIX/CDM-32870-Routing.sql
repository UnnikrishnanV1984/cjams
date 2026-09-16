/*
   Issue Description: CDM-32870
   Category/ Module  :  Approval inbox 
   Root cause: due to securityuserid issue and multiclick functionality   
    Fix Provided: Did data fix to remove the extra approval record  
*/


update cjams.routing set activeflag =0, updatedby ='CDM-32870', updatedon = now()
where routingid ='450d9c86-97c3-4f99-9948-87645413b157';
