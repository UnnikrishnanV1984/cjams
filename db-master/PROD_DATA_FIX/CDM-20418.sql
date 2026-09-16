 /*
  Issue Description: CDM-20418 - Removal End Reason Not Entered
   Category/ Module  :  child welfare
   Root cause: removed read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, added reason in removal end readon field
   Backup before update/ delete:
*/

update intakeservreqchildremoval set removalexitreason  = 'CGUARDNR',
updatedon  = now() ,
updatedby  = 'CDM-20418'
where intakeservreqchildremovalid = '89f71092-2b4d-44c4-83a0-a359c7ddd328'
and activeflag  = 1;