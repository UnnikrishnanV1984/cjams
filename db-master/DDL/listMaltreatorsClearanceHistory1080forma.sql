DROP TABLE IF EXISTS cjams.listMaltreatorsClearanceHistory1080forma;

CREATE TABLE
    IF NOT EXISTS cjams.listMaltreatorsClearanceHistory1080forma (
        maltreatorsclearancehistory1080formaid uuid NOT NULL DEFAULT gen_random_uuid (),
        form1080aid uuid,
        personid uuid NOT NULL,
        casenumber VARCHAR(255),
        intakedate date,
        programarea character varying,
        subprogramarea character varying,
        personrole character varying,
        persontype varchar(100),
        activeflag int4 NOT NULL DEFAULT 1,
        insertedby varchar(50) NOT NULL,
        insertedon timestamp NOT NULL DEFAULT now (),
        updatedby varchar(50) NOT NULL,
        updatedon timestamp NOT NULL DEFAULT now (),
        CONSTRAINT pk_listMaltreatorsClearanceHistory1080forma PRIMARY KEY (maltreatorsclearancehistory1080formaid),
        CONSTRAINT fk_listmaltreatorsclearancehistory_form1080a FOREIGN KEY (form1080aid) REFERENCES cjams.form1080a (form1080aid),
        CONSTRAINT fk_listmaltreatorsclearancehistory_person FOREIGN KEY (personid) REFERENCES cjams.person (personid)
    );

COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.maltreatorsclearancehistory1080formaid IS 'Unique identifier for the listMaltreatorsClearanceHistory1080forma (primary key).';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.form1080aid IS 'Foreign key linking this record to the main form1080a report.';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.personid IS 'Name of the person involved for history clearance data.';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.casenumber IS 'Unique identifier assigned to the case for tracking and reference.';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.intakedate IS 'Intake date realted to the case.';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.programarea IS 'Program area of the selected person or maltreator of the assigned case.';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.subprogramarea IS 'Sub Program area of the selected person or maltreator of the assigned case.';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.personrole IS 'The role of the parent in relation to the child (e.g., biological, foster, guardian).';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.persontype IS 'Indicates type of person assinged to the respective case';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.activeflag IS 'Indicates whether the History clearance is active (1 for active, 0 for inactive).';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.insertedby IS 'The user who initially inserted the form1080a record';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.insertedon IS 'Timestamp of when the form1080a record was first inserted.';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.updatedby IS 'The user who last updated the form1080a information.';
COMMENT ON COLUMN cjams.listMaltreatorsClearanceHistory1080forma.updatedon IS 'Timestamp of the last update to the form1080a record.';