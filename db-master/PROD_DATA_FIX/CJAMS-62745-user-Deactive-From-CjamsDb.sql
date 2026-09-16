/*
  Issue Description: CJAMS-62745 Datafix required to deactivate below two user profiles in cjams db yanni.sturdivant@maryland.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables. yanni.sturdivant@maryland.gov Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/




update userprofile set activeflag = 0, updatedby = 'CJAMS-62745', updatedon = now() 
where securityusersid in ('09551377-c5b6-49fb-83e9-38fe2842f87b') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-62745', updatedon = now() 
where securityusersid  in ('09551377-c5b6-49fb-83e9-38fe2842f87b') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62745', updatedon=now()  
where securityusersid in ('09551377-c5b6-49fb-83e9-38fe2842f87b') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62745', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('09551377-c5b6-49fb-83e9-38fe2842f87b') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62745', updatedon=now() 
where securityusersid in('09551377-c5b6-49fb-83e9-38fe2842f87b') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-62745', updatedon = now() 
where id in('161028958') and activeflag = 1;

--no records
--update userresource set activeflag = 1, updatedby = 'CJAMS-62745', updatedon = now() 
--where userid in ('6512616') and activeflag = 1;

--select * from cjams.as_teammemberassignment at2  
--where securityusersid in('09551377-c5b6-49fb-83e9-38fe2842f87b') and activeflag =1;
--
--select * from teammember 
--where teammemberid in (select teammemberid from as_teammemberassignment at2  
--where securityusersid in('09551377-c5b6-49fb-83e9-38fe2842f87b') and activeflag =1) 
--and activeflag = 1;