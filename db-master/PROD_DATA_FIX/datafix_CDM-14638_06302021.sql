-- CDM-14638 - Payment on hold
/*
-- Issue Description: 
   Newly created provider payments are on hold. 
   We need to have the payments made as soon as possible in CJAMS for this provider

-- Case ID: 2020020301922
-- Client ID: 4483523 (JAYDEN Michael SMITH) - f176d90a-9703-4f10-b231-95554328d9ae
-- Placement ID: 1564154 - 2021-04-29 To Current - ed8cab68-5604-4d84-99a0-70194a4f12bd
-- Private Organization: 6002820 (Pediatric Specialty Care at Hopewell)
-- RCC Facility: 6002890 (Pediatric Specialty Care at Hopewell - 2900 Johnson St.)
-- Program ID: 50002431 (Jayden Smith)
-- On-Hold Payments: 3050964 & 3050957 

-- Category/ Module: Account Payable (Finance Management) 
-- Root cause: Providre Batch checklist SP was having flaw in the logic.
-- Pull request# ...
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod Deployment 07/09
*/

select al_output 
from cjams.sp_financial_edits(6002820::bigint, 'CDM-14638'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 6002820 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(6002820::bigint) ;


