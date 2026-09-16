-- CDM-13406 - Adoption subsidy payment
/*
-- Issue Description: 
    The adoption subsidy payment for 4/1/21 has a HOLD status. 
	Not sure what this is and the adoptive parent did not receive the payment 
	which was to be issued on 4/1/21. Please advise.
   
-- Adoption Case ID: 3201552 - rebecca.burger@maryland.gov
-- Client ID: 3248664 (CAITLYN MORGAN REESE) - 011a4b36-b764-4512-be40-d3d36b86c247
-- Provider ID: 5034841	(Teresa Reese)
-- Payment ID: 3017641 - $425.63 (On-hold) - March 2021 Services

-- Category/ Module: Account Payable (Finance Management) 
-- Root cause: Provider Address Data issue.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id  = ps.payment_id 
	and ph.provider_id  = 5034841 
	and ph.delete_sw  = 'N'
	and ps.delete_sw  = 'N' 
	and ps.payment_status_cd = '1635' ;

select * from cjams.sp_release_payments(5034841::bigint) ;

