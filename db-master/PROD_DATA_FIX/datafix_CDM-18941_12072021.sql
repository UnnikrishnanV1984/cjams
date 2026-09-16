-- CDM-18941 - Service Log Approval
/*
-- Issue Description: 
   User request to update the Payment Amount for Purchase Authorization # 1806336
   "Actual Amount" from $2,500.00 to $2,000.00 and the payment is not yet Interfaced with D365 system. 
   
-- Case ID: 3283442
-- Client ID: 3496563 (ERIN	E HARDESTY) - 886a4d5e-ff60-44ae-835b-2340b32ef740
-- Provider ID: 5090182 (Professional Psychological Services)
-- Authorization ID: 1806336 - Psychological Evaluation (Paid) 
-- Payment ID: 3119598 Date: 12/07/2021
-- Payment Amount is  $2500.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Payment Amount as $2000.00

select authorization_id, cost_no, final_amount_no, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1806336 
	and delete_sw = 'N' ;

update tb_service_purchase_authorization 	
set cost_no = 2000.00,
	final_amount_no = 2000.00,
	update_ts = now(), 
	update_user_id = 'CDM-18941'
where authorization_id = 1806336
	and delete_sw = 'N' ;
	
select authorization_id, cost_no, final_amount_no, update_ts, update_user_id  
	from tb_slpa_snapshot 
where authorization_id  = 1806336
	and delete_sw = 'N' ;

update tb_slpa_snapshot
	set cost_no = 2000.00,
	final_amount_no = 2000.00,
	update_ts = now(), 
	update_user_id = 'CDM-18941'
where authorization_id  = 1806336
	and delete_sw = 'N' ;

select payment_id, authorization_id, gross_amount_no, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3119598
	and authorization_id = 1806336 
	and delete_sw = 'N' ;
	
update tb_payment_header 	
set	gross_amount_no = 2000.00,
	update_ts = now(), 
	update_user_id = 'CDM-18941'
where payment_id = 3119598
	and authorization_id = 1806336 
	and delete_sw = 'N' ;

select payment_id, payment_amount_no, final_amount_no, update_ts, update_user_id
	from tb_payment_detail 
where payment_id = 3119598 
	and delete_sw = 'N' ;
	
update tb_payment_detail	
set	payment_amount_no = 2000.00,
	final_amount_no = 2000.00,
	update_ts = now(), 
	update_user_id = 'CDM-18941'
where payment_id = 3119598 
	and delete_sw = 'N' ;
