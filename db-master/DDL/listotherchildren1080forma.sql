DROP TABLE IF EXISTS cjams.listotherchildren1080forma;

CREATE TABLE IF NOT EXISTS cjams.listotherchildren1080forma (
	otherchildrenform1080aid uuid NOT NULL DEFAULT gen_random_uuid (),
	activeflag int4 NOT NULL DEFAULT 1,
	cjamspid varchar NULL,
	form1080aid uuid NULL,
	fullname varchar NULL,
	personid uuid NULL,
	dob date NULL,
	relationshiptovictim text NULL,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	CONSTRAINT pk_listotherchildren1080forma PRIMARY KEY (otherchildrenform1080aid),
	CONSTRAINT fk_listotherchildren_form1080a FOREIGN KEY (form1080aid) REFERENCES cjams.form1080a (form1080aid),
    CONSTRAINT fk_listotherchildren_person FOREIGN KEY (personid) REFERENCES cjams.person (personid)
);

COMMENT ON COLUMN cjams.listotherchildren1080forma.otherchildrenform1080aid IS 'Unique identifier for this record (primary key).';
COMMENT ON COLUMN cjams.listotherchildren1080forma.activeflag IS 'Indicates whether this record is active (1 for active, 0 for inactive).';
COMMENT ON COLUMN cjams.listotherchildren1080forma.cjamspid IS 'Unique CJAMS identifier for the child.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.form1080aid IS 'Foreign key linking this child to the main form1080a report.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.fullname IS 'The full name of the other child.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.personid IS 'The personid (uuid) of the other child, linking to the person table.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.dob IS 'Date of birth of the other child.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.relationshiptovictim IS 'The relationship of this child to the primary child victim on the form.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.insertedby IS 'The user who initially inserted this record.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.insertedon IS 'Timestamp of when this record was first inserted.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.updatedby IS 'The user who last updated this record.';
COMMENT ON COLUMN cjams.listotherchildren1080forma.updatedon IS 'Timestamp of the last update to this record.';