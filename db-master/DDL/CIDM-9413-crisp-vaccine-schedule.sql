ALTER TABLE cjams.personimmunizationconfig ADD vaccineschedule text NULL;

COMMENT ON COLUMN cjams.personimmunizationconfig.vaccineschedule IS 'Recommended vaccination 
schedule text for the UI page.';