-- Drop table

-- DROP TABLE cjams.tb_ncands_log;

CREATE TABLE cjams.tb_ncands_log (
	runtimelog_id bigserial NOT NULL,
	programname varchar(50) NULL,
	start_time timestamp NULL
);