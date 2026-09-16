DROP TABLE if exists cjams.tb_foster_care_judicial;

CREATE TABLE  if not exists cjams.tb_foster_care_judicial (
	client_id bigint NOT NULL, 
	removal_id bigint NOT NULL,
	period_type varchar(50) NULL,
	date_agency_lost_legal_responsibility timestamp NULL,
	refpp_not_due varchar(50) null,
	create_ts timestamp NULL,
	update_ts timestamp NULL
);