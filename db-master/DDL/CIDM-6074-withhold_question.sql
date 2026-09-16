

ALTER TABLE cjams.withhold_eft_config ADD COLUMN IF NOT EXISTS withhold_question varchar(5) NULL;
COMMENT ON COLUMN cjams.withhold_eft_config.withhold_question IS 'Saving withhold question';


