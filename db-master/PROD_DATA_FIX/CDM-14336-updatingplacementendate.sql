-- 2020-09-16 00:00:00
update placement set enddatetime = '2020-10-22 00:00:00', updatedby = 'CDM-14336', updatedon = now() where placementid = '750788da-82b9-4bda-8108-d9465d109795' and activeflag = 1;
update placementrevision set exitdate = '2020-10-22 00:00:00', updatedby = 'CDM-14336', updatedon = now() where placementid = '750788da-82b9-4bda-8108-d9465d109795' and activeflag = 1;

-- 2020-09-16
update tb_placement_validation set placement_exit_dt = '2020-10-22', update_ts = now(),update_user_id = 'CDM-14336' where placement_id = '1558219';

INSERT INTO cjams.tb_placement_validation
(placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date)
VALUES(nextval('sq_placement_validation'::regclass), 1558219, '2020-07-07', '2020-10-22', '1750', NULL, 'finance', 'CDM-14336', 'N', '2020-10-01', '2020-10-31', NOW(),NOW(), NULL, NULL);



