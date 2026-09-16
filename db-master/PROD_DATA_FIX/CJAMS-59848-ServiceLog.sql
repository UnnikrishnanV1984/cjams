/*
Issue:221030023850:Not able to close service log for Karing Kids 9/18/2023. Log ended 9/29/2023
Root Cause: Service Log end date is missing which is preventing the user to close the case.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_log table..
Data/Code fix ticket#: CJAMS-59848
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update tb_service_log
set end_dt = '2023-09-18' ,update_ts = now(), update_user_id = 'CJAMS-59848',end_service_reason_cd = '1824'
where service_log_id = '2847605' and delete_sw = 'N';
