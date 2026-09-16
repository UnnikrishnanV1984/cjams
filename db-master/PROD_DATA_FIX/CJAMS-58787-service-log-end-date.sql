/*
-- Issue Description:   
   3284793:unable to end date youth savings plan service log.
   Need data fix to end the Service log with date (3/31/25) as per the latest purchase authorization (3712481) End date.

    The "Estimated End date" and "Actual End date" needs to be (3/31/25)
    The 'Service End Reason' needs to be "Service Completed".
    The same end dates and Service End Reason needs to be updated on the PDF print as well.

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates as 3/31/25
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--select end_service_reason_cd,* from tb_service_log where service_log_id = 3276614
update tb_service_log
set end_dt = '2025-03-31', 
	estimated_end_dt = '2025-03-31',
	update_user_id = 'CJAMS-58787',
	update_ts = now()
where service_log_id = 3276614 and delete_sw = 'N';