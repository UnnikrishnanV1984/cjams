/*
Issue Description: CJAMS-63014
Category/Module: Report from 2016 is showing on my dashboard
Root cause: User requested to promote the data fix to remove the old referral CW9738776 from the intake worker dashboard.
Fix provided: Data fix to remove the old referral CW9738776 from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/


update routing
set activeflag = 0,
	updatedby = 'CJAMS-63014',
	updatedon = now()
where routingid = 'd4b8f513-3303-4c3b-aa2d-d96fcd8ca760'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63014', 
	updatedon = now() 
where intakenumber = 'CW10051936' and activeflag = 1;