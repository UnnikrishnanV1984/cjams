-- CJAMS-62968 - Incorrect service log dates
/*
-- Issue Description: 
   User request to update the future Service Log End date 
  
-- Case ID: 3178879
-- Client ID: 3297840 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates as 09/06/2023 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


	
update tb_service_log
set end_dt = '2025-10-15'::date ,
	update_ts = now(),
	update_user_id = 'CJAMS-62968'
where service_log_id in ( 3439271 )
	and delete_sw = 'N';	