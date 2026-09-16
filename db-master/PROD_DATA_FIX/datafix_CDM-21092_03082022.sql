-- CDM-21092 - Final Disbursement stuck
/*
-- Issue Description: 
	Finance staff started a Final Disbursement before the interest was put in for February. 
	I denied the approval so that we could add the interest to the amount. 
	It won't let me do anything to the record so that I can add the interest 
	and then we can resubmit for Final Disbursement.
   
-- Carroll County
-- Client ID: 3582246 (MARGARET	JEAN ECKENRODE) - cb0581d0-0700-4770-a615-27c9c9602725
-- Foster Care Youth Saving Account ID: 1015858 (#F300021) - $4458.07
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Datafix to update funding approval status as 3281 - Denied
select client_account_id, client_id, amount, funding_approval_status, payment_approval_status, update_ts, update_user_id 
	from cjams.tb_child_account_disbursement  
where disbursement_id = 1006715
	and delete_sw  = 'N' ;

update cjams.tb_child_account_disbursement
set funding_approval_status = '3281',
	update_ts = now(),
	update_user_id = 'CDM-21092'
where disbursement_id = 1006715
	and delete_sw  = 'N' ;
 
