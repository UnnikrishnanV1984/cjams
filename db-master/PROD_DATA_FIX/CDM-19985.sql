 /*
  Issue Description: CDM-19985 - Child physical address after removal is blan;
   Category/ Module  :  child welfare
   Root cause: removed read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, updation of childphysicaladdressafterremoval field - provided address
   Backup before update/ delete:
*/

update intakeservreqchildremoval set childphysicaladdressafterremoval  = '3304 Oakfield Ave. Baltimore, MD 21207',
updatedon  = now, updatedby = 'CDM-19985' where  intakeservreqchildremovalid = 'bc2514a2-8d93-4e66-9353-337fb316eefc'
and activeflag  = 1;
