-- CDM-25185 - Placement Validation
/*
-- Issue Description: 
	No placement validation populated for our youth Kaitlyn Robinson ID#3242875
	
-- Case ID: 3207754
-- Client ID: 3242875 (KAITLYN J ROBINSON) - e6d29e07-c501-42a1-9cb8-aeca7ed9e591
-- Removal ID: 250614 - 2020-07-27 To 2022-09-27 - 18dcc4f8-6c70-4510-bff1-d58f38693a2b
-- Placement ID: 1571222 - 2022-04-12 To 2022-06-30 - 8fabfba3-b7a5-4fcc-89a2-ec3f5e7983f8
-- Private Organization: 5000788 (Hearts and Homes For Youth, Inc.)
-- RCC Facility: 6005162 (Hearts and Homes For Youth, Inc. - Helen Smith)
-- Program: Group Home/HI Intensity/Helen Smith (#50002350)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Placement updated was missed in CDM-22515 - datafix to remove the duplicate removal
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Placement table with removal id = 4b2935ff-6699-4dac-8953-95c5d316736f
select alternateid, placementid, startdatetime, enddatetime, altproviderid,
	intakeservreqchildremovalid, updatedby, updatedon 
from placement 
where placementid = '8fabfba3-b7a5-4fcc-89a2-ec3f5e7983f8'
	and activeflag = 1 ;

update placement  
set intakeservreqchildremovalid = '18dcc4f8-6c70-4510-bff1-d58f38693a2b', 
	updatedon = now(), 
	updatedby = 'CDM-25185'
where placementid = '8fabfba3-b7a5-4fcc-89a2-ec3f5e7983f8'
	and activeflag = 1 ;

-- Placement Validations updates
select placement_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, validation_status_cd ,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_id = 1571222
	and delete_sw = 'N'
order by validation_start_dt ;


-- Insert Placement Validations for June 2022  	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1571222, '2022-04-12', '2022-06-30', NULL, 
		NULL, 'CDM-25185', 'CDM-25185', 'N', '2022-06-01', 
		'2022-06-30', now(), now(), NULL, NULL
	);
  
