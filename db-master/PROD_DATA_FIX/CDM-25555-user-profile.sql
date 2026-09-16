 /*
   Issue Description: CDM-25555 - Lost editing rights
   Category/ Module  :  User management
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update cjams.userresource set activeflag=0, updatedby='CDM-25555', updatedon=now() where userid=3298 and activeflag=1
and permissiongroupid in (
'fb335234-73b2-4d01-92ee-6b33cdf6fbd6',
'9f0a99a4-08ae-43ee-ba78-cb8e52a818da'
);