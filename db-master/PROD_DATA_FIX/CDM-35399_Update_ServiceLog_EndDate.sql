-- CDM-35399 - Incorrect service log dates
/*
-- Issue Description: 
   User request to update the future Service Log End date 
  
-- Case ID: 3301478
-- Client ID: 4277292 ( Mikayla Newman)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates as 09/06/2023 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Update Service Log End dates (CDM-35399)
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id in (2314842,2064224,2064226,2064866,2314944,950909)
	and delete_sw = 'N';
	
update tb_service_log
set end_dt = '2023-09-06'::date ,
	update_ts = now(),
	update_user_id = 'CDM-35399'
where service_log_id in ( 2314842,2064224,2064226,2064866,2314944,950909 )
	and delete_sw = 'N';	