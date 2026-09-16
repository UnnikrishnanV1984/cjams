/*
Issue Description: Wrong Response Timer
Category/Module: Bug
Root cause: This is a known issue and code fix will be done, Proceeding with datafix for this case
Fix provided:Data fix is done to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-67284
Regression Impacts: N/A
Is Code fix Required?: Y - CIDM-11278
Code fix ticket#: CIDM-11278.
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservicerequest
set reporteddate = '2026-04-21 16:35:02.491',
updatedby = 'CJAMS-67284',
updatedon = now()
where intakeserviceid='d542272f-f5b2-4c6e-b465-5c55d3f7d193';
