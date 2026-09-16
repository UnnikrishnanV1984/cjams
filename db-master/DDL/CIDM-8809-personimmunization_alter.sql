-- B-192488 CJAMS CW Immunet Interface (CRISP) 
-- Modify personimmunization transaction table to add 3 new columns, source system name, source system primary key, 
-- and source system update timestamp for the immunization record.
ALTER TABLE IF EXISTS cjams.personimmunization  
ADD COLUMN IF NOT EXISTS sourcesystem VARCHAR(50) NULL, 
ADD COLUMN IF NOT EXISTS sourcesystemprimarykey VARCHAR(250) NULL, 
ADD COLUMN IF NOT EXISTS sourcesystemupdatetimestamp TIMESTAMP NULL;

-- Column comments

COMMENT ON COLUMN cjams.personimmunization.sourcesystem IS 'source system for the immunization record';
COMMENT ON COLUMN cjams.personimmunization.sourcesystemprimarykey IS 'source system primarykey for the immunization record';
COMMENT ON COLUMN cjams.personimmunization.sourcesystemupdatetimestamp IS 'source system updatetimestamp for the immunization record';