/*   Issue Description:CDM-16225 Unable to Edit in CJAMS
   Category/ Module  :  RBAC
   Root cause: User asked to do it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   */
update userresource set activeflag=0, updatedby='CDM-16225', updatedon=now() where userid in (3293) and activeflag=1
and permissiongroupid in ('9f0a99a4-08ae-43ee-ba78-cb8e52a818da');