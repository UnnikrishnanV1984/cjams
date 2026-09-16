/*
-- CJAMS-68188 - Write Approval Pending
-- Provider ID: 5025229  (Cathy Smith)
-- Receivable Detail ID: 676304 
-- Write-Off request is for both $765.25
-- Category/ Module: Account Receivables (Finance Management) 
-- Root Cause: Partial Transaction (It was submitted to be written off many years ago but never approved.)
-- Fix Provided: Datafix has been promoted to update the AR status back to outstanding
-- Pull Request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_receivable_detail
set receivable_status_cd = '19', -- Outstanding -- old Value 22
	write_off_approval_status = null, -- 3045
	update_ts = now(),
	update_user_id = 'CJAMS-68188'
where receivable_detail_id = 676304 
	and delete_sw = 'N' 
	and ( select count(*) from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;
		
	
