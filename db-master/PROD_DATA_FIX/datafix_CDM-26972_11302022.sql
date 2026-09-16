-- CDM-26972 - WithHold Payment
/*
-- Issue Description: 
	Courtney Williams (6004931) There is a HOLD on the providers payments. 
	CJAMS does not indicate the reason for the "HOLD". 
	The "WithHold Payment" in the providers profile is not flagged. 

-- Provider ID: 6004931 (Courtney Rapheal Williams) - Local Department Home
-- On Hold Payments
-- Payment ID	Date		Amount
-------------------------------
-- 3249409		11/13/2022	$903.96
-- 3246330		10/19/2022	$874.80
-- 3225222		09/13/2022	$903.96 

-- Category/ Module: Account Payable (Finance Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select al_output 
from cjams.sp_financial_edits(6004931::bigint, 'CDM-26972'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 6004931 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(6004931::bigint) ;
