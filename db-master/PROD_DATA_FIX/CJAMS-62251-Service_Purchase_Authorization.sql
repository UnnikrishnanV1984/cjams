/*
Issue:3272038:I need to re-open this log. There are invoices from july/aug that were not entered and I am unable to enter them as the dates overlap.
Root Cause:User request to remove  Purchase Authorization end date, due to they do not have access do that.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_purchase_authorization.
Data/Code fix ticket#: CJAMS-62251
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
select * from tb_service_log where client_id ='4022188'and delete_sw ='N';
*/
update tb_service_log
set end_dt =null,update_user_id ='CJAMS-62251', update_ts =now(),end_service_reason_cd  =null
where service_log_id in ('3765282') and delete_sw='N' ;
