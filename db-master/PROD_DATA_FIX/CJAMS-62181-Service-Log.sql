/*
  Issue Description: CJAMS-62181
   Category/ Module  :  Service Log
   Root cause: Service Log end date missing
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update tb_service_log
set end_dt = '2020-12-03'::date, update_ts = now(), update_user_id = 'CJAMS-62181' 
where service_log_id = 1974972
	and case_id = 3242766
	and client_id = 3959526
	and end_dt is null;