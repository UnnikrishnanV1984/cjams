DROP TABLE IF EXISTS cjams.schoollistreference;

CREATE TABLE IF NOT EXISTS cjams.schoollistreference (
    schoollistreferenceid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    schoolname varchar(500) NULL,
    address1 varchar(500) NULL,
    address2 varchar(500) NULL,
    city varchar(500) NULL,
    state varchar(500) NULL,
    zipcode varchar(500) NULL,
    county varchar(500) NULL,
    phoneno varchar(500) NULL,
    insertedby varchar(50) NULL,
    insertedon timestamp NOT NULL DEFAULT now(),
    updatedby varchar(50) NULL,
    updatedon timestamp NOT NULL DEFAULT now(),
    activeflag int4 NOT NULL DEFAULT 1,
    CONSTRAINT pk_schoollistreference PRIMARY KEY (schoollistreferenceid),
    CONSTRAINT uq_schoollistreference_name_address1 UNIQUE (schoolname, address1)
);

COMMENT ON COLUMN cjams.schoollistreference.schoollistreferenceid IS 'Primary key for the table';
COMMENT ON COLUMN cjams.schoollistreference.schoolname IS 'Name of the school';
COMMENT ON COLUMN cjams.schoollistreference.address1 IS 'School address line 1';
COMMENT ON COLUMN cjams.schoollistreference.address2 IS 'School address line 2';
COMMENT ON COLUMN cjams.schoollistreference.city IS 'School city';
COMMENT ON COLUMN cjams.schoollistreference.state IS 'State where the school is located';
COMMENT ON COLUMN cjams.schoollistreference.zipcode IS 'School zip code';
COMMENT ON COLUMN cjams.schoollistreference.county IS 'County name for the school';
COMMENT ON COLUMN cjams.schoollistreference.phoneno IS 'School phone number';
COMMENT ON COLUMN cjams.schoollistreference.insertedby IS 'User who inserted the record';
COMMENT ON COLUMN cjams.schoollistreference.insertedon IS 'Record inserted date';
COMMENT ON COLUMN cjams.schoollistreference.updatedby IS 'User who updated the record';
COMMENT ON COLUMN cjams.schoollistreference.updatedon IS 'Record updated date';
COMMENT ON COLUMN cjams.schoollistreference.activeflag IS 'Active record flag';