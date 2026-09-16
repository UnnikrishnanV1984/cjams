-- CDM-23649 - Approval not processed
/*
-- Issue Description: 
	I have approved the funding disbursement for the Foster Youth and the conversed accounts multiple times. 
	But the approval is not registering in CJAMS.

-- Client ID: 1051188 (MALACHAI	I WILLIAMS) - a942b7a8-d70b-428b-aaf8-3b45293dd538
-- Conserved Account ID: 14717 - Balance $2036.07
-- Foster Care Youth Saving Account ID: 1016815 - Balance $3610.69
  
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: This error is happening due to the Address field "Flat/PO Box No".
			   This field length cannot be more than 10 characters, currently CJAMS is not having any validation on UI side.
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Datafix to nullify the adr_street_no value for system to generate the payment

-- Conserved Account ID: 14717 - Balance $2036.07
select disbursement_id, client_account_id,  adr_street_no, payee_nm, update_ts, update_user_id  
	from tb_child_account_disbursement 
where disbursement_id = 1006933
	and delete_sw  = 'N' ;

-- DESTINY'S GROUP HOME INC/ATTN: ABIGAIL ADJETEY
update tb_child_account_disbursement 
set adr_street_no = '',
	payee_nm = payee_nm || ' (ATTN: ABIGAIL ADJETEY)',
	update_ts = now(),
	update_user_id = 'CDM-23649'
where disbursement_id = 1006933
	and delete_sw  = 'N' ;

-- Foster Care Youth Saving Account ID: 1016815 - Balance $3610.69
select disbursement_id, client_account_id,  adr_street_no, payee_nm, update_ts, update_user_id  
	from tb_child_account_disbursement 
where disbursement_id = 1006934
	and delete_sw  = 'N' ;

-- Old Value "DESTINY'S GROUP HOME INC/ATTN: ABIGAIL ADJETEY"
update tb_child_account_disbursement 
set adr_street_no = '',
	payee_nm = payee_nm || ' (ATTN: ABIGAIL ADJETEY)',
	update_ts = now(),
	update_user_id = 'CDM-23649'
where disbursement_id = 1006934
	and delete_sw  = 'N' ;
