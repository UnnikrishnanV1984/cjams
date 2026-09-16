-- CDM-28535 - Not able to end date Removal
/*
-- Issue Description: 
   Unable to end child removal as service log end date is beyond the child removal end date.
   
-- Category/ Module: Service Log 
-- Root cause: 
-- Fix Provided: Update the service log end date to max of purchase auth end date 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.tb_service_log
SET end_dt='2022-06-30', update_ts=now(), update_user_id='CDM-28535'
WHERE service_log_id=1991202 and client_id=1487478 and case_id=3078910;