/*
Issue:3147682:I'm tying to close out the case for Jessie Colburn. Service logs are not allowing me to close due to service start date not ending in 2021
Root Cause:User request to change Purchase Authorization end date, due to they do not have access do that.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_purchase_authorization.
Data/Code fix ticket#: CJAMS-61912
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_log
set end_dt ='2021-11-19',update_user_id ='CJAMS-61912', update_ts =now(),end_service_reason_cd = '1824'
where service_log_id in ('2021295','2021294','1968859','1968860','1968858') and delete_sw='N';
