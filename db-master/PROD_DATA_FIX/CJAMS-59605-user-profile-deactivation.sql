/*
  Issue Description: CJAMS-59605 Remove Workers who are no longer under Lisa Naumann/working for the agency.
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             ashanti.allenwilliams@maryland.gov
             brittany.jordan@maryland.gov
             sierra.turner@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: ashanti.allenwilliams@maryland.gov
--securityuserid: 369b803f-90c3-4912-9db0-29cbaa221d81
-- id : 35077

-- Email: brittany.jordan@maryland.gov
--securityuserid: 24413624-3df0-4d1d-9622-07f849f05575
-- id : 11920

-- Email: sierra.turner@maryland.gov
--securityuserid: 73eff6cf-3548-4f78-b3e5-f81376561dc5
-- id : 7349

update userprofile set activeflag = 0, updatedby = 'CJAMS-59605', updatedon = now() 
where securityusersid in ('369b803f-90c3-4912-9db0-29cbaa221d81', '24413624-3df0-4d1d-9622-07f849f05575', '73eff6cf-3548-4f78-b3e5-f81376561dc5') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-59605', updatedon = now() 
where securityusersid  in ('369b803f-90c3-4912-9db0-29cbaa221d81', '24413624-3df0-4d1d-9622-07f849f05575', '73eff6cf-3548-4f78-b3e5-f81376561dc5') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-59605', updatedon=now()  
where securityusersid in ('369b803f-90c3-4912-9db0-29cbaa221d81', '24413624-3df0-4d1d-9622-07f849f05575', '73eff6cf-3548-4f78-b3e5-f81376561dc5') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-59605', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('369b803f-90c3-4912-9db0-29cbaa221d81', '24413624-3df0-4d1d-9622-07f849f05575', '73eff6cf-3548-4f78-b3e5-f81376561dc5') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-59605', updatedon=now() 
where securityusersid in('369b803f-90c3-4912-9db0-29cbaa221d81','24413624-3df0-4d1d-9622-07f849f05575', '73eff6cf-3548-4f78-b3e5-f81376561dc5') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-59605', updatedon = now() 
where principalid in('35077','11920', '7349') and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-59605', updatedon = now() 
where userid in (35077, 11920, 7349) and activeflag = 1;

