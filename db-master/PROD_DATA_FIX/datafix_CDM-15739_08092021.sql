-- CDM-15739 - Incorrect Exit Date
/*
-- Issue Description: 
   User request to change the placement Exit date as 05/18/2021  (old value 06/25/2021)

-- Case ID: 3289659
-- Client ID: 4252495 (VINCE FONVILLE) - 67985996-ccc6-4898-9bfc-7b4a0b71ed09
-- Placement ID: 339775 - 2019-10-15 To 2021-06-25 - c3b84b07-f341-4cda-9101-61f32e70cd7f
-- Private Organization: 5001618 (MENTOR Maryland, Inc.)
-- CPA Office: 5001625 (MENTOR Maryland - Baltimore CPA)
-- Program: 2817 (Teens in Transition Baltimore Office) - 2007-06-01 To 2022-06-30
-- Exit date change  2021-06-25 --> 2021-05-18

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
where placementid = 'c3b84b07-f341-4cda-9101-61f32e70cd7f'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-05-18 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15739'
where placementid = 'c3b84b07-f341-4cda-9101-61f32e70cd7f'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'c3b84b07-f341-4cda-9101-61f32e70cd7f' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-05-18 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15739'
where placementid = 'c3b84b07-f341-4cda-9101-61f32e70cd7f'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 339775 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-05-18'::date,
	update_ts = now(),
	update_user_id = 'CDM-15739'
where placement_id = 339775
	and delete_sw = 'N' ;

-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 339775 
	and placement_validation_id = 1965146
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-15739'
where placement_id = 339775 
	and placement_validation_id = 1965146
	and delete_sw  = 'N';

