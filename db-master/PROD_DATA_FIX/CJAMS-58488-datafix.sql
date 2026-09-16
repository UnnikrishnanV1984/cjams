/*
   Issue Description: CJAMS-58488
   Category/ Module  : Placement
   Root cause:User request to deactivate only role and teamassignments for vicky.suero@montgomerycountymd.gov
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update teammemberassignment
set activeflag = '0', updatedby = 'CJAMS-58488', updatedon = now()
where securityusersid = '5e825b28-000f-4183-bdc4-f6ad2e5138bd' and activeflag = 1;


update rolemapping set activeflag = 0, updatedby = 'CJAMS-58488', updatedon = now() 
where principalid = '14805' and activeflag = 1;

update teammemberassignment
set activeflag = '0', updatedby = 'CJAMS-58488', updatedon = now()
where teammemberid = '7d090f91-fc0f-464e-a261-e3f06058dde0'  and activeflag = 1;