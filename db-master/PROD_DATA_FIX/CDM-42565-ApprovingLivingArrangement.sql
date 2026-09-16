/*
Issue: End date for living arrangement was approved, but it continues to come up in review status.
Category/Module: Bug
Root cause: Database table (placementrevision) had the wrong value in a key column for this record
Fix provided: DB query to change the wrong value in the table
Data/Code fix ticket#: CDM-42565
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating placementrevision
update placementrevision
set exittypekey = 'CIPS', updatedby = 'CDM-42565', updatedon = now()
where placementrevisionid = 'b1112195-e57c-49d0-bba5-ee27dff5ab07' and activeflag = 1;