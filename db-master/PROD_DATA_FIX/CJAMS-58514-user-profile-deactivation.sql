/*
  Issue Description: CJAMS-58514 Remove Workers who are no longer under Lisa Naumann/working for the agency.
  Category/ Module : User Management
  Root cause:It is a Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             sunnaye.rodgers@montgomerycountymd.gov
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: sunnaye.rodgers@montgomerycountymd.gov
--securityuserid: 8e047c29-46ec-42a8-b7ea-2c082d16f9d5
-- id : 11979

update userprofile set activeflag = 0, updatedby = 'CJAMS-58514', updatedon = now() 
where securityusersid in ('8e047c29-46ec-42a8-b7ea-2c082d16f9d5') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-58514', updatedon = now() 
where securityusersid  in ('8e047c29-46ec-42a8-b7ea-2c082d16f9d5') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-58514', updatedon=now()  
where securityusersid in ('8e047c29-46ec-42a8-b7ea-2c082d16f9d5') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-58514', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('8e047c29-46ec-42a8-b7ea-2c082d16f9d5') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-58514', updatedon=now() 
where securityusersid in('8e047c29-46ec-42a8-b7ea-2c082d16f9d5') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-58514', updatedon = now() 
where principalid in('11979') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-58514', updatedon = now() 
where userid in (11979) and activeflag = 1;