/*
Issue Description: Safe-C is stuck in review mode and cannot be approved by supervisor.
Category/Module: Bug
Root cause: Data glitch seemed to record incorrect teamid in the caseassignmrnt table, causing access issues
Fix provided: DB queries to rectify the teamid in caseassigment for the two users
Data/Code fix ticket#: CDM-43514
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data glitch
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating caseassignment
update caseassignment
set toteamid = '907aaffb-30ed-4f16-a823-43964e2f6707', updatedby = 'CDM-43514', updatedon = now()
where caseassignmentid = '599ea736-b8fe-428e-84f5-1b9f77dc6981' and activeflag = 1;

update caseassignment
set toteamid = 'b8d4d6d4-bd06-4087-b38a-b085abb266db', updatedby = 'CDM-43514', updatedon = now()
where caseassignmentid = '000f07ce-ac5e-4d5d-b5e8-ed90c5d86bff' and activeflag = 1;