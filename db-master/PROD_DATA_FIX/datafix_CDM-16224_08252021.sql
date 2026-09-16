-- CDM-16224 - Missing Request
/*
-- Issue Description: 
   User request to update the Payment Amount for Purchase Authorization # 1790858
   This Authorization was approved with $0 in CJAMS, and so the payment is failing to interface with D365 system. 
   
-- Case ID: 3303415
-- Client ID: 4389102 (DESAREA L WARREN)
-- Provider ID: 5064110 (Maurio Pasqualucci)
-- Authorization ID: 1790858 - Transportation assistance (Paid)
-- Payment ID: 3074510 Date: 08/20/2021
-- Payment Amount is  $210.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Payment Amount as $210.00 
select cost_no, final_amount_no, update_ts, update_user_id
	from tb_service_purchase_authorization   
where authorization_id = 1790858 
	and delete_sw = 'N' ;

update tb_service_purchase_authorization 	
set final_amount_no = 210.00,
	update_ts = now(), 
	update_user_id = 'CDM-16224'
where authorization_id = 1790858
	and delete_sw = 'N' ;
	
select payment_id, authorization_id, gross_amount_no, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3074510
	and authorization_id = 1790858 
	and delete_sw = 'N' ;
	
update tb_payment_header 	
set	gross_amount_no = 210.00,
	update_ts = now(), 
	update_user_id = 'CDM-16224'
where payment_id = 3074510
	and authorization_id = 1790858 
	and delete_sw = 'N' ;

select payment_id, payment_amount_no, final_amount_no, update_ts, update_user_id
	from tb_payment_detail 
where payment_id = 3074510 
	and delete_sw = 'N' ;
	
update tb_payment_detail	
set	payment_amount_no = 210.00,
	final_amount_no = 210.00,
	update_ts = now(), 
	update_user_id = 'CDM-16224'
where payment_id = 3074510 
	and delete_sw = 'N' ;
