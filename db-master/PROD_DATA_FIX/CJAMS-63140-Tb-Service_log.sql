/*
Issue:3300934: nadvertantly clicked the wrong date.For transaction 3890528 the dates should be 9/23/25 to 9/29/25. It has been approved.
Root Cause:User requested to updated Purchase Auth dates
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_purchase_authorization.
Data/Code fix ticket#: CJAMS-63140
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_purchase_authorization
set start_dt ='2025-09-23' , end_dt ='2025-09-29',update_user_id ='CJAMS-63140', update_ts =now()
where service_log_id in ('3718489') and authorization_id ='3890528'and delete_sw='N' ;


UPDATE tb_slpa_snapshot
SET start_dt ='2025-09-23' , end_dt ='2025-09-29',update_user_id ='CJAMS-63140', update_ts =now()
where service_log_id in ('3718489') and authorization_id ='3890528'and slpa_snapshot_id ='2600543'and  delete_sw='N' ;


update  tb_payment_detail
set final_service_end_dt ='2025-09-29',update_user_id ='CJAMS-63140', update_ts =now()
where payment_id = '4851677' and delete_sw ='N' and payment_detail_id ='6133664';
