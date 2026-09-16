ALTER TABLE cjams.afcarsadoptiondetail ADD clientid int4 NULL;
ALTER TABLE cjams.afcarsadoptiondetail ALTER COLUMN iveadoptionflag TYPE varchar USING iveadoptionflag::varchar;
ALTER TABLE cjams.afcarsadoptiondetail ALTER COLUMN detailid SET DEFAULT gen_random_uuid();
ALTER TABLE cjams.afcarsfostercare_new ALTER COLUMN caseid DROP NOT NULL;

