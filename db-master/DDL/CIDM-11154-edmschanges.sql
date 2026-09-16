ALTER TABLE cjams.documentproperties add column if not exists ispresignedurlinitiated int4 DEFAULT 0;

COMMENT ON COLUMN cjams.documentproperties.ispresignedurlinitiated IS 'Flag which determines if presign url is initiated.Default 0. Triggered one, 100 percent completed 2';