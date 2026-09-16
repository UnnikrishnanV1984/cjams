/*
-- Issue Description:   
   3302602:unable to end date youth savings plan service log.
   Need data fix to end the Service log with date (10/02/2024) as per the latest purchase authorization (3668671) End date.

    The "Estimated End date" and "Actual End date" needs to be (10/02/2024)
    The 'Service End Reason' needs to be "Service Completed".
    The same end dates and Service End Reason needs to be updated on the PDF print as well.

-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error.  
-- Fix Provided: Datafix has been promoted to update the requested Service Log End dates as 10/02/2024
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
--select estimated_end_dt,end_dt ,* from cjams.tb_service_log where service_log_id = 1998330

UPDATE cjams.tb_service_log
SET end_dt='2024-10-02', 
	end_service_reason_cd = 1824, --service completed
	estimated_end_dt = '2024-10-02',
	update_user_id='CJAMS-58244',
	update_ts=now() 
WHERE service_log_id = 1998330;

