-- Drop table

-- DROP TABLE encr.contactparticipant_encr;

CREATE TABLE encr.contactparticipant_encr (
    contactparticipantencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	contactparticipantid uuid NOT NULL,
	progressnoteid uuid NOT NULL,
	participanttypekey varchar(15) NULL,
	intakeservicerequestactorid uuid NULL,
	firstname bytea NULL,
	lastname bytea NULL,
	address1 bytea NULL,
	address2 bytea NULL,
	city bytea NULL,
	state bytea NULL,
	zipcode bytea NULL,
	email bytea NULL,
	phonenumber bytea NULL,
	activeflag int4 NULL DEFAULT 1,
	effectivedate timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	old_id varchar(25) NULL,
	participantid uuid NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 NULL DEFAULT 0,
	CONSTRAINT pk_contactparticipant_encr PRIMARY KEY (contactparticipantencrid),
	CONSTRAINT fk_contactparticipant_encr_participanttype FOREIGN KEY (participanttypekey) REFERENCES participanttype(participanttypekey)
);
CREATE INDEX contactparticipant_encr_participantid_idx ON encr.contactparticipant_encr USING btree (participantid);
CREATE INDEX ix1000_contactparticipant_encr ON encr.contactparticipant_encr USING btree (intakeservicerequestactorid);
CREATE INDEX ix1001_contactparticipant_encr ON encr.contactparticipant_encr USING btree (progressnoteid, activeflag);

-- Column comments
COMMENT ON COLUMN encr.contactparticipant_encr.contactparticipantencrid IS 'Unique identifier of this table (Primary Key)';
COMMENT ON COLUMN encr.contactparticipant_encr.contactparticipantid IS 'Unique identifier of contactparticipant table (Primary Key)';
COMMENT ON COLUMN encr.contactparticipant_encr.progressnoteid IS 'progressnoteid (Foreign Key)';
COMMENT ON COLUMN encr.contactparticipant_encr.participanttypekey IS 'participanttypekey (Foreign Key)';
COMMENT ON COLUMN encr.contactparticipant_encr.intakeservicerequestactorid IS 'intakeservicerequestactorid (Foreign Key)';
COMMENT ON COLUMN encr.contactparticipant_encr.firstname IS 'firstname of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.lastname IS 'lastname of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.address1 IS 'address1 of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.address2 IS 'address2 of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.city IS 'city of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.state IS 'state of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.zipcode IS 'zipcode of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.email IS 'email of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.phonenumber IS 'phonenumber of contact participant';
COMMENT ON COLUMN encr.contactparticipant_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.contactparticipant_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.contactparticipant_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.contactparticipant_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.contactparticipant_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.contactparticipant_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.contactparticipant_encr.old_id IS 'Used for migration purpose';
