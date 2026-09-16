
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS primarycaregiverid character VARYING;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS secondarycaregiverid CHARACTER VARYING;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS primaryrelationship CHARACTER VARYING;

ALTER TABLE cjams.livingarrangement ALTER COLUMN primarycaregiver TYPE CHARACTER VARYING;
ALTER TABLE cjams.livingarrangement ALTER COLUMN secondarycaregiver TYPE CHARACTER VARYING;