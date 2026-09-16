/*
  Issue Description: CDM-21316 Approvals over $1000
   Category/ Module  :  user management
   Root cause: finance read only access permission is active in userresource table
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
-- email:'christine.abbatiello@maryland.gov'
-- id : 9912
-- permissiongroupid : c0a323eb-9bfa-4cba-ab61-620f56ca1d0c	finance_read_only_access


update userresource set activeflag = 0,updatedby = 'CDM-21316' , updatedon = now() where userid=9912 and activeflag=1 and permissiongroupid='c0a323eb-9bfa-4cba-ab61-620f56ca1d0c';

