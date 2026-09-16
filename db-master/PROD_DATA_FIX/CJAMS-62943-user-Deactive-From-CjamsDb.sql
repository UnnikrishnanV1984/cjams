/*
Issue:MFIRA checkbox not auto-selecting even though all children and alleged victim assessments are marked as “Satisfied.”
Root Cause:Known sailpoint issue and data fix needed to remove the workers that are already deactivated from user profile related tables.claire.murphy1@maryland.gov
Security monitor confirmed users are deactivated in production sailpoint
Fix Provided (Data Fix Only):Data fix has been promoted to Remove the user roles from cjams user profile related table
Data/Code fix ticket#: CJAMS-62943
Regression Impacts:None 
Is Code fix Required?:NO
Code fix ticket#: N/A
Reason why no related code fix:
Backup before update/delete:

*/
update rolemapping 
set roleid  ='36',updatedby  ='CJAMS-62943',updatedon  =now()
where id ='178988710' and activeflag =1;

update teammember  
set roletypekey  ='CWSP',updatedby  ='CJAMS-62943',updatedon  =now()
where teammemberid  ='51c2d438-2465-40fe-a3db-16f9e61b4629' and activeflag =1;