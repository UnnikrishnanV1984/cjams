-- CIDM-7866 Provider Vacancy Data Sync batch Job

-- CJAMS CW - Daily Data Validation Batch Master data script

delete from cjams.tb_batch_master where batch_master_id = 77;

select * from cjams.tb_batch_master where batch_master_id = 77;

insert into cjams.tb_batch_master
	(	batch_master_id, batch_nm, dependent_master_id, batch_desc_tx, active_sw, 
		frequency, scheduled_tm, threshold_tm, threshold_cutoff_tm, alert_cd, 
		email_sw, comments_tx, batch_detail_desc_tx, help_failure_tx, dependencies_desc_tx, 
		module_cd, etl_userid, etl_load_date
	)
values
	(	
		77,  'cjams_cw_data_validation.sh', NULL,  'CJAMS CW Daily Data Validation Batch',  'Y', 
		'D', '01:30:00', 20, 40, 'SEV-3', 
		'Y', '', 'CJAMS CW Daily Data Validation Batch', 'Service Desk please call CJAMS on-call Support', NULL, 	
		NULL, NULL, NULL
	);

delete from cjams.tb_batch_sp_master where batch_master_id = 77;

select * from cjams.tb_batch_sp_master where batch_master_id = 77;

INSERT INTO cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES
	(	100, 77, 'SP_CW_DATA_VALIDATION', 'CJAMS CW Daily Data Validation Batch', NULL, '(current date)');


-- 1) Provider vacancy sync with Approved beds and active approved placements/ Placement Entries in Review status
INSERT INTO cjams.tb_batch_sp_master
	(	batch_sp_master_id, batch_master_id, sp_nm, sp_desc_tx, sp_call_level_cd, comments_tx )
VALUES
	(	101, 77, 'SP_PROVIDER_VACANCY_DATA_SYNC', 'Provider vacancy Data Sync', NULL, '(multiple args)');

-- Add Audit Log type
delete from auditlogtype where insertedby = 'CIDM-7866' ;

INSERT INTO cjams.auditlogtype
	(	logtypeid, logtypekey, logtype, modulename, effectivedate, 
		expirationdate, insertedby, updatedby, insertedon, updatedon, old_id
	)
VALUES
	(	gen_random_uuid(), 'PROVVACANCY', 'The vacancy was updated', 'Provider Vacancy', now(), 
		NULL, 'CIDM-7866', 'CIDM-7866', now(), now(), NULL
	);
	

