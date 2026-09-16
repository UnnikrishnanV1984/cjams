ALTER TABLE cjams.permanencyplanhistory ADD COLUMN IF NOT EXISTS  objectid uuid NULL;
COMMENT ON COLUMN permanencyplanhistory.objectid IS 'To save routing id';