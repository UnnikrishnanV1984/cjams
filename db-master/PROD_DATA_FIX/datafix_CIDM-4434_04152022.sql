-- CIDM-4430 - TB_service_log accepting five digits as year.
/*
-- Issue Description: 
  To fix the end_dt value - 2022-02-21 (20222-02-21)
  
-- Case ID: 3208036
-- Client ID: 3340909 (DORIS E BEWLEY) - 4c731f52-54fc-4044-9f5c-5306dc65ecc2
-- Servive Log ID: 2039440

  
-- Category/ Module: Service Log (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To update the end_dt
select service_log_id,estimated_start_dt, estimated_end_dt,
	start_dt, end_dt, update_ts, update_user_id 
from cjams.tb_service_log 
where service_log_id = 2039440
	and delete_sw = 'N' ;
	
update tb_service_log
set end_dt = '2022-02-21'::date,
	update_ts = now(), 
	update_user_id = 'CIDM-4430'
where service_log_id = 2039440
	and delete_sw = 'N' ;
