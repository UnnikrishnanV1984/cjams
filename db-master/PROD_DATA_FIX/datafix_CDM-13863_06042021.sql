-- CDM-13863 - Incorrect Placement Entry Date
/*
-- Issue Description: 
   User request is to change the placement Entry date as 11/06/2020 (old value 11/04/2020)
   
-- Case ID: 3273419 - brenda.hemingway@maryland.gov
-- Client ID: 3128128 (ARIEL EVANS) - 3992277c-1a02-492a-8001-469147cc7e7b
-- Placement ID: 1558991 - 11/04/2020 To 12/31/2020 - 1769e7dc-7a0e-4bf6-81a1-971a1f489fb1
-- Private Organization: 5021813 (Seraaj Family Homes, Inc.)
-- CPA Office: 5040171 (Seraaj Family Homes - Joppa CPA)
-- Program ID: 3714	(Seraaj Family Homes) - 2008-07-01 To 2021-06-30

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
where placementid = '1769e7dc-7a0e-4bf6-81a1-971a1f489fb1'
	and activeflag  = 1 ;

update placement  
set startdatetime = '2020-11-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13863'
where placementid = '1769e7dc-7a0e-4bf6-81a1-971a1f489fb1'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '1769e7dc-7a0e-4bf6-81a1-971a1f489fb1' ;

update placementrevision  
set entrydate = '2020-11-06 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13863'
where placementid = '1769e7dc-7a0e-4bf6-81a1-971a1f489fb1' ;

-- Placement Validations 
-- Soft delete Jan 2021 as Exit date is 12/31/2020
update tb_placement_validation
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-13334'
where placement_validation_id = 1953002	
	and placement_id = 1558991 
	and delete_sw = 'N' ;

select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1558991 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_entry_dt = '2020-11-06'::date,
	update_ts = now(),
	update_user_id = 'CDM-13863'
where placement_id = 1558991
	and delete_sw = 'N' ;
	
