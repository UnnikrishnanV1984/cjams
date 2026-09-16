-- Drop table

-- DROP TABLE cjams.tb_client_account_balance_transfer

CREATE TABLE cjams.tb_client_account_balance_transfer (
	id bigserial NOT NULL,
	client_id int8 NULL,
	open_dt date NULL,
	county_cd varchar(5) NULL,
	comm_account_id int4 NULL,
	conserved_account_id int4 NULL,
	amount_to_fcys_account numeric(10,2) NULL,
	delete_sw bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	is_fcys_created bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	is_bal_transferred bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
	create_user_id varchar(50) NOT NULL,
	update_user_id varchar(50) NOT NULL,
	create_ts timestamp NULL,
	update_ts timestamp NULL,
	CONSTRAINT pk1_clnt_accnt PRIMARY KEY (id)
);
