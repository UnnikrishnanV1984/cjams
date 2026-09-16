/*
Issue Description: Please remove the one of the duplicate family assignment from the assignment screen.
Category/Module: Support
Root cause: Application does not allow setting role for overlapping assignments
Fix provided: DB query to remove one duplicate assignment
Data/Code fix ticket#: CDM-42988
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in caseassignment
update caseassignment
set activeflag = 0, updatedby = 'CDM-42988', updatedon = now()
where caseassignmentid = '3c2ccc1c-01c3-4b5a-90d2-37ad2a9dde51' and activeflag = 1;