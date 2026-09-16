-- CDM-15408 - Change placement date
/*
-- Issue Description: 
   User request to change the placement Exit date as 11/06/2020  (old value 03/01/2021)

-- Case ID: 3241202
-- Client ID: 3626779 (MALEEK THOMAS) - ebd6b652-1b43-4077-97d2-53deb970dec2
-- Placement ID: 334628 - 2019-04-04 To 2021-03-01 - 86035cba-6c10-4d3f-9907-565838f9ccc2
-- Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)
-- RCC Facility: 5000649 (Board Of Child Care Colesville Group Home)
-- Program: 1098 (Colesville 54 Randolph Rd GH) - 2006-07-01 To 2021-03-31
-- Exit date change  2021-03-01 --> 2020-11-06 

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
where placementid = '86035cba-6c10-4d3f-9907-565838f9ccc2'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-11-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15408'
where placementid = '86035cba-6c10-4d3f-9907-565838f9ccc2'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '86035cba-6c10-4d3f-9907-565838f9ccc2' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-11-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15408'
where placementid = '86035cba-6c10-4d3f-9907-565838f9ccc2'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 334628 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-11-06'::date,
	update_ts = now(),
	update_user_id = 'CDM-15408'
where placement_id = 334628
	and delete_sw = 'N' ;

-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 334628 
	and placement_validation_id in ( 1950696, 1947241, 1943889 )
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-15408'
where placement_id = 334628 
	and placement_validation_id in ( 1950696, 1947241, 1943889 )
	and delete_sw  = 'N';
