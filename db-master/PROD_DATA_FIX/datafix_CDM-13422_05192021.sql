-- CDM-13422 - End Placement
/*
-- Issue Description: 
   This request is to change the placement Exit date from 01/30/2021 to 02/04/2021 
   
-- Case ID: 3274589 - januari.mckay@maryland.gov
-- Client ID: 3336077 (JOSHUA JEREMIAS JURADO) - bc7ff0b2-8763-40f4-9f5c-89248d681d3f
-- Placement ID: 337386 - 2019-10-17 To 2021-01-30 - 2bdbbaa5-81df-4ed1-95cf-f6b04b33e6b3
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5089880 (Pressley Ridge - Independence Plus ILP - Towson)
-- Program ID: 15363 (Independence Plus) - 2007-04-16 To 2021-06-30	

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
where placementid = '2bdbbaa5-81df-4ed1-95cf-f6b04b33e6b3'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2021-02-04 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13422'
where placementid = '2bdbbaa5-81df-4ed1-95cf-f6b04b33e6b3'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '2bdbbaa5-81df-4ed1-95cf-f6b04b33e6b3' 
	and exitdate is not null ;

update placementrevision  
set exitdate = '2021-02-04 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-13422'
where placementid = '2bdbbaa5-81df-4ed1-95cf-f6b04b33e6b3' 
	and exitdate is not null ;


-- Placement Validations 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 337386 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2021-02-04'::date,
	update_ts = now(),
	update_user_id = 'CDM-13422'
where placement_id = 337386
	and delete_sw = 'N' ;
	
-- Insert for Feb 2021
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 337386, '2019-10-17', '2021-02-04', NULL, 
		NULL, 'CDM-13422', 'CDM-13422', 'N', '2021-02-01', 
		'2021-02-28', now(), now(), NULL, NULL
	);
