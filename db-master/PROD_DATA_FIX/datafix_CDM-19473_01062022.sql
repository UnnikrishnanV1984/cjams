-- CDM-19473 - Placement Date/Payment issue
/*
-- Issue Description: 
   User request to change the placement Entry Date 
   
-- Case ID: 3279843
-- Client ID: 4452678 (KOLSEN P DAVIS) - b72718cd-c118-4966-ada6-3df29086fb39
-- Placement ID: 338548 - 2019-12-20 To	2021-12-20 - 0fa05d27-3c6c-4d86-9685-21c564a406b3
-- Provider ID: 5093968	(Mary Faith Larrabee)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '0fa05d27-3c6c-4d86-9685-21c564a406b3'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2019-12-19 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-19473'
where placementid = '0fa05d27-3c6c-4d86-9685-21c564a406b3'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '0fa05d27-3c6c-4d86-9685-21c564a406b3' ;

update cjams.placementrevision  
set entrydate = '2019-12-19 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-19473'
where placementid = '0fa05d27-3c6c-4d86-9685-21c564a406b3' ;

-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 338548 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2019-12-19'::date,
	update_ts = now(),
	update_user_id = 'CDM-19473'
where placement_id = 338548 
	and delete_sw = 'N';
	
