
/*
-- Issue Description: 3197032:I'm trying to put in a respite payment for this child & when I put in the service log dates, it is saying please enter the dates correctly & that they are overlapping another service log.
                      I looked & do not see where anything is overlapping. 
-- Root cause: Change requested by user.
-- Fix Provided: Updated the tb_service_log table.
*/

update tb_service_log
set end_dt = '2023-02-09', end_service_reason_cd = '1824', update_ts = now(), update_user_id = 'CDM-38791'
where service_log_id = 2957442;
