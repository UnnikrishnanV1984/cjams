-- Drop table

-- DROP TABLE cjams.personrole

CREATE TABLE cjams.personrole (
	personroleid uuid NOT NULL DEFAULT gen_random_uuid(),
	activeflag int4 NOT NULL DEFAULT 1,
	personid uuid NOT NULL,
	ishouseholdmember int4 NULL,
	iscollateralcontact int4 NULL,
	drugexposednewbornflag int4 NULL,
	drugexposedtypekey varchar(10) NULL,
	otherdrugs varchar(255) NULL,
	safehavenbabyflag int4 NULL,
	probationsearchconductedflag int4 NULL,
	sexoffenderregisteredflag int4 NULL,
	dangertoself int4 NULL,
	dangertoselfreason varchar(500) NULL,
	isdangertoworker int4 NULL,
	dangertoworkerreason varchar(512) NULL,
	ismentalillness int4 NULL,
	mentalillnessdetail varchar NULL,
	ismentalimpair int4 NULL,
	mentalimpairdetail varchar NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	CONSTRAINT pk_personrole PRIMARY KEY (personroleid)
);

-- Permissions

ALTER TABLE cjams.personrole OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.personrole TO welfareadmin;

-- Drop table

-- DROP TABLE cjams.personroletype

CREATE TABLE cjams.personroletype (
	personroletypeid uuid NOT NULL DEFAULT gen_random_uuid(),
	personroleid uuid NOT NULL,
	roletype varchar(20) NOT NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	isprimary varchar NULL,
	CONSTRAINT pk_personroletype PRIMARY KEY (personroletypeid)
);

-- Permissions

ALTER TABLE cjams.personroletype OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.personroletype TO welfareadmin;
