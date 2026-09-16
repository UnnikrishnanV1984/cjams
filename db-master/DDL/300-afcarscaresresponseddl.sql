
-- Drop table

DROP TABLE if exists cjams.afcarscaresresponse;

CREATE TABLE cjams.afcarscaresresponse (
	responseid int8 NOT NULL,
	cjamspid int8 NULL,
	cisclientid varchar(50) NOT NULL,
	element61sw int4 NULL,
	element63sw int4 NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	old_id varchar(50) NULL
);
