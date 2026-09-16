/*
Issue Description: CJAMS-62999
Category/Module: Remove the old intake  from the user dashboard CW9137754
Root cause: User requested to promote the data fix to remove the old intake  CW9137754
 from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-62999',
	updatedon = now()
where routingid = 'fb343656-4a40-4eb0-9d35-522712638fef'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-62999', 
	updatedon = now() 
where intakenumber = 'CW9137754' and activeflag = 1;