-- Drop table

-- DROP TABLE encr.intakedastaging_encr;
-- DROP TABLE if exists encr.intakedastaging_encr;
CREATE TABLE encr.intakedastaging_encr (
	encrid bigserial NOT NULL,
	id int4 NOT NULL,
	intakenumber varchar(50) NOT NULL,
	daterecieved timestamp NULL,
	narrative bytea NULL,
	raname bytea NULL,
	entityname varchar(128) NULL,
	cruworkername bytea NULL,
	"data" xml NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	status varchar(50) NULL,
	jsondata bytea NULL,
	activeflag int4 NULL DEFAULT 1,
	versionnumber int8 NULL,
	timerecieved timestamptz NULL,
	dispositiondescription varchar(250) NULL,
	statusdescription varchar(250) NULL,
	intakeuser bytea NULL,
	ispreintake bool NULL DEFAULT false,
	isclw bool NULL DEFAULT false,
	clwstatus int4 NULL,
	old_id varchar(50) NULL,
	sstastatustypekey varchar(15) NULL,
	focuspersonid uuid NULL,
	isrestricteditem bool NULL DEFAULT false,
	supervisordecision varchar(20) NULL,
	intakedecision varchar(20) NULL,
	supervisorstatus varchar(20) NULL,
	approvaldate date NULL,
	teamtypekey varchar(10) NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_encrid PRIMARY KEY (id)
);
CREATE INDEX idx_intakedastaging_encr_lower_status ON encr.intakedastaging_encr USING btree (lower((status)::text));
CREATE INDEX idx_intakedastaging_encr_status ON encr.intakedastaging_encr USING btree (status);
CREATE INDEX intakedastaging_encr_statusactive_idx ON encr.intakedastaging_encr USING btree (intakenumber, activeflag);
CREATE INDEX ix_intakedastaging_encr_insertedby_status ON encr.intakedastaging_encr USING btree (insertedby, status);
CREATE INDEX "nonclusteredindex-20170913-204050_intakedastaging_encr" ON encr.intakedastaging_encr USING btree (intakenumber);

-- Column comments
COMMENT ON COLUMN encr.intakedastaging_encr.encrid IS 'Encrypted table Primary Key';
COMMENT ON COLUMN encr.intakedastaging_encr.id IS 'This stored intake infomation (PRIMARY KEY)';
COMMENT ON COLUMN encr.intakedastaging_encr.intakenumber IS 'Intake number';
COMMENT ON COLUMN encr.intakedastaging_encr.daterecieved IS 'TimeStamp';
COMMENT ON COLUMN encr.intakedastaging_encr.narrative IS 'Description of intake';
COMMENT ON COLUMN encr.intakedastaging_encr.raname IS ' Rename';
COMMENT ON COLUMN encr.intakedastaging_encr.entityname IS 'Entity name';
COMMENT ON COLUMN encr.intakedastaging_encr.cruworkername IS 'Cruworkername';
COMMENT ON COLUMN encr.intakedastaging_encr."data" IS 'Intakedastaging data';
COMMENT ON COLUMN encr.intakedastaging_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.intakedastaging_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.intakedastaging_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.intakedastaging_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.intakedastaging_encr.status IS 'Status of type record';
COMMENT ON COLUMN encr.intakedastaging_encr.jsondata IS 'Json data';
COMMENT ON COLUMN encr.intakedastaging_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.intakedastaging_encr.versionnumber IS 'Versionnumber';
COMMENT ON COLUMN encr.intakedastaging_encr.timerecieved IS 'TimeStamp';
COMMENT ON COLUMN encr.intakedastaging_encr.dispositiondescription IS 'Disposition description';
COMMENT ON COLUMN encr.intakedastaging_encr.statusdescription IS 'Status Description';
COMMENT ON COLUMN encr.intakedastaging_encr.intakeuser IS 'Intake User';
COMMENT ON COLUMN encr.intakedastaging_encr.ispreintake IS 'Check preintake or not';
COMMENT ON COLUMN encr.intakedastaging_encr.isclw IS 'Clw';
COMMENT ON COLUMN encr.intakedastaging_encr.clwstatus IS 'Clw Status';
COMMENT ON COLUMN encr.intakedastaging_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.intakedastaging_encr.focuspersonid IS 'Focus Person uuid';
