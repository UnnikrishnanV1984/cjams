-- CDM-16399 - Placement end date change
/*
-- Issue Description: 
   User request to change the placement Exit date as 05/02/2021 (old value 08/23/2021)

-- Case ID: 3224050
-- Client ID: 3356169 (ANTHONY GREGORY) - 3549cdfd-e555-4472-b100-d1e1e7d79d2a
-- Placement ID: 1561831 - 2021-03-01 To 2021-08-23 - dfbed84c-0c82-4a35-99bb-4dc293fa2f16
-- Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)
-- RCC Facility: 5000650 (Board of Child Care Main Campus Gaither Rd)
-- Program ID: 50002392	(High Intensity-Gaither Rd GH) - 2021-02-01 To 2022-06-30

-- Exit date change  2021-08-23 --> 2021-05-02


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
where placementid = 'dfbed84c-0c82-4a35-99bb-4dc293fa2f16'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-05-02 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-16399'
where placementid = 'dfbed84c-0c82-4a35-99bb-4dc293fa2f16'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'dfbed84c-0c82-4a35-99bb-4dc293fa2f16' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-05-02 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-16399'
where placementid = 'dfbed84c-0c82-4a35-99bb-4dc293fa2f16'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1561831 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-05-02'::date,
	update_ts = now(),
	update_user_id = 'CDM-16399'
where placement_id = 1561831
	and delete_sw = 'N' ;

-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1561831 
	and placement_validation_id in ( 1966165, 1969415 )
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-16399'
where placement_id = 1561831 
	and placement_validation_id in ( 1966165, 1969415 )
	and delete_sw  = 'N';
