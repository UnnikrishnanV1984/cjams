-- CDM-14408 - Placement
/*
-- Issue Description: 
   User request is to change the placement Entry date as 05/10/2021 (old value 06/02/2021)
   
-- Case ID: 3302120
-- Client ID: 200661248	(De'mari Eppes) - ccd98ea2-73a7-4480-9d24-367e779423cc
-- Placement ID: 1563701 - 2021-06-02 To 2021-06-10 - af3a34ca-ed8b-4c67-80d1-3e7754881e16
-- Provider ID: 5076841 (Sarah Owens) - Local Department Home

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'af3a34ca-ed8b-4c67-80d1-3e7754881e16'
	and activeflag  = 1 ;

update placement  
set startdatetime = '2021-05-10 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14408'
where placementid = 'af3a34ca-ed8b-4c67-80d1-3e7754881e16'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'af3a34ca-ed8b-4c67-80d1-3e7754881e16' 	;

update placementrevision  
set entrydate = '2021-05-10 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-14408'
where placementid = 'af3a34ca-ed8b-4c67-80d1-3e7754881e16' ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 1563701 
	and delete_sw  = 'N';

	
-- Add May 2021
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1563701, '2021-05-10', '2021-06-10', NULL, 
		NULL, 'CDM-14408', 'CDM-14408', 'N', '2021-05-01', 
		'2021-05-31', now(), now(), NULL, NULL
	);

