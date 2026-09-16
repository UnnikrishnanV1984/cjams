/*
Issue Description: Please delete the intake as we received SSA approval for this request.
Category/Module: Error
Root cause: Referral was erroneously cleared
Fix provided: DB queries to deactivate the intake
Data/Code fix ticket#: CDM-41316
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in intakedastaging 
update intakedastaging
set activeflag = 0, updatedby = 'CDM-41316', updatedon = now()
where intakenumber = 'I241013073332' and activeflag = 1;

--Deactivating in intakedastatus 
update intakedastatus
set activeflag = 0, updatedby = 'CDM-41316', updatedon = now()
where intakedastatusid = '880a1925-fc3c-4e3c-a67a-0d063d8840a8' and activeflag = 1;

--Deactivating in intakesnapshot
update intakesnapshot
set activeflag = 0, updatedby = 'CDM-41316', updatedon = now()
where intakeserviceid = '771a69cd-6571-4f5b-af57-a6ca6892a0de' and activeflag = 1;

--Deactivating in intakeservicerequest
update intakeservicerequest
set activeflag = 0, updatedby = 'CDM-41316', updatedon = now()
where intakeserviceid = '771a69cd-6571-4f5b-af57-a6ca6892a0de' and activeflag = 1;