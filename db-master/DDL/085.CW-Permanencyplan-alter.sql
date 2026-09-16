ALTER TABLE cjams.permanencyplan ADD COLUMN IF NOT EXISTS enddate timestamp NULL;
ALTER TABLE cjams.permanencyplan ADD COLUMN IF NOT EXISTS reason varchar(300) NULL;
