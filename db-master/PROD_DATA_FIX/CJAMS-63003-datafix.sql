/*
Issue Description: CJAMS-63003
Category/Module: REMOVE FROM MY BOX
Root cause: User requested to promote the data fix to remove the old referral CW10047526 from the intake worker dashboard.
Fix provided: Data fix to remove the old referral CW9738776 from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/


update routing
set activeflag = 0,
	updatedby = 'CJAMS-63003',
	updatedon = now()
where routingid = '4fb794d1-6372-45fd-aaee-a9a9885aaec9'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63003', 
	updatedon = now() 
where intakenumber = 'CW10047526' and activeflag = 1;