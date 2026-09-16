-- CDM-23252 - Payment Disbursement Not Working
/*
-- Issue Description: 
	The final step of the payment disbursement for Caden Brower will not go through. 

-- Client ID: 4486699 (CADEN M BROWER) - a10ff499-868c-482c-bdf3-5e2684eb383e
-- Account # 0004795728 (Foster Care Youth Saving)
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: This error is happening due to the Address field "Flat/PO Box No".
			   This field length cannot be more than 10 characters, currently CJAMS is not having any validation on UI side.
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Datafix to nullify the adr_street_no value for system to generate the payment
select disbursement_id, client_account_id,  adr_street_no, update_ts, update_user_id  
	from tb_child_account_disbursement 
where disbursement_id = 1006937
	and delete_sw  = 'N' ;

-- Old Value "FBO Caden Brower 150098"
update tb_child_account_disbursement 
set adr_street_no = '',
	update_ts = now(),
	update_user_id = 'CDM-23252'
where disbursement_id = 1006937
	and delete_sw  = 'N' ;

