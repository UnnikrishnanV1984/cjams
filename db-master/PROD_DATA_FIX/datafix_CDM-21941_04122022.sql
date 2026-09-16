-- CDM-21941 - OVERPAYMENT IS NOT APPEARING IN CJAMS
/*
-- Issue Description: 
   Placement exit Date was changed nut CJMAS did not genrated the AR
   
-- Case ID: 3281842
-- Client ID: 3359335 (LESLY CRUZ) - 008899a5-e1a0-4132-9c9a-3273ab3a3d73
-- Placement ID: 1533890 - 2020-07-14 To 2022-01-15 -- d2c0ebf6-4809-449f-8413-78d1621f9fff 
-- Private Organization: 5001352 (The National Center for Children and Families, Inc.)
-- CPA Office: 5001597 (National Center for Children and Families - Futurebound IL Program)
-- Program ID: 736 (Futurebound IL) - 2006-02-01 To 2023-06-30 

-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: The Placement exit date was updated as a part of CDM-21466, 
--			where tb_placement_validation update was missed in that CDM fix.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Exit Date date to trigger Under/Over
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1533890 
	and delete_sw = 'N' 
	and placement_exit_dt = '2022-01-19'::date ;

Update cjams.tb_placement_validation 
set -- placement_entry_dt = '2020-07-14'::date,
	placement_exit_dt = '2022-01-15'::date,
	update_ts = now(),
	update_user_id = 'CDM-21941'
where placement_id = 1533890 
	and delete_sw = 'N' 
	and placement_exit_dt = '2022-01-19'::date ;
