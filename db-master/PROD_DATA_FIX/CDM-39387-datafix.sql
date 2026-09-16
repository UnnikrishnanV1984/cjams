/*
   Issue Description: CDM-39387
   Category/ Module  : service log 
   Root cause: unable to process a service log request.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log
set end_dt = '2021-04-13'::date ,
	update_ts = now(),
	update_user_id = 'CDM-39387',
    end_service_reason_cd = '1824'
where service_log_id ='1991951'
	and delete_sw = 'N';