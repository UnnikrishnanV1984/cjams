
/*
   Issue Description: CJAMS-58251 
   Category/ Module  :Services
   Root cause : user request to update service log end date
   Resolution: Updated end date to the specified service log end date
   Pull request# for code fix: 
   Reason why no related code fix:  User Error
  
*/

update tb_service_log
set start_dt = '2025-01-01'::date,
	end_dt = '2025-01-31'::date,
	estimated_start_dt = '2025-01-01'::date,
	estimated_end_dt = '2025-01-31'::date,
	update_ts = now(), 
	update_user_id = 'CJAMS-58251'
where service_log_id = 3567069
	and delete_sw = 'N' ;
