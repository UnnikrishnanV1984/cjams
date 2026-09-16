ALTER TABLE cjams.quickperson ADD COLUMN IF NOT EXISTS casenumber varchar(50) NULL;
ALTER TABLE cjams.quickperson_history ADD COLUMN IF NOT EXISTS casenumber varchar(50) NULL;