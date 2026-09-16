-- CDM-13578 - Incorrect End Date
/*
-- Issue Description: 
   User request is to change the placement Exit date as 02/13/2020 (old value 02/28/2020)
   
-- Case ID: 3224565 - carleen.talley-watson@maryland.gov
-- Client ID: 3539548 (PAGE LEON BOYD) - 84a0af62-3f35-4ff6-9fb4-5126c4193465
-- Placement ID: 1556792 - 2019-05-01 To 2020-02-28 - c707f939-f97e-446f-90d8-f39435d768c8
-- Private Organization: 5001618 (MENTOR Maryland, Inc.)
-- CPA Office: 5001625 (MENTOR Maryland - Baltimore CPA)
-- Program ID: 2817	(Teens in Transition Baltimore Office) - 2007-06-01 To 2021-06-30 

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
where placementid = 'c707f939-f97e-446f-90d8-f39435d768c8'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-02-13 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13578'
where placementid = 'c707f939-f97e-446f-90d8-f39435d768c8'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'c707f939-f97e-446f-90d8-f39435d768c8' 
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-02-13 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13578'
where placementid = 'c707f939-f97e-446f-90d8-f39435d768c8' 
	and exitdate is not null ;


-- Placement Validations 
-- Soft delete March 2020 onwards
update tb_placement_validation
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-13578'
where placement_validation_id in (1927961, 1927960, 1927959, 1927958, 1927957)
	and delete_sw = 'N' ;


select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1556792 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-02-13'::date,
	update_ts = now(),
	update_user_id = 'CDM-13578'
where placement_id = 1556792
	and delete_sw = 'N' ;
	
