/*
Issue Description:  CJAMS-63094
Category/Module: Remove the old intake (CW10101021) from the user dashboard
Root cause: User requested to promote the data fix to remove the old intake (CW10101021) from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63094',
	updatedon = now()
where routingid = '81975707-0484-495b-b508-c701b511c903'
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63094', 
	updatedon = now() 
where intakenumber = 'CW10101021'
and activeflag = 1;