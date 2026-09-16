 /*
  Issue Description: CDM-20258 - removal of record from removal history
   Category/ Module  :  child welfare
   Root cause: removed read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, removal of unneccesary record
   Backup before update/ delete:
*/

update cjams.intakeservreqchildremoval  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20258'
where intakeservreqchildremovalid = '67d43d15-2673-4b80-a1b4-2b566860da0d'
	and activeflag = 1 ;

update cjams.routing  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20258'
where routingid = 'ad9c4055-20fb-4703-a551-0125802a0d85'
	and activeflag = 1 ;