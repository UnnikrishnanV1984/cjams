/*
Issue Description: CJAMS-62982
Category/Module: Old Intakes from Chessie on current Dashboard
Root cause: User requested to promote the data fix to remove the old referral C
from the intake worker dashboard.
Fix provided: Data fix to remove the old referral from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/


update routing
set activeflag = 0,
	updatedby = 'CJAMS-62982',
	updatedon = now()
where routingid in ('2b5a8590-338b-4b25-a51d-98a6bfc43da4','e055987f-0b56-48a2-b7e2-96982ecb7fe0','565d298d-724a-4456-989f-377beb65d373',
'e5e804f4-f904-498a-a5f6-ac4060151ec5')
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-62982', 
	updatedon = now() 
where intakenumber in ('CW10236310','CW10198195','CW10003071','CW9725802') 
  and activeflag = 1;