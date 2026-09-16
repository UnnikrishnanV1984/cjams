/*
Issue Description: CJAMS-63231
Category/Module: Remove the old intake  from the user dashboard 
Root cause: User requested to promote the data fix to remove the old intake  CW10285055
 from the user dashboard
Fix provided: Data fix to remove the old referral CW10285055 from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63231',
	updatedon = now()
where routingid = '70012d97-a69b-4cb5-9c3e-30d5b5680ff9'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63231', 
	updatedon = now() 
where intakenumber = 'CW10285055' and activeflag = 1;