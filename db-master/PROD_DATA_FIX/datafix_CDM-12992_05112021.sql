-- CDM-12992 - incorrect start date
/*
-- Issue Description: 
   This request is to change the placement entry date from 03/01/2021 to 12/14/2017. 
   
	Case ID: 3246783
	Client ID: 4142807 (TIERIYAN	BARNARD) - 42b63287-72af-446b-9fc5-7da9abc88e6b
	Placement ID: 323650 - 2021-03-01 to 2021-03-24 - ab9e8aaf-5462-4d9c-bce9-77e66252d679
	Provider ID: 5015042 (Edith  Turnage)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placements after exit.
		We have a User Story to fix this is our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = 'ab9e8aaf-5462-4d9c-bce9-77e66252d679'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2017-12-14 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12992'
where placementid = 'ab9e8aaf-5462-4d9c-bce9-77e66252d679'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'ab9e8aaf-5462-4d9c-bce9-77e66252d679' ;

update cjams.placementrevision  
set entrydate = '2017-12-14 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12992'
where placementid = 'ab9e8aaf-5462-4d9c-bce9-77e66252d679' ;


-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 323650 ;

Update cjams.tb_placement_validation 
set delete_sw = 'N',
	update_ts = now(),
	update_user_id = 'CDM-12992'
where placement_id = 323650
	and delete_sw = 'Y' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2017-12-14'::date,
	update_ts = now(),
	update_user_id = 'CDM-12992'
where placement_id = 323650
	and delete_sw = 'N' ;
