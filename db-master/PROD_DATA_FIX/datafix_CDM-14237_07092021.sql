-- CDM-14237 - placement program needs changed
/*
-- Issue Description: 
   User request is to change the placement Exit date as 11/16/2020 (old value 03/31/2021)
   
-- Case ID: 3208250
-- Client ID: 2495917 (KEVIN AGUILAR) - c92aea49-35c6-46a2-8d82-19c44f93dbce
-- Placement ID: 1557075 - 2020-08-24 To 2021-03-01 - e6b97614-f17e-4ec3-95ce-b9418ef40fe5
-- Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)
-- RCC Facility: 5000650 (Board of Child Care Main Campus Gaither Rd)
-- Program ID: 	1590 (Main Campus 3300 Gaither Rd - High Intensity) - 2006-07-01 To 2021-03-31

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
where placementid = 'e6b97614-f17e-4ec3-95ce-b9418ef40fe5'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-11-16 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14237'
where placementid = 'e6b97614-f17e-4ec3-95ce-b9418ef40fe5'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'e6b97614-f17e-4ec3-95ce-b9418ef40fe5' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-11-16 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14237'
where placementid = 'e6b97614-f17e-4ec3-95ce-b9418ef40fe5'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1557075 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-11-16'::date,
	update_ts = now(),
	update_user_id = 'CDM-14237'
where placement_id = 1557075
	and delete_sw = 'N' ;

