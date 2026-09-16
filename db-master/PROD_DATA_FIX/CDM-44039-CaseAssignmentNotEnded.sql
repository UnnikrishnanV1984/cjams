/*
Issue Description:  Please end date the family assignment for 1/24/25
Category/Module: Support
Root cause: Case Assignments cannot be end-dated after closing the case
Fix provided: DB query to end the active case assignment for this case
Data/Code fix ticket#: CDM-44039
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
update caseassignment
set enddate = '2025-01-24 14:58:27', updatedby = 'CDM-44039', updatedon = now()
where caseassignmentid = 'be5fc123-941e-4c81-99f2-da5a6e32da4c' and activeflag = 1;