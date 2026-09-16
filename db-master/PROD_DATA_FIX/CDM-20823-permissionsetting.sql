 /*
  Issue Description: CDM-20823 CJAMS - unable to enter new contacts into CJAMS: MIchele Keller
   Category/ Module  :  user management
   Root cause: Removed the readonly access
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update userresource set activeflag=0, updatedby='CDM-20823', updatedon=now() where userid=9656 
and activeflag=1 and permissiongroupid='9f0a99a4-08ae-43ee-ba78-cb8e52a818da';