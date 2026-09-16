/*
Issue Description: CJAMS-62991
Category/Module: Remove the old intake (CW10117994) from the user dashboard
Root cause: User requested to promote the data fix to remove the old intake (CW10117994) from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-62991',
	updatedon = now()
where routingid = '761f7a1e-4434-4fad-aaf8-1650b759d56f'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-62991', 
	updatedon = now() 
where intakenumber = 'CW10117994' and activeflag = 1;