/* 
    Issue Description: CJAMS-62213
  Category/ Module  : Service log
  Root cause: User request to add servicelog end date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

UPDATE tb_service_log
SET end_dt = '2022-06-23'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-62213',
    end_service_reason_cd = '1824'
WHERE service_log_id = '2040879'
    and client_id = '4292271' 
    and case_id = '3046020'
    and delete_sw = 'N';