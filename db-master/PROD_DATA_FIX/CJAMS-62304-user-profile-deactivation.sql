/*
  Issue Description: CJAMS-62304 User inactive and data fix needed to deactivate  lashero.terry1@maryland.gov
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             lashero.terry1@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: lashero.terry1@maryland.gov
--securityuserid: 884562f5-b962-46f1-9b4b-92f334bdcfe1
-- id : 73611


update userprofile set activeflag = 0, updatedby = 'CJAMS-62304', updatedon = now() 
where securityusersid in ('884562f5-b962-46f1-9b4b-92f334bdcfe1') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-62304', updatedon = now() 
where securityusersid  in ('884562f5-b962-46f1-9b4b-92f334bdcfe1') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62304', updatedon=now()  
where securityusersid in ('884562f5-b962-46f1-9b4b-92f334bdcfe1') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62304', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('884562f5-b962-46f1-9b4b-92f334bdcfe1') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62304', updatedon=now() 
where securityusersid in('884562f5-b962-46f1-9b4b-92f334bdcfe1') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-62304', updatedon = now() 
where principalid in('73611') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-62304', updatedon = now() 
where userid in (73611) and activeflag = 1;