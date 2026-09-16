-- CDM-28152 - 
/*
-- Issue Description: 
   User request to change the placement Exit Date 
   Need to update the Exit date from 01/18/2023 12:30 PM to 8/30/2022 12 AM
   
-- Case ID: 3098103
-- Client ID: 1079084 (ADRIAN GUZMAN) - 
-- Placement ID: 332385 - 8a8ec43f-31ac-4aaa-b3f4-7e476663695a - Exit Date to be updated as 8/30/2022 12 AM

-- Category/ Module: Placements  (Case Management) 
-- Root cause: TBD
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select 	alternateid, startdatetime, starttime, enddatetime, endtime, exitreasontypekey, exittypekey, updatedby , updatedon 
from 	cjams.placement 
where 	placementid = '8a8ec43f-31ac-4aaa-b3f4-7e476663695a' and activeflag  = 1 ;

update 	cjams.placement  
set 	enddatetime = '2022-08-30 00:00:00', 
		endtime = '00:00',
		updatedon = now(), 
		updatedby = 'CDM-28152 '
where 	placementid = '8a8ec43f-31ac-4aaa-b3f4-7e476663695a' and activeflag = 1 ;

-- Placement Revision Exit date & time changes
select 	entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
from 	cjams.placementrevision  
where 	placementid = '8a8ec43f-31ac-4aaa-b3f4-7e476663695a' and placementrevisionid = 'abf73624-12e4-4c25-93fb-52a48565c033';

update 	cjams.placementrevision  
set 	exitdate = '2022-08-30 00:00:00',
		updatedon = now(), 
		updatedby = 'CDM-28152 '
where 	placementid = '8a8ec43f-31ac-4aaa-b3f4-7e476663695a' and placementrevisionid = 'abf73624-12e4-4c25-93fb-52a48565c033';

-- Placement Validation 
select 	placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
		validation_status_cd, update_ts, update_user_id, delete_sw 
from 	cjams.tb_placement_validation 
where 	placement_id  = 332385 and delete_sw = 'N' ;

Update 	cjams.tb_placement_validation 
set 	-- placement_entry_dt = '2021-09-01'::date,
		placement_exit_dt = '2022-08-30'::date,
		update_ts = now(),
		update_user_id = 'CDM-28152 '
where 	placement_id = 332385 and delete_sw = 'N';
