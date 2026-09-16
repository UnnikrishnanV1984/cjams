/* 
    Issue Description: CJAMS-66022
  Category/ Module  : Services: Service Log
  Root cause: User request to update the end date 
  Fix provided: Data fix is done to update the service log end date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/




update tb_service_log
set end_dt ='2023-02-08',
    update_user_id ='CJAMS-66022', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2152656') and delete_sw='N' ;