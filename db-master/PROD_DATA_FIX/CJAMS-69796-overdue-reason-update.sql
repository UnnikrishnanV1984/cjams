/*
Issue Description: CJAMS-69796
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason to 3 to 4 attempts instead of 1 - 2 attempts
Fix provided: Data fix to update the over due reason as 3 to 4 attempts from 1 - 2 attempts
Reason why no related code fix: User error
*/


update cpsresponsetimeractions
set cpsresponsetimerreason3='V34R',
	cpsresponsetimerreason9='C34F',
	updatedby='CJAMS-69796',
	updatedon=now()
where cpsresponsetimeractionsid='cb3563c2-d6e8-444a-b902-a908d143e0a8' and activeflag=1;
