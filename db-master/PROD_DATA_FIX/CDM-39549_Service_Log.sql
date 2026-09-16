/*
-- Issue Description: 211030011575:Case# 211030011575; unable to close out service logs for this case. It looks like a check box was not selected in the service log page and it does not allow you to identify an end date without getting the error message. 
-- Root cause: Change requested by user.
-- Fix Provided: Updated the tb_service_log table.
*/

update tb_service_log
set end_dt = '2023-03-31', end_service_reason_cd = '1824', update_ts = now(), update_user_id = 'CDM-39549'
where service_log_id = 2048111;