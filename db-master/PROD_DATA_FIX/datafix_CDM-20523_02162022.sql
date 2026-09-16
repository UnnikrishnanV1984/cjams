-- CDM-20523 - CA Disb never interfaced to D365
/*
-- Issue Description: 
   Child account for client Sidney P. #3010345 Partial Disbursement processed and approved for $1,700. 
   to First Disability Trust has not produced the payment ID or interfaced to AFS-D365.

-- Client ID: 3010345 (SIDNEY M	POSTOL) - a3ca7045-cf78-44b7-a29c-1887d9dd468d
-- Client Account ID: 11040 (# S000005080)
-- Disbursement ID: 1006683	Date: 02/08/2022 - $1700.00
-- Payment ID: 3144713 
   
-- Category/ Module: Child Account Partial Disbursement (Finance Management) 
-- Root cause: Invalid Tax ID (data issue)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove the - (hypen) from Tax ID Column.
-- Due to which payment # 3144713 is failing to interface with D365  
select client_id, amount, tax_id_no, funding_approval_status, payment_approval_status, update_ts, update_user_id 
	from cjams.tb_child_account_disbursement  
where disbursement_id = 1006683
	and delete_sw  = 'N' ;

update cjams.tb_child_account_disbursement
set tax_id_no = '266866320', -- (Old value 26-6866320)
	update_ts = now(),
	update_user_id = 'CDM-20523'
where disbursement_id = 1006683
	and delete_sw  = 'N' ;
 
