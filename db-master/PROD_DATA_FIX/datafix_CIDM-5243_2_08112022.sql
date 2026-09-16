-- CIDM-5243 - CfE Payments - Payment method code is missing
/*
-- Issue Description: 
   Emergency Care Retainer Fees payments are failing to interface with D365
   Fiscal Category Code: 4184 Emergency Care Retainer Fees
   
-- Payment ID 	Aud ID	Provider ID
-- 3218945		1845242	5093082
-- 3218946		1845241	6005321
-- 3218947		1845229	6005839

-- Category/ Module: Cfe Payments (Finance Management) 
-- Root cause: payment_method_cd is not getting updated in the tb_payment_header table 
-- Pull request# Vignehs is working on the fix. 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update payment_method_cd as 1 - Check
select payment_id, provider_id, payment_type_cd, payment_method_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3218945, 3218946, 3218947)
	and delete_sw = 'N' ;

update tb_payment_header
set payment_method_cd = '1',
	update_ts = now(),
	update_user_id = 'CIDM-5243_1'
where payment_id in (3218945, 3218946, 3218947)
	and delete_sw = 'N' ;
