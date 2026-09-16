-- expunge.investigationmaltreatmentactor_expunge definition

-- Drop table

-- DROP TABLE expunge.investigationmaltreatmentactor_expunge;

CREATE TABLE expunge.investigationmaltreatmentactor_expunge (
	investigationmaltreatmentactorexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Unique identifier of this table (Primary Key)
	investigationmaltreatmentactorid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Unique identifier of this table (Primary Key)
	maltreatmentid uuid NOT NULL, -- maltreatmentid (FOREIGN KEY)
	intakeservicerequestactorid uuid NOT NULL, -- intakeservicerequestactorid   (FOREIGN KEY)
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	insertedby varchar(50) NULL, -- User who created this record
	updatedby varchar(50) NULL, -- user who last updated the record
	effectivedate timestamp DEFAULT now() NULL, -- Record valid from
	insertedon timestamp DEFAULT now() NULL, -- Record created date and time
	updatedon timestamp NULL, -- Record updated date and time
	old_id varchar(50) NULL, -- Used for migration purpose
	ismaltreator int4 NULL, -- Helps to identity the person is Maltreator
	fk_id varchar(50) NULL,
	fk_rcd varchar(50) NULL,
	fk_am_id varchar NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_investigationmaltreatmentactor_expunge PRIMARY KEY (investigationmaltreatmentactorexpungeid),
	CONSTRAINT fk_investigationmaltreatmentactor_expunge_intakeservicerequestactor FOREIGN KEY (intakeservicerequestactorid) REFERENCES cjams.intakeservicerequestactor(intakeservicerequestactorid),
	CONSTRAINT fk_investigationmaltreatmentactor_expunge_investigationmaltreatment FOREIGN KEY (maltreatmentid) REFERENCES cjams.investigationmaltreatment(maltreatmentid)
);
CREATE INDEX "IX1001_investigationmaltreatmentactor_expunge" ON expunge.investigationmaltreatmentactor_expunge USING btree (maltreatmentid, activeflag);
CREATE INDEX investigationmaltreatmentactor_expunge_test_idx ON expunge.investigationmaltreatmentactor_expunge USING btree (maltreatmentid);
CREATE INDEX xie1_investigationmaltreatmentactor_expunge ON expunge.investigationmaltreatmentactor_expunge USING btree (intakeservicerequestactorid, activeflag);

-- Column comments
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.investigationmaltreatmentactorexpungeid IS 'Unique identifier of this table (Primary Key)';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.investigationmaltreatmentactorid IS 'Unique identifier of this table (Primary Key) for investigationmaltreatmentactor table ';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.maltreatmentid IS 'maltreatmentid (FOREIGN KEY)';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.intakeservicerequestactorid IS 'intakeservicerequestactorid   (FOREIGN KEY)';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.effectivedate IS 'Record valid from';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.ismaltreator IS 'Helps to identity the person is Maltreator';
COMMENT ON COLUMN expunge.investigationmaltreatmentactor_expunge.isexpunged IS 'Flag to indicate the expunged record';