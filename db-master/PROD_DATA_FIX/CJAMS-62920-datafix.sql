/*
Issue Description: CJAMS-62920
Category/Module: Three old cases on my tree
Root cause: User requested to promote the data fix to remove the old referral CW10178491, CW9457423, CW9613719 
from the intake worker dashboard.
Fix provided: Data fix to remove the old referral CW10178491, CW9457423, CW9613719 from the intake worker dashboard.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: data fix to remove the old referral from the intake worker dashboard.
*/

--CW10178491, CW9457423, CW9613719

update routing
set activeflag = 0,
	updatedby = 'CJAMS-62920',
	updatedon = now()
where routingid in ('cdbca242-0350-4bce-814f-f1e6247ca620','e8dda3f0-99a2-4573-8cad-412f2d59bfe7','5855e4a4-c9f1-4d4f-8459-ba9c9f95ad9d',
'a0c7025f-e473-4f5e-abce-f044339ef045','1541b2a2-7ff9-44e1-9d8d-b7048bd7742e')
	and activeflag =1;

update intakedastaging  
set status='Complete', 
	updatedby='CJAMS-62920', 
	updatedon = now() 
where intakenumber in ('CW10178491','CW9457423','CW9613719','CW10164036', 'CW9892108') and activeflag = 1;