-- Drop table

-- DROP TABLE encr.intakeservrequestsdmmaltreatment_encr;

CREATE TABLE encr.intakeservrequestsdmmaltreatment_encr (
    sdmmaltreatmentencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	sdmmaltreatmentid uuid NOT NULL,
	intakeservicerequestsdmid uuid NOT NULL,
	maltreatmenttype bytea NOT NULL,
	maltreatorsname bytea NOT NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	updatedby varchar(50) NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	effectivedate timestamp NOT NULL DEFAULT now(),
	old_id varchar(50) NULL,
	client_id varchar(20) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_sdmmaltreatmentencrid PRIMARY KEY (sdmmaltreatmentencrid),
	CONSTRAINT fk_sdmmaltreatment_encr_intakeservicerequestsdm FOREIGN KEY (intakeservicerequestsdmid) REFERENCES intakeservicerequestsdm(intakeservicerequestsdmid)
);
CREATE INDEX xie1_intakeservrequestsdmmaltreatment_encr ON encr.intakeservrequestsdmmaltreatment_encr USING btree (intakeservicerequestsdmid);

-- Column comments
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.sdmmaltreatmentencrid IS 'Primary Key';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.sdmmaltreatmentid IS 'Primary Key for intakeservrequestsdmmaltreatment';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.intakeservicerequestsdmid IS 'Primary Key for intakeservicerequestsdm';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.maltreatmenttype IS 'maltreatment type';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.maltreatorsname IS 'maltreators name';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.client_id IS 'client id';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.isexpunged IS 'Flag used to show if the record is expunged';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.intakeservrequestsdmmaltreatment_encr.old_id IS 'Used for migration purpose';