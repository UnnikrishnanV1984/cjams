/*   Issue Description: CDM-14697 Supervisor Dashboard
   Category/ Module  :  RBAC
   Root cause: User asked to do it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   */
update userresource set activeflag=0, updatedby='CDM-14697', updatedon=now() where userid in (3292,3308,3306,3309,3298) and activeflag=1
and permissiongroupid in ('fb335234-73b2-4d01-92ee-6b33cdf6fbd6','9f0a99a4-08ae-43ee-ba78-cb8e52a818da');