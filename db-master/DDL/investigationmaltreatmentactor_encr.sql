-- Drop table

-- DROP TABLE encr.investigationmaltreatmentactor_encr;

CREATE TABLE encr.investigationmaltreatmentactor_encr (
    investigationmaltreatmentactorencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	investigationmaltreatmentactorid uuid NOT NULL,
	maltreatmentid uuid NOT NULL,
	intakeservicerequestactorid uuid NOT NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NULL,
	updatedby varchar(50) NULL,
	effectivedate timestamp NULL DEFAULT now(),
	insertedon timestamp NULL DEFAULT now(),
	updatedon timestamp NULL,
	old_id varchar(50) NULL,
	ismaltreator int4 NULL,
	fk_id bytea NULL,
	fk_rcd bytea NULL,
	fk_am_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_investigationmaltreatmentactor_encr PRIMARY KEY (investigationmaltreatmentactorencrid),
	CONSTRAINT fk_investigationmaltreatmentactor_encr_intakeservicerequestactor FOREIGN KEY (intakeservicerequestactorid) REFERENCES intakeservicerequestactor(intakeservicerequestactorid),
	CONSTRAINT fk_investigationmaltreatmentactor_encr_investigationmaltreatment FOREIGN KEY (maltreatmentid) REFERENCES investigationmaltreatment(maltreatmentid)
);
CREATE INDEX "IX1001_investigationmaltreatmentactor_encr" ON encr.investigationmaltreatmentactor_encr USING btree (maltreatmentid, activeflag);
CREATE INDEX xie1_investigationmaltreatmentactor_encr ON encr.investigationmaltreatmentactor_encr USING btree (intakeservicerequestactorid, activeflag);

-- Column comments
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.investigationmaltreatmentactorencrid IS 'Unique identifier of this table (Primary Key)';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.investigationmaltreatmentactorid IS 'Unique identifier of this table investigationmaltreatmentactor (Primary Key)';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.maltreatmentid IS 'maltreatmentid (FOREIGN KEY)';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.intakeservicerequestactorid IS 'intakeservicerequestactorid   (FOREIGN KEY)';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.investigationmaltreatmentactor_encr.ismaltreator IS 'Helps to identity the person is Maltreator';
