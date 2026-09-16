ALTER TABLE cjams.intakeservicerequestsdm ADD ismalsa_sex_trafficking bool NULL DEFAULT false;
COMMENT ON COLUMN cjams.intakeservicerequestsdm.ismalsa_sex_trafficking IS 'Maltreatment Sexual Abuse - Sex trafficking flag';
