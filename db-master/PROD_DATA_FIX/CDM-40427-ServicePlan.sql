/*
Issue Description: User wants to edit two service plan end dates and delete the new service plan created with the family name
Category/Module: Bug
Root cause: Users cannot edit old service plans after recent update
Fix provided: DB query to edit service plan end dates and delete another one
Code/Data fix ticket#: CDM-40427
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Page working as intended
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deleting the new service plan created with the family name
update serviceplan
set activeflag = 0, updatedby = 'CDM-40427', updatedon = now()
where serviceplanid = 'ec755ba8-6ae9-468a-b658-92b9aaf31402' and activeflag = 1;

--Changing end dates of two existing service plans
update serviceplan
set targetenddate = '2024-11-15 04:00:00.000', updatedby = 'CDM-40427', updatedon = now()
where serviceplanid in ('ddac05cd-dbc6-4e71-9bdb-8cc028bd59fd', '0d0d8c2d-8c8b-40f1-af39-e22cab4b93b6') and activeflag = 1;