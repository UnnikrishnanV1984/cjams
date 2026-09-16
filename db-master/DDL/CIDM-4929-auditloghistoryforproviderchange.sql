CREATE TABLE if not exists cjams.improviderswitchinfo (
	improviderswitchid uuid NOT NULL DEFAULT gen_random_uuid(),
	activeflag int4 NOT NULL DEFAULT 1,
	objectid uuid NOT NULL,
	objecttype varchar(10) NULL,
	oldproviderid varchar(10) null,
	newproviderid varchar(10) null,
	providerchange boolean null,
	reasonchange varchar(50) null,
	explainreason varchar(50) null,
	explainreasonlist varchar(50) null,
	requestedby varchar(50) null,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	CONSTRAINT pk_improviderswitch PRIMARY KEY (improviderswitchid)
);
