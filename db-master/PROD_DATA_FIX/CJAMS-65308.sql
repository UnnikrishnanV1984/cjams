/*
Issue Description: CJAMS-65308 YTP for case 3204133 has been approved. But continues to show in Approval Box as needing approval
Root cause: User requested to delete the approval inbox record.
Fix provided: update into routing table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data issue.
*/


update routing
	set activeflag = 0,
		updatedby='CJAMS-65308',
		updatedon=now()
where routingid = '85b42f8b-b1e1-4c44-b54a-5cf8acf996b6' 
	and activeflag=1;