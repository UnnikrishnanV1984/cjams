-- Drop table

-- DROP TABLE cjams.personhlthsleeping

CREATE TABLE cjams.personhlthsleeping (
	personhlthfeedingid uuid NOT NULL DEFAULT gen_random_uuid(),
	providedname varchar NULL,
	relationship varchar NULL,
	ishousehold bool NULL,
	iscollateral bool NULL,
	issleepinginfoknown bool NULL,
	sleepingenvironment jsonb NULL,
	sleepingproblems jsonb NULL,
	sleepingposition jsonb NULL,
	sleepingschedule_naptime timestamp NULL,
	sleepingschedule_bedtime timestamp NULL,
	insertedon timestamp NULL,
	insertedby varchar NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	"comments" varchar(500) NULL,
	personid uuid NULL
);

-- Permissions

ALTER TABLE cjams.personhlthsleeping OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.personhlthsleeping TO welfareadmin;

-- Drop table

-- DROP TABLE cjams.personhlthelimination

CREATE TABLE cjams.personhlthelimination (
	personhltheliminationid uuid NOT NULL DEFAULT gen_random_uuid(),
	providedname varchar NULL,
	relationship varchar NULL,
	ishousehold bool NULL,
	iscollateral bool NULL,
	iseliminationinfoknown bool NULL,
	elimination_currentstatus jsonb NULL,
	toilettrainingmethod jsonb NULL,
	wordforbowelmovement varchar NULL,
	wordforurination varchar NULL,
	insertedon timestamp NULL,
	insertedby varchar NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	"comments" varchar(500) NULL,
	personid uuid NULL
);

-- Permissions

ALTER TABLE cjams.personhlthelimination OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.personhlthelimination TO welfareadmin;

