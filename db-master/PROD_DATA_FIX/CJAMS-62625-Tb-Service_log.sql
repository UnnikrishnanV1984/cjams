/*
Issue:241030334227:I am unable to close case due to 5052118 does not have an Actual End Date. I am unable to end date it and the previous Worker as well. Need to end date the service log to be able to close the case.
Root Cause:As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_log.
Data/Code fix ticket#: CJAMS-62625
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
select * from tb_service_log where client_id ='568025'and delete_sw ='N';
*/
update tb_service_log
set end_dt ='2025-02-14',update_user_id ='CJAMS-62625', update_ts =now(),end_service_reason_cd=1824,estimated_end_dt='2025-02-14'
where service_log_id in ('3594945') and delete_sw='N' ;