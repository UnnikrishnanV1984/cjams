/*
Issue Description: Intake is still in-progress status. Please remove/delete the Intake #I241013132468 as requested.
Category/Module: Bug
Root cause: Intake needs to be removed due to unavailable fields
Fix provided: DB queries to deactivate intake
Data/Code fix ticket#: CDM-41491
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in intakedastaging
update intakedastaging
set activeflag = 0, updatedby = 'CDM-41491', updatedon = now()
where intakenumber = 'I241013132468' and activeflag = 1;

--Deactivating in intakedastatus
update intakedastatus
set activeflag = 0, updatedby = 'CDM-41491', updatedon = now()
where intakedastatusid = '54d86c1e-3780-4888-9ac2-7b83a5e521c7' and activeflag = 1;