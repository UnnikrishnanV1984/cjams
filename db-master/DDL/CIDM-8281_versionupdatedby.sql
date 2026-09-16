ALTER TABLE cjams.snapshothist ADD COLUMN IF NOT EXISTS versionupdatedby varchar NULL;
COMMENT ON COLUMN cjams.snapshothist.versionupdatedby IS 'To store updated Username';