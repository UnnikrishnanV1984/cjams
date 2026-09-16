 /*
  Issue Description: CDM-19213 - Supervisor not able to assign cases or submit support ticket
   Category/ Module  :  staff management
   Root cause: removed read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update userresource set activeflag=0, updatedby='CDM-19213', updatedon=now() where userid=3227 and activeflag=1
and permissiongroupid='9f0a99a4-08ae-43ee-ba78-cb8e52a818da';