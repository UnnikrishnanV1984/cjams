-- expunge.intakesnapshot_expunge definition

-- Drop table

-- DROP TABLE expunge.intakesnapshot_expunge;

CREATE TABLE expunge.intakesnapshot_expunge (
    intakesnapshotexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Intakesnapshot information (PRIMARY KEY)
	intakesnapshotid uuid NOT NULL, -- Intakesnapshot information (PRIMARY KEY)
	intakenumber varchar NULL, -- Intakenumber
	intakeserviceid uuid NULL, -- Intakeservice id (FOREIGN KEY)
	approvedate timestamp NULL, -- Approve date
	jsondata jsonb NULL, -- Json data
	approverusersid varchar(50) NOT NULL, -- Approver users id
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	insertedby varchar(50) NOT NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NOT NULL, -- Record created date and time
	updatedby varchar(50) NOT NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NOT NULL, -- Record updated date and time
	old_id varchar(50) NULL, -- Used for migration purpose
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_intakesnapshot_expunge PRIMARY KEY (intakesnapshotexpungeid),
	CONSTRAINT fk_intakesnapshot_expunge_intakeservicerequest FOREIGN KEY (intakeserviceid) REFERENCES cjams.intakeservicerequest(intakeserviceid)
);
CREATE INDEX xie1_intakesnapshot_expunge ON expunge.intakesnapshot_expunge USING btree (intakeserviceid);
CREATE INDEX xie2_intakesnapshot_expunge ON expunge.intakesnapshot_expunge USING btree (intakenumber);

-- Column comments
COMMENT ON COLUMN expunge.intakesnapshot_expunge.intakesnapshotexpungeid IS 'Intakesnapshot Expunge information (PRIMARY KEY)';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.intakesnapshotid IS 'Intakesnapshot information (PRIMARY KEY)';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.intakenumber IS 'Intakenumber';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.intakeserviceid IS 'Intakeservice id (FOREIGN KEY)';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.approvedate IS 'Approve date';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.jsondata IS 'Json data';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.approverusersid IS 'Approver users id';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.intakesnapshot_expunge.isexpunged IS 'Flag to indicate the expunged record';