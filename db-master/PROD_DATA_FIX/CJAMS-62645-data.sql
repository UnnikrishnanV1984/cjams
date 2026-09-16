/*
-- Issue Description:  CJAMS-62645 
  211030012946:Unable to end date the service log in order to close the provider 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User requested to do a data fix to update Actual End Date needs to be "10/29/2024" and Service End Reason: Service Completed for the Provider ID: 5063371 (Victory Cab Inc). Client ID: 200168228 (Tramaine Mitchell), Provider ID: 5063371 (Victory Cab Inc), 
Service: Transportation assistance (Paid) has been already updated by User
-- Fix Provided: Data fix has been promoted to update the Actual end date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.tb_service_log
SET end_dt='2024-10-29', 
	end_service_reason_cd = 1824, --service completed
	estimated_end_dt = '2024-10-29',
	update_user_id='CJAMS-62645',
	update_ts=now() 
WHERE service_log_id = 3548974 
and delete_sw = 'N';