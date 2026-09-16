-- CDM-34056 - Disappearing Flex Fund
/*
-- Issue Description: 
   A flex fund (Purchase Authorization #2481086) that was submitted cannot be found 
   when it is clicked on for processing. It needs to be removed from my approval inbox 
  
-- Case ID: 3122016
-- Client ID: 4437622 (A'ayliyah Harlem	HAYWARD) - 066d7fb6-2812-48da-8bc2-37bbb7831d1c
-- provider ID: 6041226	(Ethel Canita Rouse) 
-- Service Log ID: 2618267 - 08/10/2023 To 08/10/2023 - Food (Paid) 
-- Auth ID: 2481086 - 08/10/2023 To 08/10/2023 - $284.69 - Food (Paid) 

-- Category/ Module: Service Log (Case Management) 
-- Root cause: TBD (Data Issue: Service log transaction is a soft-deleted record).
-- Fix Provided: Datafix has been promoted to make the Service log record active.
--				 The request is forwarded to Baltimore City Supervsior Cheryl Paige, plerase ask the user to approve the same.	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Update Service Log as Active (CDM-34056)
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id = 2618267
	and delete_sw = 'Y';	
	
update tb_service_log
set delete_sw = 'N',
	update_ts = now(), 
	update_user_id = 'CDM-34056'
where service_log_id = 2618267
	and delete_sw = 'Y';	

-- After 
select service_log_id, start_dt, end_dt, end_service_reason_cd, update_ts, update_user_id 
	from tb_service_log 
where service_log_id = 2618267
	and delete_sw = 'N';	
