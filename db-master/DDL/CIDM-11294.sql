ALTER TABLE cjams.personexamination
ADD COLUMN IF NOT EXISTS casenumber varchar(50) NULL;

COMMENT ON COLUMN cjams.personexamination.casenumber IS 'Stores the case number for Health Passport Calendar display';