-- CJAMS CW - E&E Master data script

-- Picklist Value for E&E (Interface)
INSERT INTO cjams.tb_picklist_values
(	picklist_value_cd, picklist_type_id, value_tx, description_tx, active_sw, 
	sort_order_no, create_ts, create_user_id, update_ts, update_user_id, delete_sw, category_tx
)
VALUES
(	'3247 ', 317, 'E&E (Interface)', 'E&E (Interface)', 'Y', 
	0, now(), 'admin', now(), 'admin', 'N', NULL );


-- Batch Master & SP Master Data

select * from cjams.tb_batch_master where batch_master_id = 67;
select * from cjams.tb_batch_sp_master where batch_master_id = 67;

insert into cjams.tb_batch_master
( 	batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, 
	frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, 
	email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, 
	module_cd, etl_userid, etl_load_date
)
values
(	67, 'load_ene_inbound.sh', NULL, 'E&E Inbound Batch', 'Y', 
	'WD', '19:30:00', 30, 60, 'SEV-3', 
	'Y', NULL, NULL, 'Service Desk please call CJAMS on-call Support', 
	NULL, NULL, NULL, NULL);

	
insert into cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx,  sp_call_level_cd, comments_tx	 )
values
	(	94, 67, 'SP_ENE_INBOUND_TXT', 'SP to validate the E&E Inbound data', NULL, '(eneadmin,?)' );

insert into cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx,  sp_call_level_cd,  comments_tx	 )
values
	(	95, 67, 'SP_CARES_INTERFACE_LOAD_INBOUND', 'SP to load E&E Inbound data in CJAMS/E&E Tables', NULL, '(multiple args)' );

insert into cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx,  sp_call_level_cd,  comments_tx	 )
values
	(	96, 67, 'SP_CARES_INTERFACE_PROCESS_INBOUND', 'SP to update the E&E Inbound data in CJAMS Tables', NULL, '(eneinterface,?,?,?,?)' );
