-- CDM-20334 - Duplicate Payment
/*
-- Issue Description: 
   Duplicate payments are generated for Authorization ID: 1817592.
   User request is to deleet one form CJAMS.
   
-- Case ID: 3248202
-- Client ID: 1056515 (TYNEKA L	LANKFORD)- 702cd806-ad6b-4ebb-952a-fe6231f63db9
-- Provider ID: 5076607 (Talbot Interfaith Shelter) - Rent Payments/Deposit (Paid) 
-- Service Log ID: 2031066 - 02/01/2022 To Current
-- Authorization ID: 1817592  for 02/01/2022 - $451.80	
-- Duplicate Payments IDs: 3144203 & 3144204 - Date: 02/07/2022 


-- Category/ Module: Service Purchase Authorization (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Delete duplicate payment ID 3144204
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id = 3144204
	and delete_sw  = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-20334'
where payment_id = 3144204
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3144204
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-20334'
where payment_id = 3144204
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3144204
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-20334'
where payment_id = 3144204
	and delete_sw = 'N' ;

