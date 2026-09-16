-- CDM-12924 - Placement Validation
/*
-- Issue Description: 
	Feb 2021 Placement Validation is missing for the below Placement:
	
	Case ID: 3077818 - tiffany.jones-lam1@maryland.gov
	Client ID: 1426608 (KEYSHAWE	TYRINE LEE) - f34ef197-c60c-46db-90e3-61f2dbd2c8f5
	Placement ID: 336646 - 08/26/2019 to 02/04/2021 - 'a1f2aed7-4143-4aa2-9ecc-6008ed1f17d1'
	Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)
	RCC Facility: 5000650 (Board of Child Care Main Campus Gaither Rd)	
	Contract Program: 1590 (Main Campus 3300 Gaither Rd - High Intensity) - 07/01/2006 to 03/31/2021	

-- Category/ Module: Placements  (Case Management) 
-- Root cause: The corresponding removal record was having a data issue, which was fixed with CDM-10048.
   This placement validation was missed due to that removal error. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to Insert the missing Feb 2021 Placement Validation 
insert into cjams.tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 336646, '2019-08-26', '2021-02-04', NULL, 
		NULL, 'CDM-12924', 'CDM-12924', 'N', '2021-02-01', 
		'2021-02-28', now(), now(), NULL, NULL
	);


