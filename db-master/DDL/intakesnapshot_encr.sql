-- Drop table

-- DROP TABLE encr.intakesnapshot_encr;

CREATE TABLE encr.intakesnapshot_encr (
	intakesnapshotencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    intakesnapshotid uuid NOT NULL,
	intakenumber varchar NULL,
	intakeserviceid uuid NULL,
	approvedate timestamp NULL,
	jsondata bytea NULL,
	approverusersid varchar(50) NOT NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	old_id varchar(50) NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_intakesnapshot_encr PRIMARY KEY (intakesnapshotencrid),
	CONSTRAINT fk_intakesnapshot_encr_intakeservicerequest FOREIGN KEY (intakeserviceid) REFERENCES intakeservicerequest(intakeserviceid)
);
CREATE INDEX xie1_intakesnapshot_encr ON encr.intakesnapshot_encr USING btree (intakeserviceid);
CREATE INDEX xie2_intakesnapshot_encr ON encr.intakesnapshot_encr USING btree (intakenumber);

-- Column comments
COMMENT ON COLUMN encr.intakesnapshot_encr.intakesnapshotencrid IS 'intakesnapshot_encr information (PRIMARY KEY)';
COMMENT ON COLUMN encr.intakesnapshot_encr.intakesnapshotid IS 'Intakesnapshot table information (PRIMARY KEY)';
COMMENT ON COLUMN encr.intakesnapshot_encr.intakenumber IS 'Intakenumber';
COMMENT ON COLUMN encr.intakesnapshot_encr.intakeserviceid IS 'Intakeservice id (FOREIGN KEY)';
COMMENT ON COLUMN encr.intakesnapshot_encr.approvedate IS 'Approve date';
COMMENT ON COLUMN encr.intakesnapshot_encr.jsondata IS 'Json data';
COMMENT ON COLUMN encr.intakesnapshot_encr.approverusersid IS 'Approver users id';
COMMENT ON COLUMN encr.intakesnapshot_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.intakesnapshot_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.intakesnapshot_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.intakesnapshot_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.intakesnapshot_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.intakesnapshot_encr.old_id IS 'Used for migration purpose';