/*
  Issue Description: As per sailpoint user has DHS_CJAMS_AS_PROV_RESOURCE_WORKER, DHS_CJAMS_ASCASEWORKER.Please deactivate the user role CWCASEWORKER and update the roletypekey in teammember as ASPROVRW              
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.kim.farmer@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user roles from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/


update teammember
set activeflag = 0, updatedby ='CJAMS-62508',updatedon =now()
where teammemberid ='185f4a0e-8011-42dc-afa9-8ee44c6ded56' and activeflag=1;


update teammemberassignment
set activeflag = 0, updatedby ='CJAMS-62508',updatedon =now()
where teammemberassignmentid ='3ce7f86d-1b12-409d-8c82-4b510a1fdbc0' and activeflag=1;

update rolemapping
set activeflag=0, updatedby ='CJAMS-62508',updatedon =now()
where id ='163609' and activeflag=1;