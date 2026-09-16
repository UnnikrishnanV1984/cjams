-- CJAMS-60461-End-Date-Service-Log
/*
-- Issue Description: End date updated
   
-- Category/ Module: Service Log 
-- Root cause: 
-- Fix Provided: Updated the service log end date 
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_service_log 	
set end_dt = '04/30/2015',--10/31/2015
	estimated_end_dt = '04/30/2015',--2015-08-31
	update_ts = now(), 
	update_user_id = 'CJAMS-60461'
where service_log_id = '650146';