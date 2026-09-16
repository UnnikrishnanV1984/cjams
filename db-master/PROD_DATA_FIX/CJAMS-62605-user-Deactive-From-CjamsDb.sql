/*
  Issue Description: Please fix roletypekey in teammember table as CWCW      
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.heather.chorney@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user roles from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/


update teammember
set roletypekey = 'CWCW', updatedby ='CJAMS-62605',updatedon =now()
where teammemberid ='7390455d-c6af-4d0e-bf21-fbaba4a80c76' and activeflag=1;
