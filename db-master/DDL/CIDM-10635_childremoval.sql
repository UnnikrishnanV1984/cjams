ALTER TABLE cjams.intakeservreqchildremoval
  DROP CONSTRAINT IF EXISTS fk_fintakeservreqchildremoval_;
ALTER TABLE cjams.intakeservreqchildremoval
  DROP CONSTRAINT IF EXISTS fk_intakeservreqchildremoval_agencytype;
ALTER TABLE cjams.intakeservreqchildremoval
  DROP CONSTRAINT IF EXISTS fk_intakeservreqchildremoval_assessment;
ALTER TABLE cjams.intakeservreqchildremoval
  DROP CONSTRAINT IF EXISTS fk_intakeservreqchildremoval_intakeservicerequestactor;

ALTER TABLE cjams.intakeservreqchildremoval_history
  DROP CONSTRAINT IF EXISTS fk_fintakeservreqchildremoval_history_;
ALTER TABLE cjams.intakeservreqchildremoval_history
  DROP CONSTRAINT IF EXISTS fk_intakeservreqchildremoval_history_agencytype;
ALTER TABLE cjams.intakeservreqchildremoval_history
  DROP CONSTRAINT IF EXISTS fk_intakeservreqchildremoval_history_assessment;
ALTER TABLE cjams.intakeservreqchildremoval_history
DROP CONSTRAINT IF EXISTS fk_intakeservreqchildremoval_history_intakeservicerequestactor;

ALTER TABLE cjams.intakeservreqchildremoval
  ADD COLUMN IF NOT EXISTS showcontactpage boolean;
ALTER TABLE cjams.intakeservreqchildremoval_history
  ADD COLUMN IF NOT EXISTS showcontactpage boolean;

COMMENT ON COLUMN cjams.intakeservreqchildremoval.showcontactpage
  IS 'Flag to indicate save triggered via Go to Contacts button';
COMMENT ON COLUMN cjams.intakeservreqchildremoval_history.showcontactpage
  IS 'Flag to indicate save triggered via Go to Contacts button';
