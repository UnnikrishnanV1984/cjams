/*
Issue:Need data fix to update/change the Purchase Auth# 3831043 End date to "08/31/2025". The same needs to be updated on the print as well.
Root Cause:User request to update   Purchase Authorization end date, due to they do not have access do that.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_purchase_authorization.
Data/Code fix ticket#: CJAMS-62429
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_purchase_authorization
set end_dt ='2025-08-31',update_user_id ='CJAMS-62429', update_ts =now()
where  service_log_id  in ('3720921') and authorization_id ='3831043' and delete_sw='N' ;

UPDATE cjams.tb_slpa_snapshot
set end_dt ='2025-08-31',update_user_id ='CJAMS-62429', update_ts =now()
where  service_log_id  in ('3720921') and authorization_id='3831043' and delete_sw='N' ;


UPDATE cjams.tb_payment_detail
set final_service_end_dt ='2025-08-31',update_user_id ='CJAMS-62429', update_ts =now()
where  payment_id  in ('4796545') and  delete_sw='N' ;
