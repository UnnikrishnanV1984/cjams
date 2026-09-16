

/*
  Issue Description: CJAMS-61681 Datafix required to deactivate below two user profiles in cjams db
                     tiffany.cunningham@montgomerycountymd.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             tiffany.cunningham@montgomerycountymd.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: tiffany.cunningham@montgomerycountymd.gov
--securityuserid: 78c01c99-0581-46be-94c5-641833db28a4
-- id : 160240779


update userprofile set activeflag = 0, updatedby = 'CJAMS-61681', updatedon = now() 
where securityusersid in ('78c01c99-0581-46be-94c5-641833db28a4') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-61681', updatedon = now() 
where securityusersid  in ('78c01c99-0581-46be-94c5-641833db28a4') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-61681', updatedon=now()  
where securityusersid in ('78c01c99-0581-46be-94c5-641833db28a4') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-61681', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('78c01c99-0581-46be-94c5-641833db28a4') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-61681', updatedon=now() 
where securityusersid in('78c01c99-0581-46be-94c5-641833db28a4') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-61681', updatedon = now() 
where id in('160240779') and activeflag = 1;

--no records
--update userresource set activeflag = 0, updatedby = 'CJAMS-61681', updatedon = now() 
--where userid in ('160240779') and activeflag = 1;