/*
Issue Description: Unable to close service log due t the dates overlapping with another service log
Category/Module: Support
Root cause: Service Log end date is missing which is preventing the user to close the case.
Fix provided: DB queries to update  record in tb_service_log table.
Data/Code fix ticket#: CJAMS-58635
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/

update tb_service_log
  	set end_dt = '2024-10-08'::date, end_service_reason_cd = '1824', update_ts = now(), update_user_id = 'CJAMS-58651' 
  	where service_log_id = 1998199  and delete_sw = 'N';