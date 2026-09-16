/*
Issue:3300934:There is an open service log for the mother molly anne Leight, this was opened with CPS and never closed, this is preventing me from closing the close as the service log remains open.
Root Cause:As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_log.
Data/Code fix ticket#: CJAMS-62983
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_log
set end_dt ='2024-11-08',update_user_id ='CJAMS-62983', update_ts =now(),estimated_end_dt='2024-11-08'
where service_log_id in ('3307688') and delete_sw='N' ;