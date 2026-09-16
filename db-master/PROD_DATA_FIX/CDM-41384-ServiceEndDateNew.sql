/*
Issue Description: Need data fix to end-date the highlighted service log with 07/01/2020
Category/Module: Bug
Root cause: Old service logs cannot be ended if dates overlap
Fix provided: DB query to add end date to the service log
Data/Code fix ticket#: CDM-41384
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating end date in tb_service_log
update tb_service_log
set end_dt = '2020-07-01', end_service_reason_cd = '1824', update_user_id = 'CDM-41384', update_ts = now()
where service_log_id = 836302;