-- CDM-18988 - Missing Validations
/*
-- Issue Description: 
	Missing FC Payments due to the inactive removal is associated with active placement

-- Case ID: 3215035
-- Client ID: 1749802 (ALONNA ALSTON) - 2c63ccb5-902a-4ee0-b9d7-cdba4d49f115
-- Placement ID: 1558133 - 2020-10-05 To 2021-02-02 - 388756a4-1119-40d6-8e11-d230358ecc63
-- Private Organization: 5000485 (Arrow Child & Family Ministries of Maryland, Inc.)
-- RCC Facility: 5000486 (Arrow Child & Family - Diagnostic Center RCC)	
-- Program ID: 1141	(Diagnostic Center RCC- Arrow) - 2006-07-01 To 2021-12-31

-- Category/ Module: Placements  (Case Management) 
-- Root cause: CDM-5394 fix was wrong - datafix to remove the duplicate removal
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Placements with Removal ID as 6ca00167-c0cc-4201-9a65-c426730ab82d - Current Inactive
-- Update as 174defdb-3ba1-441e-ae0c-8afa00279f33 - Active

select alternateid, placementid, startdatetime, enddatetime, altproviderid,
	intakeservreqchildremovalid, updatedby, updatedon 
from placement 
where intakeservreqchildremovalid = '6ca00167-c0cc-4201-9a65-c426730ab82d'
	and activeflag = 1 ;

update placement  
set intakeservreqchildremovalid = '174defdb-3ba1-441e-ae0c-8afa00279f33', 
	updatedon = now(), 
	updatedby = 'CDM-18988'
where intakeservreqchildremovalid = '6ca00167-c0cc-4201-9a65-c426730ab82d'
	and activeflag = 1 ;

-- Update Placement 
-- End date as 2021-02-01 (To avoid overlapping)
-- Placement End date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '388756a4-1119-40d6-8e11-d230358ecc63'
	and activeflag  = 1 ;

update cjams.placement  
set enddatetime = '2021-02-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-18988'
where placementid = '388756a4-1119-40d6-8e11-d230358ecc63'
	and activeflag = 1 ;

-- Placement Revision End date changes
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '388756a4-1119-40d6-8e11-d230358ecc63'
	and exitdate is not null ;

update cjams.placementrevision  
set exitdate = '2021-02-01 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-18988'
where placementid = '388756a4-1119-40d6-8e11-d230358ecc63'
	and exitdate is not null ;


-- Placement Validations updates
-- Update Exit date
select placement_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, validation_status_cd ,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_id = 1558133
	and delete_sw = 'N'
order by validation_start_dt ;

-- Update placement_exit_dt
update tb_placement_validation
set placement_exit_dt = '2021-02-01'::date,
	update_ts = now(), 
	update_user_id = 'CDM-18988'
where placement_id = 1558133
	and delete_sw = 'N' ;

-- Update staus as null for Nov 2020
select placement_id, placement_entry_dt, placement_exit_dt, 
	validation_start_dt, validation_end_dt, validation_status_cd ,
	update_ts, update_user_id 
from tb_placement_validation 
where placement_id = 1558133
	and placement_validation_id = 1942234
	and delete_sw = 'N' ;

update tb_placement_validation
set validation_status_cd = NULL,
	update_ts = now(), 
	update_user_id = 'CDM-18988'
where placement_id = 1558133
	and placement_validation_id = 1942234
	and delete_sw = 'N' ;

 
-- Insert Placement Validations for Dec 2020 & Jan 2021  	
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1558133, '2020-10-05', '2021-02-01', NULL, 
		NULL, 'CDM-18988', 'CDM-18988', 'N', '2020-12-01', 
		'2020-12-31', now(), now(), NULL, NULL
	);
  
  
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1558133, '2020-10-05', '2021-02-01', NULL, 
		NULL, 'CDM-18988', 'CDM-18988', 'N', '2021-01-01', 
		'2021-01-31', now(), now(), NULL, NULL
	);
