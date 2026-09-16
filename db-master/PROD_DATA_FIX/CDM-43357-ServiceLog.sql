/*
Issue Description: Need data fix to end the Service log with 06/01/2022
Category/Module: Support
Root cause: Actual begin date of this service log cannot be changed and is causing conflicts
Fix provided: DB query end date the service log
Data/Code fix ticket#: CDM-43357
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating tb_service_log
update tb_service_log
set end_dt = '2022-06-01', update_user_id = 'CDM-43357', update_ts = now()
where service_log_id = 2380886 and delete_sw = 'N';