/* 
    Issue Description: CJAMS-68050
  Category/ Module  : Services: Service Log
  Root cause: per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period,
  User requested to  end the Service log as 05/22/2023
  Fix provided: Data fix has been done to end date the service log
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update tb_service_log
set end_dt ='2023-05-22',
    update_user_id ='CJAMS-68050', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2339472') and delete_sw='N';