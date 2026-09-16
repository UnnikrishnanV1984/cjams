/*
-- Issue Description: End date is not updated
   
-- Category/ Module: Service Log 
-- Root cause: User Requested to update service log end date with 05/31/2022
-- Fix Provided: Updated the service log end date 
-- Pull request# 8407
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update tb_service_log
set end_dt ='2022-05-31',
    update_user_id ='CJAMS-66621', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2339742');