-- expunge.intakeservrequestsdmmaltreatment_expunge definition

-- Drop table

-- DROP TABLE expunge.intakeservrequestsdmmaltreatment_expunge;

CREATE TABLE expunge.intakeservrequestsdmmaltreatment_expunge (
    sdmmaltreatmentexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL,
	sdmmaltreatmentid uuid NOT NULL,
	intakeservicerequestsdmid uuid NOT NULL,
	maltreatmenttype varchar(15) NOT NULL,
	maltreatorsname varchar(150) NOT NULL,
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NOT NULL, -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NOT NULL, -- Record created date and time
	effectivedate timestamp DEFAULT now() NOT NULL, -- Record valid from
	old_id varchar(50) NULL, -- Used for migration purpose
	client_id varchar(20) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_sdmmaltreatmentexpungeid PRIMARY KEY (sdmmaltreatmentexpungeid),
	CONSTRAINT fk_sdmmaltreatment_intakeservicerequestsdm_expunge FOREIGN KEY (intakeservicerequestsdmid) REFERENCES cjams.intakeservicerequestsdm(intakeservicerequestsdmid)
);
CREATE INDEX xie1_intakeservrequestsdmmaltreatment_expunge ON expunge.intakeservrequestsdmmaltreatment_expunge USING btree (intakeservicerequestsdmid);

-- Column comments
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.sdmmaltreatmentexpungeid IS 'SDM Maltreatment stored in this table(Primary key)';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.sdmmaltreatmentid IS 'SDM Maltreatment stored in this table(Primary key) for intakeservrequestsdmmaltreatment table';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.effectivedate IS 'Record valid from';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.intakeservrequestsdmmaltreatment_expunge.isexpunged IS 'Flag to indicate the expunged record';