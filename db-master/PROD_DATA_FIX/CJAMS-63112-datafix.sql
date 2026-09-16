/*
Issue Description: CJAMS-63112
Category/Module: Remove the old intake  from the user dashboard CW10200162
Root cause: User requested to promote the data fix to remove the old intake  CW10200162
 from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63112',
	updatedon = now()
where routingid = '3afd6f06-9f2b-40d4-8913-0a75b436e877'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63112', 
	updatedon = now() 
where intakenumber = 'CW10200162' and activeflag = 1;