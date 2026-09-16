/*
-- Issue Description: End date is not updated
   
-- Category/ Module: Service Log 
-- Root cause: CJAMS-69635 - Not able to end date Removal
-- Fix Provided: Need to end update end date as 6/3/2026
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_service_log 
set end_dt = '06/03/2026',update_ts = now(), update_user_id = 'CJAMS-69635'
where service_log_id in ('4020477','3974673');