/*
Issue Description: The program assignment for Family Worker - Rochelle Smith needs to be ended on the same date as the case was closed.
Category/Module: assignments
Root cause: Old program assignments seem to not end when case is closed
Fix provided: DB query to end program assignments for all clients
Data/Code fix ticket#: CJAMS-57980
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update caseassignment
set enddate='2024-01-10',updatedby='CJAMS-57980', updatedon=now()
where caseassignmentid='cf91cfb0-e78a-443e-959a-42d8fac4ddf9' and activeflag=1;
