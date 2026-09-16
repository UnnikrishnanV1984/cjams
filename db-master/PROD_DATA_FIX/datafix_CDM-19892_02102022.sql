-- CDM-19892 - Providers with HOLD Payments and NO Withhold Payment Checkbox checked
/*
-- Issue Description: 
   Providers with HOLD Payments and NO Withhold Payment Checkbox checked

-- Category/ Module: Account Payable (Finance Management) 
-- Root cause: This error happened on 12/01/2021 & 01/01/2022 during our CJAMS Payment batch runs 
			   Provider Batch Checklist SP falied due to provider data issue.
			   The permanent code fix to avoid such failures in the future was deployed in production on 01/12/2022.
-- Pull request# CIDM-4135
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Payment Status updated as "Released" as Provider Already Paid
select payment_id, payment_status_cd, update_ts, update_user_id 
	from tb_payment_status 
where payment_id in ( 1978222, 1891309, 1459073 )
	and payment_status_cd = '1635'
	and delete_sw  = 'N' ;
	
update tb_payment_status 
set payment_status_cd = '1639', -- Released
	update_ts = now(),
	update_user_id = 'CDM-19892'
where payment_id in ( 1978222, 1891309, 1459073 )
	and payment_status_cd = '1635'
	and delete_sw  = 'N' ;


-- Release Payments Confirmation received for the following Providers:
--------------------------------------------------------------------------
-- 5094962 (Robin Lucille Ruffley) - St. Mary's - Melissa Evick	
select al_output 
from cjams.sp_financial_edits(5094962::bigint, 'CDM-19892'::character varying, 'N'::character) ;

select provider_id, withhold_payment_sw, update_ts, update_user_id 
	from prov.tb_provider 
where provider_id  = 5094962
	and delete_sw  = 'N' ;

update prov.tb_provider
	set withhold_payment_sw = 'N'
where provider_id  = 5094962
	and delete_sw  = 'N' 
	and withhold_payment_sw = 'Y' ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 5094962 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(5094962::bigint) ;

-- 5095605 (Lewis Albert Mills) - Washington - Barry	
select al_output 
from cjams.sp_financial_edits(5095605::bigint, 'CDM-19892'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 5095605 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(5095605::bigint) ;


-- 5083581 (Sara Winterling) - Baltimore City - Debra Dandridge	
select al_output 
from cjams.sp_financial_edits(5083581::bigint, 'CDM-19892'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 5083581 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(5083581::bigint) ;

-- 5008466	(Carolyn Smith) - Montgomery -	Brad W and Crystal
select al_output 
from cjams.sp_financial_edits(5008466::bigint, 'CDM-19892'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 5008466 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(5008466::bigint) ;

-- 6001927 (SHAUNTA A THOMAS) - Baltimore City - Debra Dandridge
select al_output 
from cjams.sp_financial_edits(6001927::bigint, 'CDM-19892'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 6001927 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(6001927::bigint) ;

-- 5096558 (Niambi Peace) - Baltimore City - Debra Dandridge
select al_output 
from cjams.sp_financial_edits(5096558::bigint, 'CDM-19892'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 5096558 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(5096558::bigint) ;

-- 5058861 (Barbara L Smith) - Baltimore City - Debra Dandridge
select al_output 
from cjams.sp_financial_edits(5058861::bigint, 'CDM-19892'::character varying, 'N'::character) ;

select ph.payment_id, ph.payment_dt, ph.gross_amount_no, ps.payment_status_cd 
from tb_payment_header ph,
	tb_payment_status ps 
where ph.payment_id = ps.payment_id 
	and ph.provider_id = 5058861 
	and ph.delete_sw = 'N'
	and ps.delete_sw = 'N' 
	and ps.payment_status_cd = '1635';

select * from cjams.sp_release_payments(5058861::bigint) ;

/*
Usre requested to update Payment Status as "Released" as Provider Already Paid
-------------------------------
5083400	(Angela Blue-Williams)				 - Prince George's - Mavis
5000978	(Sheppard Pratt Health System, Inc.) - DHS/Central/T Barnes	- Tyra
*/
