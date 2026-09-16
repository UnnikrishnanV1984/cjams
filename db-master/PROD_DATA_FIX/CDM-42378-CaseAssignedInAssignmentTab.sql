/*
Issue Description: Please remove the case from the supervisor dashboard.
Category/Module: Bug
Root cause: Data error seems to keep case in assign tab even after assignment
Fix provided: DB query to remove the case from assign tab
Data/Code fix ticket#: CDM-42378
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservicerequest
update intakeservicerequest
set isrouted = true, updatedby = 'CDM-42378', updatedon = now()
where intakeserviceid = 'c9d41300-7b1f-4e4e-8d94-9732ee47b6e9' and activeflag = 1;