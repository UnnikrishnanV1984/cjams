drop table if exists withhold_eft_config;
CREATE TABLE cjams.withhold_eft_config (
	withholdeftconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	withhold_payment_sw varchar(5) NULL,
	eft_sw varchar(5) NULL,
	activeflag int4 NULL DEFAULT 1,
	insertedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
    provider_id bigint null,
    withhold_reason text null,
	CONSTRAINT pk_withholdeftconfigid PRIMARY KEY (withholdeftconfigid)
);

