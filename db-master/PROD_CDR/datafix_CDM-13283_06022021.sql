-- CDM-13283 - Missing Payments
/*
-- Issue Description: 
   Provider' Contract Program is currently not having any Placement Structure associated 
   and so there are no Placement validations and so the payments.

   Data fix to update the placements and create Placement validations for March, April & May 2021.

-- Private Organization: 5066577 (Total Quality Residential Services, Inc.)
-- RCC Facility: 5078809 (Total Quality - Balin DDA)
-- Contract ID: 50000096
-- Program ID: 50002378 (Medically Fragile-9004 Balin Crt) - 07/01/2020 To 06/30/2022
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Contratc Program data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/* 
-- Case ID: 3118022
-- Client ID: 1677181 (DAQUAN ANDRE	WILLIAMS) - f539b903-6a92-4fb7-aa5c-0c6f46620eaf
-- Placement ID: 1562001 - 2021-03-01 To Current - 794ee3f0-981a-4e1b-ac5d-6d84bc80e18a

-- Case ID: 3261273
-- Client ID: 3890411 (TYRELL M	WILLIAMS) - 97bcbd29-6465-4fd7-ac87-63b15ba40b1f
-- Placement ID: 1562002 - 	2021-03-01 To Current - b563fd75-fb76-4e38-88d2-313f36f6c2a4

-- Case ID: 3285386
-- Client ID: 4203575 (KARL	RAGSDALE) - c6afea62-dbbc-4213-b46b-4c1f63739f06
-- Placement ID: 1562003 - 2021-03-01 To Current - e99f1b29-6761-4074-88b1-a0d2ee4749cd

*/

-- Update Placement Structure
select altproviderid, contractprogramid, service_id, activeflag, updatedby, updatedon 
	from placement 
where placementid 
	in ( 	'794ee3f0-981a-4e1b-ac5d-6d84bc80e18a', 
			'b563fd75-fb76-4e38-88d2-313f36f6c2a4',
			'e99f1b29-6761-4074-88b1-a0d2ee4749cd' 
		)
	and activeflag = 1 ;

-- Structure: (Therapeutic Group Homes)
update placement 
set service_id = 167, 
	updatedby = 'CDM-13283',
	updatedon = now()
where placementid 
	in ( 	'794ee3f0-981a-4e1b-ac5d-6d84bc80e18a', 
			'b563fd75-fb76-4e38-88d2-313f36f6c2a4',
			'e99f1b29-6761-4074-88b1-a0d2ee4749cd' 
		)
	and activeflag = 1 ;
	

-- Create Placement Validations 	
-- Placement ID: 1562001 - 2021-03-01 To Current - 794ee3f0-981a-4e1b-ac5d-6d84bc80e18a
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562001, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-03-01', 
		'2021-03-31', now(), now(), NULL, NULL
	);
	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562001, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-04-01', 
		'2021-04-30', now(), now(), NULL, NULL
	);

insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562001, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-05-01', 
		'2021-05-31', now(), now(), NULL, NULL
	);
	
-- Placement ID: 1562002 - 	2021-03-01 To Current - b563fd75-fb76-4e38-88d2-313f36f6c2a4
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562002, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-03-01', 
		'2021-03-31', now(), now(), NULL, NULL
	);
	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562002, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-04-01', 
		'2021-04-30', now(), now(), NULL, NULL
	);
	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562002, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-05-01', 
		'2021-05-31', now(), now(), NULL, NULL
	);
	
-- Placement ID: 1562003 - 2021-03-01 To Current - e99f1b29-6761-4074-88b1-a0d2ee4749cd
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562003, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-03-01', 
		'2021-03-31', now(), now(), NULL, NULL
	);
	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562003, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-04-01', 
		'2021-04-30', now(), now(), NULL, NULL
	);
	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562003, '2021-03-01', NULL, NULL, 
		NULL, 'CDM-13283', 'CDM-13283', 'N', '2021-05-01', 
		'2021-05-31', now(), now(), NULL, NULL
	);
	


