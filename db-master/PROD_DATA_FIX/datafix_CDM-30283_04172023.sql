-- CDM-30283 - AR approval stuck
/*
-- Issue Description: 
   Account Receivable Write-Off approval Issue (Routing record is missing).
   Finance cannot find or see the approval button to complete the transaction.
   
-- Provider ID: 6003129	(AMY Michelle MURPHY) - Local Department Home
-- Receivable Detail ID: 1728393 - 2021-10-01 To 2021-10-31 - $903.96
-- Write-Off request is for $903.96
    
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
where receivable_detail_id = 1728393
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;

update tb_receivable_detail
set written_off_amount_no = null, -- 903.96
	receivable_status_cd = '19', -- Outstanding -- old Value 22
	write_off_approval_status = null, -- 3045
	write_off_request_date = null, -- 2023-04-14
	written_off_request_amount_no = null, -- 0
	update_ts = now(),
	update_user_id = 'CDM-30283'
where receivable_detail_id = 1728393
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;
