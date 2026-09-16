-- CDM-33921 - Incorrect service log dates
/*
-- Issue Description: 
   User request to remove the future Service Log End date 
  
-- Case ID: 3308009
-- Client ID: 4349562 (ALYSSA MARIE	GOODSON) - 20a6a11f-d3cb-49ec-ba48-f9dc3a93d4eb

-- Service Log ID: 2061836 - 2022-10-10	To 2025-10-17 - Food (Paid) 
-- Provider ID: 5032080 (Harford County DSS)

-- Service Log ID: 2093845 - 2022-09-01	To 2025-01-06 - Clothing Purchase (Paid) 
-- Provider ID: 5032080 (Harford County DSS)

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates as 07/01/2023 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Update Service Log End dates (CDM-33921)
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id in ( 2061836, 2093845 )
	and delete_sw = 'N';	
	
update tb_service_log
set end_dt = '2023-07-01'::date ,
	update_ts = now(), 
	update_user_id = 'CDM-33921'
where service_log_id in ( 2061836, 2093845 )
	and delete_sw = 'N';	
