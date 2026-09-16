CREATE TABLE IF NOT exists ivecsesoutbounddata (
	ivecsesoutboundid uuid NOT NULL DEFAULT gen_random_uuid(),
	inputjson json NULL,
	outputjson json NULL,
	reviewperiod varchar(50) NULL,
	clientid bigint null,
	removalid bigint null,
	activeflag int4 NULL,
	insertedon timestamp NULL,
	updatedon timestamp NULL,
	outboundtime timestamp null,
	CONSTRAINT ivecsesoutbounddata_pkey PRIMARY KEY (ivecsesoutboundid)
);