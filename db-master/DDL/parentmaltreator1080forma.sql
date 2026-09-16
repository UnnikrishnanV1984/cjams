DROP TABLE IF EXISTS cjams.parentmaltreator1080forma;

CREATE TABLE IF NOT EXISTS cjams.parentmaltreator1080forma (
	parentmaltreatorform1080aid uuid NOT NULL DEFAULT gen_random_uuid(),
	isMaltreator int4 NOT NULL DEFAULT 0,
	isParent int4 NOT NULL DEFAULT 0,
	activeflag int4 NOT NULL DEFAULT 1,
	fullname character varying,
	personid uuid,
	cjamspid character varying,
	aliases text,
	dob date,
	relationshiptovictim text,
	anychildwelfarehistoryinvolvingthisperson boolean,
	form1080aid uuid,
	iscasehead boolean,
	isallegedmaltreator boolean,
	isthisalsothecasehead  boolean,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now (),
	updatedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now (),
	CONSTRAINT pk_parentmaltreator1080forma PRIMARY KEY (parentmaltreatorform1080aid),
	CONSTRAINT fk_parentmaltreator_form1080a FOREIGN KEY (form1080aid) REFERENCES cjams.form1080a (form1080aid),
	CONSTRAINT fk_parentmaltreator_person FOREIGN KEY (personid) REFERENCES cjams.person (personid)
);

COMMENT ON COLUMN cjams.parentmaltreator1080forma.parentmaltreatorform1080aid IS 'Unique identifier for this record (primary key).';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.isMaltreator IS 'Flag to indicate if this person is a maltreator (1 for yes, 0 for no).';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.isParent IS 'Flag to indicate if this person is a parent/guardian (1 for yes, 0 for no).';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.activeflag IS 'Indicates whether this record is active (1 for active, 0 for inactive).';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.fullname IS 'The full name of the parent or maltreator.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.personid IS 'The personid (uuid) of the individual, linking to the person table.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.cjamspid IS 'Unique CJAMS identifier for the person.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.aliases IS 'Any known aliases for the person.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.dob IS 'Date of birth of the person.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.relationshiptovictim IS 'The person''s relationship to the child victim.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.anychildwelfarehistoryinvolvingthisperson IS 'Indicates if this person has any prior child welfare history (true or false).';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.form1080aid IS 'Foreign key linking this person to the main form1080a report.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.iscasehead IS 'Indicates if this person is the head of the case (true or false).';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.isallegedmaltreator IS 'Indicates if this person is an alleged maltreator (true or false).';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.isthisalsothecasehead IS 'Indicates if this person is also the case head (true or false).';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.insertedby IS 'The user who initially inserted this record.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.insertedon IS 'Timestamp of when this record was first inserted.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.updatedby IS 'The user who last updated this record.';
COMMENT ON COLUMN cjams.parentmaltreator1080forma.updatedon IS 'Timestamp of the last update to this record.';