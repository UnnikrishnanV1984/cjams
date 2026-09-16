/*
-- CJAMS-68912 - Write Approval Pending
-- Issue Description: Account Receivable Write-Off approval Issue (Routing record is missing).
   Finance cannot find or see the approval button to complete the transaction.
   Provider ID: 5096254 (Elizabeth Albert)
   Client ID: 4226444 (NATALIA DAVIS)
   Receivable ID: 1728763
-- Category/ Module: Account Receivables (Finance Management) 
-- Root Cause: Partial Transaction (This is a data issue, Write-Off requests routing record is missing)
-- Fix Provided: Datafix has been promoted to update the AR status back to outstanding 
	         (This is a data issue, Write-Off requests routing record is missing).  
		  User can do the Write-Off for that AR again.
-- Pull Request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update tb_receivable_detail
set written_off_amount_no = null, -- 903.96
	receivable_status_cd = '19', -- Outstanding -- old Value 22
	write_off_approval_status = null, -- 3045
	write_off_request_date = null, -- 2022-04-11
	written_off_request_amount_no = null, -- 0
	update_ts = now(),
	update_user_id = 'CJAMS-68912'
where receivable_detail_id = 1728763
	and delete_sw = 'N' 
	and ( select count(*) from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;