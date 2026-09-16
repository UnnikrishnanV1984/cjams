/*
  Issue Description: CJAMS-60171 Datafix required to deactivate below two user profiles in cjams db
                     vanessa.santos@maryland.gov
                     heather.cibor@maryland.gov
                     Security monitor Lisa verified and confirmed the above profiles are deactivated in sailpoint
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             vanessa.santos@maryland.gov
             heather.cibor@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: vanessa.santos@maryland.gov
--securityuserid: 4ad79574-e913-49d4-9865-ea2c00be4eae
-- id : 66556

-- Email: heather.cibor@maryland.gov
--securityuserid:f1213069-3b83-4cf4-9731-1f81d3197006
-- id : 66589

update userprofile set activeflag = 0, updatedby = 'CJAMS-60171', updatedon = now() 
where securityusersid in ('4ad79574-e913-49d4-9865-ea2c00be4eae', 'f1213069-3b83-4cf4-9731-1f81d3197006') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-60171', updatedon = now() 
where securityusersid  in ('4ad79574-e913-49d4-9865-ea2c00be4eae', 'f1213069-3b83-4cf4-9731-1f81d3197006') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-60171', updatedon=now()  
where securityusersid in ('4ad79574-e913-49d4-9865-ea2c00be4eae', 'f1213069-3b83-4cf4-9731-1f81d3197006') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-60171', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('4ad79574-e913-49d4-9865-ea2c00be4eae', 'f1213069-3b83-4cf4-9731-1f81d3197006') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-60171', updatedon=now() 
where securityusersid in('4ad79574-e913-49d4-9865-ea2c00be4eae','f1213069-3b83-4cf4-9731-1f81d3197006') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-60171', updatedon = now() 
where principalid in('66556','66589') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-60171', updatedon = now() 
where userid in (66556, 66589) and activeflag = 1;
