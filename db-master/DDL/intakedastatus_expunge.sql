-- expunge.intakedastatus_expunge definition

-- Drop table

-- DROP TABLE expunge.intakedastatus_expunge;

CREATE TABLE expunge.intakedastatus_expunge (
    intakedastatusexpungid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- This stored intake infomation (PRIMARY KEY)
	intakedastatusid uuid NOT NULL, -- This stored intake infomation (PRIMARY KEY)
	intakenumber varchar(50) NULL, -- IntakeNumber
	status int4 NULL, -- Status of the Intake
	jsondata jsonb NULL, -- Jsondata
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	updatedby varchar(50) NOT NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NOT NULL, -- Record updated date and time
	insertedby varchar(50) NOT NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NOT NULL, -- Record created date and time
	submitteddate timestamp NULL, -- Status SubmittedDate
	ispreintake bool DEFAULT false NULL, -- Preintake flag
	assigneddate timestamp NULL, -- Staus AssignedDate
	assignedto varchar(50) NULL, -- Status AssignedTo
	receiveddelayreason varchar(250) NULL, -- Status ReceivedDelayReason
	submissiondelayreason varchar(250) NULL, -- Status SubmissionDelayReason
	teamtypekey varchar(25) NULL, -- TeamTypeKey
	iscps bool NULL, -- Cps flag
	intakeuser varchar(50) NULL, -- Intakeuser
	isclw bool DEFAULT false NULL, -- Clw flag
	clwstatus int4 NULL, -- Clw status
	old_id varchar(50) NULL, -- Used for migration purpose
	signedoffdate timestamp NULL, -- DJS SAO Document Signed off date
	sstastatustypekey varchar(15) NULL, -- ssta status type
	saocountyid varchar NULL, --  sao county mapping key
	saotransfernotes varchar NULL, --  saotransfernotes for forward
	userprofileaddressid uuid NULL, -- DJS Intake Office - Choose the work Location
	reasonforassignmenttypekey varchar(15) NULL, -- DJS Reason For Assignment. referencevalues key
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	priorinsertedby varchar NULL,
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_intakedastatusexpungid PRIMARY KEY (intakedastatusexpungid)
);
CREATE INDEX idx_trgm_intakedastatus_expunge_intake_number ON expunge.intakedastatus_expunge USING gin (lower((intakenumber)::text) gin_trgm_ops);
CREATE INDEX "intakedastatus_expunge_intakenumber_IDX" ON expunge.intakedastatus_expunge USING btree (intakenumber, isexpunged);
CREATE INDEX intakedastatus_expunge_intakenumber_idx ON expunge.intakedastatus_expunge USING btree (intakenumber);
CREATE INDEX ix1002_intakedastatus_expunge ON expunge.intakedastatus_expunge USING btree (intakenumber, activeflag);
CREATE INDEX ix1002_intakedastatus_expunge_22 ON expunge.intakedastatus_expunge USING btree (teamtypekey, intakenumber, activeflag);
CREATE INDEX ix1002_intakedastatus_expunge_23 ON expunge.intakedastatus_expunge USING btree (insertedby);
CREATE INDEX ix1002_intakedastatus_expunge_24 ON expunge.intakedastatus_expunge USING btree (status);
CREATE INDEX ix1002_intakedastatus_expunge_25 ON expunge.intakedastatus_expunge USING btree (ispreintake);
CREATE INDEX ix1002_intakedastatus_expunge_comp ON expunge.intakedastatus_expunge USING btree (status, ispreintake, insertedby, intakeuser);
CREATE INDEX xie1_intakedastatus_expunge ON expunge.intakedastatus_expunge USING btree (lower((intakenumber)::text), teamtypekey, activeflag);

-- Column comments
COMMENT ON COLUMN expunge.intakedastatus_expunge.intakedastatusexpungid IS 'This stored intake infomation (PRIMARY KEY)';
COMMENT ON COLUMN expunge.intakedastatus_expunge.intakedastatusid IS 'This stored intake infomation (PRIMARY KEY) for intakedastatus';
COMMENT ON COLUMN expunge.intakedastatus_expunge.intakenumber IS 'IntakeNumber';
COMMENT ON COLUMN expunge.intakedastatus_expunge.status IS 'Status of the Intake';
COMMENT ON COLUMN expunge.intakedastatus_expunge.jsondata IS 'Jsondata';
COMMENT ON COLUMN expunge.intakedastatus_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.intakedastatus_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.intakedastatus_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.intakedastatus_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.intakedastatus_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.intakedastatus_expunge.submitteddate IS 'Status SubmittedDate';
COMMENT ON COLUMN expunge.intakedastatus_expunge.ispreintake IS 'Preintake flag';
COMMENT ON COLUMN expunge.intakedastatus_expunge.assigneddate IS 'Staus AssignedDate';
COMMENT ON COLUMN expunge.intakedastatus_expunge.assignedto IS 'Status AssignedTo';
COMMENT ON COLUMN expunge.intakedastatus_expunge.receiveddelayreason IS 'Status ReceivedDelayReason';
COMMENT ON COLUMN expunge.intakedastatus_expunge.submissiondelayreason IS 'Status SubmissionDelayReason';
COMMENT ON COLUMN expunge.intakedastatus_expunge.teamtypekey IS 'TeamTypeKey';
COMMENT ON COLUMN expunge.intakedastatus_expunge.iscps IS 'Cps flag';
COMMENT ON COLUMN expunge.intakedastatus_expunge.intakeuser IS 'Intakeuser';
COMMENT ON COLUMN expunge.intakedastatus_expunge.isclw IS 'Clw flag';
COMMENT ON COLUMN expunge.intakedastatus_expunge.clwstatus IS 'Clw status';
COMMENT ON COLUMN expunge.intakedastatus_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.intakedastatus_expunge.signedoffdate IS 'DJS SAO Document Signed off date';
COMMENT ON COLUMN expunge.intakedastatus_expunge.sstastatustypekey IS 'ssta status type';
COMMENT ON COLUMN expunge.intakedastatus_expunge.saocountyid IS ' sao county mapping key';
COMMENT ON COLUMN expunge.intakedastatus_expunge.saotransfernotes IS ' saotransfernotes for forward';
COMMENT ON COLUMN expunge.intakedastatus_expunge.userprofileaddressid IS 'DJS Intake Office - Choose the work Location';
COMMENT ON COLUMN expunge.intakedastatus_expunge.reasonforassignmenttypekey IS 'DJS Reason For Assignment. referencevalues key';
COMMENT ON COLUMN expunge.intakedastatus_expunge.isexpunged IS 'Flag to indicate the expunged record';