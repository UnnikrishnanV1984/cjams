-- CDM-27884 -  Client # 1079084 - ADRIAN GUZMAN - Placement Data Fix Request 
/*
-- Issue Description: 
   User request to change the placement Exit Date 
   Need to update the Exit date from blank to 2021-04-24 00:45
   
-- Case ID: 3263244
-- Client ID: 1079084 (ADRIAN GUZMAN) - 
-- Placement ID: 1556712 - 120292d8-bf60-435b-9b66-566f7a1712f7 - Exit Date to be updated as 2021-04-24 00:45

-- Category/ Module: Placements  (Case Management) 
-- Root cause: TBD
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select 	alternateid, startdatetime, starttime, enddatetime, endtime, exitreasontypekey, exittypekey, updatedby , updatedon 
from 	cjams.placement 
where 	placementid = '120292d8-bf60-435b-9b66-566f7a1712f7' and activeflag  = 1 ;

update 	cjams.placement  
set 	enddatetime = '2021-04-24 00:00:00', 
		endtime = '00:45',
		updatedon = now(), 
		updatedby = 'CDM-27884'
where 	placementid = '120292d8-bf60-435b-9b66-566f7a1712f7' and activeflag = 1 ;

-- Placement Revision Exit date & time changes
select 	entrydate, entrytime, exitdate, exittime, updatedby , updatedon  
from 	cjams.placementrevision  
where 	placementid = '120292d8-bf60-435b-9b66-566f7a1712f7' and placementrevisionid = '05dbeb2f-a2df-4412-b321-832b2717cc15';

update 	cjams.placementrevision  
set 	exitdate = '2021-04-24 00:00:00',
		updatedon = now(), 
		updatedby = 'CDM-27884'
where 	placementid = '120292d8-bf60-435b-9b66-566f7a1712f7' and placementrevisionid = '05dbeb2f-a2df-4412-b321-832b2717cc15';

-- Placement Validation 
select 	placement_id, placement_entry_dt , placement_exit_dt, validation_start_dt, validation_end_dt, 
		validation_status_cd, update_ts, update_user_id, delete_sw 
from 	cjams.tb_placement_validation 
where 	placement_id  = 1556712 and delete_sw = 'N' ;

Update 	cjams.tb_placement_validation 
set 	-- placement_entry_dt = '2021-09-01'::date,
		placement_exit_dt = '2021-04-24'::date,
		update_ts = now(),
		update_user_id = 'CDM-27884'
where 	placement_id = 1556712 and delete_sw = 'N';
