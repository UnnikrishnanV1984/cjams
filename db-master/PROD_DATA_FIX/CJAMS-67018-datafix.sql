-- CJAMS-67018 -End date
/*
-- Issue Description: End date is not updated
   
-- Category/ Module: Service Log 
-- Root cause: User Requested to update service log end date with 08/28/2023
-- Fix Provided: Updated the service log end date 
-- Pull request# 8407
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update tb_service_log
set end_dt ='2023-08-28',
     estimated_end_dt='2023-08-28',
    update_user_id ='CJAMS-67018', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2063410');

update tb_service_log
set end_dt ='2024-07-24',
    estimated_end_dt='2024-07-24',
    update_user_id ='CJAMS-67018', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2054973') and delete_sw='N' ;