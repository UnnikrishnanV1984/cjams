/*
  Issue Description: CJAMS-61482 d:Melodi Lewis and Mariah Stokes were both removed/deleted as users through Sail Point, however they are still listed as workers under CPS 3. Please removed them.
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             mariah.stokes@maryland.gov
             melodi.lewis@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: mariah.stokes@maryland.gov
--securityuserid: fe8f1b2a-a867-4284-a617-f7bd1be41322
-- id : 65325

-- Email: melodi.lewis@maryland.gov
--securityuserid: 6eb16da7-bde6-4720-b8bd-1df868be8784
-- id : 51514


update userprofile set activeflag = 0, updatedby = 'CJAMS-61482', updatedon = now() 
where securityusersid in ('fe8f1b2a-a867-4284-a617-f7bd1be41322', '6eb16da7-bde6-4720-b8bd-1df868be8784') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-61482', updatedon = now() 
where securityusersid  in ('fe8f1b2a-a867-4284-a617-f7bd1be41322', '6eb16da7-bde6-4720-b8bd-1df868be8784') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-61482', updatedon=now()  
where securityusersid in ('fe8f1b2a-a867-4284-a617-f7bd1be41322', '6eb16da7-bde6-4720-b8bd-1df868be8784') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-61482', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('fe8f1b2a-a867-4284-a617-f7bd1be41322', '6eb16da7-bde6-4720-b8bd-1df868be8784') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-61482', updatedon=now() 
where securityusersid in('fe8f1b2a-a867-4284-a617-f7bd1be41322','6eb16da7-bde6-4720-b8bd-1df868be8784') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-61482', updatedon = now() 
where principalid in('65325','51514') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-61482', updatedon = now() 
where userid in (65325, 51514) and activeflag = 1;

