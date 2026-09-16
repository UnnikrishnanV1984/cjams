-- CDM-16276 - Incorrect end date
/*
-- Issue Description: 
   User request to change the placement Exit date as 12/29/2020  (old value 02/04/2021)

-- Case ID: 3221787
-- Client ID: 1722787 (PAUL	E BOSTON) - 2005e795-80e9-4f9a-860c-63e9fee96025
-- Placement ID: 1565751 - 2020-12-03 To 2021-02-04 - cc73bd8a-a4dd-417d-98a2-ba512c10b1a8
-- Private Organization: 5001352 (The National Center for Children and Families, Inc.)	
-- CPA Office: 5001295 (National Center for Children and Families  CPA)	
-- Program: 735	(TFC - National Center for Children and Families) - 2006-02-01 To 2022-06-30

-- Exit date change  2021-02-04 --> 2020-12-29

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Exit date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'cc73bd8a-a4dd-417d-98a2-ba512c10b1a8'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-12-29 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-16276'
where placementid = 'cc73bd8a-a4dd-417d-98a2-ba512c10b1a8'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'cc73bd8a-a4dd-417d-98a2-ba512c10b1a8' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-12-29 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-16276'
where placementid = 'cc73bd8a-a4dd-417d-98a2-ba512c10b1a8'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1565751 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-12-29'::date,
	update_ts = now(),
	update_user_id = 'CDM-16276'
where placement_id = 1565751
	and delete_sw = 'N' ;

-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1565751 
	and placement_validation_id in ( 1970797, 1970796, 1970795, 1970794, 1970793, 1970792, 1970791 )
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16276'
where placement_id = 1565751 
	and placement_validation_id in ( 1970797, 1970796, 1970795, 1970794, 1970793, 1970792, 1970791 )
	and delete_sw  = 'N';
