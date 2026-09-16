-- CJAMS CW - E&E Master data script

select * from cjams.tb_batch_master where batch_master_id = 69;

insert into cjams.tb_batch_master
( 	batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, 
	frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, 
	email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, 
	module_cd, etl_userid, etl_load_date
)
values
(	69, 'cjams_ene_rej.sh', NULL, 'E&E File Rejection Inbound Batch', 'Y', 
	'WD', '19:00:00', 20, 40, 'SEV-3', 
	'Y', NULL, NULL, 'Service Desk please call CJAMS on-call Support', 
	NULL, NULL, NULL, NULL);

