-- CDM-15925 - Placement end date correction
/*
-- Issue Description: 
   User request to change the placement Exit date as 08/06/2021  (old value 07/23/2021)

-- Case ID: 3280463
-- Client ID: 4067081 (BROOKE M	HEDDINGER) - 3d1f69d9-9133-4817-b4cc-336d48fdad0c
-- Placement ID: 1563736 - 2021-06-07 To 2021-07-23 - 493ead3b-77f1-47f2-a8dc-7d837ffe628c
-- Private Organization: 5001360 (Rolling Vista Place Incorporated)
-- RCC Facility: 5092003 (Rolling Vista Place - Sinclair Greens)
-- Program: 50002360 (Group Home-5518 Sinclair Greens Dr.) - 2020-07-01 To 2022-06-30
-- Exit date change  2021-07-23 --> 2021-08-06

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '493ead3b-77f1-47f2-a8dc-7d837ffe628c'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-08-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15925'
where placementid = '493ead3b-77f1-47f2-a8dc-7d837ffe628c'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '493ead3b-77f1-47f2-a8dc-7d837ffe628c' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-08-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15925'
where placementid = '493ead3b-77f1-47f2-a8dc-7d837ffe628c'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1563736 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-08-06'::date,
	update_ts = now(),
	update_user_id = 'CDM-15925'
where placement_id = 1563736
	and delete_sw = 'N' ;
