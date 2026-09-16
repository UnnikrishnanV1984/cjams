/*
   Issue Description: CJAMS-67362
   Category/ Module  : Child Removal
   Root cause: Requested to remove Draft child removal record.
   Fix provided: Data fix is done to remove the draft child removal record.
   Pull request# for code fix: 
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE intakeservreqchildremoval 
SET activeflag = 0, 
updatedby = 'CJAMS-67362', 
updatedon = now() 
WHERE intakeservreqchildremovalid = '40532cda-cb78-484a-9ee6-f17c47cc9c8d';

update intakeservreqchildremoval_history
set activeflag = 0,
updatedby = 'CJAMS-67362', 
updatedon = now() 
WHERE intakeservreqchildremovalid = '40532cda-cb78-484a-9ee6-f17c47cc9c8d';

update cjams.placement  
set intakeservreqchildremovalid = null, 
	updatedon = now(), 
	updatedby = 'CJAMS-67362'
where intakeservreqchildremovalid = '40532cda-cb78-484a-9ee6-f17c47cc9c8d'
	and activeflag = 1;