--New tables for the stories B-120023,B-120024- quick add person card

-- DROP TABLE cjams.quickperson;

CREATE TABLE cjams.quickperson (
	quickpersonid uuid NOT NULL DEFAULT gen_random_uuid(),
	caseid uuid NULL,
	firstname varchar(100) NULL,
	middlename varchar(100) NULL,
	lastname varchar(100) NULL,
	dob timestamp NULL,
	ssn numeric NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	legalclientid int4 NULL,
	expungementflag int4 NULL,
	datavalidflag int4 NULL,
	clientmergeid uuid NULL,
	old_id varchar(50) NULL,
	intakenumber varchar(50) NULL,
	objecttype varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	substanceexposednewbornflag int4 NULL,
	substanceexposednewbornsourceid int4 NULL,
	substanceexposednewborntimetamp timestamp NULL,
	substanceclasskey varchar(200) NULL,
	substanceclasother varchar(200) NULL,
	personid uuid NULL
);
CREATE INDEX quickperson_quickperson_id_idx ON cjams.quickperson USING btree (quickpersonid);
CREATE INDEX quickperson_quickpersonid_idx ON cjams.quickperson USING btree (quickpersonid, activeflag);


-- DROP TABLE cjams.quickpersonroleconfig;

CREATE TABLE cjams.quickpersonroleconfig (
	quickpersonroleconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	quickpersonid uuid NOT NULL,
	actortypekey varchar(50) NOT NULL,
	activeflag int4 NULL DEFAULT 1,
	effectivedate timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	old_id varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	CONSTRAINT pk_quickpersonroleconfig PRIMARY KEY (quickpersonroleconfigid)
);
CREATE INDEX quickpersonroleconfig_quickpersonid_idx ON cjams.quickpersonroleconfig USING btree (quickpersonid, activeflag);


-- DROP TABLE cjams.quickpersonsubstconfig;

CREATE TABLE cjams.quickpersonsubstconfig (
	quickpersonsubstconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	quickpersonid uuid NOT NULL,
	substanceexposednewbornsourcetypekey varchar(50) NOT NULL,
	activeflag int4 NULL DEFAULT 1,
	effectivedate timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	old_id varchar(50) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	CONSTRAINT pk_quickpersonsubstconfig PRIMARY KEY (quickpersonsubstconfigid)
);
CREATE INDEX quickpersonsubstconfig_quickpersonid_idx ON cjams.quickpersonsubstconfig USING btree (quickpersonid, activeflag);

