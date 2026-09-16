-- Table: cjams.bintifamilyfindings
DROP TABLE IF EXISTS cjams.bintifamilyfindings;
CREATE TABLE IF NOT EXISTS cjams.bintifamilyfindings (
    bintifamilyfindingsid uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
    binticasenumber varchar(25) NULL,
    binticasestartdate date NULL,
    binticaselastsearchdate timestamp default now() NULL,
    cjamspid int8 NULL,
    caseworkerid uuid null,
    caseworkeragencyid int8 null,
    externalapilogid uuid NULL,
    activeflag int4 DEFAULT 1 NOT NULL,
    insertedby varchar(50) NOT NULL,
    insertedon timestamp DEFAULT now() NOT NULL,
    updatedby varchar(50) NULL,
    updatedon timestamp DEFAULT now() NULL
);

COMMENT ON TABLE cjams.bintifamilyfindings IS 'Binti family findings table for Binti API integration.';
COMMENT ON COLUMN cjams.bintifamilyfindings.bintifamilyfindingsid IS 'Primary key. Unique identifier for each Binti family finding record.';
COMMENT ON COLUMN cjams.bintifamilyfindings.binticasenumber IS 'Binti case number associated with the family finding.';
COMMENT ON COLUMN cjams.bintifamilyfindings.binticasestartdate IS 'Start date of the Binti case.';
COMMENT ON COLUMN cjams.bintifamilyfindings.binticaselastsearchdate IS 'Timestamp of the last search performed for the Binti case.';
COMMENT ON COLUMN cjams.bintifamilyfindings.cjamspid IS 'CJAMSPID from Person table';
COMMENT ON COLUMN cjams.bintifamilyfindings.caseworkerid IS 'securityusersid of the caseworker (from userprofile table).';
COMMENT ON COLUMN cjams.bintifamilyfindings.caseworkeragencyid IS 'Agency Worker ID from Binti system.';
COMMENT ON COLUMN cjams.bintifamilyfindings.externalapilogid IS 'Reference to external API logs (if any)';
COMMENT ON COLUMN cjams.bintifamilyfindings.activeflag IS 'Active Flag. 1 - Active, 0 - Inactive';
COMMENT ON COLUMN cjams.bintifamilyfindings.insertedby IS 'Inserted By';
COMMENT ON COLUMN cjams.bintifamilyfindings.insertedon IS 'Inserted On';
COMMENT ON COLUMN cjams.bintifamilyfindings.updatedby IS 'Updated By';
COMMENT ON COLUMN cjams.bintifamilyfindings.updatedon IS 'Updated On';
