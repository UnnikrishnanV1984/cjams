/*
Issue Description:  CJAMS-62993
Category/Module: Remove the old intake (CW9786030) from the user dashboard
Root cause: User requested to promote the data fix to remove the old intake (CW9786030) from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-62993',
	updatedon = now()
where routingid = '9460f22d-8eda-46df-ae05-b72ee674fd43'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-62993', 
	updatedon = now() 
where intakenumber = 'CW9786030' and activeflag = 1;