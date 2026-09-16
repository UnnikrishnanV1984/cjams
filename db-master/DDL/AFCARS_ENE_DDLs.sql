-- AFCARS - E&E DDLs

-- Table to capture Application/County wide Go-live dates

-- DROP SEQUENCE if exists cjams.sq_interfacegolivedates;
CREATE SEQUENCE cjams.sq_interfacegolivedates
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;
	
-- DROP TABLE if exists cjams.interfacegolivedates;
CREATE TABLE cjams.interfacegolivedates (
	interfacegoliveid int8 NOT NULL Default nextval('sq_interfacegolivedates'::regclass),
	applicationname varchar(100) NOT NULL,
	localagencytypekey varchar(50) NULL, 
	golivedate date NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now()
);
CREATE INDEX intfgolive_app_county_idx ON interfacegolivedates USING btree (applicationname, localagencytypekey);

	
-- Table for CJAMS - E&E Interface and to capture E&E response

-- DROP SEQUENCE if exists cjams.sq_afcarseneresponse;
CREATE SEQUENCE cjams.sq_afcarseneresponse
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;
								
-- DROP TABLE if exists cjams.afcarseneresponse;
CREATE TABLE cjams.afcarseneresponse (
	afcarseneresponseid int8 NOT NULL Default nextval('sq_afcarseneresponse'::regclass),
	afcarsfostercareid varchar NULL,
	cjamspid int8 NULL,
	cisclientid varchar(50) NULL,
	removaldate timestamp NULL,
	returndate timestamp NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedon timestamp NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	insertedby varchar(50) NULL,
	"extract" varchar(50) NULL,
	ivaflag varchar NULL,
	xixflag varchar NULL
);
CREATE INDEX afcarseneresponse_idx ON afcarseneresponse USING btree (afcarsfostercareid);


-- Table for CJAMS - E&E Interface data history

-- DROP SEQUENCE if exists cjams.sq_afcarseneresponsehistory;
CREATE SEQUENCE cjams.sq_afcarseneresponsehistory
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;
								
-- DROP TABLE if exists cjams.afcarseneresponsehistory;
CREATE TABLE cjams.afcarseneresponsehistory (
	afcarseneresponsehistoryid int8 NOT NULL Default nextval('sq_afcarseneresponsehistory'::regclass),
	afcarseneresponseid int8,
	afcarsfostercareid varchar NULL,
	cjamspid int8 NULL,
	cisclientid varchar(50) NULL,
	removaldate timestamp NULL,
	returndate timestamp NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedon timestamp NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	insertedby varchar(50) NULL,
	"extract" varchar(50) NULL,
	ivaflag varchar NULL,
	xixflag varchar NULL,
    dataloaddate timestamp
);
CREATE INDEX afcarseneresponsehistory_idx ON afcarseneresponsehistory USING btree (dataloaddate, afcarseneresponseid);

