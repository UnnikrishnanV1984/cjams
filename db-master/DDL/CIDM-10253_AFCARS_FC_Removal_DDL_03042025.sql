-- CIDM-10253 - AFCARS Submission Changes (B-214951)

-- Add 2 new columns for capturing the child removal date & removal exit date: removal_date and exit_date
ALTER TABLE cjams.afcars_fc_child_removals ADD COLUMN IF NOT EXISTS removal_date timestamp NULL;
COMMENT ON COLUMN cjams.afcars_fc_child_removals.removal_date IS 'Actual Child Removal Date';

ALTER TABLE cjams.afcars_fc_child_removals ADD COLUMN IF NOT EXISTS exit_date timestamp NULL;
COMMENT ON COLUMN cjams.afcars_fc_child_removals.exit_date IS 'Actual Child Removal Exit Date';

ALTER TABLE cjams.afcars_fc_child_removals_history ADD COLUMN IF NOT EXISTS removal_date timestamp NULL;
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.removal_date IS 'Actual Child Removal Date';

ALTER TABLE cjams.afcars_fc_child_removals_history ADD COLUMN IF NOT EXISTS exit_date timestamp NULL;
COMMENT ON COLUMN cjams.afcars_fc_child_removals_history.exit_date IS 'Actual Child Removal Exit Date';


-- Add 3 new column for capturing the Living Arrangement type/ Placement Structure ID, Original Removalid and PL start date 
ALTER TABLE cjams.afcars_fc_placements ADD COLUMN IF NOT EXISTS original_removalid character varying NULL;
COMMENT ON COLUMN cjams.afcars_fc_placements.original_removalid IS 'Actual Child Removal ID (Primary Key)';

ALTER TABLE cjams.afcars_fc_placements ADD COLUMN IF NOT EXISTS start_date timestamp NULL;
COMMENT ON COLUMN cjams.afcars_fc_placements.start_date IS 'Actual Placement Start Date';

ALTER TABLE cjams.afcars_fc_placements ADD COLUMN IF NOT EXISTS placementsubtype character varying NULL;
COMMENT ON COLUMN cjams.afcars_fc_placements.placementsubtype IS 'Living Arrangement type/ Placement Structure ID';

ALTER TABLE cjams.afcars_fc_placements_history ADD COLUMN IF NOT EXISTS start_date timestamp NULL;
COMMENT ON COLUMN cjams.afcars_fc_placements_history.start_date IS 'Actual Placement Start Date';

ALTER TABLE cjams.afcars_fc_placements_history ADD COLUMN IF NOT EXISTS placementsubtype character varying NULL;
COMMENT ON COLUMN cjams.afcars_fc_placements_history.placementsubtype IS 'Living Arrangement type/ Placement Structure ID';

ALTER TABLE cjams.afcars_fc_placements_history ADD COLUMN IF NOT EXISTS original_removalid character varying NULL;
COMMENT ON COLUMN cjams.afcars_fc_placements_history.original_removalid IS 'Actual Child Removal ID (Primary Key)';

