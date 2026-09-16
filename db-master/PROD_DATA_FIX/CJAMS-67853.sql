/* 
    Issue Description: CJAMS-67853
  Category/ Module  : Services: Service Log
  Root cause: User requested to  end the Service log as 10/20/2024 and to modify purchase authorization status to denied
  Fix provided: Data fix has been done to end date the service log and to modify purchase authorization status to denied
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/



update tb_service_log
set end_dt ='2024-10-20',
    update_user_id ='CJAMS-67853', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('3531286') and delete_sw='N';



update routing
set routingstatustypeid= 62,
routeddescription='Denied CJAMS-67853',
remarks='Denied',
updatedby='CJAMS-67853',
updatedon=now()
where  routingid='eec01a5b-7ad4-46e4-b4bc-1bcfb0c13dca' and eventcode='PCAUTH';