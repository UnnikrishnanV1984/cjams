-- CDM-13334 - Placement
/*
-- Issue Description: 
   User request is to change the placement Exit date as 03/30/2021 (old value 04/16/2021)
   
-- Case ID: 3149858 
-- Client ID: 1949202 (LYRIK RUFFNER) - 2fe15416-0caf-4025-83bc-4d268d1cb614
-- Placement ID: 340790 - 2020-06-08 To 2021-04-16 - 29388259-9e5a-42f6-b67d-f1ac750eb39c
-- Private Organization: 5070361 (Building Families for Children)
-- CPA Office: 5070362 (Building Families for Children TFC Columbia)
-- 13441 (Chosen Building Families for Children's Services) - 02/28/2014 To 03/31/2021

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
	We have a User Story to fix this in our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = '29388259-9e5a-42f6-b67d-f1ac750eb39c'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-03-30 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13334'
where placementid = '29388259-9e5a-42f6-b67d-f1ac750eb39c'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '29388259-9e5a-42f6-b67d-f1ac750eb39c' 
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-03-30 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13334'
where placementid = '29388259-9e5a-42f6-b67d-f1ac750eb39c' 
	and exitdate is not null ;


-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 340790 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-03-30'::date,
	update_ts = now(),
	update_user_id = 'CDM-13334'
where placement_id = 340790
	and delete_sw = 'N' ;
	
-- Soft delete April 2021
update tb_placement_validation
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-13334'
where placement_validation_id = 1958350	
	and delete_sw = 'N' ;
