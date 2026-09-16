---CIDM-5740- Removal environmentatremovalkey


ALTER TABLE cjams.intakeservreqchildremoval  ADD COLUMN IF NOT EXISTS environmentatremovalkey varchar(50) NULL;
COMMENT ON COLUMN cjams.intakeservreqchildremoval.environmentatremovalkey IS 'Environment at Removal (Foreign key)';


ALTER TABLE cjams.intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS environmentatremovalkey varchar(50) NULL;
COMMENT ON COLUMN cjams.intakeservreqchildremoval_history.environmentatremovalkey IS 'Environment at Removal (Foreign key)';