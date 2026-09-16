-- CDM-13575 - Placement end date
/*
-- Issue Description: 
	User request to remove the placement End date.
   
-- Case ID: 3218960 
-- Client ID: 2660503 (KEVIN HICKES) - e0c8709e-4ae5-43ee-af6e-231cc4990ab8
-- Placement ID: 340246 - 2020-04-09 To	2021-05-03 - 9a781992-3783-46a7-97ec-64f6d86b6317
-- Private Organization: 5000485 (Arrow Child & Family Ministries of Maryland, Inc.)
-- CPA Office: 5000487 (Arrow Child & Family - CPA TFC Baltimore)
-- Program ID: 2768	(Arrow Treatment Foster Care Program) 
    
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to Void the placements.
			   We have a User Story to fix this is our backlog.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '9a781992-3783-46a7-97ec-64f6d86b6317'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13575'
where placementid = '9a781992-3783-46a7-97ec-64f6d86b6317'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '9a781992-3783-46a7-97ec-64f6d86b6317' 
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-13575'
where placementid = '9a781992-3783-46a7-97ec-64f6d86b6317' 
	and exitdate is not null ;
	
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 340246 
	and delete_sw  = 'N';
	

Update tb_placement_validation 
set placement_exit_dt = null,
	update_ts = now(),
	update_user_id = 'CDM-13575'
where placement_id = 340246
	and delete_sw = 'N' ;
