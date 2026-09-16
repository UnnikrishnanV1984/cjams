-- CDM-19697 - Placement Structure Correction
/*
-- Issue Description: 
   Provider' Contract Program placement structure was updated to Residential Group Home.
   User request to update the placement and create Placement validations for April & May 2021.

-- Case ID: 3295707
-- Client ID: 1529827 (SARA ELIZABETH GIFFORD)
-- Placement ID: 1562849 - 04/22/2021 To 05/04/2021 - b6a5846f-185a-4ec3-8fc5-3df324da406c
-- Private Organization: 5076776 (Youth For Tomorrow New Life Center, Inc.)
-- Residential Treatment Center: 5076835 (Youth For Tomorrow-Chelsea House)
-- Program: 50002410 (Sara Gifford)

-- Current Placement Structure: 76	Residential Treatment Centers
-- New Placement Structure: 14	Residential Group Homes 
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User Error - Wrong placement structure was selected under the Provider Contract Program 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Placement Structure
select alternateid, altproviderid, contractprogramid, service_id, activeflag, updatedby, updatedon 
	from placement 
where placementid = 'b6a5846f-185a-4ec3-8fc5-3df324da406c'
	and activeflag = 1 ;

-- Structure: (Residential Group Homes )
update placement 
set service_id = 14, 
	updatedby = 'CDM-19697',
	updatedon = now()
where placementid = 'b6a5846f-185a-4ec3-8fc5-3df324da406c'
	and activeflag = 1 ;
	
 -- Create Placement Validations 	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562849, '2021-04-22', '2021-05-04', NULL, 
		NULL, 'CDM-19697', 'CDM-19697', 'N', '2021-04-01', 
		'2021-04-30', now(), now(), NULL, NULL
	);

insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1562849, '2021-04-22', '2021-05-04', NULL, 
		NULL, 'CDM-19697', 'CDM-19697', 'N', '2021-05-01', 
		'2021-05-31', now(), now(), NULL, NULL
	);
