-- CIDM-5663 - Need Data Fix for Tax ID - Ref CDM-25204
-- CDM-25204 - Child Account Final Disbursement
/*
-- Issue Description: 
	Child Account disbursement Tax ID number entry issue 

-- Client ID: 2677551 (AALIYAH NOEL	HILL) - 8707df25-663e-4bef-ac54-b213be71b04b
-- Foster Care Youth Saving Account ID: 1017269
-- Disbursement ID: 1007071 - $700.43 (Paymemt ID: 3234733 - 09/22/2022)  

-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: CJAMS is not allowing the user to enter 526002033 as FEIN 
-- Pull request# Uma is working on the code fix
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: NEtx Prod deployment
*/

-- Datafix to nullify the adr_street_no value for system to generate the payment

-- FEIN 52-6002033 
select client_account_id, tax_type_cd, tax_id_no, update_ts, update_user_id 
	from tb_child_account_disbursement 
where disbursement_id = 1007071
	and delete_sw  = 'N' ;

-- DESTINY'S GROUP HOME INC/ATTN: ABIGAIL ADJETEY
update tb_child_account_disbursement 
set tax_id_no = 526002033,
	update_ts = now(),
	update_user_id = 'CIDM-5663'
where disbursement_id = 1007071
	and delete_sw  = 'N' ;

