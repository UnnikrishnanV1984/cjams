-- DROP SEQUENCE cjams.sq_rs_ive_status;

CREATE SEQUENCE cjams.sq_rs_ive_status
	START 10000000;


ALTER TABLE cjams.tb_rs_ive_status ALTER COLUMN rs_ive_status_id SET DEFAULT nextval('sq_rs_ive_status'::regclass);
