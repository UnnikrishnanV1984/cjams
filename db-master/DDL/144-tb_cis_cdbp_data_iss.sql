-- Drop table

-- DROP TABLE cjams.tb_cis_cdbp_data_iss

CREATE TABLE cjams.tb_cis_cdbp_data_iss (
	cis_cdbp_data_id int8 NOT NULL,
	cis_cdbp_interface_id int8 NOT NULL,
	transaction_type_sw bpchar(1) NOT NULL,
	cdbp_record_id int8 NOT NULL,
	cis_client_id int8 NOT NULL,
	su_id int8 NOT NULL,
	ldss bpchar(2) NOT NULL,
	program_type_cd varchar(4) NOT NULL,
	relation_to_casehead varchar(5) NULL,
	case_status_sw bpchar(1) NOT NULL,
	begin_dt date NOT NULL,
	end_dt date NULL,
	worker_last_nm varchar(20) NOT NULL,
	worker_first_nm varchar(20) NOT NULL,
	worker_user_id varchar(10) NOT NULL,
	worker_phone varchar(10) NOT NULL,
	supervisor_last_nm varchar(20) NOT NULL,
	supervisor_first_nm varchar(20) NOT NULL,
	supervisor_user_id varchar(10) NOT NULL,
	transcation_dt varchar(30) NOT NULL,
	create_ts timestamp NOT NULL,
	create_user_id varchar(10) NOT NULL,
	update_ts timestamp NOT NULL,
	update_user_id varchar(10) NOT NULL,
	delete_sw bpchar(1) NOT NULL,
	run_no varchar(9) NULL,
	data_valid_sw bpchar(1) NULL
);

-- Permissions

ALTER TABLE cjams.tb_cis_cdbp_data_iss OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.tb_cis_cdbp_data_iss TO welfareadmin;
