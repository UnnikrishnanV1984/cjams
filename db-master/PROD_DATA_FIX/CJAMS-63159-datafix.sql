/*
Issue Description: CJAMS-63159
Category/Module: Remove the old intake  from the user dashboard CW9556364
Root cause: User requested to promote the data fix to remove the old intake  CW9556364
 from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63159',
	updatedon = now()
where routingid = '7b0cf9df-697c-4070-a60f-f22604943432'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63159', 
	updatedon = now() 
where intakenumber = 'CW9556364' and activeflag = 1;