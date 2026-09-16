ALTER TABLE intakeservicerequestactor_history ADD COLUMN IF NOT EXISTS isexpunged INTEGER DEFAULT 0;

COMMENT ON COLUMN cjams.intakeservicerequestactor_history.isexpunged IS 'Flag to indicate the expunged record';