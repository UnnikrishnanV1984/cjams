 /*
  Issue Description: CDM-17440 - Issue adding contact note
   Category/ Module  :  staff management
   Root cause: read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

 update userresource set activeflag=0, updatedby='CDM-17440', updatedon= now() where userid=9643 
 and permissiongroupid='9f0a99a4-08ae-43ee-ba78-cb8e52a818da' and activeflag=1;