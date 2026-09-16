-- CDM-12982 - Placement End date
/*
-- Issue Description: 
   This request is to change the placement Exit date from 10/23/2020 to 10/20/2020. 
   
-- Case ID: 3279123
-- Client ID: 1698831 (AMAYA Y SUTTON) - c02fedea-c09d-4c08-984c-bde401e67173
-- Placement ID: 1557316 - 2020-09-01 to 2020-10-23 - 93327d5a-63d3-48f6-bd14-a1aa11c2a5a0
-- Private Organization: 5000748 (The Children's Home, Inc.)
-- RCC Facility: 5000751 (The Children's Home Long Term Care Group Home)
-- Program ID: 1384 (Children's Home Long Term Care Home) - 07/01/2006 to 03/31/2021

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
where placementid = '93327d5a-63d3-48f6-bd14-a1aa11c2a5a0'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2020-10-20 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12982'
where placementid = '93327d5a-63d3-48f6-bd14-a1aa11c2a5a0'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from cjams.placementrevision  
where placementid = '93327d5a-63d3-48f6-bd14-a1aa11c2a5a0' 
	and exitdate is not null ;


update cjams.placementrevision  
set exitdate = '2020-10-20 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-12982'
where placementid = '93327d5a-63d3-48f6-bd14-a1aa11c2a5a0' 
	and exitdate is not null ;


-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1557316 
	and delete_sw  = 'N';

Update cjams.tb_placement_validation 
set placement_exit_dt = '2020-10-20'::date,
	update_ts = now(),
	update_user_id = 'CDM-12982'
where placement_id = 1557316
	and delete_sw = 'N' ;
