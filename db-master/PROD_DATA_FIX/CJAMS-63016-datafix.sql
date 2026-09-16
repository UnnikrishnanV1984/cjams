/*
Issue Description: CJAMS-63016
Category/Module: Remove the old intake (CW9457423 ) from the user dashboard
Root cause: User requested to promote the data fix to remove the old intake (CW9457423 ) from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63016',
	updatedon = now()
where routingid = 'e8dda3f0-99a2-4573-8cad-412f2d59bfe7'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63016', 
	updatedon = now() 
where intakenumber = 'CW9457423' and activeflag = 1;