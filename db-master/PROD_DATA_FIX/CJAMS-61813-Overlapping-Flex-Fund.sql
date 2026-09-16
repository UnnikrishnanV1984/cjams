/* 
    Issue Description: CJAMS-61813
  Category/ Module  : Service log and PA
  Root cause: User request to add servicelog end date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

UPDATE tb_service_log
SET end_dt = null,
    update_ts = now(),
    update_user_id = 'CJAMS-61813',
    end_service_reason_cd = null
WHERE service_log_id = '3651025'
    and delete_sw = 'N';
    
UPDATE cjams.tb_service_purchase_authorization
SET end_dt='2025-04-11', 
	update_user_id='CJAMS-61813',
	update_ts =now() 
WHERE authorization_id  = 3772591;

/*payment table --> tb_payment_detail -> final_service_end_dt 
select final_service_start_dt, final_service_end_dt, * from tb_payment_detail 
where final_service_end_dt = '2026-07-31' and final_service_start_dt = '2020-07-01' 
and client_id = 4040404 
and case_id = 3299565;
*/
-- payment_id = 3035311;

update tb_payment_detail
set final_service_end_dt = '2025-04-11',
	update_user_id='CJAMS-61813',
	update_ts =now() 
where payment_detail_id = 5984025;

/*
 * update PDF
select * from tb_slpa_snapshot where authorization_id  = 3772591;
*/

UPDATE cjams.tb_slpa_snapshot
SET end_dt='2025-04-11', 
	update_user_id='CJAMS-61813',
	update_ts =now() 
WHERE authorization_id  = 3772591;