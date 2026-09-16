-- CDM-15393 - Write Off Button Missing
/*
-- Issue Description: 
   Account Receivable Write-Off approval Issue (Routing record is missing).
   
-- Provider ID: 5080957 (Tikisha Jenkins) - Local Department Home
-- Receivable Detail ID: 1718803 - $874.80 - 09/01/2020 To 09/30/2020
    
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Data Issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 22   Write-Off Request
select receivable_detail_id, amount_no, receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_request_date, 
	written_off_request_amount_no, comments_tx, update_ts, update_user_id  
from tb_receivable_detail 
where receivable_detail_id = 1718803
	and delete_sw = 'N' ;

	
update 	tb_receivable_detail
set written_off_amount_no = null,
	receivable_status_cd = '19', -- Outstanding
	write_off_approval_status = null,
	write_off_request_date = null,
	written_off_request_amount_no = null,
	update_ts = now(),
	update_user_id = 'CDM-15393'
where receivable_detail_id = 1718803
	and delete_sw = 'N' ;
