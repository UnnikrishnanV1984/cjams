CREATE TABLE IF NOT exists ivecsescountycodes (
    referencetypeid int4 NOT NULL,
    countycode varchar(10) not null,
	value_text varchar(150) NULL,
	description varchar(150) NULL,
	fipscode varchar(10) not null,
	activeflag int4 NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	CONSTRAINT uk_ivecsescountycode UNIQUE (referencetypeid)
);