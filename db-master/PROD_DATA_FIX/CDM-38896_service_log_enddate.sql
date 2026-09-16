/*
-- Issue Description: 3224998:Unable to end date service log from 9/7/2023 - this is stopping me from successfully closing  
-- Root cause: Change requested by user.
-- Fix Provided: Updated the tb_service_log table.
*/

update tb_service_log
set end_dt = '2023-09-07', end_service_reason_cd = '1824', update_ts = now(), update_user_id = 'CDM-38791'
where service_log_id = 2632109;