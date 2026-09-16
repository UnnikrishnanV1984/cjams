/*
Issue Description: Please remove the intake I231011417489
Category/Module: Support
Root cause: Old intake cannot be removed
Fix provided: DB queries to deactiavte old intake
Data/Code fix ticket#: CDM-41957
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating intake in intakedastaging
update intakedastaging
set activeflag = 0, updatedby = 'CDM-41957', updatedon = now()
where intakenumber = 'I231011417489' and activeflag = 1;

--Deactivating intake in intakedastatus
update intakedastatus
set activeflag = 0, updatedby = 'CDM-41957', updatedon = now()
where intakenumber = 'I231011417489' and activeflag = 1;