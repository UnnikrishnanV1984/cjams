-- CDM-9625 - Pending placement validation issue
/*
-- Issue Description: 
   User has requested to delete one placement validation record where service month is beyond client's 21st Birthday
   
-- Case ID: 3259453 - Client ID: 3866180 
-- Placement ID: 326570 (04/23/2018 to 07/01/2020)
  
-- Category/ Module: Placement (Case Management) 
-- Root cause: Exception scenario; no code fix is required. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Before 
select placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd,
	validation_start_dt, validation_end_dt, delete_sw, update_ts, update_user_id
from tb_placement_validation 
where placement_validation_id = 1935553
	and delete_sw = 'N' ;

-- Update
update tb_placement_validation
	set	delete_sw = 'Y',
		update_user_id = 'CDM-9625',
		update_ts = now()
where placement_validation_id = 1935553
	and delete_sw = 'N' ;

