/* 
    Issue Description: CJAMS-67555
  Category/ Module  : Services: Service Log
  Root cause: As per system design, the service log can not be ended prior to the latest approved purchase authorization and beyond the selected client program, requested to  end the Service log as 2024-09-30
  Fix provided: Data fix has been done to end date the service log  and deny the purchase authorization
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update routing
set routingstatustypeid= 62,
routeddescription='Denied CJAMS-67555',
remarks='Denied',
updatedby='CJAMS-67555',
updatedon=now()
where  routingid='74f01adf-3bd9-40ae-a446-89eee2fad6b6' and eventcode='PCAUTH';

update tb_service_log
set end_dt ='2024-09-30',
    update_user_id ='CJAMS-67555', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('3516565') and delete_sw='N';