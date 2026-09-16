-- CDM-13505 - Incorrect end date
/*
-- Issue Description: 
   This request is to change the placement Exit date from 2020-12-23 to 2020-12-24
   
-- Case ID: 2020036305012
-- Client ID: 1929642 (MADISON LEIGH WILSON) - 19fd8e1c-6fde-453a-b9b9-27465eed3f8f
-- Placement ID: 1559898 - 2020-12-22 To 2020-12-23 - bdde19f5-7335-4115-a2ac-b62d6626d54c
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5061783 (Pressley Ridge Caroline St)
-- Program ID: 50002263 (Teen Mother Program) - 2020-07-01 To 2022-06-30

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
where placementid = 'bdde19f5-7335-4115-a2ac-b62d6626d54c'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-12-24 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13505'
where placementid = 'bdde19f5-7335-4115-a2ac-b62d6626d54c'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'bdde19f5-7335-4115-a2ac-b62d6626d54c' 
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-12-24 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13505'
where placementid = 'bdde19f5-7335-4115-a2ac-b62d6626d54c' 
	and exitdate is not null ;


-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1559898 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-12-24'::date,
	update_ts = now(),
	update_user_id = 'CDM-13505'
where placement_id = 1559898
	and delete_sw = 'N' ;
	
