
alter table gapsuspension add column if not exists otherreason varchar(100) null;
DROP table if exists personmilitaryphone;
CREATE TABLE personmilitaryphone (
	personmilitaryphoneid uuid NOT NULL DEFAULT gen_random_uuid(),
	personmilitaryserviceid uuid NOT NULL,
	personsuperiortypekey varchar(10) NULL,
	personphonetypekey varchar(50) NULL,
	phonenumber varchar(50) NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	CONSTRAINT personmilitaryphone_pkey PRIMARY KEY (personmilitaryphoneid)
);