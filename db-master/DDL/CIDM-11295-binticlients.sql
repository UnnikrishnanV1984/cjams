-- Table: cjams.binticlients
DROP TABLE IF EXISTS cjams.binticlients;
CREATE TABLE IF NOT EXISTS cjams.binticlients (
    binticlientsid uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    cjamspid int8 NULL,
    binti_clientid varchar(50) NULL,
    firstname varchar(255) NULL,
    lastname varchar(255) NULL,
    dob date NULL,
    gender varchar(50) NULL,
    county varchar(100) NULL,
    activeflag int4 DEFAULT 1 NOT NULL,
    insertedby varchar(50) NOT NULL,
    insertedon timestamp DEFAULT now() NOT NULL,
    updatedby varchar(50) NULL,
    updatedon timestamp DEFAULT now() NULL,
    externalapilogsid uuid NULL
);

COMMENT ON TABLE cjams.binticlients IS 'Binti clients table for Binti API integration.';
COMMENT ON COLUMN cjams.binticlients.binticlientsid IS 'Primary key. Unique identifier for each Binti client record.';
COMMENT ON COLUMN cjams.binticlients.cjamspid IS 'CJAMSPID from Person table';
COMMENT ON COLUMN cjams.binticlients.binti_clientid IS 'Binti system client identifier.';
COMMENT ON COLUMN cjams.binticlients.firstname IS 'Client first name';
COMMENT ON COLUMN cjams.binticlients.lastname IS 'Client last name';
COMMENT ON COLUMN cjams.binticlients.dob IS 'Date of birth';
COMMENT ON COLUMN cjams.binticlients.gender IS 'Gender';
COMMENT ON COLUMN cjams.binticlients.county IS 'County';
COMMENT ON COLUMN cjams.binticlients.activeflag IS 'Active Flag. 1 - Active, 0 - Inactive';
COMMENT ON COLUMN cjams.binticlients.insertedby IS 'Inserted By';
COMMENT ON COLUMN cjams.binticlients.insertedon IS 'Inserted On';
COMMENT ON COLUMN cjams.binticlients.updatedby IS 'Updated By';
COMMENT ON COLUMN cjams.binticlients.updatedon IS 'Updated On';
COMMENT ON COLUMN cjams.binticlients.externalapilogsid IS 'Reference to external API logs (if any)';