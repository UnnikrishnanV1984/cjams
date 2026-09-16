/*
   Issue Description: CDM-44092 
   Category/ Module  :Services
   Root cause : user request to update service log end date
   Resolution: Updated end date to the specified service log end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

-- select service_log_id,estimated_start_dt, estimated_end_dt,
-- 	start_dt, end_dt, update_ts, update_user_id 
-- from cjams.tb_service_log 
-- where service_log_id = 2242904
-- 	and delete_sw = 'N' ;
	
update tb_service_log
set end_dt = '2023-05-10'::date,
	update_ts = now(), 
	update_user_id = 'CDM-44092'
where service_log_id = 2242904
	and delete_sw = 'N' ;
