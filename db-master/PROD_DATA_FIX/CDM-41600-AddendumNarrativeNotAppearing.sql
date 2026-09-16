/*
Issue Description: Addendum to Narrative is not available in the case even after the code fix.(Same issue as CDM-41564)
Category/Module: Error
Root cause: intakesnapshot table has an active snapshot of inactive intake of the same case
Fix provided: DB query to deactivate active snapshot
Data/Code fix ticket#: CDM-41600
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating inactive record in intakesnapshot
update intakesnapshot
set activeflag = 0, updatedby = 'CDM-41600', updatedon = now()
where intakesnapshotid = 'fdfac948-826b-401d-9c21-4b9e4198c162' and activeflag = 1;