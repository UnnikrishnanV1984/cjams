/*
Issue Description: Data fix to ended the worker case assignment with 01/10/2025
Category/Module: Data Error
Root cause: Data error seems to cause case assignment to not end
Fix provided: DB query to end date open case assignment
Data/Code fix ticket#: CDM-43766
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
update caseassignment
set enddate = '2025-01-10 00:00:00.000', updatedby = 'CDM-43766', updatedon = now()
where caseassignmentid = 'd34343d7-bc54-4750-a08f-b7a5a729b46c' and activeflag = 1;