/*
  Issue Description: Please do a datafix to deactivate user role CJAMS_ASSUPERVISOR            
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.shana.matthews@maryland.gov
  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the user roles from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/


update teammember
set activeflag = 0, updatedby ='CJAMS-62509',updatedon =now()
where teammemberid ='48dcc326-bff2-4855-808a-79cec8ee29e6' and activeflag=1;

update teammemberassignment
set activeflag = 0, updatedby ='CJAMS-62509',updatedon =now()
where teammemberassignmentid ='ab479ff7-246b-4b13-be74-ec5ab510b5d5' and activeflag=1;

update rolemapping
set roleid='5253',teamtypekey ='ASPROV', updatedby ='CJAMS-62509',updatedon =now()
where id ='172725765' and activeflag=1;
