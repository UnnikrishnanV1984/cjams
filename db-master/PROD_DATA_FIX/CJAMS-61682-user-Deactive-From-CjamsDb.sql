

/*
  Issue Description: CJAMS-61682 Datafix required to deactivate below two user profiles in cjams db
                     agatha.chukwuezi@montgomerycountymd.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             agatha.chukwuezi@montgomerycountymd.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: agatha.chukwuezi@montgomerycountymd.gov
--securityuserid: c771366f-c929-4596-b2af-7825eb1a499c
-- id : 171924848


update userprofile set activeflag = 0, updatedby = 'CJAMS-61682', updatedon = now() 
where securityusersid in ('c771366f-c929-4596-b2af-7825eb1a499c') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-61682', updatedon = now() 
where securityusersid  in ('c771366f-c929-4596-b2af-7825eb1a499c') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-61682', updatedon=now()  
where securityusersid in ('c771366f-c929-4596-b2af-7825eb1a499c') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-61682', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('c771366f-c929-4596-b2af-7825eb1a499c') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-61682', updatedon=now() 
where securityusersid in('c771366f-c929-4596-b2af-7825eb1a499c') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-61682', updatedon = now() 
where id in('171924848') and activeflag = 1;

--no records
--update userresource set activeflag = 0, updatedby = 'CJAMS-61682', updatedon = now() 
--where userid in ('6512616') and activeflag = 1;