-- CDM-28022 - Unable to close provider
/*
-- Issue Description: 
   Unable to close provider due to open ended Service Logs
  
-- Case ID: 3264063
-- Client ID: 3916158 (CHRYSTALIN NOEL MORGAN) - a85bc8a9-c733-488a-bad1-2578b9da15fa
-- Provider ID: 5082010	(Linda Clark) - Local Department Home
-- Clothing Purchase (Paid)
-- Service Log ID: 1959625 - 2020-07-13 To Open - update as 7/31/2020	
-- Service Log ID: 896652 - 2018-11-01 TO Open - update as 11/30/2018	

-- Category/ Module: Service Log (Case Management) 
-- Root cause: Migrated Service Logs, CJAMS is not allowing the caseworkers to close them.
-- Fix Provided: Datafix has been promoted to end date the below 2 Service Logs.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To End date the Service Log
-- Service Log ID: 1959625 - 2020-07-13 To Open - update as 7/31/2020	
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id = 1959625
	and delete_sw = 'N';	
	
update tb_service_log
set end_dt = '2020-07-31'::date,
	end_service_reason_cd = '1824', -- Service Completed
	update_ts = now(), 
	update_user_id = 'CDM-28022'
where service_log_id = 1959625
	and delete_sw = 'N';	

-- Service Log ID: 896652 - 2018-11-01 TO Open - update as 11/30/2018	
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id = 896652
	and delete_sw = 'N';	
	
update tb_service_log
set end_dt = '2018-11-30'::date,
	end_service_reason_cd = '1824', -- Service Completed
	update_ts = now(), 
	update_user_id = 'CDM-28022'
where service_log_id = 896652
	and delete_sw = 'N';	