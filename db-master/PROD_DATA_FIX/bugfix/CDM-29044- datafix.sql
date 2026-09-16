-- CDM-28535 - Not able to end date Removal
/*
-- Issue Description: End date is not updated
   
-- Category/ Module: Service Log 
-- Root cause: 
-- Fix Provided: Update the service log end date to max of purchase auth end date 
-- Pull request# 8407
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_service_log 	
set end_dt = '06/24/2022',
	update_ts = now(), 
	update_user_id = 'CDM-29044'
where service_log_id = '1982223';