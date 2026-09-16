/* 
    Issue Description: CJAMS-68217
  Category/ Module  : Services: Service Log
  Root cause: Requested for a data fix to end date the service log as  as dates are over lapping with the same provider duration
  Fix provided: Data fix has been done to end date the service log with latest purchase authorization date as 2022-05-06.
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update tb_service_log
set end_dt ='2022-05-06',
    update_user_id ='CJAMS-68217', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2642521') and delete_sw='N';