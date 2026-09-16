    /*
  Issue Description:  CDM-32498
   Category/ Module  :  Permanenancyplan-Routing
   Root cause: due to wrong securityuserid updates
   Pull request# for code fix: 
   Fix provided: Did data fix to update correct security id's
   */


--3dc5f025-9f68-4812-88e2-c7ef4fbde6c6 --from
--527e483b-5108-4906-b2bb-6fdbc317f03e --to

update cjams.routing set fromsecurityusersid ='d8d2196c-7b3b-434b-8160-1c6eb29eed6e', tosecurityusersid ='330d12cd-f428-41b9-b332-36e53fe5f16a', updatedby ='CDM-32498'
where routingid ='39b1e5b7-7936-4b99-a19b-71fcae635d0c';


--dc7166df-699d-4c20-a8a8-c8e00fb6866d--from
--2f784d3d-00a5-4798-9f36-fb5e0cb8d68b--to 

update cjams.routing set fromsecurityusersid ='d8d2196c-7b3b-434b-8160-1c6eb29eed6e', tosecurityusersid ='330d12cd-f428-41b9-b332-36e53fe5f16a', updatedby ='CDM-32498'
where routingid ='b32f74ee-a435-48df-876d-8e4748abe894';
