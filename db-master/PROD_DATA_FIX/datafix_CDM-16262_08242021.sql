-- CDM-16262 - Placement Validations
/*
-- Issue Description: 
   Provider' Contract Program placement structure was updated to Residential Group Home.
   Data fix to update the placement and create Placement validations for March, April & May 2021.

-- Case ID: 3299616
-- Client ID: 2581980 (MAKAYLA L BREHM) - d7fc81cf-703c-4897-a40a-e552de040004
-- Placement ID: 1561990 - 2021-03-01 To 2021-05-14 - 1ea86b9e-bef6-4f3a-b14f-e1a95b24f7dd
-- Private Organization: 5018960 (UHS of Savannah - d/b/a Coastal Harbor Treatment Center)
-- RCC Facility: 5088786 (Coastal Harbor Treatment Center)
-- Program: 50002269 (Makayla Brehm) 

-- Current Placement Structure: 76	Residential Treatment Centers
-- New Placement Structure: 14	Residential Group Homes 
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User Error - Wrong placement structure was selected under the Provider Contract Program 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Placement Structure
select altproviderid, contractprogramid, service_id, activeflag, updatedby, updatedon 
	from placement 
where placementid = '1ea86b9e-bef6-4f3a-b14f-e1a95b24f7dd'
	and activeflag = 1 ;

-- Structure: (Residential Group Homes )
update placement 
set service_id = 14, 
	updatedby = 'CDM-16262',
	updatedon = now()
where placementid = '1ea86b9e-bef6-4f3a-b14f-e1a95b24f7dd'
	and activeflag = 1 ;
	
-- Create Placement Validations 	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1561990, '2021-03-01', '2021-05-14', NULL, 
		NULL, 'CDM-16262', 'CDM-16262', 'N', '2021-03-01', 
		'2021-03-31', now(), now(), NULL, NULL
	);
	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1561990, '2021-03-01', '2021-05-14', NULL, 
		NULL, 'CDM-16262', 'CDM-16262', 'N', '2021-04-01', 
		'2021-04-30', now(), now(), NULL, NULL
	);

insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1561990, '2021-03-01', '2021-05-14', NULL, 
		NULL, 'CDM-16262', 'CDM-16262', 'N', '2021-05-01', 
		'2021-05-31', now(), now(), NULL, NULL
	);
