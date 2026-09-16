-- CIDM-4204 -  Placement Validation Enhancement and Checkbox to Identify CfE Youth (B-123939)

-- Add Foster Care Rates
-- The CfE differential board rate to be paid to resource families after a youth's placement in the CfE home 
-- $1237/month for children 4-11 years old 
-- $1252/month for children 12 - 18 only
-- Period October 1, 2021, thru September 30, 2023 

-- Placement Structure: Service ID: 525 - CfE Placement

-- 4-11 years:  Monthly $1237 - Per Diem $40.67
-- 5670	Room & Board/Clothing
INSERT INTO cjams.tb_foster_care_rate
	(	rate_id, service_id, start_dt, end_dt, min_age_no, max_age_no, 
		monthly_rate_no, per_diem_rate_no, monthly_clothing_no, emergency_per_diem_no, 
		emergency_bed_fee, create_user_id, update_user_id, delete_sw, 
		rate_type_cd, difficulty_level_cd, max_clothing_no, monthly_stipend_no, 
		monthly_differential_no, create_ts, update_ts, dirty_status, 
		etl_userid, etl_load_date
	)
VALUES
	(	324, 525 , '2021-10-01 00:00:00', NULL, 4, 11, 
		1237, 40.67, NULL, NULL, 
		NULL, 'B-123939', 'B-123939', 'N', 
		'5670', NULL, NULL, NULL, 
		NULL, now(), now(), NULL, 
		NULL, NULL
	);

-- 12 - 18 years: Monthly $1252 - Per Diem $41.16
-- 5670	Room & Board/Clothing
INSERT INTO cjams.tb_foster_care_rate
	(	rate_id, service_id, start_dt, end_dt, min_age_no, max_age_no, 
		monthly_rate_no, per_diem_rate_no, monthly_clothing_no, emergency_per_diem_no, 
		emergency_bed_fee, create_user_id, update_user_id, delete_sw, 
		rate_type_cd, difficulty_level_cd, max_clothing_no, monthly_stipend_no, 
		monthly_differential_no, create_ts, update_ts, dirty_status, 
		etl_userid, etl_load_date
	)
VALUES
	(	325, 525 , '2021-10-01 00:00:00', NULL, 12, 18, 
		1252, 41.16, NULL, NULL, 
		NULL, 'B-123939', 'B-123939', 'N', 
		'5670', NULL, NULL, NULL, 
		NULL, now(), now(), NULL, 
		NULL, NULL
	);

select rate_id, service_id, start_dt, end_dt, min_age_no, max_age_no, 
		monthly_rate_no, per_diem_rate_no, update_ts, update_user_id 
from tb_foster_care_rate
where service_id = 525 ;


-- Commented on 02/14/2022
-- as this will be part of the below PR
-- https:// source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_db_scripts/pull-requests/4530/overview
/*
-- New CfE fiscal category code addition for differential board rate (was part of B-114423 - currently on Hold)

-- New Fiscal Category Code: 4185 Differential Board Rate
-- for period October 1, 2021, thru September 30, 2023 

Insert into cjams.tb_fiscal_category_master
	(	fiscal_category_id, fiscal_category_cd, fiscal_category_desc, eligibility_cd, ancillary_maintenance_sw, 
		payment_type_cd, create_user_id, update_user_id, delete_sw, start_dt, end_dt, 
		create_ts, update_ts, etl_userid, etl_load_date, as_pca_code_type, annual_max_amount
	)
values
	(	174, '4185', 'Differential Board Rate', '3952', 'M', 
		'6', 'CIDM-4204', 'CIDM-4204', 'N', '2021-10-01', '2023-09-30', 
		now(), now(), NULL, NULL, NULL, NULL
	);

-- Commented so the code will not show on Purchase Authorization screen
-- Program Assignment: Out of Home - 0c5e589f-78ce-42f9-8052-289d51e8dfdb
Insert into cjams.programcategorylink
	(	programcategorylinkid, agencyprogramareaid, insertedby, insertedon, updatedby, 
		updatedon, activeflag, old_id, fiscalcategoryid, etl_userid, etl_load_date
	)
values
	(	gen_random_uuid(), '0c5e589f-78ce-42f9-8052-289d51e8dfdb', 'B-114423', now()::date, 'B-114423', 
		now(), 1, NULL, 174, NULL, NULL
	);
*/	
