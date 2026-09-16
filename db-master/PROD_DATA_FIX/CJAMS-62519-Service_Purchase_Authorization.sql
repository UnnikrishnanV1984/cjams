/*
Issue:241030372844:I had to deny some daycare bill because the payment code was wrong but now the dates do not match the bill. Is there a way to fix that because finance states it is a audit issue?
Root Cause:User request to update   Purchase Authorization start and  end date, due to they do not have access do that.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_service_purchase_authorization.
Data/Code fix ticket#: CJAMS-62519
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_service_purchase_authorization
set start_dt ='2025-09-01',end_dt= '2025-10-05',update_user_id ='CJAMS-62519', update_ts =now()
where  service_log_id  in ('3756070') and authorization_id ='3883044' and delete_sw='N' ;

UPDATE cjams.tb_slpa_snapshot
set start_dt ='2025-09-01',end_dt= '2025-10-05',update_user_id ='CJAMS-62519', update_ts =now()
where  service_log_id  in ('3756070') and authorization_id='3883044' and delete_sw='N' ;


UPDATE cjams.tb_payment_detail
set final_service_end_dt ='2025-10-05', final_service_start_dt ='2025-09-01',update_user_id ='CJAMS-62519', update_ts =now()
where  payment_id  in ('4840239') and  delete_sw='N' ;