/*
   Issue Description: CDM-32714
   Category/ Module  : Routing  
   Root cause: It's due to wrong securityuserid issue
   Fx Provided: Did data fix to remove that record 
*/

update cjams.routing set activeflag =0, updatedby ='CDM-32714', updatedon = now()
where routingid ='26c7b726-e5e9-4e47-ad8f-bc887a49a093';
