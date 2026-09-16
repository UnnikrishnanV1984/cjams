-- CDM-14220 - Placement validation dates
/*
-- Issue Description: 
   Datafix to update Placement Exit date in tb_placement_validation table.
   Placement Exit Date was fix with CDM-13876 (tb_placement_validation was missed in that fix)
   
-- Case ID: 3248658
-- Client ID: 3734769 (ANGELA MARTINEZ) - a727bf3b-df0d-414d-b42e-c556845f56d3
-- Placement ID: 340215 - 04/07/2020 To 05/25/2021 - 501061f0-22d8-48a2-95b4-2d844242a5ee
-- Private Organization: 5001352 (The National Center for Children and Families, Inc.)
-- CPA Office: 5001295 (National Center for Children and Families  CPA)
-- Program ID: 735 (TFC - National Center for Children and Families) - 2006-02-01 To 2022-06-30
	
-- Category/ Module: Placement Validation (Case Management) 
-- Root cause: Update was missed in the prior fix.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select placement_id, placement_entry_dt, placement_exit_dt,  validation_start_dt, validation_end_dt,
	validation_status_cd, update_ts, update_user_id 
from tb_placement_validation 
where placement_id  = 340215
	and delete_sw  = 'N' ;


update tb_placement_validation
set placement_exit_dt = '2021-05-25'::date,
	update_ts = now(),
	update_user_id = 'CDM-14220'
where placement_id  = 340215
	and delete_sw  = 'N' ;
