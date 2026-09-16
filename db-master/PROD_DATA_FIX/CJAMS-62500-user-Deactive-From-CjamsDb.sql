/*
  Issue Description: CJAMS-62500 Datafix required to deactivate below two user profiles in cjams db
                     kim.dudley@maryland.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             kim.dudley@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

update userprofile set activeflag = 0, updatedby = 'CJAMS-62500', updatedon = now() 
where securityusersid in ('283de272-cd7b-481e-9e28-78aa3683a5f8') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-62500', updatedon = now() 
where  securityusersid in ('283de272-cd7b-481e-9e28-78aa3683a5f8') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62500', updatedon=now()  
where securityusersid in ('283de272-cd7b-481e-9e28-78aa3683a5f8') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62500', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('283de272-cd7b-481e-9e28-78aa3683a5f8') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62500', updatedon=now() 
where securityusersid in('283de272-cd7b-481e-9e28-78aa3683a5f8') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-62500', updatedon = now() 
where principalid in('2789') and activeflag = 1;

--no records
--update userresource set activeflag = 0, updatedby = 'CJAMS-62500', updatedon = now() 
--where userid in ('2789') and activeflag = 1;