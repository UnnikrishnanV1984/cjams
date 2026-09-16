ALTER TABLE cjams.expungement ALTER COLUMN resultoflawenforcement TYPE varchar(1000);
ALTER TABLE cjams.expungement ADD COLUMN IF NOT EXISTS investigationnarrative1 varchar(1000) NULL;
