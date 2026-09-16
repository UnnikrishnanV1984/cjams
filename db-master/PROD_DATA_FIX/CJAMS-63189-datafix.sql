/*
Issue Description: CJAMS-63189
Category/Module: Remove the old intake  from the user dashboard CW10101021,CW9837383
Root cause: User requested to promote the data fix to remove the old intake  CW10101021,CW9837383
 from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63189',
	updatedon = now()
where routingid in ('81975707-0484-495b-b508-c701b511c903','73d9856d-7445-41c0-b72a-0fe012ce24f2')
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63189', 
	updatedon = now() 
where intakenumber in ('CW10101021','CW9837383') and activeflag = 1;