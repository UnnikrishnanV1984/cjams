/*
Issue Description: Wrong Response Timer
Category/Module: Bug
Root cause: This is a known issue and code fix will be done, Proceeding with datafix for this case
Fix provided:Data fix is done to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-68013
Regression Impacts: N/A
Is Code fix Required?: Y - CIDM-11278
Code fix ticket#: CIDM-11278.
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update intakeservicerequest
set reporteddate = '2026-05-26 16:06:38',
updatedby = 'CJAMS-68013',
updatedon = now()
where intakeserviceid='865beaf9-ab08-49a3-9f62-22b62e2f48b4';