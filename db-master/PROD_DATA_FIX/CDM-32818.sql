
/*
   Issue Description: CDM-32818'
   Category/ Module  : Permanencyplan 
   Root cause: update the wrong caseworker name due to securityuserid issue
   Fix Provided: Did data fix to update the correct users info
   
   --For this defect code fix is already done golbally --CIDM-7347 
*/


update cjams.permanencyplanhistory set insertedby ='ade669f5-2e8b-4c96-bb95-8dab3867d8e3', updatedby ='CDM-32818',updatedon = now()
where permanencyplanhistoryid ='856a6e50-ebe6-418b-bf8f-f83349e68e5c';

update cjams.routing set fromsecurityusersid ='ade669f5-2e8b-4c96-bb95-8dab3867d8e3', tosecurityusersid ='eba740d3-c238-4497-a660-3b7b09e12922', updatedby ='CDM-32818',updatedon = now()
where routingid ='ec9a4027-2abd-452e-a069-8f9caea887d6';