/*
  Issue Description: CJAMS-69262  Case Closure Prevention
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing
               Please carry out data fix to update the Actual End Date as 03/18/2014 in Service Log
                Case# 3211244
                Client# TRINITY DAVIS 3148632
                Provider 5041461 Provider Name The Joy of Learning II    
                Service Child Care (Paid)    
                Actual Begin Date 02/01/2014
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/


update tb_service_log
set end_dt = '2024-03-18'::date, end_service_reason_cd= '1824', update_ts = now(), update_user_id = 'CJAMS-69262' 
where service_log_id = 554112 and case_id = 3211244 and client_id = 3148632 and end_dt is null;