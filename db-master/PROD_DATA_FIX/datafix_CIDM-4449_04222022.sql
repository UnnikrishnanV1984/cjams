-- CIDM-4449 - Future end date picks 5 digit for year
/*
-- Issue Description: 
  To fix the estimated_start_dt, estimated_end_dt, start_dt and end_dt years as 2022
  
-- Case ID: 2021010407239
-- Client ID: 200571988 (Victor	Lane) - f7e6ba80-975c-44ed-9185-1f7976bbe6ae
-- Service Log ID: 2040090

-- Category/ Module: Service Log (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To update the dates
select service_log_id, estimated_start_dt, estimated_end_dt,
	start_dt, end_dt, update_ts, update_user_id 
from cjams.tb_service_log 
where service_log_id = 2040090
	and delete_sw = 'N' ;
	
update tb_service_log
set estimated_start_dt = '2022-04-01'::date,
	estimated_end_dt = '2022-04-30'::date,
	start_dt = '2022-04-01'::date,
	end_dt = '2022-04-30'::date,
	update_ts = now(), 
	update_user_id = 'CIDM-4449'
where service_log_id = 2040090
	and delete_sw = 'N' ;
