/*
Issue Description: CJAMS-62918 
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
	updatedby = 'CJAMS-62918',
	updatedon = now()
where routingid = 'df458ca2-0196-4f59-b6a8-f35c2f4dfb8b'
	and activeflag =1;

--CW9738776
update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-62918', 
	updatedon = now() 
where intakenumber = 'CW9738776' and activeflag = 1;