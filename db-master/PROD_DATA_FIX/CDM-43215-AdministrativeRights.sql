/*
Issue Description: Please end-date the Worker Administrative assignment as highlighted below.
Category/Module: Support
Root cause: Open case assignment is blocking history clearence for this completed case
Fix provided: DB query to end case assignment for the case
Data/Code fix ticket#: CDM-43215
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updating caseassignment
update caseassignment
set enddate = '2020-11-30 00:00:00', updatedby = 'CDM-43215', updatedon = now()
where caseassignmentid = 'c9ae7002-cf5d-47eb-a2b4-89df42198485' and activeflag = 1;