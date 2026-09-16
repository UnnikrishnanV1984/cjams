/*
Issue:241030398924:Need data fix to change the Purchase Authorization (3866705) end date to "08/25/2025".Client ID: 200980211 (La'Nyiah Young-Spiegler)Provider ID: 6203551 (Brightstar Care of Waldorf)
	Auth ID: 3866705
	Payment ID: 4826006
Root Cause:User request to change Purchase Authorization end date, due to they do not have access do that.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_purchase_authorization.
Data/Code fix ticket#: CJAMS-61874
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_purchase_authorization
set end_dt ='2025-08-25',update_user_id ='CJAMS-61874', update_ts =now()
where service_log_id ='3718489' and authorization_id ='3866705' and delete_sw='N';

UPDATE tb_slpa_snapshot
SET end_dt ='2025-08-25',update_user_id ='CJAMS-61874', update_ts =now()
where service_log_id ='3718489' and authorization_id ='3866705' and   slpa_snapshot_id ='2585172' and delete_sw='N';

UPDATE tb_payment_detail
SET final_service_end_dt = '2025-08-25',
    update_ts = now(),
    update_user_id = 'CJAMS-61874'
WHERE payment_id = 4826006 
  AND delete_sw = 'N';