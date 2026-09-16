-- CDM-20919 - Missing payment
/*
-- Issue Description: 
   Child has been in placement since 11/19/2021. 
   Placement is approved and no outstanding placement validations but provider has only been paid for January. 
   Provider has not received payment for November of December.

-- Case ID: 211030010451
-- Client ID: 200799604	(Navariante Willis) - f3a7bf48-79db-4b2e-b810-73822d27d2b7
-- Placement ID: 1569379 - 2021-11-19 To Current - 9c1f328e-6150-4b9f-871d-294116c8c0b3
-- Provider ID: 5093809	(Lakesha Monroe) 

-- Category/ Module: Account Receivable (Finance Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod Deployment
*/

-- Data fix to trigger Under Over batch for Nov/Dec 2021 payments 
select placement_id, placement_entry_dt, placement_exit_dt,  validation_start_dt, validation_end_dt,
	validation_status_cd, update_ts, update_user_id 
from tb_placement_validation 
where placement_validation_id in ( 1987998, 1987997 )
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-20919'
where placement_validation_id in ( 1987998, 1987997 )
	and delete_sw = 'N' ;

