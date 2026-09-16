/* 
    Issue Description: CJAMS-67885
  Category/ Module  : Services: Service Log
  Root cause: As per system design, duplicate or multiple service logs can not be created on the same or overlapping date period for the same client ID, 
  Provider/Vendor ID and Service.,User requested to  end the Service log as 2018-08-02
  Fix provided: Data fix has been done to end date the service log
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update tb_service_log
set end_dt ='2018-08-02',
    update_user_id ='CJAMS-67885', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('903905') and delete_sw='N';