/*
Issue Description: End Date to be changed to 11/06/2024 as given in the screenshot
Category/Module: Bug
Root cause: Users cannot save Service plan data in old plans after recent update
Fix provided: DB query to edit service plan end date
Code/Data fix ticket#: CDM-40608
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CIDM-9172
Reason why no related code fix: Codefix already deployed
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Changing end date in serviceplan
update serviceplan
set targetenddate = '2024-11-06 08:00:00', updatedby = 'CDM-40608', updatedon = now()
where serviceplanid = 'a5480411-1450-4792-8377-adb6df76d612' and activeflag = 1;