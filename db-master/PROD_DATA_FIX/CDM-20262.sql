 /*
  Issue Description: CDM-20262- duplicate removal of removal history
   Category/ Module  :  staff management
   Root cause: removed read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, removal of duplocate data
   Backup before update/ delete:
*/

update cjams.intakeservreqchildremoval  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20262'
where intakeservreqchildremovalid = 'f34046b7-c556-4fa6-9a4f-15b565f748d3'
	and activeflag = 1 ;

    update cjams.routing  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20262'
where routingid = 'd4d92240-eb44-4a1c-a6e1-9e7531164941'
	and activeflag = 1 ;
