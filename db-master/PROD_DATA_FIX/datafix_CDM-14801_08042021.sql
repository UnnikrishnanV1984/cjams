-- CDM-14801 - Wrong placement
/*
-- Issue Description: 
   User request to change the placement Exit date as 11/18/2020 (old value 03/01/2021)
   
-- Case ID: 3208036
-- Client ID: 1072643 (DANIEL P	JOHNSON) - 212e649f-9de6-45b7-b4d5-0f6005ceeed7
-- Placement ID: 322143 - 2017-09-21 To	2021-03-01 - cde42fd1-fdc2-4804-a70f-66162c185378
-- Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)
-- RCC Facility: 5000650 (Board of Child Care Main Campus Gaither Rd)
-- Program: 1590 (Main Campus 3300 Gaither Rd - High Intensity) - 2006-07-01 To 2021-03-31
-- Exit date change  2021-03-01 --> 2020-11-18 


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
where placementid = 'cde42fd1-fdc2-4804-a70f-66162c185378'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-11-18 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14801'
where placementid = 'cde42fd1-fdc2-4804-a70f-66162c185378'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'cde42fd1-fdc2-4804-a70f-66162c185378' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-11-18 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14801'
where placementid = 'cde42fd1-fdc2-4804-a70f-66162c185378'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 322143 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-11-18'::date,
	update_ts = now(),
	update_user_id = 'CDM-14801'
where placement_id = 322143
	and delete_sw = 'N' ;

-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 322143 
	and placement_validation_id in ( 1950058, 1946569, 1943186 )
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-14801'
where placement_id = 322143 
	and placement_validation_id in ( 1950058, 1946569, 1943186 )
	and delete_sw  = 'N';
