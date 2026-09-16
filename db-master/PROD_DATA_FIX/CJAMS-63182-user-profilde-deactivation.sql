/*
  Issue Description: CJAMS-63812 User inactive and data fix needed to deactivate  lashero.terry1@maryland.gov
  Category/ Module : User Management
  Root cause:It is a Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             (Please do a datafix to deactivate the user tiera.gailliard-mcafee1@maryland.gov in cjams db)
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user tiera.gailliard-mcafee1@maryland.gov  from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: tiera.gailliard-mcafee1@maryland.gov
--securityuserid: 1a334734-d1e0-476a-8fd2-aa4ad9cf37fb
-- id : 13511


update userprofile set activeflag = 0, updatedby = 'CJAMS-63812', updatedon = now() 
where securityusersid in ('1a334734-d1e0-476a-8fd2-aa4ad9cf37fb') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-63812', updatedon = now() 
where securityusersid  in ('1a334734-d1e0-476a-8fd2-aa4ad9cf37fb') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-63812', updatedon=now()  
where securityusersid in ('1a334734-d1e0-476a-8fd2-aa4ad9cf37fb') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-63812', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('1a334734-d1e0-476a-8fd2-aa4ad9cf37fb') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-63812', updatedon=now() 
where securityusersid in('1a334734-d1e0-476a-8fd2-aa4ad9cf37fb') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-63812', updatedon = now() 
where principalid in('4870') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-63812', updatedon = now() 
where userid in (4870) and activeflag = 1;