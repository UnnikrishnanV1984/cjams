-- CDM-13581 - Karen Larimer A/R Module
/*
-- Issue Description: 
   Account Receivable Write-Off issue, routing record is missing.
   User has requested to update the status back to Outstanding.
   
-- Provider ID: 5040688	(Karen Larimer)	Local Department Home
-- Receivable Detail ID: 1717596 - $868.00 - 10/01/2018 To 10/31/2018
    
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Daat Issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 22   Write-Off Request
select receivable_detail_id, amount_no, receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_request_date, 
	written_off_request_amount_no, update_ts, update_user_id 
from tb_receivable_detail 
where receivable_detail_id = 1717596
	and delete_sw = 'N' ;
	
update 	tb_receivable_detail
set written_off_amount_no = null,
	receivable_status_cd = '19', -- Outstanding
	write_off_approval_status = null,
	write_off_request_date = null,
	written_off_request_amount_no = null,
	update_ts = now(),
	update_user_id = 'CDM-13581'
where receivable_detail_id = 1717596
	and delete_sw = 'N' ;
	
 