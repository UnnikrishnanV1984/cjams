/*
Issue Description: Dev team - CJAMS PID - 3475213 - with child removal in draft status needs to be removed / deleted.
Category/Module: Error
Root cause: Removal request draft is a duplicate
Fix provided: DB queries to deactivate duplicate removal request
Data/Code fix ticket#: CDM-41926
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservreqchildremoval
update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-41926', updatedon = now()
where intakeservreqchildremovalid = '9d6cf41f-f52e-4f2b-b206-44130801e6b7' and activeflag = 1;

--Updating intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set activeflag = 0, updatedby = 'CDM-41926', updatedon = now()
where intakeservreqchildremovalid = '9d6cf41f-f52e-4f2b-b206-44130801e6b7' and activeflag = 1;

--Updating intakeservreqchildremovalreason
update intakeservreqchildremovalreason
set activeflag = 0, updatedby = 'CDM-41926', updatedon = now()
where intakeservreqchildremovalid = '9d6cf41f-f52e-4f2b-b206-44130801e6b7' and activeflag = 1;