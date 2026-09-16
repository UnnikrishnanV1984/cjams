/*
Issue Description: CJAMS-63127
Category/Module: Remove the old intake  from the user dashboard CW10162976, CW10259555
Root cause: User requested to promote the data fix to remove the old intake  CW10162976, CW10259555
 from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63127',
	updatedon = now()
where routingid in ('420eb94c-da16-47b8-9f5e-c2e9eae9a1ea','a91a28c4-6773-427a-89dd-152dfb089baa')
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63127', 
	updatedon = now() 
where intakenumber in ('CW10162976', 'CW10259555') and activeflag = 1;
