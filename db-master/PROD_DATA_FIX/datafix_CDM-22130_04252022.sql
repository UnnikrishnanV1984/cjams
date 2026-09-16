-- CDM-22130 -- OVERPAYMENT FOR JANUARY SERVICE PERIOD IS NOT APPEARING ON THE OVERPAYMENT SCREEN
/*
-- Issue Description: 
   Overpayment for service period 1/17/2022-1/31/2022 is not appearing on the overpayment screen.

-- Case ID: 3296515
-- Client ID: 2645708 (DIAMOND MERRICKS) - e9d32c35-966a-4b88-8ff3-5ebfee14c1da
-- Placement ID: 1568709 - 2021-07-24 To 2022-01-17 - f83556c2-ee78-43c0-92ac-76928aaa4e4b
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5089879 (Independence Plus/Second Gen Towson)
-- Program ID: 50002475 (D. Merricks w/2 children)
	
-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Partial Transaction; Placement was exited but tb_placement_validation update did not happen.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update Exit Date date to trigger Under/Over
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1568709 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set -- placement_entry_dt = '2021-07-24'::date,
	placement_exit_dt = '2022-01-17'::date,
	update_ts = now(),
	update_user_id = 'CDM-22130'
where placement_id = 1568709 
	and delete_sw = 'N' ;
