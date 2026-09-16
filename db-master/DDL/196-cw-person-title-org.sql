ALTER TABLE cjams.person 
add column if not exists employername varchar(500) null,
add column if not exists clienttitle varchar(500) null;

DROP table if EXISTS cjams.personauditlog;

CREATE TABLE cjams.personauditlog (
	personauditlogid uuid NOT null DEFAULT gen_random_uuid(),
	personid uuid NOT NULL,
	personjson json,
	typekey varchar(25),
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	old_id varchar(50) NULL
);