ALTER TABLE cjams.Personmedicpshychotropic ADD COLUMN IF NOT EXISTS ismedicationpsychotropic bool NULL;
COMMENT ON COLUMN cjams.Personmedicpshychotropic.ismedicationpsychotropic IS 'Is medication psychotropic information';

ALTER TABLE cjams.Personmedicpshychotropic ADD COLUMN IF NOT EXISTS classification character varying;
COMMENT ON COLUMN cjams.Personmedicpshychotropic.classification IS 'medical classification information';

ALTER TABLE cjams.Personmedicpshychotropic ADD COLUMN IF NOT EXISTS diagnosis character varying;
COMMENT ON COLUMN cjams.Personmedicpshychotropic.classification IS 'diagnosis information';