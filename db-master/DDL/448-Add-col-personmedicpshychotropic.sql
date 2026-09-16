ALTER TABLE cjams.Personmedicpshychotropic ADD COLUMN IF NOT EXISTS isprescribedmedication bool NULL;
ALTER TABLE cjams.Personmedicpshychotropic ADD COLUMN IF NOT EXISTS medicationtype character varying;
ALTER TABLE cjams.Personmedicpshychotropic ADD COLUMN IF NOT EXISTS prescribedduration character varying;
ALTER TABLE cjams.Personmedicpshychotropic ADD COLUMN IF NOT EXISTS prescribedreason character varying;
