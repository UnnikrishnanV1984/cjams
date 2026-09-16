drop table if exists cjams.expungementlookup;

--create expungement lookup table
CREATE TABLE cjams.expungementlookup(
    expungementlookupid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    tablename varchar(100) NOT NULL,
    expungedtablename varchar(100) NOT NULL,
    tablepk varchar(50) not NULL,
    tablecolumns text not null,
    untouchedcolumns text,
    nullyfiedcolumns text,
    objecttype text,
    activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50),
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50),
	updatedon timestamp NOT NULL DEFAULT now(),
	CONSTRAINT pk_expungementlookup PRIMARY KEY (expungementlookupid)
);

-- Column comments
COMMENT ON COLUMN cjams.expungementlookup.expungementlookupid IS 'Primary Key';
COMMENT ON COLUMN cjams.expungementlookup.tablename IS 'Table Name which will be expunged';
COMMENT ON COLUMN cjams.expungementlookup.expungedtablename IS 'Table where the expunged data is saved';
COMMENT ON COLUMN cjams.expungementlookup.tablepk IS 'Primary key of the table which will be expunged';
COMMENT ON COLUMN cjams.expungementlookup.tablecolumns IS 'Columns of the table which will be expunged';
COMMENT ON COLUMN cjams.expungementlookup.untouchedcolumns IS 'Untouched Columns of the table which will be same and saved to another expunged table';
COMMENT ON COLUMN cjams.expungementlookup.nullyfiedcolumns IS 'nullyfied Columns of the table which will be nullyfied';
COMMENT ON COLUMN cjams.expungementlookup.objecttype IS 'Configuration based on the oject type';
COMMENT ON COLUMN cjams.expungementlookup.activeflag IS 'Status of the record';
COMMENT ON COLUMN cjams.expungementlookup.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN cjams.expungementlookup.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.expungementlookup.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.expungementlookup.insertedon IS 'Record created date and time';
