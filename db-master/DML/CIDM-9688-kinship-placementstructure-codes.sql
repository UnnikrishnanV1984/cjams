-- B-207876 - Restrictions on Placements following Kinship Regulation Deployment - 20241002 ( CIDM-9688 )

-- Placement Structure
------------------------------------
-- 530	kinship

-- COMAR Rate Category: Kinship Care

-- ---------------------------------------------------------------------------

-- Fiscal Category Codes:

-- 2173      Regular Foster Home Care (for Eligible Reimbursable clients)
-- 7173      Regular Foster Home Care (for Non-Reimbursable clients)



Delete from cjams.tb_placement_stru_category_link where fiscal_category_id in ( 179, 180 );	 
Delete from cjams.tb_foster_care_rate where rate_id in ( 326, 327 );	 



INSERT INTO cjams.tb_placement_stru_category_link
	(	service_id, fiscal_category_id, create_user_id, update_user_id, delete_sw, 
		create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	530, 62, 'CIDM-9688', 'CIDM-9688', 'N', 
		now(), now(), NULL, NULL
	);


INSERT INTO cjams.tb_placement_stru_category_link
	(	service_id, fiscal_category_id, create_user_id, update_user_id, delete_sw, 
		create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	530, 63, 'CIDM-9688', 'CIDM-9688', 'N', 
		now(), now(), NULL, NULL
	);



INSERT INTO cjams.tb_foster_care_rate
(rate_id, service_id, start_dt, end_dt, min_age_no, max_age_no, monthly_rate_no, per_diem_rate_no, monthly_clothing_no, emergency_per_diem_no, emergency_bed_fee, create_user_id, update_user_id, delete_sw, rate_type_cd, difficulty_level_cd, max_clothing_no, monthly_stipend_no, monthly_differential_no, create_ts, update_ts, dirty_status, etl_userid, etl_load_date)
VALUES(326, 530, '2024-12-12 00:00:00.000', NULL, 0, 11, 887.00, 29.16, NULL, NULL, NULL, 'CIDM-9688', 'CIDM-9688', 'N', '5670 ', NULL, NULL, NULL, NULL, now(), now(), NULL, NULL, NULL);


INSERT INTO cjams.tb_foster_care_rate
(rate_id, service_id, start_dt, end_dt, min_age_no, max_age_no, monthly_rate_no, per_diem_rate_no, monthly_clothing_no, emergency_per_diem_no, emergency_bed_fee, create_user_id, update_user_id, delete_sw, rate_type_cd, difficulty_level_cd, max_clothing_no, monthly_stipend_no, monthly_differential_no, create_ts, update_ts, dirty_status, etl_userid, etl_load_date)
VALUES(327, 530, '2024-12-12 00:00:00.000', NULL, 12, 20, 902.00, 29.66, NULL, NULL, NULL, 'CIDM-9688', 'CIDM-9688', 'N', '5670 ', NULL, NULL, NULL, NULL, now(), now(), NULL, NULL, NULL);