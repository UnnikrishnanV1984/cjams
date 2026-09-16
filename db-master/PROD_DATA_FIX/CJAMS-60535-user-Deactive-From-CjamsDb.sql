/*
  Issue Description: CJAMS-60535 Datafix required to deactivate below two user profiles in cjams db
                     kayla.newton1@maryland.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             kayla.newton1@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: kayla.newton1@maryland.gov
--securityuserid: 7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1
-- id : 128927530


update userprofile set activeflag = 0, updatedby = 'CJAMS-60535', updatedon = now() 
where securityusersid in ('7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-60535', updatedon = now() 
where securityusersid  in ('7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-60535', updatedon=now()  
where securityusersid in ('7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-60535', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-60535', updatedon=now() 
where securityusersid in('7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-60535', updatedon = now() 
where id in('128927530') and activeflag = 1;

--no records
--update userresource set activeflag = 0, updatedby = 'CJAMS-60535', updatedon = now() 
--where userid in ('128927530') and activeflag = 1;