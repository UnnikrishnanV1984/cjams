-- B-192488 CJAMS CW Immunet Interface (CRISP) 
-- Add new child table to map CJAMS immunization code with CRISP system immunization code. CJAMS PK, CVX Code & CVX Group 
ALTER TABLE IF EXISTS cjams.crispconfig DROP CONSTRAINT IF EXISTS pk_crisppersonimmunizationconfig;
ALTER TABLE IF EXISTS cjams.crispconfig DROP CONSTRAINT IF EXISTS pk_crispconfig;
DROP TABLE IF EXISTS cjams.crispconfig;

-- Create table crispconfig
CREATE TABLE IF NOT EXISTS cjams.crispconfig (
    crispconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
    immunizationkey varchar(20),
    cvxcode varchar(50) NULL,
    cvxgroup varchar(50) NULL,
    activeflag int4 NOT NULL DEFAULT 1, 
    insertedby varchar(50) NOT NULL, 
    insertedon timestamp NOT NULL DEFAULT now(), 
    updatedby varchar(50) NULL, 
    updatedon timestamp NULL DEFAULT now(), 
    CONSTRAINT pk_crispconfig PRIMARY KEY (crispconfigid)
);

-- Column comments

COMMENT ON COLUMN cjams.crispconfig.crispconfigid IS 'crispconfig details stored in this table(primary key)';
COMMENT ON COLUMN cjams.crispconfig.immunizationkey IS 'immuniztionkey for vaccine from referencevalues';
COMMENT ON COLUMN cjams.crispconfig.cvxcode IS 'cvxcode of crisp system';
COMMENT ON COLUMN cjams.crispconfig.cvxgroup IS 'cvxgroup of crisp system';
COMMENT ON COLUMN cjams.crispconfig.activeflag IS 'status of the record';
COMMENT ON COLUMN cjams.crispconfig.insertedby IS 'user who created this record';
COMMENT ON COLUMN cjams.crispconfig.insertedon IS 'record created date and time';
COMMENT ON COLUMN cjams.crispconfig.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN cjams.crispconfig.updatedon IS 'record updated date and time';