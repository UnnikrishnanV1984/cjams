ALTER TABLE cjams.ivessissadata ADD COLUMN IF NOT EXISTS ischildageabove18 int4 NULL;
ALTER TABLE cjams.tb_ive_fostercare_audit ALTER COLUMN mandatorynoteonmissing2ndparentsignatureonvpa TYPE varchar(500) USING mandatorynoteonmissing2ndparentsignatureonvpa::varchar;

