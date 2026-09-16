/* 
    Issue Description: CJAMS-68861
  Category/ Module  : Services: Service Log
  Root cause: As per system design, the service log can not if its overlapping with existing service logs, requested to  end the Service log as 2026-05-11
  Fix provided: Data fix has been done to end date the service log
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: Expected behaviour
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update tb_service_log
set end_dt ='2026-05-11',
    update_user_id ='CJAMS-68861', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('3819502') and delete_sw='N';