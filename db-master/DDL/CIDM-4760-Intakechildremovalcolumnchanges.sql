ALTER TABLE intakeservreqchildremoval ADD COLUMN IF NOT EXISTS removalcircumstances json;
ALTER TABLE intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS removalcircumstances json;
