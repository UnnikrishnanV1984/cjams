DROP TABLE IF EXISTS cjams.listotherchildrenhousehold1080forma;

CREATE TABLE IF NOT EXISTS cjams.listotherchildrenhousehold1080forma (
	otherchildrenhouseholdform1080aid uuid NOT NULL DEFAULT gen_random_uuid (),
	activeflag int4 NOT NULL DEFAULT 1,
	cjamspid character varying,
	form1080aid uuid,
	fullname character varying,
	personid uuid,
	dob date,
	relationshiptovictim text,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now (),
	updatedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now (),
	CONSTRAINT pk_listotherchildrenhousehold1080forma PRIMARY KEY (otherchildrenhouseholdform1080aid),
	CONSTRAINT fk_listotherchildrenhousehold_form1080a FOREIGN KEY (form1080aid) REFERENCES cjams.form1080a (form1080aid),
	CONSTRAINT fk_listotherchildrenhousehold_person FOREIGN KEY (personid) REFERENCES cjams.person (personid)
);

COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.otherchildrenhouseholdform1080aid IS 'Unique identifier for this record (primary key).';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.activeflag IS 'Indicates whether this record is active (1 for active, 0 for inactive).';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.cjamspid IS 'Unique CJAMS identifier for the child in the household.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.form1080aid IS 'Foreign key linking this child to the main form1080a report.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.fullname IS 'The full name of the other child in the household.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.personid IS 'The personid (uuid) of the other child in the household, linking to the person table.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.dob IS 'Date of birth of the other child in the household.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.relationshiptovictim IS 'The relationship of this child to the primary child victim on the form.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.insertedby IS 'The user who initially inserted this record.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.insertedon IS 'Timestamp of when this record was first inserted.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.updatedby IS 'The user who last updated this record.';
COMMENT ON COLUMN cjams.listotherchildrenhousehold1080forma.updatedon IS 'Timestamp of the last update to this record.';
