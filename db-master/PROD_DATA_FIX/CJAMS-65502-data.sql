/*
Issue Description: Wrong Response Timer
Category/Module: Bug
Root cause: Issue is not replicable so proceeding with datafix to modify the start date
Fix provided:DB query to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-65502
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakeservicerequest
set reporteddate = '2026-02-13 09:56',
updatedby = 'CJAMS-65502',
updatedon = now()
where intakeserviceid='42ecc291-a60d-4a87-a525-25178e2368b2';