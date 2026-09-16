/*
Issue Description: Service Plan end date needs to be changed to 08/05/2024, datafix needed
Category/ Module: Bug
Root cause: User opened a new version but needed the service plan end date to change
Fix provided: DB query to change end date of the service plan.
Code/Data fix ticket#: CDM-40540
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CDM-40540
Reason why no related code fix: DB issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating end date for serviceplan
update serviceplan
set targetenddate = '2024-08-05 04:00:00.000', updatedby = 'CDM-40540', updatedon = now()
where serviceplanid = 'cc20c8dc-bfb9-4151-8f6a-8ad34cbb965c' and activeflag = 1;