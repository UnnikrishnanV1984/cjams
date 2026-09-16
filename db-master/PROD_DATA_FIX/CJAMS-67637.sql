/* 
    Issue Description: CJAMS-67637
  Category/ Module  : Services: Service Log
  Root cause: User requested to  end the Service log as 06/28/2024
  Fix provided: Data fix has been done to end date the service log
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/






update tb_service_log
set end_dt ='2024-06-28',
    update_user_id ='CJAMS-67637', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('1982166') and delete_sw='N';