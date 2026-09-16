-- B-224215 IV-E Adoption & Guardianship Subsidies Stamping/Restamping

delete from cjams.tb_batch_master where batch_master_id = 110;

insert into cjams.tb_batch_master
	(	batch_master_id, 
		batch_nm, 
		dependent_master_id, 
		batch_desc_tx, 
		active_sw, 
		frequency, 
		scheduled_tm, 
		threshold_tm, 
		threshold_cutoff_tm, 
		alert_cd, 
		email_sw, 
		comments_tx, 
		batch_detail_desc_tx, 
		help_failure_tx, 
		dependencies_desc_tx, 
		module_cd, 
		etl_userid, 
		etl_load_date
	)
values
	(	
		110, 
		 'subsidy_payment_stamping.sh', 
		NULL, 
		'Adoption & GAP Payment Stamping Batch', 
		'Y', 
		'2', 
		'01:01:00', 
		90, 
		120, 
		'SEV-2', 
		'Y', 
		NULL, 
		NULL, 
        'Service Desk please call CJAMS on-call Support', 
		NULL, 
		NULL, 
		NULL, 
		NULL
	);

delete from cjams.tb_batch_sp_master where batch_master_id = 110;

INSERT INTO cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES
	(	211, 110, 'sp_subsidy_payment_stamping', '', NULL, (current_date));

INSERT INTO cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES
	(	212, 110, 'sp_subsidy_payment_restamping', '', NULL, (current_date));