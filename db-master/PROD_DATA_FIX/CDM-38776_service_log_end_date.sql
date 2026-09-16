/*
-- Issue Description: Cannot enter a subsequent purchase authorization in service case 3269317. 
    Receiving error indicating cannot be added due to overlapping service. In order to correct overlapping service, 
    service provided by provider 5091274 on 04/18/2024 must be change to service completed on 4/18/2024.
-- Root cause: Change requested by user.
-- Fix Provided: Updated the tb_service_log table end date colume as requested by user.
*/

update tb_service_log
set end_dt = '2024-04-18', end_service_reason_cd = '1824', update_ts = now(), update_user_id = 'CDM-38776'
where service_log_id = 3108305;