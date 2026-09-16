-- CDM-19122 - Payment issue again
/*
-- Issue Description: 
   Please fix so this doesnt occur every month. 
   Provider, Donna Fayer payment not going out as it should.

-- Case ID: 3172366
-- Client ID: 2568057 (CARSON EDWARD WILLIAMS) - dde873f2-1d56-4379-a387-853a833c476b
-- Provider ID: 5095829 (Donna Fayer) - Local Department Home

-- On-Hold Payment: 3118054 

-- Category/ Module: Account Payable (Finance Management) 
-- Root cause: Provider Picklist Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Provider Picklist Data fix
-- 5058560	Ruthann Aitkins	Local Department Home
select provider_picklist_id, provider_picklist_id, picklist_value_cd, delete_sw, update_ts, update_user_id 
	from tb_provider_picklist
where provider_picklist_id = 50753008
	and provider_id = 5058560
	and picklist_type_id = 155
	and delete_sw = 'N' ;

update tb_provider_picklist
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19122'
where provider_picklist_id = 50753008
	and provider_id = 5058560
	and picklist_type_id = 155
	and delete_sw = 'N' ;

select al_output 
from cjams.sp_financial_edits(5095829::bigint, 'CDM-19122'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 5095829 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(5095829::bigint) ;

