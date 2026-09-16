-- CDM-28824 - 5013805 Jan & feb payment missing 
/*
-- Issue Description: 
   To generate missing Adoption payments for Jan & Feb 2023
   
-- Adoption Case ID: 3138297
-- Client # 1753231	(BRYLEIGH M	ADDISON) - 1ee6063e-e6cd-44ab-a71c-4f6a7fe4cffc
-- Provider ID: 5013805	(Margurite Addison)
-- Adoption ID: 13472 - 2004-05-27 To 2023-07-27 - 676a0676-4192-49bd-b0ac-4fc13d7bc2a4

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no info on Home Approval.
--				Code fix and the datafix was promoted to update provider information with prior fix.
--				This additional fix is to generate the missing payment for Jan & Feb 2023
-- Fix Provided: Datafix has been promoted to remove the invalid on-hold payments and generate the missing payments.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Trigger Under_over
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '64f7f5ca-cfb8-4d23-8eb9-299a8d0e3131'
	and adoptionagreementrateid = 'aa237117-8bfc-4433-ae40-4e83a07942d0';

update adoptioncaserevision
set provider_id = 5013805,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-28824'
where adoptionagreementid = '64f7f5ca-cfb8-4d23-8eb9-299a8d0e3131'
	and adoptionagreementrateid = 'aa237117-8bfc-4433-ae40-4e83a07942d0';

-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3353650, 3373485)
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-28824'
where payment_id in (3353650, 3373485)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3353650, 3373485)
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-28824'
where payment_id in (3353650, 3373485)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3353650, 3373485)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-28824'
where payment_id in (3353650, 3373485)
	and delete_sw = 'N' ;
