-- CJAMS CW - Daily Notification Batch Master data script

select * from cjams.tb_batch_master where batch_master_id = 75;

insert into cjams.tb_batch_master
	(	batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, 
		frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, 
		email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, 
		module_cd, etl_userid, etl_load_date
	)
values
	(	
		75,  'cjams_cw_notifications.sh', NULL,  'CJAMS CW Daily Notifications Batch',  'Y', 
		'D', '19:30:00', 20, 40, 'SEV-3', 
		'Y', '', 'CJAMS CW Daily Notifications Batch', 'Service Desk please call CJAMS on-call Support', NULL, 	
		NULL, NULL, NULL
	);

select * from cjams.tb_batch_sp_master where batch_master_id = 75;

INSERT INTO cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES
	(	98, 75, 'SP_CW_USERNOTIFICATIONS', 'CJAMS CW Daily Notifications Batch', NULL, '(?,?)'	);
