-- Provider Vacancy Issue Program # 3721

update placement
set intakeservreqchildremovalid = (select intakeservreqchildremovalid
									from intakeservreqchildremoval
									where activeflag = 1
									and personid  = '17ffdd12-6298-48e0-94a1-de57b7968807'
									and returndate is null
									and old_id = 184202)
where placementid = '9c218427-395e-4810-999d-70102a466c57';

INSERT INTO cjams.tb_placement_validation
(placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES(nextval('sq_placement_validation'::regclass), 338818, '2020-01-17', NULL, NULL, NULL, 'finance', 'finance', 'N', '2020-03-01', '2020-03-31', now(), now(), NULL, NULL);

INSERT INTO cjams.tb_placement_validation
(placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES(nextval('sq_placement_validation'::regclass), 338818, '2020-01-17', NULL, NULL, NULL, 'finance', 'finance', 'N', '2020-02-01', '2020-02-29', now(), now(), NULL, NULL);

INSERT INTO cjams.tb_placement_validation
(placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES(nextval('sq_placement_validation'::regclass), 338818, '2020-01-17', NULL, NULL, NULL, 'finance', 'finance', 'N', '2020-01-01', '2020-01-31', now(), now(), NULL, NULL);
