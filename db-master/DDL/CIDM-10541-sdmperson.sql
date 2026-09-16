ALTER TABLE cjams.person ADD COLUMN IF NOT EXISTS sdmpersonapprovalflag int4 NULL;
COMMENT ON COLUMN cjams.person.sdmpersonapprovalflag IS 'Indicates SDM status for the person';