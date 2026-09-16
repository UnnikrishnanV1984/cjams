-- CDM-23218 - Final Disbursement from FYS account
/*
-- Issue Description: 
	We are trying to approve a Final Disbursement from a Foster Youth Savings account 
	and it won't approve even though it says it has but it does not leave the dashboard.

-- Client ID: 200012261 (Jayla Brown) - 1db8bdd3-d365-4f88-97d8-1dac75162f7f
-- Foster Care Youth Saving Account ID: 1017085 (F360216) - $700.05
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: This error is happening due to the Address field "Flat/PO Box No".
			   This field length cannot be more than 10 characters, currently CJAMS is not having any validation on UI side.
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Datafix to nullify the adr_street_no value for system to generate the payment
select disbursement_id, client_account_id,  adr_street_no, payee_nm, update_ts, update_user_id  
	from tb_child_account_disbursement 
where disbursement_id = 1006878
	and delete_sw  = 'N' ;

-- Old Value "FBO Caden Brower 150098"
update tb_child_account_disbursement 
set adr_street_no = '',
	payee_nm = payee_nm || ' (c/o: Jayla Brown)',
	update_ts = now(),
	update_user_id = 'CDM-23218'
where disbursement_id = 1006878
	and delete_sw  = 'N' ;
