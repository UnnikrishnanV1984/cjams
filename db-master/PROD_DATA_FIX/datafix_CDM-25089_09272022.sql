-- CDM-25089 - Write Off Request
/*
-- Issue Description: 
   Account Receivable Write-Off approval Issue (Routing record is missing).
   Finance cannot find or see the approval button to complete the transaction.
   
-- Provider ID: 6004294 (Phyllis A Thomas) -  Local Department Home
-- Receivable Detail ID: 1722394 - 04/01/2022 To 04/30/2022
-- Write-Off request is for $874.80
    
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
where receivable_detail_id = 1722394
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;

update tb_receivable_detail
set written_off_amount_no = null,
	receivable_status_cd = '19', -- Outstanding
	write_off_approval_status = null,
	write_off_request_date = null,
	written_off_request_amount_no = null,
	update_ts = now(),
	update_user_id = 'CDM-25089'
where receivable_detail_id = 1722394
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;
