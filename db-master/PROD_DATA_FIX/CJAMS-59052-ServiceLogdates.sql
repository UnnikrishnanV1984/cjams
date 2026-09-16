
/*
Issue Description: 3284099:Client aged out on 3/24/2025 but the service log was extended to March 31, 2025. We need the dates fixed or the service log closed.
Category/Module: Bug
Root cause: due to a data glitch casued service record was not closed propely, which is preventing the user to close the case.
Fix provided: DB queries to update  record in tb_service_log table.
Data/Code fix ticket#: CJAMS-59052
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/




update tb_service_log
set end_dt = '2025-03-31' ,update_user_id = 'CJAMS-59052', update_ts = now(),end_service_reason_cd = '1824',estimated_end_dt = '2025-03-31'
where client_id ='4188498' and service_log_id = '3256154' and  case_id = '3284099' and delete_sw = 'N';