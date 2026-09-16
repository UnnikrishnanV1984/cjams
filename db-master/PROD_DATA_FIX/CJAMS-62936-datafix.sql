/*
Issue Description: CJAMS-62936  Case from 2018 randomly appearing
Category/Module: Case from 2018 randomly appearing
Root cause: User requested to promote the data fix to remove the old referral from the intake worker dashboard.
Datafix to remove case worker and make case management specialist as the primary role for the user
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-62936',
	updatedon = now()
where routingid = '1d0f9a8d-8940-44ad-9f32-3b898338c72b'
	and activeflag =1;

--'CW9319310','CW2507797' are in pending status
update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-62936', 
	updatedon = now() 
where intakenumber = 'CW10057105' and activeflag = 1;