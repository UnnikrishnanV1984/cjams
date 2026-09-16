/*
Issue Description: Please end-date the service log as mentioned below
Category/Module: Bug
Root cause: Old service log cannot be ended
Fix provided: DB query update end date of the service log
Data/Code fix ticket#: CDM-CDM-41273
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating service log end date in tb_service_log
update tb_service_log
set end_dt = '2022-08-31', end_service_reason_cd = '1824', update_user_id = 'CDM-41273', update_ts = now()
where service_log_id = 2033521;