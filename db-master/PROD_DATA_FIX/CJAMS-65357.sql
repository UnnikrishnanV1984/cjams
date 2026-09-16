/*
   Issue Description: CJAMS-65357
   Category/ Module  : Child Removal
   Root cause: Requested to remove approved child removal record.
   Fix provided: Data fix is done to remove the approved child removal record.
   Pull request# for code fix: 
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



UPDATE intakeservreqchildremoval 
SET activeflag = 0, 
updatedby = 'CJAMS-65357', 
updatedon = now() 
WHERE intakeservreqchildremovalid = 'd39825d6-beeb-4916-99f1-694da6a88392';

update intakeservreqchildremoval_history
set activeflag = 0,
updatedby = 'CJAMS-65357', 
updatedon = now() 
WHERE intakeservreqchildremovalid = 'd39825d6-beeb-4916-99f1-694da6a88392';

update routing 
set activeflag = 0,
updatedby = 'CJAMS-65357', 
updatedon = now() 
WHERE objectid = 'd39825d6-beeb-4916-99f1-694da6a88392';

update cjams.placement  
set intakeservreqchildremovalid = null, 
	updatedon = now(), 
	updatedby = 'CJAMS-65357'
where intakeservreqchildremovalid = 'd39825d6-beeb-4916-99f1-694da6a88392'
	and activeflag = 1 ;