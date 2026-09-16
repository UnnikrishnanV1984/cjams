/*
Issue Description: please proceed with the data fix to remove the worker case assignment from the CPS IR case # 241022771001
Category/Module: Support
Root cause: User was assigned the case in error
Fix provided: DB query to remove the user from the case assignment
Data/Code fix ticket#: CDM-42356
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
update caseassignment
set activeflag = 0, updatedby = 'CDM-42356', updatedon = now()
where caseassignmentid = 'e0c4a760-d12d-412e-bbee-feac04080212' and activeflag = 1;