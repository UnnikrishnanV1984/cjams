drop table if exists providerstaffconfig;
CREATE TABLE cjams.providerstaffconfig (
	provider_staff_config_id uuid NOT NULL DEFAULT gen_random_uuid(),
	object_id varchar(50) NULL,
	provider_staff_id uuid null,
	create_ts varchar(30) NULL,
	create_user_id varchar(50) NULL,
	update_ts varchar(30) NULL,
	update_user_id varchar(50) NULL,
	delete_sw bpchar(1) NULL DEFAULT 'N'::bpchar
);

alter table tb_provider_applicant add column if not exists corporation_name varchar(50) null;