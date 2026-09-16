
/*
  Issue Description: CJAMS-62214 Datafix required to deactivate below two user profiles in cjams db
                     jocelyn.tillman2@maryland.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             jocelyn.tillman2@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: jocelyn.tillman2@maryland.gov
--securityuserid: e3f8e690-40b6-4a2c-a230-318661c3e221
-- id : 176558546


update userprofile set activeflag = 0, updatedby = 'CJAMS-62214', updatedon = now() 
where securityusersid in ('e3f8e690-40b6-4a2c-a230-318661c3e221') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-62214', updatedon = now() 
where securityusersid  in ('e3f8e690-40b6-4a2c-a230-318661c3e221') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62214', updatedon=now()  
where securityusersid in ('e3f8e690-40b6-4a2c-a230-318661c3e221') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62214', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('e3f8e690-40b6-4a2c-a230-318661c3e221') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62214', updatedon=now() 
where securityusersid in('e3f8e690-40b6-4a2c-a230-318661c3e221') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-62214', updatedon = now() 
where id in('176558546') and activeflag = 1;

--no records
--update userresource set activeflag = 0, updatedby = 'CJAMS-62214', updatedon = now() 
--where userid in ('74010') and activeflag = 1;