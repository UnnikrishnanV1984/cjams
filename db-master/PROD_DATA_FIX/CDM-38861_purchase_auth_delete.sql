/*
-- Issue Description: The issue is that the user cannot edit the end date for the provider 5008913, begin date is 02/28/2024. 
                      Second issue is that the user wants to delete the authorization link 3130945
-- Root cause: Change requested by user.
-- Fix Provided: Updated the tb_service_log table and tb_service_purchase_authorization table.
*/

update tb_service_purchase_authorization
set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-38861'
where authorization_id = 3130945;

update tb_service_log
set end_dt = '2024-04-30', end_service_reason_cd = '1824', update_ts = now(), update_user_id = 'CDM-38861'
where service_log_id = 3058919;

update routing
set activeflag = 0, updatedon = now(), updatedby = 'CDM-38861'
where objectid = '3130945'
and eventcode in ( 'PCAUTHR', 'PCAUTH' )
and activeflag = 1;