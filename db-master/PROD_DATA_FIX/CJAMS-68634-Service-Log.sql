/* 
    Issue Description: CJAMS-68634
  Category/ Module  : Service log and PA
  Root cause: User request to add servicelog end date
                need to end date the service log to 5/1/22      
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


UPDATE tb_service_log
SET end_dt = '2022-05-01',
    update_ts = now(),
    update_user_id = 'CJAMS-68634',
    end_service_reason_cd = '1824'  
WHERE service_log_id in ('2380745','2345086')
    and case_id = 3277542
    and delete_sw = 'N';