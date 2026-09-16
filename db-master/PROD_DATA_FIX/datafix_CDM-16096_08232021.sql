-- CDM-16096 - Change the Placement Date
/*
-- Issue Description: 
   User request to change the placement Exit date as 09/16/2020  (old value 03/27/2021)
-- September 16, 2020 Time 11 AM and reason is change in placement structure

-- Case ID: 3071508
-- Client ID: 1447165 (DEONTE JALEEL MORRIS) - 967a04b9-5f93-47a4-8444-e86818f666e4	
-- DOB: 1999-09-16 - 21st Bday: 2020-09-16
-- Placement ID: 337161 - 2019-09-25 To	2021-03-27 - e343d3d4-97d4-453b-9a68-37d9f07f9999
-- Private Organization: 5001391 (Jumoke, Inc.)
-- CPA Office: 5001427 (Jumoke, Inc. Independent Living Program)
-- Program: 1713 (Jumoke, Independent Living Program) - 2006-07-01 To 2022-06-30 

-- Exit date change  2021-03-27 --> 2020-09-16

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
where placementid = 'e343d3d4-97d4-453b-9a68-37d9f07f9999'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-09-16 00:00:00', 
	endtime = '11:00', 
	exittypekey = 'CIPS',
	exitreasontypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-16096'
where placementid = 'e343d3d4-97d4-453b-9a68-37d9f07f9999'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, exitreasontypkey, exittypekey, updatedby, updatedon  
	from placementrevision  
where placementid = 'e343d3d4-97d4-453b-9a68-37d9f07f9999' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-09-16 00:00:00', 
	exittime = '11:00', 
	exittypekey = 'CIPS',
	exitreasontypkey = null,
	updatedon = now(), 
	updatedby = 'CDM-16096'
where placementid = 'e343d3d4-97d4-453b-9a68-37d9f07f9999'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 337161 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-09-16'::date,
	update_ts = now(),
	update_user_id = 'CDM-16096'
where placement_id = 337161
	and delete_sw = 'N' ;
	
-- Delete Placement Validations - Oct 2020 to March 2021
select placement_validation_id, placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 337161 
	and placement_validation_id in ( 1956545, 1956544, 1956543, 1956542, 1956541, 1956540 )
	and delete_sw  = 'N' ;

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16096'
where placement_id = 337161 
	and placement_validation_id in ( 1956545, 1956544, 1956543, 1956542, 1956541, 1956540 )
	and delete_sw  = 'N' ;
