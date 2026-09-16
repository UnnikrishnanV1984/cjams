-- expunge.contactparticipant_expunge definition

-- Drop table

-- DROP TABLE expunge.contactparticipant_expunge;

CREATE TABLE expunge.contactparticipant_expunge (
	contactparticipantexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL,
	contactparticipantid uuid NOT NULL,
	progressnoteid uuid NOT NULL,
	participanttypekey varchar(15) NULL,
	intakeservicerequestactorid uuid NULL,
	firstname varchar(100) NULL,
	lastname varchar(50) NULL,
	address1 varchar(100) NULL,
	address2 varchar(100) NULL,
	city varchar(50) NULL,
	state varchar(32) NULL,
	zipcode varchar(32) NULL,
	email varchar(50) NULL,
	phonenumber varchar(32) NULL,
	activeflag int4 DEFAULT 1 NULL,
	effectivedate timestamp DEFAULT now() NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp DEFAULT now() NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	old_id varchar(25) NULL,
	participantid uuid NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isexpunged int4 DEFAULT 0 NULL,
	CONSTRAINT pk_contactparticipant_expunge PRIMARY KEY (contactparticipantexpungeid),
	CONSTRAINT fk_contactparticipant_expunge_participanttype FOREIGN KEY (participanttypekey) REFERENCES cjams.participanttype(participanttypekey)
);
CREATE INDEX contactparticipant_expunge_participantid_idx ON expunge.contactparticipant_expunge USING btree (participantid);
CREATE INDEX ix1000_contactparticipant_expunge ON expunge.contactparticipant_expunge USING btree (intakeservicerequestactorid);
CREATE INDEX ix1001_contactparticipant_expunge ON expunge.contactparticipant_expunge USING btree (progressnoteid, activeflag);

-- Column comments

COMMENT ON COLUMN expunge.contactparticipant_expunge.contactparticipantexpungeid IS 'Unique identifier of this table (Primary Key)';
COMMENT ON COLUMN expunge.contactparticipant_expunge.contactparticipantid IS 'Unique identifier of Contact Participant Table (Primary Key)';
COMMENT ON COLUMN expunge.contactparticipant_expunge.progressnoteid IS 'progressnoteid (Foreign Key)';
COMMENT ON COLUMN expunge.contactparticipant_expunge.participanttypekey IS 'participanttypekey (Foreign Key)';
COMMENT ON COLUMN expunge.contactparticipant_expunge.intakeservicerequestactorid IS 'intakeservicerequestactorid (Foreign Key)';
COMMENT ON COLUMN expunge.contactparticipant_expunge.firstname IS 'firstname of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.lastname IS 'lastname of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.address1 IS 'address1 of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.address2 IS 'address2 of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.city IS 'city of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.state IS 'state of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.zipcode IS 'zipcode of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.email IS 'email of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.phonenumber IS 'phonenumber of contact participant';
COMMENT ON COLUMN expunge.contactparticipant_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.contactparticipant_expunge.effectivedate IS 'Record valid from';
COMMENT ON COLUMN expunge.contactparticipant_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.contactparticipant_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.contactparticipant_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.contactparticipant_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.contactparticipant_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.contactparticipant_expunge.isexpunged IS 'Flag to indicate the expunged record';