
/* 
    Issue Description: CDM-39717
  Category/ Module  : Services: Service Log
  Root cause: User request to end date service logs
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


update tb_service_log
      set end_dt = '2021-12-17'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CDM-39717' 
      where service_log_id = 978638
          and case_id =  3289748
          and client_id = 4241190;
      
 update tb_service_log
      set end_dt = '2023-09-26'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CDM-39717' 
      where service_log_id = 2012840
          and case_id =  3289748
          and client_id = 4241190;
