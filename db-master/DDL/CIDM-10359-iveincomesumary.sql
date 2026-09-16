ALTER TABLE cjams.iveincomesumary ADD COLUMN IF NOT EXISTS afdceligibilitymonth date NULL;
COMMENT ON COLUMN iveincomesumary.afdceligibilitymonth IS 'AFDC Eligibility Month enter by user in the AFDC Section.';
