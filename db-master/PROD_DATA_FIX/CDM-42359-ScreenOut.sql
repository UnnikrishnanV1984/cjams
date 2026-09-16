/*
Issue: User requested to delete the intake.
Category/Module: Support
Root cause: Intake has incorrect values because of user error
Fix provided: DB queries to deactivate erroneous intake
Data/Code fix ticket#: CDM-42359
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakedastaging
update intakedastaging
set activeflag = 0, updatedby = 'CDM-42359', updatedon = now()
where intakenumber = 'I241013144979' and activeflag = 1;

--Updating intakedastatus
update intakedastatus
set activeflag = 0, updatedby = 'CDM-42359', updatedon = now()
where intakedastatusid = 'b4b93a40-6165-4e15-bb25-a3f8bfbbae03' and activeflag = 1;