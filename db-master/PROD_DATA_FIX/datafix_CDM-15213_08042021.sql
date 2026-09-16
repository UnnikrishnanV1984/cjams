-- CDM-15213 - Placement error
/*
-- Issue Description: 
   User request to change the placement Exit date as 11/06/2020 (old value 03/01/2021)
   
-- Case ID: 3211148
-- Client ID: 1450370 (ROBERT EDWARD REED) - c1377335-39c4-4bbb-9d27-27ef3d3cc946
-- Placement ID: 288853 - 2013-11-14 To 2021-03-01 - b71f83c1-4ed4-4a72-b6bc-21701b8928d0
-- Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)
-- RCC Facility: 5000650 (Board of Child Care Main Campus Gaither Rd)
-- Program: 1590 (Main Campus 3300 Gaither Rd - High Intensity) - 2006-07-01 To 2021-03-31
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
where placementid = 'b71f83c1-4ed4-4a72-b6bc-21701b8928d0'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-11-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15213'
where placementid = 'b71f83c1-4ed4-4a72-b6bc-21701b8928d0'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'b71f83c1-4ed4-4a72-b6bc-21701b8928d0' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-11-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15213'
where placementid = 'b71f83c1-4ed4-4a72-b6bc-21701b8928d0'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 288853 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-11-06'::date,
	update_ts = now(),
	update_user_id = 'CDM-15213'
where placement_id = 288853
	and delete_sw = 'N' ;

-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 288853 
	and placement_validation_id in ( 1949846, 1946349, 1942956 )
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-15213'
where placement_id = 288853 
	and placement_validation_id in ( 1949846, 1946349, 1942956 )
	and delete_sw  = 'N';
