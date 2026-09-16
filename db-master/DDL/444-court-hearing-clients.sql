ALTER TABLE cjams.hearingclients ALTER COLUMN hearingclientid SET DEFAULT gen_random_uuid();
ALTER TABLE cjams.hearingclients ALTER COLUMN updatedby TYPE varchar(50) USING updatedby::varchar;
ALTER TABLE cjams.hearingclients ALTER COLUMN insertedby TYPE varchar(50) USING insertedby::varchar;
ALTER TABLE cjams.hearingclients ALTER COLUMN clientmergeid DROP NOT NULL;