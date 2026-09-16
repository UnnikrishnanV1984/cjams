--New tables for the stories B-120023,B-120024- quick add person card

ALTER TABLE cjams.quickperson ADD COLUMN IF NOT EXISTS actualdata json;
ALTER TABLE cjams.quickperson ADD COLUMN IF NOT EXISTS modifieddata json;
ALTER TABLE cjams.quickperson ADD COLUMN IF NOT EXISTS deletestatus character varying NULL;
ALTER TABLE cjams.quickperson ADD COLUMN IF NOT EXISTS fromuserid character varying;
ALTER TABLE cjams.quickperson ADD COLUMN IF NOT EXISTS touserid character varying; 
ALTER TABLE cjams.quickperson ADD COLUMN IF NOT EXISTS gendertypekey varchar(100) NULL;


-- DROP TABLE cjams.quickperson_history;

CREATE TABLE IF NOT EXISTS cjams.quickperson_history (
	quickpersonhistoryid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	"rowtype" varchar(20) NULL,
	quickpersonid uuid NOT NULL,
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
	actualdata json NULL,
	substanceexposednewbornflag int4 NULL,
	substanceclasother varchar(200) NULL,
	substanceexposednewbornsourceid int4 NULL,
	substanceexposednewborntimetamp timestamp NULL,
	personid uuid NULL,
	modifieddata json NULL,
	deletestatus character varying NULL,
	fromuserid varchar NULL,
	touserid varchar NULL,
	gendertypekey varchar(100) NULL,
	CONSTRAINT pk_quickperson_history PRIMARY KEY (quickpersonhistoryid)
);



