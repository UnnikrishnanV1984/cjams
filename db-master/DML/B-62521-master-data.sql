delete from cjams.tb_foster_care_rate where rate_id=323 and service_id=501;

INSERT INTO cjams.tb_foster_care_rate 
(rate_id, service_id, start_dt, end_dt, min_age_no, max_age_no, monthly_rate_no, per_diem_rate_no, monthly_clothing_no, emergency_per_diem_no, emergency_bed_fee, create_user_id, update_user_id, delete_sw, rate_type_cd, difficulty_level_cd, max_clothing_no, monthly_stipend_no, monthly_differential_no, create_ts, update_ts, dirty_status, etl_userid, etl_load_date)
VALUES(323, 501, '2019-07-01 00:00:00.000', NULL, 0, 20, 1702.00, 55.97, NULL, NULL, NULL, 'admin', 'admin', 'N', '1234', NULL, NULL, NULL, NULL, now(),  now() , NULL, NULL, NULL);
