-- CDM-12751 - Missing Payments
/*
-- Issue Description: 
	Missing FC Payments due to the inactive removal is associated with active placement
	
	Case ID: 2020021002033 - leanna.mckenzie@montgomerycountymd.gov
	Client ID: 4237196 (KIERA EVANS) - e7b3942c-23f3-44c3-9107-e46f9d7a60db 
	Placement ID: 1557194 - 2020-08-28 to 2020-12-28 - b259bf11-849c-44c3-af26-5cdb185cbbc5
	Private Organization: 5001284 (Nexus Woodbourne Family Healing)
	RCC Facility: 5090757 (Nexus-Woodbourne Family Healing- DETP - CSE)	
	Program ID: 15915 (DETP) - 2019-06-01 to 2021-05-31

-- Category/ Module: Placements  (Case Management) 
-- Root cause: CDM-5394 fix was wrong - datafix to remove the duplicate removal
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Placement table with removal id = 4b2935ff-6699-4dac-8953-95c5d316736f
select alternateid, placementid, startdatetime, enddatetime, altproviderid,
	intakeservreqchildremovalid, updatedby, updatedon 
from placement 
where intakeservreqchildremovalid = 'b45394d4-49a7-4644-92dc-94da734923f0'
	and activeflag = 1 ;

update placement  
set intakeservreqchildremovalid = '4b2935ff-6699-4dac-8953-95c5d316736f', 
	updatedon = now(), 
	updatedby = 'CDM-12751'
where intakeservreqchildremovalid = 'b45394d4-49a7-4644-92dc-94da734923f0'
	and activeflag = 1 ;


-- Placement Validations updates
select placement_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, validation_status_cd ,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_id = 1557194
	and delete_sw = 'N'
order by validation_start_dt ;

-- Update placement_exit_dt
update tb_placement_validation
	set placement_exit_dt = '2020-12-28'::date,
	update_ts = now(), 
	update_user_id = 'CDM-12751'
where placement_id = 1557194
	and delete_sw = 'N' ;

-- Insert Placement Validations for Oct, Nov & Dec 2020  	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1557194, '2020-08-28', '2020-12-28', NULL, 
		NULL, 'CDM-12751', 'CDM-12751', 'N', '2020-10-01', 
		'2020-10-31', now(), now(), NULL, NULL
	);
  
  
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1557194, '2020-08-28', '2020-12-28', NULL, 
		NULL, 'CDM-12751', 'CDM-12751', 'N', '2020-11-01', 
		'2020-11-30', now(), now(), NULL, NULL
	);

 
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1557194, '2020-08-28', '2020-12-28', NULL, 
		NULL, 'CDM-12751', 'CDM-12751', 'N', '2020-12-01', 
		'2020-12-31', now(), now(), NULL, NULL
	);

