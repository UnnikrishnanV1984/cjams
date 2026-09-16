/*
  Issue Description: CDM-21687 Sailpoint Role Conflict
   Category/ Module  :  user management
   Root cause: Updated user resource to deactivate the CWCENTRALPOLICY 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
-- email:'michele.keller@maryland.gov'
-- id : 9656
-- roleid : 3150

update userresource set activeflag = 0,updatedby='CDM-21687',updatedon= now() where userid = 9656 and roleid=3150 and activeflag = 1;