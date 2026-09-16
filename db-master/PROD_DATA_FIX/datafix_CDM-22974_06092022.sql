-- CDM-22974 - A/R Write Off
/*
-- Issue Description: 
   Account Receivable Write-Off approval Issue (Routing record is missing).
   Finance cannot find or see the approval button to complete the transaction.
   

-- Provider ID: 5093828	(Tamara Dt O'laughlin) - Local Department Home
-- 1) Receivable Detail ID: 1721221 - 01/01/2020 To 01/31/2020
-- AR Amount $903.96
-- AR Balance $903.96
-- Write-Off request is for $903.96

-- Provider ID: 5087346	(Sherrie B Pearson)- Local Department Home
-- 1) Receivable Detail ID: 1721081 - 02/01/2020 To 02/29/2020
-- AR Amount $845.64
-- AR Balance $845.64
-- Write-Off request is for $845.64

-- 2) Receivable Detail ID: 1721106 - 06/01/2021 To 06/30/2021
-- AR Amount $874.80
-- AR Balance $874.80
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
where receivable_detail_id in ( 1721221, 1721081, 1721106 )
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;

update 	tb_receivable_detail
set written_off_amount_no = null,
	receivable_status_cd = '19', -- Outstanding
	write_off_approval_status = null,
	write_off_request_date = null,
	written_off_request_amount_no = null,
	update_ts = now(),
	update_user_id = 'CDM-22974'
where receivable_detail_id in ( 1721221, 1721081, 1721106 )
	and delete_sw = 'N' 
	and ( select count(*) 
			from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;
