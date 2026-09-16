-- CIDM-5243 - Payment method missing
/*
-- Issue Description: 
   Emergency Care Retainer Fees payments are failing to interface with D365
   Fiscal Category Code: 4184 Emergency Care Retainer Fees
   
-- Payment ID: 3208609, 3208610, 3208003

-- Category/ Module: Dfe Payment (Finance Management) 
-- Root cause: TDB 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update payment_method_cd as 1 - Check
select payment_id, provider_id, payment_type_cd, payment_method_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3208609, 3208610, 3208003)
	and delete_sw = 'N' ;

update tb_payment_header
set payment_method_cd = '1',
	update_ts = now(),
	update_user_id = 'CIDM-5243'
where payment_id in (3208609, 3208610, 3208003)
	and delete_sw = 'N' ;
