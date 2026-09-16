/*
   Issue Description: CDM-29044
   Category/ Module  : service log 
   Root cause: date disappeared from service log
   Pull request# for data fix: 8421
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/

update tb_service_log 	
set end_dt = '06/24/2022',
	update_ts = now(), 
	update_user_id = 'CDM-29044'
where service_log_id = '1982223';