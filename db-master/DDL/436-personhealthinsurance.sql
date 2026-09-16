
ALTER TABLE cjams.personhealthinsurance ADD COLUMN IF NOT EXISTS caresmatypekey character varying (50);
ALTER TABLE cjams.personhealthinsurance ADD COLUMN IF NOT EXISTS old_id character varying (50);