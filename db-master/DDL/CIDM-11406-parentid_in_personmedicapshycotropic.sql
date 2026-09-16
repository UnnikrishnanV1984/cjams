ALTER TABLE cjams.personmedicpshychotropic 
ADD COLUMN if not exists personmedicpshychotropicparentid uuid;

ALTER TABLE cjams.personmedicpshychotropic_history
ADD COLUMN  if not exists personmedicpshychotropicparentid uuid;

COMMENT ON COLUMN cjams.personmedicpshychotropic.personmedicpshychotropicparentid IS 'to store the parentid value to identify parent record and refill record';

COMMENT ON COLUMN cjams.personmedicpshychotropic_history.personmedicpshychotropicparentid IS 'to store the parentid value to identify parent record and refill record';