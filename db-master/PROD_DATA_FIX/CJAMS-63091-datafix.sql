/*
Issue Description:  CJAMS-63091
Category/Module: Remove the old intake (CW10132894,CW10092845) from the user dashboard
Root cause: User requested to promote the data fix to remove the old intake (CW10132894,CW10092845) from the user dashboard
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-63091',
	updatedon = now()
where routingid in ('bc2e1037-f11c-4952-8abf-8809f686e0e8','b36edb86-6083-47ac-a1b4-f3471c8202f8')
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-63091', 
	updatedon = now() 
where intakenumber in ('CW10132894','CW10092845') and activeflag = 1;
