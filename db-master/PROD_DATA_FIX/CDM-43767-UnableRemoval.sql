/*
Issue Description: Service Log Actual End Date to be changed as 12/05/2024 instead of 01/13/2025
Category/Module: Support
Root cause: Old service log info cannot be changed by users
Fix provided: DB queries to change the end dates so service case can be closed
Data/Code fix ticket#: CDM-43767
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating tb_service_log
update tb_service_log
set end_dt = '2024-12-05', update_user_id = 'CDM-43767', update_ts = now()
where service_log_id = 3346854 and delete_sw = 'N';

update tb_service_log
set end_dt = '2024-12-06', update_user_id = 'CDM-43767', update_ts = now()
where service_log_id = 2449687 and delete_sw = 'N';