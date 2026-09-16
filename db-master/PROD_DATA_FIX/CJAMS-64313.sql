-- CJAMS-64313 - Incorrect service log dates
/*
-- Issue Description: User request to update the Service Log End date 
-- Case ID: 3300052
-- Client ID:  1677472
-- Category/ Module: Service Log (Case Management) 
-- Root cause:  Service logs can not be ended as there is an overlapping service log for the same services.  
-- Fix Provided: Data fix to update the service log end date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update cjams.tb_service_log
set end_dt = '2024-02-01'::date ,
	end_service_reason_cd = '1824',
	update_ts = now(),
	update_user_id = 'CJAMS-64313'
where service_log_id in ( 3059638 )
	and delete_sw = 'N';	
	
