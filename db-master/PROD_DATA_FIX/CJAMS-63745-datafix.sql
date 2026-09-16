/*
Issue Description: CJAMS-63745
Category/Module: Intake did not case connect
Root cause: User requested to data fix to revert the approval of the intake: I251013461306 and 
put it back to the supervisor for approval.
Fix provided: Data fix todata fix to revert the approval of the intake: I251013461306 
and put it back to the supervisor for approval.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update routing
set routingstatustypeid  = 1,
supervisordecision = null,
updatedon = now()
where objectid = 'I251013461306';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CJAMS-63745'
where intakenumber = 'I251013461306' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CJAMS-63745'
where intakenumber = 'I251013461306' and activeflag = 1;

update intakeservicerequest
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-63745'				
where intakenumber = 'I251013461306';

update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-63745'
where intakesnapshotid= '4bff3f7b-8792-489a-85c7-648eab708107'
and activeflag = 1;
