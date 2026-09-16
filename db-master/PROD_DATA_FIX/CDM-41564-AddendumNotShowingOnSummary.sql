/*
Issue Description: Addendum to Narrative is not displaying in the CPS case.
Category/Module: Error
Root cause: intakesnapshot table has an active snapshot of inactive intake of the same case
Fix provided: DB query to deactivate active snapshot
Data/Code fix ticket#: CDM-41564
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating snapshot in intakesnapshot
update intakesnapshot
set activeflag = 0, updatedby = 'CDM-41564', updatedon = now()
where intakesnapshotid = 'bee603fe-0571-4758-9a43-a5ccd653f68b' and activeflag = 1;