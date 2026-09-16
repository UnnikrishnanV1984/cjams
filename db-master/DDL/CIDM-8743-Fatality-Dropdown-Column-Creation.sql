ALTER TABLE investigation ADD COLUMN fatalitycommentaudittrail JSONB;

COMMENT ON COLUMN cjams.investigation.fatalitycommentaudittrail IS 'Json data to store fatality comments, previous and current dropdown status values';