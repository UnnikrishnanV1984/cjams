-- expunge.intakedastaging_expunge definition

-- Drop table

-- DROP TABLE expunge.intakedastaging_expunge;

CREATE TABLE expunge.intakedastaging_expunge (
    expungeid bigserial NOT NULL, -- This stored intake infomation (PRIMARY KEY)¶
	id int4 NOT NULL, -- This stored intake infomation (PRIMARY KEY)¶
	intakenumber varchar(50) NOT NULL, -- Intake number¶
	daterecieved timestamp NULL, -- TimeStamp¶
	narrative text NULL, -- Description of intake¶
	raname varchar(128) NULL, --  Rename¶
	entityname varchar(128) NULL, -- Entity name¶
	cruworkername varchar(128) NULL, -- Cruworkername¶
	"data" xml NULL, -- Intakedastaging data¶
	insertedon timestamp NULL, -- Record created date and time
	insertedby varchar(50) NULL, -- User who created this record
	updatedon timestamp NULL, -- Record updated date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	status varchar(50) NULL, -- Status of type record¶
	jsondata jsonb NULL, -- Json data¶
	activeflag int4 DEFAULT 1 NULL, -- Status of the record
	versionnumber int8 NULL, -- Versionnumber¶
	timerecieved timestamptz NULL, -- TimeStamp¶
	dispositiondescription varchar(250) NULL, -- Disposition description
	statusdescription varchar(250) NULL, -- Status Description
	intakeuser varchar NULL, -- Intake User
	ispreintake bool DEFAULT false NULL, -- Check preintake or not
	isclw bool DEFAULT false NULL, -- Clw 
	clwstatus int4 NULL, -- Clw Status
	old_id varchar(50) NULL, -- Used for migration purpose
	sstastatustypekey varchar(15) NULL,
	focuspersonid uuid NULL, -- Focus Person uuid
	isrestricteditem bool DEFAULT false NULL,
	supervisordecision varchar(20) NULL,
	intakedecision varchar(20) NULL,
	supervisorstatus varchar(20) NULL,
	approvaldate date NULL,
	teamtypekey varchar(10) NULL,
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_expung_id PRIMARY KEY (expungeid)
);
CREATE INDEX idx_dastaging_expunge_cw_1 ON expunge.intakedastaging_expunge USING btree (intakenumber, teamtypekey, activeflag, lower((status)::text));
CREATE INDEX idx_intakedastaging_expunge_lower_status ON expunge.intakedastaging_expunge USING btree (lower((status)::text));
CREATE INDEX idx_intakedastaging_expunge_status ON expunge.intakedastaging_expunge USING btree (status);
CREATE INDEX intakedastaging_expunge_statusactive_idx ON expunge.intakedastaging_expunge USING btree (intakenumber, activeflag);
CREATE INDEX ix_intakedastaging_expunge_insertedby_status ON expunge.intakedastaging_expunge USING btree (insertedby, status);
CREATE INDEX "intakedastaging_expunge_nonclusteredindex-20170913-204050" ON expunge.intakedastaging_expunge USING btree (intakenumber);

-- Column comments
COMMENT ON COLUMN expunge.intakedastaging_expunge.expungeid IS 'This stored intake infomation (PRIMARY KEY)
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.id IS 'This stored intake infomation (PRIMARY KEY) for intakedastaging
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.intakenumber IS 'Intake number
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.daterecieved IS 'TimeStamp
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.narrative IS 'Description of intake
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.raname IS ' Rename
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.entityname IS 'Entity name
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.cruworkername IS 'Cruworkername
';
COMMENT ON COLUMN expunge.intakedastaging_expunge."data" IS 'Intakedastaging data
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.intakedastaging_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.intakedastaging_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.intakedastaging_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.intakedastaging_expunge.status IS 'Status of type record
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.jsondata IS 'Json data
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.intakedastaging_expunge.versionnumber IS 'Versionnumber
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.timerecieved IS 'TimeStamp
';
COMMENT ON COLUMN expunge.intakedastaging_expunge.dispositiondescription IS 'Disposition description';
COMMENT ON COLUMN expunge.intakedastaging_expunge.statusdescription IS 'Status Description';
COMMENT ON COLUMN expunge.intakedastaging_expunge.intakeuser IS 'Intake User';
COMMENT ON COLUMN expunge.intakedastaging_expunge.ispreintake IS 'Check preintake or not';
COMMENT ON COLUMN expunge.intakedastaging_expunge.isclw IS 'Clw ';
COMMENT ON COLUMN expunge.intakedastaging_expunge.clwstatus IS 'Clw Status';
COMMENT ON COLUMN expunge.intakedastaging_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.intakedastaging_expunge.focuspersonid IS 'Focus Person uuid';
COMMENT ON COLUMN expunge.intakedastaging_expunge.isexpunged IS 'Flag to indicate the expunged record';