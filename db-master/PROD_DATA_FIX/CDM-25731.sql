/*
-- Issue Description: 
  To fix the  estimated_end_dt
-- Category/ Module: Service Log (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/


update tb_service_log
set
	end_dt = '2022-09-28'::date,
	update_ts = now(), 
	update_user_id = 'CDM-25731'
where service_log_id = 1962112
	and delete_sw = 'N' ;