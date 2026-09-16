/*
  Issue Description: CJAMS-62941 Datafix required to deactivate below two user profiles in cjams db brandy.guy@maryland.gov                  
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables. brandy.guy@maryland.gov Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/

update teammember set activeflag = 0, updatedby = 'CJAMS-62941', updatedon = now()
where teammemberid in (select teammemberid from teammemberassignment where securityusersid in ('33cf10bf-6ab6-4efe-84fb-3535833a78ea') and activeflag=1) 
and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CJAMS-62941', updatedon=now() 
where securityusersid in('33cf10bf-6ab6-4efe-84fb-3535833a78ea') and activeflag =1;

update rolemapping  set activeflag=0, updatedby='CJAMS-62941', updatedon=now() 
where id  in('107772545') and activeflag =1;


update userresource  set activeflag=0, updatedby='CJAMS-62941', updatedon=now() 
where userresourceid  in('017df653-4dcf-48fb-a573-0cf4ecaec84c','4b0910be-a318-4734-8ca2-8145dec88ae3','d3827732-e63d-405e-8e79-8fe7262b2a9e') and activeflag =1;



