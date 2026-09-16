
-- ALTER TABLE cjams.documentproperties DROP COLUMN other;

 ALTER TABLE cjams.documentproperties ADD COLUMN IF NOT EXISTS other varchar(500) NULL;
 COMMENT ON COLUMN cjams.documentproperties.other IS 'To store other inputs of the document';




