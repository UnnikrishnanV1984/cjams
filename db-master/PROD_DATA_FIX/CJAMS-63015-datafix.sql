/*
Issue Description: CJAMS-63015
Category/Module: Remove the old intake (CW10183688, CW10162727, CW10128435, and CW9613719) from the user dashboard
Root cause: User requested to promote the data fix to remove the old intake (CW10183688, CW10162727, CW10128435, and CW9613719)
 from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63015',
	updatedon = now()
where routingid in ('f9f15faf-92bd-4964-8978-eb700bb260e5','53873a0c-41bb-4df7-962c-cb64c3da6db7',
'9391b6f9-7275-4f66-901d-9f0ed1aa1d07','5855e4a4-c9f1-4d4f-8459-ba9c9f95ad9d')
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63015', 
	updatedon = now() 
where intakenumber in ('CW10183688','CW10162727','CW10128435','CW9613719') and activeflag = 1;
