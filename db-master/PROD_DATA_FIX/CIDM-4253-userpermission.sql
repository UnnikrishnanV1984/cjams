 /*
  Issue Description: CIDM-4253 Role issue
   Category/ Module  :  Staff Management
   Root cause: Removing read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update userresource set activeflag=0, updatedby='CIDM-4253', updatedon=now() where userid=10070 and permissiongroupid='9f0a99a4-08ae-43ee-ba78-cb8e52a818da'
and activeflag=1;