-- CDM-23232 - placement payment
/*
-- Issue Description: 
	Provider has not been paid from 08/1/2020 to 9/10/2020 for FC placement.

-- Case ID: 3308062
-- Client ID: 4495682 (LARENZO THOMPSON) - 0d408ba0-83f6-4bf2-a0f9-935e6b4905ea
-- Placement ID: 340952 - 2020-07-07 To 2020-09-10 - 53fe515e-be61-4799-aef9-7f570528959e
-- Private Organization: 5000485 (Arrow Child & Family Ministries of Maryland, Inc.)
-- RCC Facility: 5000486 (Arrow Child & Family - Ascension Place)
-- Program: 1141 (Diagnostic Center RCC- Arrow)

-- Category/ Module: Placements (Case Management) 
-- Root cause: Placement Data Integrity issue (Placement associated with inactive Removal)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- This datafix is to link placement wih an approved/active removal. 
-- Removal
-- 200132	3be64f0b-d5e3-4cf5-be55-f36a2eafdcf2	2020-07-07 00:00:00						0
-- 250719	f91dc411-5756-4b78-be55-d2d4aad4f489	2020-07-07 00:00:00	2020-11-18 21:00:00	1

select activeflag, alternateid, intakeservreqchildremovalid, 
		altproviderid, startdatetime, enddatetime, updatedby, updatedon 
	from placement 
where placementid = '53fe515e-be61-4799-aef9-7f570528959e'
	and activeflag = 1
order by startdatetime ;

update placement
set intakeservreqchildremovalid = 'f91dc411-5756-4b78-be55-d2d4aad4f489',
	updatedon = now(), 
	updatedby = 'CDM-23232'
where placementid = '53fe515e-be61-4799-aef9-7f570528959e'
	and activeflag = 1 ;

Insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 340952, '2020-07-07', '2020-09-10', '1750', 
		NULL, 'CDM-23232', 'CDM-23232', 'N', '2020-08-01', 
		'2020-08-31', now(), now(), NULL, NULL
	);

Insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 340952, '2020-07-07', '2020-09-10', '1750', 
		NULL, 'CDM-23232', 'CDM-23232', 'N', '2020-09-01', 
		'2020-09-30', now(), now(), NULL, NULL
	);

update tb_placement_validation
set placement_exit_dt = '2020-09-10',
	update_ts = now(), 
	update_user_id = 'CDM-23232'
where placement_validation_id = 1927479
	and delete_sw = 'N' ;
	