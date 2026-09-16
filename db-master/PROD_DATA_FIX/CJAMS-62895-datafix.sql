/*
Issue Description: CJAMS-62895
Category/Module: Old Intakes from Chessie on current Dashboard
Root cause: User requested to promote the data fix to remove the old referral 
from the intake worker dashboard.
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

update routing
set activeflag = 0,
	updatedby = 'CJAMS-62895',
	updatedon = now()
where routingid in ('5505fadf-1a87-45cf-9ad3-f67e4c83f171','33d4f4b8-5839-4884-b637-c679ca6cadf0','87cea25c-2fc5-4027-ade6-1ddd1a0a4aef',
'a4c535d1-e860-4060-a211-585e2661961d')
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-62895', 
	updatedon = now() 
where intakenumber in ('CW9862856','CW9799007','CW10105828','CW9909542') 
  and activeflag = 1;