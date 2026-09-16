ALTER TABLE cjams.intakeservicerequestpa ALTER COLUMN updatedby TYPE varchar(50) USING updatedby::varchar;
ALTER TABLE cjams.intakeservicerequestpa ALTER COLUMN insertedby TYPE varchar(50) USING insertedby::varchar;
ALTER TABLE cjams.intakeservicerequestpa ALTER COLUMN intakeservicerequestspaid SET DEFAULT gen_random_uuid();
