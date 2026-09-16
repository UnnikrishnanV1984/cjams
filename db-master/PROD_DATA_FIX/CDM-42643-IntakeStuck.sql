/*
Issue: Please remove the in-progress intake as requested.
Category/Module: Error
Root cause: User requested this intake to be deleted
Fix provided: DB queries to deactivate intake
Data/Code fix ticket#: CDM-42643
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in intakedastaging
update intakedastaging
set updatedon = now(), updatedby = 'CDM-42643' ,activeflag = 0
where intakenumber = 'I241013168078' and activeflag = 1;

--Deactivating in intakedastatus
update intakedastatus
set updatedon = now(), updatedby = 'CDM-42643' ,activeflag = 0
where intakenumber = 'I241013168078' and activeflag = 1;