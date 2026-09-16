-- CDM-24365 - AR Wite-Off request is lost in approval path
/*
-- Issue Description: 
	I submitted Receivable ID 1722952 for $596.13, to Amy Robinson to approved 
	the request on 8/10/22. It never showed up in her Dashboard under Write-Offs.
	Can you reset this request so that I can re-submit it for Supervisory approval?

-- Provider ID: 5039888 (Mirian Santoni) - Local Department Home
-- Receivable Detail ID: 1722952 - 08/01/2015 To 08/31/2015
-- AR Amount $596.13 - AR Balance $596.13
-- Write-Off request is for $596.13
    
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
where receivable_detail_id = 1722952
	and delete_sw = 'N' ;
	
update 	tb_receivable_detail
set written_off_amount_no = null,
	receivable_status_cd = '19', -- Outstanding
	write_off_approval_status = null,
	write_off_request_date = null,
	written_off_request_amount_no = null,
	update_ts = now(),
	update_user_id = 'CDM-24365'
where receivable_detail_id = 1722952
	and delete_sw = 'N' ;
