-- CDM-16302 - End date placement vs void placement
/*
-- Issue Description: 
	User request to remove the placement End date so that users can Void the placement.
	
-- Case ID: 3253118 
-- Client ID: 2195925 (ELIJAH J	FROMMELT) - d06f02d2-356b-43bc-9088-9d3a88c034b9
-- Placement ID: 1564997 - 2021-07-29 To 2021-08-09 - 07b0bfbe-b091-4868-a3bf-b5bb1362ef38
-- Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)
-- RCC Facility: 5000650 (Board of Child Care Main Campus Gaither Rd)
-- Program: 50002392 (High Intensity-Gaither Rd GH) - 2021-02-01 To 2022-06-30
    
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to Void the Closed placements.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- To remove the Placement Exit Date (No changes required to Removal & OOH) 
select alternateid, startdatetime, starttime, enddatetime, endtime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = '07b0bfbe-b091-4868-a3bf-b5bb1362ef38'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-16302'
where placementid = '07b0bfbe-b091-4868-a3bf-b5bb1362ef38'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '07b0bfbe-b091-4868-a3bf-b5bb1362ef38' 
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-16302'
where placementid = '07b0bfbe-b091-4868-a3bf-b5bb1362ef38' 
	and ( exitdate is not null or exittime is not null ) ;
	
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1564997 
	and delete_sw = 'N';

Update tb_placement_validation 
set placement_exit_dt = null,
	update_ts = now(),
	update_user_id = 'CDM-16302'
where placement_id = 1564997
	and delete_sw = 'N' ;	
