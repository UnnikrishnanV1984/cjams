ALTER TABLE IF EXISTS cjams.adoptioninitialsavedatatable RENAME TO adoptioninitialeligibilityinfo;
ALTER TABLE cjams.adoptioninitialeligibilityinfo ADD COLUMN IF NOT EXISTS childagency varchar NULL;
ALTER TABLE cjams.adoptioninitialeligibilityinfo ADD COLUMN IF NOT EXISTS casenumber varchar NULL;
ALTER TABLE cjams.adoptioninitialeligibilityinfo ADD COLUMN IF NOT EXISTS adoptioncasenumber varchar NULL;
ALTER TABLE cjams.adoptioninitialeligibilityinfo ADD COLUMN IF NOT EXISTS adoptioncaseid varchar NULL;
ALTER TABLE cjams.adoptioninitialeligibilityinfo ADD COLUMN IF NOT EXISTS adoptionstartdate timestamp NULL;
ALTER TABLE cjams.adoptioninitialeligibilityinfo ADD COLUMN IF NOT EXISTS createdate timestamp NULL;
ALTER TABLE cjams.adoptioninitialeligibilityinfo ADD COLUMN IF NOT EXISTS ivestatus varchar NULL;
ALTER TABLE cjams.adoptioninitialeligibilityinfo ADD COLUMN IF NOT EXISTS servicecaseid uuid NULL;

