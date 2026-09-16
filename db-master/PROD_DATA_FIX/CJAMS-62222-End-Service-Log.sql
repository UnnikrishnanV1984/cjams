/*
-- Issue Description:   
  211030012946:Unable to end date the service log in order to close the provider 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User error, The latest Purchase Authorization (3792553) ended with "03/28/2025" which is beyond the client OOH program assignment end date "03/24/2025" due to which system is not allowed to end the Service log. 
-- Fix Provided: Datafix has been promoted to end the Service log as "03/28/2025" with Service end reason as "Service Completed"
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.tb_service_log
SET end_dt='2025-03-28', 
	end_service_reason_cd = 1824, --service completed
	estimated_end_dt = '2025-03-28',
	update_user_id='CJAMS-62222',
	update_ts=now() 
WHERE service_log_id = 3672849 
and delete_sw = 'N';