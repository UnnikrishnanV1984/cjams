/*
  Issue Description: CJAMS-59992 Remove Former staff in Unit drop down.
  Category/ Module : User Management
  Root cause:It is a Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             anna.wood@maryland.gov
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table.
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: anna.wood1@maryland.gov
--securityuserid: 1a098570-75dd-461e-ad5e-8083c3bc3b54
-- id : 28152

update userprofile set activeflag = 0, updatedby = 'CJAMS-59992', updatedon = now() 
where securityusersid in ('1a098570-75dd-461e-ad5e-8083c3bc3b54') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-59992', updatedon = now() 
where securityusersid  in ('1a098570-75dd-461e-ad5e-8083c3bc3b54') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-59992', updatedon=now()  
where securityusersid in ('1a098570-75dd-461e-ad5e-8083c3bc3b54') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-59992', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('1a098570-75dd-461e-ad5e-8083c3bc3b54') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-59992', updatedon=now() 
where securityusersid in('1a098570-75dd-461e-ad5e-8083c3bc3b54') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-59992', updatedon = now() 
where principalid in('28152') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-59992', updatedon = now() 
where userid in (28152) and activeflag = 1;