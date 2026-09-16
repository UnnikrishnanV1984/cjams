CREATE TABLE if not exists cjams.providerswitchinfo (
	providerswitchid uuid NOT NULL DEFAULT gen_random_uuid(),
	activeflag int4 NOT NULL DEFAULT 1,
	objectid uuid NOT NULL,
	objecttype varchar(10) NULL,
	approvalstatus varchar(10) NULL,
	oldproviderid varchar(10) null,
	newproviderid varchar(10) null,
	requestedby varchar(50) null,
	approvedby varchar(50) null,
	approvaldate timestamp NULL,
	decisiondate timestamp NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	CONSTRAINT pk_providerswitch PRIMARY KEY (providerswitchid)
);