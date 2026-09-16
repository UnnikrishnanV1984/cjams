ALTER TABLE caseplan3 ADD COLUMN IF NOT EXISTS caseplan3applaid int;
ALTER TABLE caseplan3appla2 ADD COLUMN IF NOT EXISTS caseplan3applaid int;
ALTER TABLE caseplan3 DROP COLUMN IF EXISTS actorid ;
ALTER TABLE caseplan4 DROP COLUMN IF EXISTS actorid ;
ALTER TABLE caseplan3 ADD COLUMN IF NOT EXISTS personid uuid;
ALTER TABLE caseplan4 ADD COLUMN IF NOT EXISTS personid uuid;
 