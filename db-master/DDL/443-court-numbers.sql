ALTER TABLE cjams.courtnumbers ALTER COLUMN courtnumberid SET DEFAULT gen_random_uuid();

ALTER TABLE cjams.courtnumbers ALTER COLUMN clientmergeid DROP NOT NULL;

ALTER TABLE cjams.courtnumbers ALTER COLUMN insertedby TYPE varchar(50) USING insertedby::varchar;

ALTER TABLE cjams.courtnumbers ALTER COLUMN updatedby TYPE varchar(50) USING updatedby::varchar;