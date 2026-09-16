/*
   Issue Description: CDM-17434
   Category/ Module  : User Permissions   
   Root cause: redirected to home dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
 
update cjams.userresource set activeflag = 0, updatedon = now(), updatedby = 'CDM-17434' 
where userid=12769 and activeflag = 1
and permissiongroupid='e9dc6a81-ba1f-4a37-874e-8221d732e71f';
     