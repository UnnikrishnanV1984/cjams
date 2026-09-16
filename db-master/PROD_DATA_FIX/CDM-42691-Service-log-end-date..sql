/*
  Issue Description: CDM-42691  Case Closure Prevention
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update tb_service_log
  	set end_dt = '2019-06-21'::date , end_service_reason_cd = '1824' , update_ts = now(), update_user_id = 'CDM-42691'
  	where service_log_id = 928532
  		and case_id = 3236684
  		and client_id = 3637748
  		and end_dt is null;