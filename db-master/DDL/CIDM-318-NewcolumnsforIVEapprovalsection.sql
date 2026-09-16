ALTER TABLE cjams.tb_eligibility_period ADD column IF NOT EXISTS approvedby varchar(50) NULL;
ALTER TABLE cjams.tb_eligibility_period ADD column IF NOT EXISTS approvedon timestamp NULL;