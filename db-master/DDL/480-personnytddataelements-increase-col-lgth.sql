ALTER TABLE cjams.personnytddetail ALTER COLUMN insertedby TYPE varchar(50) USING insertedby::varchar;
ALTER TABLE cjams.personnytddetail ALTER COLUMN updatedby TYPE varchar(50) USING updatedby::varchar;
