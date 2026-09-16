/*
Issue Description: De Shaun's Service Plan End date needs to be changed to 01/30/2025
Category/Module: Bug
Root cause: Users cannot save Service plan data in old plans after recent update
Fix provided: DB query to edit service plan end date
Code/Data fix ticket#: CDM-40635
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CIDM-9172
Reason why no related code fix: Codefix already deployed
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Changing end date in serviceplan
update serviceplan
set targetenddate = '2025-01-30 04:00:00', updatedby = 'CDM-40635', updatedon = now()
where serviceplanid = 'a37f5036-a8d4-4df2-93e3-36425721a76b' and activeflag = 1;