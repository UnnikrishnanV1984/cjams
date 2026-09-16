/*
  Issue Description: CDM-28328  Case Closure Prevention
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update tb_service_log
  	set end_dt = '2021-03-01'::date, update_ts = now(), update_user_id = 'CDM-28328' 
  	where service_log_id = 1990626
  		and case_id = 2020027303296
  		and client_id = 3371905
  		and end_dt is null;