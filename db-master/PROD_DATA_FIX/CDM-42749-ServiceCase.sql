/*
Issue: Please end-date the Worker administrative assignment with 09/10/2024.
Category/Module: Error
Root cause: Data error caused user assignment to not end when case was closed
Fix provided: DB query to end user assignment
Data/Code fix ticket#: CDM-42749
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
update caseassignment
set enddate = '2024-09-10 13:51:04.904', updatedby = 'CDM-42749', updatedon = now()
where caseassignmentid = '8f22ed0a-0656-46a2-a779-9cf0631ee35e' and activeflag = 1;