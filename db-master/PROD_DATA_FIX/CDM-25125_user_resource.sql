 /*
  Issue Description: CDM-25125 only view access for IV-E cases
   Category/ Module  :  User management issue
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update userresource set activeflag=0, updatedby='CDM-25125', updatedon=now() 
where userid in (3295,3294) and activeflag=1
and permissiongroupid in ('9f0a99a4-08ae-43ee-ba78-cb8e52a818da','fb335234-73b2-4d01-92ee-6b33cdf6fbd6');