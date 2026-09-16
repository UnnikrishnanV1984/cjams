ALTER TABLE cjams.visitationlog ALTER COLUMN visitationlogid SET DEFAULT gen_random_uuid();

ALTER TABLE cjams.visitationlog ALTER COLUMN clientmergeid DROP NOT NULL;
ALTER TABLE cjams.visitationlog ALTER COLUMN referralid DROP NOT NULL;

ALTER TABLE cjams.visitationlogclient ALTER COLUMN visitlogclntid SET DEFAULT gen_random_uuid();

ALTER TABLE cjams.visitationlogclient ALTER COLUMN personid DROP NOT NULL;
ALTER TABLE cjams.visitationlogclient ALTER COLUMN collateralid DROP NOT NULL;
ALTER TABLE cjams.visitationlogclient ALTER COLUMN clientmergeid DROP NOT NULL;
