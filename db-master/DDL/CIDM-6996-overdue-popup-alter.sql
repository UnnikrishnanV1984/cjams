ALTER TABLE cjams.overduepopup ADD COLUMN IF NOT EXISTS revisioncount int4;
COMMENT ON COLUMN cjams.overduepopup.revisioncount IS 'To save Count Override popup';