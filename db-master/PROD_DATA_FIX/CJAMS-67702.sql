/* 
    Issue Description: CJAMS-67702
  Category/ Module  : Services: Service Log
  Root cause: The child's out of home program assignment ended on 07/28/2018 but somehow user created a service in 2019 and now its throwing error when user is end dating the servicelog ,
              so data fix is needed to end the servicelog so user can close the case
  Fix provided: Data fix has been done to end date the service log with latest purchase authorization date as 2019-02-08 .
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update tb_service_log
set end_dt ='2019-02-08',
    update_user_id ='CJAMS-67702', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('903805') and delete_sw='N';