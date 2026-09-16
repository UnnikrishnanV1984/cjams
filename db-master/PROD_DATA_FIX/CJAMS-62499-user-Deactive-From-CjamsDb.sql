/*
  Issue Description: CJAMS-62499 Datafix required to deactivate below two user profiles in cjams db
                     kristina.hoffman@maryland.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.
             kristina.hoffman@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

update userprofile set activeflag = 0, updatedby = 'CJAMS-62499', updatedon = now() 
where securityusersid in ('2d4695d8-107d-45ad-a0fd-43c18bf4c627') and activeflag=1;

update muser set activeflag = 0, updatedby = 'CJAMS-62499', updatedon = now() 
where  securityusersid in ('2d4695d8-107d-45ad-a0fd-43c18bf4c627') and activeflag=1;

update cjams.securityusers set activeflag=0, updatedby='CJAMS-62499', updatedon=now()  
where securityusersid in ('2d4695d8-107d-45ad-a0fd-43c18bf4c627') and activeflag =1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62499', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('2d4695d8-107d-45ad-a0fd-43c18bf4c627') and activeflag=1) 
and activeflag = 1;

update teammember set activeflag = 0, updatedby = 'CJAMS-62499', updatedon = now()
where teammemberid in (select teammemberid from as_teammemberassignment where securityusersid in ('2d4695d8-107d-45ad-a0fd-43c18bf4c627') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62499', updatedon=now() 
where securityusersid in('2d4695d8-107d-45ad-a0fd-43c18bf4c627') and activeflag =1;

update cjams.as_teammemberassignment set activeflag=0, updatedby='CJAMS-62499', updatedon=now() 
where securityusersid in('2d4695d8-107d-45ad-a0fd-43c18bf4c627') and activeflag =1;

update rolemapping set activeflag = 0, updatedby = 'CJAMS-62499', updatedon = now() 
where principalid in('2784') and activeflag = 1;

--no records
--update userresource set activeflag = 0, updatedby = 'CJAMS-62499', updatedon = now() 
--where userid in ('2784') and activeflag = 1;