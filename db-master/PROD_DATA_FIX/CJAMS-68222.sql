/* 
    Issue Description: CJAMS-68222
  Category/ Module  : Services: Service Log
  Root cause: As per system design,  service log dates are over lapping with previous ones, requested to  end the Service log as 2022-04-30
  Fix provided: Data fix has been done to end date the service log .
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update tb_service_log
set end_dt ='2023-09-06',
    update_user_id ='CJAMS-68222', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2005274') and delete_sw='N';