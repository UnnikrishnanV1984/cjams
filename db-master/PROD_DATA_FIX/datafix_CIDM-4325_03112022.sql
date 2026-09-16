-- To Remove the CJAMS Daily Contact Notes Audit Batch batch log record of 03/11/2022
-- 76 - CJAMS Daily Contact Notes Audit Batch

-- This is re-run the batch starting 03/10 to Current

select batch_sp_master_id, success_sw, comments_tx, start_ts, end_ts  
  from tb_batch_sp_log 
where batch_log_id = 405256 ;

delete from tb_batch_sp_log where batch_log_id = 405256 ;

select batch_master_id, run_dt, start_ts, end_ts, success_sw  
  from tb_batch_log 
where batch_log_id = 405256 ;

delete from tb_batch_log where batch_log_id = 405256 ;

/*
-- Back up data
INSERT INTO cjams.tb_batch_log
(batch_log_id, batch_master_id, success_sw, run_dt, comments_tx, start_ts, end_ts, etl_userid, etl_load_date)
VALUES(405256, 76, 'Y', '2022-03-11', NULL, '2022-03-11 00:30:00.163553-05', '2022-03-11 00:31:51.862227-05', NULL, NULL);

INSERT INTO cjams.tb_batch_sp_log
(batch_sp_log_id, batch_log_id, batch_sp_master_id, success_sw, sp_args, comments_tx, start_ts, end_ts, etl_userid, etl_load_date)
VALUES(2447076, 405256, 99, 'Y', '?, ?, ?', 'SP_CONTACT_NOTES_AUDIT_BATCH - Run', '2022-03-11 00:30:00.283116-05', '2022-03-11 00:31:51.836903-05', NULL, NULL);
*/
