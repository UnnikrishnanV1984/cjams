drop table if exists attorneyaddress;

CREATE TABLE cjams.attorneyaddress (
	attorneyaddressid uuid NOT NULL DEFAULT gen_random_uuid(),
	attorneyname varchar(50) NULL,
	addressline1 varchar(50) NULL,
	attorneyphonenumber varchar(50) NULL,
	attorneyfax varchar(50) NULL,
	attorneyemail varchar(100) NULL,
	activeflag int4 NULL,
	effectivedate timestamp NULL,
	insertedby varchar NULL,
	updatedby varchar NULL,
	insertedon timestamp NULL,
	updatedon timestamp NULL,
	addressline2 varchar(50) NULL,
	county varchar(50) NULL,
	statekey varchar(50) NULL,
	zipcode numeric(50) NULL,
	division varchar(50) NULL,
	CONSTRAINT attorneyaddress_pkey PRIMARY KEY (attorneyaddressid)
);