ALTER TABLE cjams.casereview ALTER COLUMN casereviewid SET DEFAULT gen_random_uuid();
ALTER TABLE cjams.reviewrecommendations ALTER COLUMN reviewrecommendationid SET DEFAULT gen_random_uuid();

ALTER TABLE cjams.casereview ALTER COLUMN clientmergeid DROP NOT NULL;
ALTER TABLE cjams.casereview ALTER COLUMN fk_id DROP NOT NULL;
ALTER TABLE cjams.casereview ALTER COLUMN panelsupervisorid DROP NOT NULL;
ALTER TABLE cjams.casereview ALTER COLUMN panelworkerid DROP NOT NULL;
