-- Drop table

-- DROP TABLE cjams.programupdatetrigger;

CREATE TABLE cjams.programupdatetrigger (
	requestid bigserial NOT NULL,
	sourcesystem varchar(2) NULL DEFAULT 'CJ'::character varying,
	statusflag varchar(10) NULL,
	cjamspid int8 NULL,
	cisclientid varchar(10) NULL,
	casenumber varchar(20) NULL,
	programcasestatus varchar(20) NULL,
	programcode varchar(10) NULL,
	"comments" text NULL,
	effectivestartdate date NULL,
	effectiveenddate date NULL,
	headofhousehold bpchar(1) NULL,
	history varchar(20) NULL DEFAULT NULL::character varying,
	projecttype varchar(20) NULL DEFAULT NULL::character varying,
	relationship varchar(10) NULL DEFAULT NULL::character varying,
	errorcode varchar(4) NULL DEFAULT '0000'::character varying,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	CONSTRAINT programupdatetrigger_pkey PRIMARY KEY (requestid)
);
