/* 
    Issue Description: CDM-39793
  Category/ Module  : Service log
  Root cause: User request to add servicelog end date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

UPDATE tb_service_log
SET end_dt = '2022-11-27'::date ,
    update_ts = now(),
    update_user_id = 'CDM-39793',
    end_service_reason_cd = '1824'
WHERE service_log_id = '1998710'
    and delete_sw = 'N';