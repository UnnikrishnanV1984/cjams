/*
Issue:Attempting to open GAP for Khalif Farrar; service log for Tyonni Lewis won’t close as it was created under the OHP program (5/1/2021–5/31/2021) though she went home on 4/21/2021; a work order is needed for closure — message from Wanda Nolt to Yolanda requesting assistance.
Root Cause:The service log did not close automatically because the actual end date and service completion details were missing, preventing proper closure. Updating these fields will align the record with the client’s service completion and allow the log to close correctly.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_log.
Data/Code fix ticket#: CJAMS-62455
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_log
set end_dt ='2021-07-09',update_user_id ='CJAMS-62455', update_ts =now(),end_service_reason_cd=1824,estimated_end_dt='2021-07-09'
where service_log_id in ('2005350') and delete_sw='N' ;