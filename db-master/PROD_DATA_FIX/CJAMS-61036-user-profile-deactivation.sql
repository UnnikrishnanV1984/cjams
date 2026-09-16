/*
  Issue Description: CJAMS-61036 inactive user still showing in workload drop down.
  Category/ Module : User Management
  Root cause:It is Known sailpoint issue and data fix needed to remove the workers that are already deactivated in sailpoint from user profile related tables.
              mary.peyton@montgomerycountymd.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: mary.peyton@montgomerycountymd.gov
--securityuserid: 8d5ebaa4-5518-4408-822a-e7998fec3989
-- id : 4726

update userprofile set activeflag = 0, updatedby = 'CJAMS-61036', updatedon = now() 
where securityusersid in ('8d5ebaa4-5518-4408-822a-e7998fec3989') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-61036', updatedon = now() 
where securityusersid  in ('8d5ebaa4-5518-4408-822a-e7998fec3989') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-61036', updatedon=now()  
where securityusersid in ('8d5ebaa4-5518-4408-822a-e7998fec3989') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-61036', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('8d5ebaa4-5518-4408-822a-e7998fec3989') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-61036', updatedon=now() 
where securityusersid in('8d5ebaa4-5518-4408-822a-e7998fec3989') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-61036', updatedon = now() 
where principalid in('4726') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-61036', updatedon = now() 
where userid in (4726) and activeflag = 1;