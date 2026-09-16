-- CIDM-4430 - TB_service_log accepting five digits as year.
/*
-- Issue Description: 
  To fix the estimated_end_dt value - 2022-04-07 (20222-04-07)
  
-- Case ID: 221030013986
-- Client ID: 200805141 (Atika Jabbar) - 8588a33f-b6c8-43fd-9549-787094998518
-- Servive Log ID: 2038994

  
-- Category/ Module: Service Log (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To update the estimated_end_dt
select service_log_id,estimated_start_dt, estimated_end_dt,
	start_dt, end_dt, update_ts, update_user_id 
from cjams.tb_service_log 
where service_log_id = 2038994
	and delete_sw = 'N' ;
	
update tb_service_log
set estimated_end_dt = '2022-04-07'::date,
	update_ts = now(), 
	update_user_id = 'CIDM-4430'
where service_log_id = 2038994
	and delete_sw = 'N' ;
