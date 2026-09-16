/*
  Issue Description: Please remove all "Green Team" units in CJAMS please.            
  Category/ Module : User Management
  Root cause:Known sailpoint issue and data fix needed to  deactivate below teams from userprofile.  Security monitor confirmed users are deactivated in production sailpoint
  Fix Provided: Data fix has been promoted to Remove the teams from cjams user profile related table
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: It's a known sailpoint issue.
*/
update  team  
set activeflag =0, updatedby ='CJAMS-62507', updatedon =now()
where teamnumber in ('1448_28',
'1448_33',
'1448_31',
'1448_32',
'1448_30') and activeflag =1;