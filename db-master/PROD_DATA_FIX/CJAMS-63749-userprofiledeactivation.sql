/*
  Issue Description: CJAMS-63749 User inactive and data fix needed to deactivate  lashero.terry1@maryland.gov
  Category/ Module : User Management
  Root cause:It is a Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             (Erin Lewis)
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/
-- user name:Erin Lewis
-- Email: erin.lewis@maryland.gov
--securityuserid: 31522727-d57a-4001-8f63-1e175548b20a
-- id : 13511


update userprofile set activeflag = 0, updatedby = 'CJAMS-63749', updatedon = now() 
where securityusersid in ('31522727-d57a-4001-8f63-1e175548b20a') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-63749', updatedon = now() 
where securityusersid  in ('31522727-d57a-4001-8f63-1e175548b20a') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-63749', updatedon=now()  
where securityusersid in ('31522727-d57a-4001-8f63-1e175548b20a') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-63749', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('31522727-d57a-4001-8f63-1e175548b20a') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-63749', updatedon=now() 
where securityusersid in('31522727-d57a-4001-8f63-1e175548b20a') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-63749', updatedon = now() 
where principalid in('13511') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-63749', updatedon = now() 
where userid in (13511) and activeflag = 1;