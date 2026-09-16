-- CJAMS-65136: Purchase authorization incorrect enddate.
/*
-- Issue Description: Purchase authorization incorrect enddate.
-- authorization_id: 4184582
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to update the Purchase authorization enddate to a right value. 
-- Pull request# CJAMS-65136
-- Reason why no related code fix: This scenario isn't reproducible on stage3 as its user error and user 
    requested to update it correct value. 
	
    authorization_id: 4184582
    incorrect end_dt: 2027-01-12
    correct end_dt: 2026-01-12
*/

-- This is for UI
update tb_service_purchase_authorization 
set end_dt = '2026-01-12', update_ts = now(), update_user_id = 'CJAMS-65136'
where authorization_id = '4184582';

-- This is for download/print
update tb_slpa_snapshot 
set end_dt = '2026-01-12', update_ts = now(), update_user_id = 'CJAMS-65136'
where authorization_id = '4184582';

-- We need to update tb_payment_detail table as well. 
update tb_payment_detail 
set final_service_end_dt = '2026-01-12', update_ts = now(), update_user_id = 'CJAMS-65136'
where payment_id = 5048322 and delete_sw = 'N';

