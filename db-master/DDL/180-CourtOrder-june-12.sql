ALTER TABLE cjams.intakeservreqcourtorder ADD COLUMN IF NOT EXISTS courtorderdelaytimeframe smallint NULL;
ALTER TABLE cjams.intakeservreqcourtorder ADD COLUMN IF NOT EXISTS courtorderdelayremoval bool NULL;
