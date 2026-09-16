-- B-193551 Immunet Interface (CRISP)-Team-4(I&B-4)

-- CJAMS CW - CRISP Inbound and Outbound batch jobs

-- CRISP Outbound Batch
delete from cjams.tb_batch_master where batch_master_id = 108;

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
		108, 
		 'crisp_outbound.sh', 
		NULL, 
		'CRISP Outbound Interface', 
		'Y', 
		'D', 
		'18:00:00', 
		20, 
		40, 
		'SEV-3', 
		'Y', 
		'', 
		'CRISP Outbound Interface', 
        'Service Desk please call CJAMS on-call Support', 
		NULL, 
		NULL, 
		NULL, 
		NULL
	);

delete from cjams.tb_batch_sp_master where batch_master_id = 108;

INSERT INTO cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES
	(	208, 108, 'crisp_outbound_interface', '', NULL, (current_date));

-- CRISP Inbound Batch
delete from cjams.tb_batch_master where batch_master_id = 107;

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
		107,
		 'crisp_inbound.sh',
		NULL,
		 'CRISP Inbound Interface to Person Immunization Transaction',
		 'Y',
		'D',
		'09:00:00',
		20,
		40,
		'SEV-3',
		'Y',
		'',
		'CRISP Inbound Interface to Person Immunization Transaction',
        'Service Desk please call CJAMS on-call Support',
		NULL,
		NULL,
		NULL,
		NULL
	);

delete from cjams.tb_batch_sp_master where batch_master_id = 107;

INSERT INTO cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES
	(	207, 107, 'crisp_load_inbound_interface', '', NULL, NULL);

INSERT INTO cjams.tb_batch_sp_master
	( batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES 
	( 209, 107, 'sp_crisp_notification', '', NULL, NULL);