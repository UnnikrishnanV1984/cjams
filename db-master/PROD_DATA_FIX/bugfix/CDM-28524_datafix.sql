-- CDM-28524 - Pending A/R approval
/*
-- Issue Description: 
   Account Receivable Write-Off approval Issue (Routing record is missing).
   Finance cannot find or see the approval button to complete the transaction.
   
-- Provider ID: 5013071 (Doris Martin) - Local Department Home
-- Receivable Detail ID: 1726506 - 12/01/2021 To 12/31/2021 - $816.48
-- Write-Off request is for $816.48
    
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Partial Transacion (This is a data issue, Write-Off requests routing record is missing)
-- Fix Provided: Datafix has been promoted to update the AR status back to Outstanding. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 22   Write-Off Request
select receivable_detail_id, amount_no, receivable_balance_no, written_off_amount_no, 
	receivable_status_cd, write_off_approval_status, write_off_request_date, 
	written_off_request_amount_no, comments_tx, update_ts, update_user_id  
from tb_receivable_detail 
where receivable_detail_id = 1726506
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;

update tb_receivable_detail
set written_off_amount_no = null, -- 816.48
	receivable_status_cd = '19', -- Outstanding -- old Value 22
	write_off_approval_status = null, -- 3045
	write_off_request_date = null, -- 2022-04-05
	written_off_request_amount_no = null, -- 0
	update_ts = now(),
	update_user_id = 'CDM-28524'
where receivable_detail_id = 1726506
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;
