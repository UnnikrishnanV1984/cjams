ALTER TABLE cjams.audittraillukup
ADD COLUMN IF NOT EXISTS historytablename character varying NULL,
ADD COLUMN IF NOT EXISTS primarykeyname character varying NULL;

COMMENT ON COLUMN cjams.audittraillukup.historytablename IS 'history table of the table in type key';
COMMENT ON COLUMN cjams.audittraillukup.primarykeyname IS 'primary key of the table in typekey';