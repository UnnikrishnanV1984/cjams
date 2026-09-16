-- CDM-13335 - Placement
/*
-- Issue Description: 
   This request is to change the placement Exit date.
   Worker put in wrong end date due to SSA contact change needs to be 3/30 instead of 4/30.
   
-- Case ID: 3120225 - tiffany.jones-lam1@maryland.gov
-- Client ID: 1722747 (ANIYA I MCCARGO) - 16c66816-4857-4493-bb30-c09c53bb0667
-- Placement ID: 315918 - 2016-12-07 to 2021-04-30 - 858d533c-7173-452c-910c-73868c1d7f1d
-- Private Organization: 5001652 (Second Family, Inc.)
-- RCC Facility: 5049802 (Second Family - 14110 Lancaster DDA)
-- Program ID: 8802	(14110 Lancaster MF 3 Second Family) - 03/16/2011 to 03/31/2021	

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
from placement 
where placementid = '858d533c-7173-452c-910c-73868c1d7f1d'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-03-30 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13335'
where placementid = '858d533c-7173-452c-910c-73868c1d7f1d'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '858d533c-7173-452c-910c-73868c1d7f1d' 
	and exitdate is not null ;


update placementrevision  
set exitdate = '2021-03-30 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13335'
where placementid = '858d533c-7173-452c-910c-73868c1d7f1d' 
	and exitdate is not null ;


-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 315918 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-03-30'::date,
	update_ts = now(),
	update_user_id = 'CDM-13335'
where placement_id = 315918
	and delete_sw = 'N' ;
	
-- April 2021
select placement_id, validation_start_dt, validation_end_dt, delete_sw, update_ts, update_user_id 
	from tb_placement_validation 
where placement_validation_id  = 1956922 
	and delete_sw = 'N';
	
Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-13335'
where placement_validation_id  = 1956922 
	and delete_sw = 'N';
