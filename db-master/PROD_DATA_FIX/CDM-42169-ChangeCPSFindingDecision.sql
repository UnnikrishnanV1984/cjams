/*
Issue Description: SSA approved on 10/16 - please modify the findings from Indicated to Unsubstantiated for the case # CW2715661 for both clients.
Category/Module: Support
Root cause: Case was reviewed and was stated that the ruling needs to be changed to unsubstantiated
Fix provided: DB query to change the ruling to unsubstantiated
Data/Code fix ticket#: CDM-42169
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migrated case
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating investigationfinding
update investigationfinding
set investigationfindingtypekey = 'UD', updatedby = 'CDM-42169', updatedon = now()
where activeflag = 1 and investigationfindingid in (
'97e214df-c5ee-4d89-ba5a-940a12586f17',
'dd812d42-0fb1-467b-987a-2d3944ef8c11',
'330ba4bb-787f-4f38-a66b-963f65eddd63');