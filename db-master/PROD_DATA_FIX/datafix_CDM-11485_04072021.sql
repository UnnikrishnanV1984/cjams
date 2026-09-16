-- CDM-11485 - Child Account Module: Balances and FM106
/*
-- Issue Description: 
   Child Account Available for Ancillary is displaying (-ve) -$2,782.51
   Client ID: 1487478 (IMRAN RANA)
   CLIENT_ACCOUNT_ID : 11829
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Partial Transaction (data issue)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update fundinf approval status as 3047 - Approved
select client_id, amount, funding_approval_status, payment_approval_status, update_ts, update_user_id 
	from cjams.tb_child_account_disbursement  
where disbursement_id = 1006029
	and delete_sw  = 'N' ;

update cjams.tb_child_account_disbursement
set funding_approval_status = '3047',
	update_ts = now(),
	update_user_id = 'CDM-11485'
where disbursement_id = 1006029
	and delete_sw  = 'N' ;
 
