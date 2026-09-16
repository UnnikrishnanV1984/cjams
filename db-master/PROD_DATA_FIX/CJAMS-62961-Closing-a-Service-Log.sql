/* 
    Issue Description: CJAMS-62961
  Category/ Module  : Service log
  Root cause: User request to add servicelog end date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/
UPDATE tb_service_log
SET end_dt = '2025-08-19'::date ,
	estimated_end_dt = '2025-08-19'::date,
    update_ts = now(),
    update_user_id = 'CJAMS-62961',
    end_service_reason_cd = '1824'
WHERE service_log_id = '3077427'
    and client_id = '3713182' 
    and case_id = '3178879'
    and delete_sw = 'N';