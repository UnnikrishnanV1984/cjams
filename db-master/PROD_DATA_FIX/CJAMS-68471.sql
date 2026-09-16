/* 
    Issue Description: CJAMS-68471
  Category/ Module  : Services: Service Log
  Root cause: Requested for a data fix to end date the service log as its throeing error because of the beyond the OOH Program Assignment
  Fix provided: Data fix has been done to end the servicelog with atest purchase authorization date 
  Is code fix required: Y 
  Pull request# for code fix: 
  Reason why no related code fix: CIDM-11517
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update tb_service_log
set end_dt ='2026-05-31',
    update_user_id ='CJAMS-68471', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('4192629') and delete_sw='N';