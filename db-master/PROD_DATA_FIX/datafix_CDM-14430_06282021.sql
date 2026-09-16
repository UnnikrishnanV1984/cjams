-- CDM-14430 - Child Account-Ruth Harlow
/*
-- Issue Description: 
   Child Account Available for Ancillary is displaying (-ve) -$1,918.36
-- Client ID: 1746304 (RUTH	E HARLOW) - 7ff58e88-c84f-4255-8239-cb5f91df69ae
-- Conserved Client Account ID: 9048
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Partial Transaction (data issue)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update funding approval status as 3047 - Approved
select client_id, amount, funding_approval_status, payment_approval_status, update_ts, update_user_id 
	from cjams.tb_child_account_disbursement  
where disbursement_id  in ( 1006251, 1006239 )
	and delete_sw  = 'N' ;

update cjams.tb_child_account_disbursement
set funding_approval_status = '3047',
	update_ts = now(),
	update_user_id = 'CDM-14430'
where disbursement_id  in ( 1006251, 1006239 )
	and delete_sw  = 'N' ;
 
