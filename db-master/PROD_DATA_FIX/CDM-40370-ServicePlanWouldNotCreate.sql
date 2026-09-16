/*
Issue Description: Delete - WILLIAMS Family Service plan, with  start date as - 05/23/2024
Category/Module: Bug
Root cause: Old service plans won't let users create new versions after recent update
Fix provided: DB query to remove the mentioned service plan
Code/Data fix ticket#: CDM-40370
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Page working as intended
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating service plan with 05/23/2024 start date
update serviceplan
set activeflag = 0, updatedby = 'CDM-40370', updatedon = now()
where serviceplanid = 'f7fad4fa-45b0-4392-b747-01f4f0576102' and activeflag = 1;