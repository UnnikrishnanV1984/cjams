-- AFCARS - CSMS DDLs - (B-130478 / CIDM-4511)
	
-- Table for CJAMS - CSMS Interface and to capture CSMS response

-- DROP SEQUENCE if exists cjams.sq_afcarscsmsresponse;
CREATE SEQUENCE cjams.sq_afcarscsmsresponse
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;
								
-- DROP TABLE if exists cjams.afcarscsmsresponse;
CREATE TABLE cjams.afcarscsmsresponse (
	afcarscsmsresponseid int8 NOT NULL Default nextval('sq_afcarscsmsresponse'::regclass),
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
	ivdflag varchar NULL
);
CREATE INDEX afcarscsmsresponse_idx ON afcarscsmsresponse USING btree (afcarsfostercareid);


-- Table for CJAMS - CSMS Interface data history

-- DROP SEQUENCE if exists cjams.sq_afcarscsmsresponsehistory;
CREATE SEQUENCE cjams.sq_afcarscsmsresponsehistory
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807;
								
-- DROP TABLE if exists cjams.afcarscsmsresponsehistory;
CREATE TABLE cjams.afcarscsmsresponsehistory (
	afcarscsmsresponsehistoryid int8 NOT NULL Default nextval('sq_afcarscsmsresponsehistory'::regclass),
	afcarscsmsresponseid int8,
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
	ivdflag varchar NULL,
    dataloaddate timestamp
);
CREATE INDEX afcarscsmsresponsehistory_idx ON afcarscsmsresponsehistory USING btree (dataloaddate, afcarscsmsresponseid);
