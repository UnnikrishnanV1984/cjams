/*
Issue Description: Please do the data fix to end-date the service log highlighted below with 06/09/2024
Category/Module: Bug
Root cause: Old service logs cannot be ended
Fix provided: DB query to update end date for the service log
Data/Code fix ticket#: CDM-42233
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Old service log
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating tb_service_log
update tb_service_log
set end_dt = '2024-06-09', update_user_id = 'CDM-42233', update_ts = now()
where service_log_id = 3167187;