/*
Issue:Need data fix to update Purchase Authorization end date 
Root Cause: requested to update   Purchase Authorization end date
Fix Provided (Data Fix Only):Data fix was done by remove purchase authorization records
Data/Code fix ticket#: CJAMS-65579
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/



update tb_service_purchase_authorization set end_dt='2025-12-31',
update_ts= now(), 
update_user_id = 'CJAMS-65579' WHERE authorization_id ='4119646';

update tb_slpa_snapshot set end_dt ='2025-12-31',update_ts= now(),
update_user_id = 'CJAMS-65579' WHERE authorization_id ='4119646';

update  tb_payment_detail set final_service_end_dt='2025-12-31'
,update_ts= now(),update_user_id = 'CJAMS-65579' where payment_id = 5076703
and delete_sw = 'N';