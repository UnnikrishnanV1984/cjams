 /*
  Issue Description: CDM-27989 Incorrect MD THINK System alerts forCJAMS
   Category/ Module  :  user
   Root cause: wrongly added role has been removed
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

select * from userresource where userid='11963' and activeflag=1
and permissiongroupid = '9a29e0be-1506-4b30-a2c3-8b4ac0c8a1e0';


update userresource set activeflag=0, updatedby='CDM-27989', updatedon=now() where userid='11963' and activeflag=1
and permissiongroupid = '9a29e0be-1506-4b30-a2c3-8b4ac0c8a1e0';