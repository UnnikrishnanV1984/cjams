
/*
  Issue Description: CJAMS-61680 Datafix required to deactivate below two user profiles in cjams db
                     idania.hernandez@montgomerycountymd.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             idania.hernandez@montgomerycountymd.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

-- Email: idania.hernandez@montgomerycountymd.gov
--securityuserid: 76038e22-8708-44fe-b59e-1c9b747f66ed
-- id : 6512616


update userprofile set activeflag = 0, updatedby = 'CJAMS-61680', updatedon = now() 
where securityusersid in ('76038e22-8708-44fe-b59e-1c9b747f66ed') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-61680', updatedon = now() 
where securityusersid  in ('76038e22-8708-44fe-b59e-1c9b747f66ed') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-61680', updatedon=now()  
where securityusersid in ('76038e22-8708-44fe-b59e-1c9b747f66ed') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-61680', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('76038e22-8708-44fe-b59e-1c9b747f66ed') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-61680', updatedon=now() 
where securityusersid in('76038e22-8708-44fe-b59e-1c9b747f66ed') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-61680', updatedon = now() 
where id in('6512616') and activeflag = 1;

--no records
--update userresource set activeflag = 0, updatedby = 'CJAMS-61680', updatedon = now() 
--where userid in ('6512616') and activeflag = 1;