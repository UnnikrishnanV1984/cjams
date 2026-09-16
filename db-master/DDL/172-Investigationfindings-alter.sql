ALTER TABLE cjams.investigationfinding ADD COLUMN IF NOT EXISTS finalfinding varchar(50) NULL;
ALTER TABLE cjams.expungement DROP COLUMN IF EXISTS investigationnarrative1;
ALTER TABLE cjams.expungement ADD COLUMN IF NOT EXISTS investigationnarrative varchar(1000) NULL;
