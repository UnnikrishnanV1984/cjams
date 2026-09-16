/*
Issue Description: Please do a data fix to update the service case status as Open in the database.
Category/Module: Bug
Root cause: Caseworker visitation report shows this case as closed even though it was reopened
Fix provided: Db query to change case status as open
Code fix ticket#: CDM-40697
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Database issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating case status to open in servicecase
update servicecase
set statustypekey = 'OPEN', updatedon = now(), updatedby = 'CDM-40697'
where servicecasenumber = '241030262083' and activeflag  = 1;