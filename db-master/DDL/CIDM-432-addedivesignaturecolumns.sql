ALTER TABLE cjams.tb_eligibility_period ADD COLUMN IF NOT EXISTS  supervisorname text;
ALTER TABLE cjams.tb_eligibility_period ADD COLUMN IF NOT EXISTS  supervisorsubmissiondate timestamp without time zone;
ALTER TABLE cjams.tb_eligibility_period ADD COLUMN IF NOT EXISTS  supervisorsignature text;
ALTER TABLE cjams.tb_eligibility_period ADD COLUMN IF NOT EXISTS  specialistname text;
ALTER TABLE cjams.tb_eligibility_period ADD COLUMN IF NOT EXISTS  specialistsubmissiondate timestamp without time zone;
ALTER TABLE cjams.tb_eligibility_period ADD COLUMN IF NOT EXISTS  specialistsignature text;







