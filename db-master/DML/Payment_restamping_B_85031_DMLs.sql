-- Datafix to update tb_batch_runtime_log table
-- For Payment Re-stamping to resume in CJAMS starting FC IV-E go-live date (03/16/2020)

-- Before
select count(*)
	from tb_batch_runtime_log
where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
	and success_sw = 'Y' ;

-- Update all MD CHESSIE records 
update tb_batch_runtime_log
	set success_sw = 'X'
where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
	and success_sw = 'Y' ;
	
-- 	Insert Record for prior day of FC IV-E go-live date (03/16/2020)
insert into cjams.tb_batch_runtime_log
(	runtime_log_id, 
	batch_type_tx, 
	program_nm, 
	runtime_start_ts, 
	runtime_end_ts, 
	batch_no, 
	comments_tx, 
	success_sw, 
	create_ts, 
	create_user_id, 
	update_ts, 
	update_user_id, 
	delete_sw, 
	etl_userid, 
	etl_load_date
)
values
(	nextval('sq_batch_runtime_log'::regclass), 
	NULL, 
	'SP_IVE_INSERT_RS_STATUS', 
	'2020-03-15 19:16:29-04', 
	'2020-03-15 19:16:36-04',
	NULL, 
	'This record is for capturing the eligibility data from FC IV-E go-live date 03/16/2020', 
	'Y', 
	current_timestamp, 
	'B-85031', 
	current_timestamp, 
	'B-85031', 
	NULL, 
	NULL, 
	NULL
);

-- After
select count(*)
	from tb_batch_runtime_log
where program_nm = 'SP_IVE_INSERT_RS_STATUS' 
	and success_sw = 'Y' ;	
	