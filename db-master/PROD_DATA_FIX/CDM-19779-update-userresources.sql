/*
  Issue Description: CDM-19779 Cannot see the intake screen
   Category/ Module  :  user management
   Root cause: User is having Intake_noaccess permission in userresource
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 0
*/
-- email:'pierre.verleysen@maryland.gov'
-- id : 2932
-- permission group to be activated : ba33236e-83fa-4a36-b994-0298c0aa9322 Intake_noaccess

update userresource u2 set activeflag = 0,updatedby ='CDM-19779',updatedon =now()
where userid = 2932
and permissiongroupid = 'ba33236e-83fa-4a36-b994-0298c0aa9322'
and activeflag =1;