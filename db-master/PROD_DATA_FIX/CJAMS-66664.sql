-- CJAMS-66664 -Issue closing the service logs 
/*
-- Issue Description: End date is not updated
   
-- Category/ Module: Service Log 
-- Root cause: User Requeste to update service log end date with 2022-09-30.
-- Fix Provided: Updated the service log end date 
-- Pull request# 8407
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update tb_service_log
set end_dt ='2022-09-30',
    update_user_id ='CJAMS-66664', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2384646') and delete_sw='N' ;