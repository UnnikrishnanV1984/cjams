/*
  Issue Description: CJAMS-61351 Elizabeth Medina is removed/deleted as users through Sail Point, however they are still listed in OHP unit 2.
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             elizabeth.medina1@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: elizabeth.medina1@maryland.gov
--securityuserid: 06b4c650-1246-463f-b3b4-2922b85c290e
-- id : 27056

update userprofile set activeflag = 0, updatedby = 'CJAMS-61351', updatedon = now() 
where securityusersid in ('06b4c650-1246-463f-b3b4-2922b85c290e') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-61351', updatedon = now() 
where securityusersid  in ('06b4c650-1246-463f-b3b4-2922b85c290e') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-61351', updatedon=now()  
where securityusersid in ('06b4c650-1246-463f-b3b4-2922b85c290e') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-61351', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('06b4c650-1246-463f-b3b4-2922b85c290e') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-61351', updatedon=now() 
where securityusersid in('06b4c650-1246-463f-b3b4-2922b85c290e') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-61351', updatedon = now() 
where principalid in('27056') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-61351', updatedon = now() 
where userid in (27056) and activeflag = 1;