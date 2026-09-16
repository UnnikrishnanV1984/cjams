/* 
    Issue Description: CJAMS-59157
  Category/ Module  : Service log
  Root cause: User request to add servicelog end date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

UPDATE tb_service_log
SET end_dt = '2023-12-08'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-59157',
    end_service_reason_cd = '1824'
WHERE service_log_id = '2745276'
    and delete_sw = 'N';
