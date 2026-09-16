/*
Issue Description: Service Log Actual End Date to be changed as 12/16/2024 instead of 11/29/2024
Category/Module: Support
Root cause:  worker incorrectly enter the service log end-date
Fix provided: Datafix to change the end dates  for service log as requested
Data/Code fix ticket#: CDM-44010
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--Updating tb_service_log

-- select * from  tb_service_log where service_log_id='3438346';
update tb_service_log
set end_dt = '2024-11-29', update_user_id = 'CDM-44010', update_ts = now()
where service_log_id = 3438346 and delete_sw = 'N';