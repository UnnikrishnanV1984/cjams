
/*
  Issue Description: CJAMS-62254 Datafix required to deactivate below two user profiles in cjams db
                     charles.lanham@maryland.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             charles.lanham@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: charles.lanham@maryland.gov
--securityuserid: 935f6c4b-05a3-4e7d-a29a-6b9b11a0fcd5
-- id : 141525238


update userprofile set activeflag = 0, updatedby = 'CJAMS-62254', updatedon = now() 
where securityusersid in ('935f6c4b-05a3-4e7d-a29a-6b9b11a0fcd5') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-62254', updatedon = now() 
where securityusersid  in ('935f6c4b-05a3-4e7d-a29a-6b9b11a0fcd5') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62254', updatedon=now()  
where securityusersid in ('935f6c4b-05a3-4e7d-a29a-6b9b11a0fcd5') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62254', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('935f6c4b-05a3-4e7d-a29a-6b9b11a0fcd5') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62254', updatedon=now() 
where securityusersid in('935f6c4b-05a3-4e7d-a29a-6b9b11a0fcd5') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-62254', updatedon = now() 
where id in('141525238') and activeflag = 1;

--no records
update userresource set activeflag = 0, updatedby = 'CJAMS-62254', updatedon = now() 
where userid in ('4033') and activeflag = 1;