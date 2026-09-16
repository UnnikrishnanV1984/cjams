-- Drop table

-- DROP TABLE encr.intakedastatus_encr;

CREATE TABLE encr.intakedastatus_encr (
	intakedastatusencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    intakedastatusid uuid NOT NULL,
	intakenumber varchar(50) NULL,
	status int4 NULL,
	jsondata bytea NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	updatedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	submitteddate timestamp NULL,
	ispreintake bool NULL DEFAULT false,
	assigneddate timestamp NULL,
	assignedto varchar(50) NULL,
	receiveddelayreason bytea NULL,
	submissiondelayreason bytea NULL,
	teamtypekey varchar(25) NULL,
	iscps bool NULL,
	intakeuser bytea NULL,
	isclw bool NULL DEFAULT false,
	clwstatus int4 NULL,
	old_id varchar(50) NULL,
	signedoffdate timestamp NULL,
	sstastatustypekey varchar(15) NULL,
	saocountyid varchar NULL,
	saotransfernotes varchar NULL,
	userprofileaddressid uuid NULL,
	reasonforassignmenttypekey varchar(15) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	priorinsertedby varchar NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_intakedastatusencrid PRIMARY KEY (intakedastatusencrid)
);
CREATE INDEX intakedastatus_encr_intakenumber_idx ON encr.intakedastatus_encr USING btree (intakenumber);
CREATE INDEX ix1002_intakedastatus_encr ON encr.intakedastatus_encr USING btree (intakenumber, activeflag);
CREATE INDEX ix1002_intakedastatus_encr_22 ON encr.intakedastatus_encr USING btree (teamtypekey, intakenumber, activeflag);
CREATE INDEX ix1002_intakedastatus_encr_23 ON encr.intakedastatus_encr USING btree (insertedby);
CREATE INDEX ix1002_intakedastatus_encr_24 ON encr.intakedastatus_encr USING btree (status);
CREATE INDEX ix1002_intakedastatus_encr_25 ON encr.intakedastatus_encr USING btree (ispreintake);
CREATE INDEX ix1002_intakedastatus_encr_comp ON encr.intakedastatus_encr USING btree (status, ispreintake, insertedby, intakeuser);
CREATE INDEX xie1_intakedastatus_encr ON encr.intakedastatus_encr USING btree (lower((intakenumber)::text), teamtypekey, activeflag);

-- Column comments
COMMENT ON COLUMN encr.intakedastatus_encr.intakedastatusencrid IS 'Encrypted table (PRIMARY KEY)';
COMMENT ON COLUMN encr.intakedastatus_encr.intakedastatusid IS 'This stored intake infomation (PRIMARY KEY)';
COMMENT ON COLUMN encr.intakedastatus_encr.intakenumber IS 'IntakeNumber';
COMMENT ON COLUMN encr.intakedastatus_encr.status IS 'Status of the Intake';
COMMENT ON COLUMN encr.intakedastatus_encr.jsondata IS 'Jsondata';
COMMENT ON COLUMN encr.intakedastatus_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.intakedastatus_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.intakedastatus_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.intakedastatus_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.intakedastatus_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.intakedastatus_encr.submitteddate IS 'Status SubmittedDate';
COMMENT ON COLUMN encr.intakedastatus_encr.ispreintake IS 'Preintake flag';
COMMENT ON COLUMN encr.intakedastatus_encr.assigneddate IS 'Staus AssignedDate';
COMMENT ON COLUMN encr.intakedastatus_encr.assignedto IS 'Status AssignedTo';
COMMENT ON COLUMN encr.intakedastatus_encr.receiveddelayreason IS 'Status ReceivedDelayReason';
COMMENT ON COLUMN encr.intakedastatus_encr.submissiondelayreason IS 'Status SubmissionDelayReason';
COMMENT ON COLUMN encr.intakedastatus_encr.teamtypekey IS 'TeamTypeKey';
COMMENT ON COLUMN encr.intakedastatus_encr.iscps IS 'Cps flag';
COMMENT ON COLUMN encr.intakedastatus_encr.intakeuser IS 'Intakeuser';
COMMENT ON COLUMN encr.intakedastatus_encr.isclw IS 'Clw flag';
COMMENT ON COLUMN encr.intakedastatus_encr.clwstatus IS 'Clw status';
COMMENT ON COLUMN encr.intakedastatus_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.intakedastatus_encr.signedoffdate IS 'DJS SAO Document Signed off date';
COMMENT ON COLUMN encr.intakedastatus_encr.sstastatustypekey IS 'ssta status type';
COMMENT ON COLUMN encr.intakedastatus_encr.saocountyid IS ' sao county mapping key';
COMMENT ON COLUMN encr.intakedastatus_encr.saotransfernotes IS ' saotransfernotes for forward';
COMMENT ON COLUMN encr.intakedastatus_encr.userprofileaddressid IS 'DJS Intake Office - Choose the work Location';
COMMENT ON COLUMN encr.intakedastatus_encr.reasonforassignmenttypekey IS 'DJS Reason For Assignment. referencevalues key';


