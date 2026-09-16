-- CDM-30505 - GAP payment did not generate
/*
-- Issue Description: 
   GAP subsidy payment (03/21/23 - 03/31/23) did not generate for Desiyrae Scott

-- Case ID: 2020035404899
-- Client ID: 3564554 (DESIYRAE	SCOTT) - 89a4826e-d4cd-4e39-8dba-05900de911b9
-- Provider ID: 6004332 (EUGENIA L FRAZIER) - Local Department Home
-- GAP ID: 1010283 - 2023-03-21 To 2025-11-09 -- fe0f5f96-7833-4632-a588-01d5cd38e38a 
-- gapagreementid: 24b7b8a5-b530-4441-ab75-5dd242cc0a2c
-- Delete gapagreementid: 7733f9be-2ed9-4a4e-baaf-c9b7424f6f8e 


-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Data issue, duplicate records in gapagreement table for the same GAP
-- Fix Provided: Datafix has been promoted to remove the duplicate GAP Agreement record and triggre under/over batch.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete duplicate GAP Agreement
select gapid, gapagreementid, activeflag, updatedby, updatedon
	from gapagreement	
where gapagreementid = '7733f9be-2ed9-4a4e-baaf-c9b7424f6f8e'
	and activeflag  = 1 ;

update gapagreement
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-30505'
where gapagreementid = '7733f9be-2ed9-4a4e-baaf-c9b7424f6f8e'
	and activeflag  = 1 ;
	
select gapid, gapagreementid, activeflag, updatedby, updatedon
	from gapagreementrevision	
where gapagreementid = '7733f9be-2ed9-4a4e-baaf-c9b7424f6f8e'
	and activeflag  = 1 ;

update gapagreementrevision
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-30505'
where gapagreementid = '7733f9be-2ed9-4a4e-baaf-c9b7424f6f8e'
	and activeflag  = 1 ;

-- Delete 
select routingid, eventcode, remarks,  activeflag, updatedby, updatedon
	from routing 	
where objectid  = '7733f9be-2ed9-4a4e-baaf-c9b7424f6f8e'
	and activeflag  = 1 ;

update routing
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-30505'
where objectid  = '7733f9be-2ed9-4a4e-baaf-c9b7424f6f8e'
	and activeflag  = 1 ;


-- Delete On HOLD Payment with NULL provider ID
select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id = 3401392
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30505'
where payment_id = 3401392
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3401392
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30505'
where payment_id = 3401392
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id = 3401392
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30505'
where payment_id = 3401392
	and delete_sw = 'N' ; 

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = 'f2aae547-17b2-48c6-a591-2b5c0c4cc1b7' ;

update gapratesrevision 
set approvaldate = now(),
	updatedby = 'CDM-30505',
	updatedon = now()
where gaprateid = 'f2aae547-17b2-48c6-a591-2b5c0c4cc1b7' ;

