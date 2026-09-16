-- CJAMS-59849 Service log

/*
--	Issue Description: 
	 data fix is needed to ended the service log with 04/15/2024 as they worker will not be able to ended the respective 
     service log when there is an overlapping service log with the same provider and service
-- Category/ Module: Persons: Others
-- Root cause: Data fix is needed to ended the service log with 04/15/2024 
-- Fix Provided: Datafix has been promoted to ended the service log with 04/15/2024
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_service_log 	
set end_dt = '2024-04-15',
end_service_reason_cd = '1824',
	update_ts = now(), 
	update_user_id = 'CJAMS-59849'
where service_log_id = '2141904';
