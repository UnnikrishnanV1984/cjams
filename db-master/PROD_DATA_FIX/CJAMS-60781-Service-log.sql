/*
-- Issue Description:   
   3172431:end this service log and i need to send the case for closure.
   Need data fix to end the Service log with date (10/02/2024) as per the latest purchase authorization (3668671) End date.

    The "Estimated End date" and "Actual End date"  needs to be end dated 10/31/2014 as per user request
    The 'Service End Reason' needs to be "Service Completed".
    The same end dates and Service End Reason needs to be updated on the PDF print as well.

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates as 10/02/2024
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.tb_service_log
SET end_dt='2014-10-31', --null
	end_service_reason_cd = 1824, --service completed
	estimated_end_dt = '2014-10-31',
	update_user_id='CJAMS-60781',
	update_ts=now() 
WHERE service_log_id = 572872;
