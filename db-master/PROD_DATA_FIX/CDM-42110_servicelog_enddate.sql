--CDM-42110-Service_log- Overlapping Dates
/*
-- Issue Description: 
   User request to add the Service Log Estimated End date, Actual End date and Purchase Authorization End date to 2024-09-12.
--  Case ID: 3123893
	Client ID: 1720303 (ANTWONE JENKINS)
	Provider ID: 5093433
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates , Actual End date and Purchase Authorization End date to 2024-09-12.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
select end_service_reason_cd,estimated_end_dt,* from cjams.tb_service_log
where service_log_id = 3518234; 
*/

UPDATE cjams.tb_service_log
SET end_dt='2024-09-12', 
	end_service_reason_cd = '1824', --service completed
	update_user_id='CDM-42110', 
	estimated_end_dt ='2024-09-12',
	update_ts=now() 
WHERE service_log_id = 3518234;