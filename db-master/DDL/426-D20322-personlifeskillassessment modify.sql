alter table personlifeskillassessment
alter column lifeskillassessid set default  gen_random_uuid();

ALTER TABLE cjams.personlifeskillassessment ALTER COLUMN fk_id DROP NOT NULL;

ALTER TABLE cjams.personlifeskillassessment ALTER COLUMN insertedby TYPE uuid USING insertedby::uuid;
ALTER TABLE cjams.personlifeskillassessment ALTER COLUMN updatedby TYPE uuid USING updatedby::uuid;
    