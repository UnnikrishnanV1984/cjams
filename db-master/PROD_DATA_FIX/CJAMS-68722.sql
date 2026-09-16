/* 
    Issue Description: CJAMS-68722
  Category/ Module  : Services: Service Log
  Root cause: Requested for a data fix to end date the service log as its overlapping with the same provider duration and also requested to deny purchase authorization
  Fix provided: Data fix has been done to end the servicelog with latest purchase authorization date and also denied purchase authorization
  Is code fix required: N
  Reason why no related code fix: Expected behaviour
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update tb_service_log
set end_dt ='2021-08-20',
    update_user_id ='CJAMS-68722', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('1996459','1996455') and delete_sw='N';


update routing
set routingstatustypeid= 62,
routeddescription='Denied CJAMS-68722',
remarks='Denied',
updatedby='CJAMS-68722',
updatedon=now()
where  routingid='7572f337-df4e-4769-b158-7dceb9ec0c88' and eventcode='PCAUTH';