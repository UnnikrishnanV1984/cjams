/*
Issue Description: Need to end admin rights as case is closed
Category/Module: User Error
Root cause: Case Assignments cannot be end-dated after closing the case
Fix provided: DB query to end the active case assignment for this case
Data/Code fix ticket#: CDM-43970
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
update caseassignment
set enddate = '2024-12-04 17:24:49.757', updatedby = 'CDM-43970', updatedon = now()
where caseassignmentid = 'b360353b-9317-4490-92ac-9780bdd4fed5' and activeflag = 1;