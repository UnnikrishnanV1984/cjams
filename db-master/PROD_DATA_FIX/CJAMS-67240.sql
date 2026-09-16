/* 
    Issue Description: CJAMS-67240
  Category/ Module  : Services: Service Log
  Root cause: User request to change the end date service log with date as 03/24/2022
  Provider id - 5008901
  Client ID: 4432386
  Fix provided: Data fix has been done to end date the service log
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/






update tb_service_log
set end_dt ='2022-03-24',
    update_user_id ='CJAMS-67240', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2052352') and delete_sw='N';