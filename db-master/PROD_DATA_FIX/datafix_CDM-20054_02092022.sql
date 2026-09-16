-- CDM-20054 Placment Change
/*
-- Issue Description: 
   User request to change the placement Entry Date from 01/27/2022 to 12/01/2021

-- Case ID: 3275985
-- Client ID: 4077173 (MACY WILSON) - a706830c-9452-4215-804e-8c0f21115c14
-- Placement ID: 1569519 - 2022-01-27 To Current - bc259e90-2f05-456d-bfe9-4b8d1542934a
-- Private Organization: 5000788 (Hearts and Homes For Youth, Inc.)
-- RCC Facility: 6005162 (Hearts and Homes For Youth, Inc. - Helen Smith)
-- Program: 50002350 (Group Home/HI Intensity/Helen Smith) - 2021-12-01 To 2022-06-30 00:00:00

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
-- Placement Entry date changes
-- 2022-01-27 00:00:00 08:00 (current)
-- 2021-12-01 00:00:00 08:01 (new)

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = 'bc259e90-2f05-456d-bfe9-4b8d1542934a'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2021-12-01 00:00:00', 
	starttime = '08:01',
	updatedon = now(), 
	updatedby = 'CDM-20054'
where placementid = 'bc259e90-2f05-456d-bfe9-4b8d1542934a'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'bc259e90-2f05-456d-bfe9-4b8d1542934a' ;

update cjams.placementrevision  
set entrydate = '2021-12-01 00:00:00', 
	entrytime = '08:01',
	updatedon = now(), 
	updatedby = 'CDM-20054'
where placementid = 'bc259e90-2f05-456d-bfe9-4b8d1542934a' ;

-- Placement Validation 
-- Update Entry date
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1569519 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2021-12-01'::date,
	update_ts = now(),
	update_user_id = 'CDM-20054'
where placement_id = 1569519 
	and delete_sw = 'N';
	
-- Insert for Dec 2021
insert into cjams.tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1569519, '2021-12-01', NULL, NULL, 
		NULL, 'CDM-20054', 'CDM-20054', 'N', '2021-12-01', 
		'2021-12-31', now(), now(), NULL, NULL
	);

