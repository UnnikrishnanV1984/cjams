-- CDM-38853 -Issue closing the service logs 
/*
-- Issue Description: End date is not updated
   
-- Category/ Module: Service Log 
-- Root cause: 
-- Fix Provided: Updated the service log end date 
-- Pull request# 8407
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_service_log 	
set end_dt = '08/16/2023',
	update_ts = now(), 
	update_user_id = 'CDM-38853',
	end_service_reason_cd = '1824'
where service_log_id = '1999681';

update tb_service_log 	
set end_dt = '07/01/2021',
	update_ts = now(), 
	update_user_id = 'CDM-38853',
	end_service_reason_cd = '1824'
where service_log_id = '1990966';
