-- CJAMS CW - Daily Contact Notes Audit Batch Master data script
-- sp_contact_notes_daily_audit

select * from cjams.tb_batch_master where batch_master_id  = 76 ;

insert into cjams.tb_batch_master
	( 	batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, 
		frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, 
		email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, 
		module_cd, etl_userid, etl_load_date
	)
values
	(	
		76,  'cjams_contact_notes_auditlog.sh', NULL,  'CJAMS Daily Contact Notes Audit Batch',  'Y', 
		'D', '02:30:00', 20, 40, 'SEV-3', 
		'Y', '', 'CJAMS Daily Contact Notes Audit Batch', 'Service Desk please call CJAMS on-call Support', NULL, 	
		NULL, NULL, NULL
	);

select * from cjams.tb_batch_sp_master where batch_master_id = 76;

INSERT INTO cjams.tb_batch_sp_master
	( batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES
	( 99, 76, 'SP_CONTACT_NOTES_DAILY_AUDIT', 'CJAMS CW Daily Contact Notes Audit Batch', NULL, '(?,?,?)' );


INSERT INTO cjams.tb_batch_log
	(	batch_master_id, success_sw, run_dt, comments_tx, 
		start_ts, end_ts
	)
VALUES
	(	76, 'Y', '2022-02-28'::date, '',
		'2022-02-28 18:15:31', '2022-02-28 18:15:31'
	) ;

INSERT INTO cjams.tb_batch_sp_log
	(	batch_log_id,
		batch_sp_master_id, success_sw, sp_args, comments_tx, 
		start_ts, end_ts
	)
VALUES
	(	(select max(batch_log_id) from cjams.tb_batch_log where batch_master_id = 76), 
		99, 'Y', '?, ?, ?', 'SP_CONTACT_NOTES_DAILY_AUDIT - Run',
		'2022-02-28 18:15:31', '2022-02-28 18:15:31'
	);


