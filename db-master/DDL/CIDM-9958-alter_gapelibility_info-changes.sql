         ALTER TABLE cjams.gapeligibilityinfo ADD COLUMN IF NOT exists guardian_subsidy_id integer;
         COMMENT ON COLUMN gapeligibilityinfo.guardian_subsidy_id IS 'To link Subsidy Guardian and Eligibility Episode record';
         