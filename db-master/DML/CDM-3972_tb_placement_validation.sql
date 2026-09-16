update cjams.placement set intakeservreqchildremovalid = '2c80e4e2-d6c5-4658-accc-1a95d7ba1a05', updatedon = now(), updatedby = 'CDM-3972' where alternateid = 1533824;

INSERT INTO cjams.tb_placement_validation
(placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES(nextval('sq_placement_validation'::regclass), 1533824, '2020-07-09', NULL, NULL, NULL, 'CDM-3972', 'CDM-3972', 'N', '2020-07-01', '2020-07-31', now(), now(), NULL, NULL);

INSERT INTO cjams.tb_placement_validation
(placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES(nextval('sq_placement_validation'::regclass), 1533824, '2020-07-09', NULL, NULL, NULL, 'CDM-3972', 'CDM-3972', 'N', '2020-08-01', '2020-08-31', now(), now(), NULL, NULL);
