ALTER TABLE cjams.personasset ALTER COLUMN fk_id DROP NOT NULL;
ALTER TABLE cjams.personasset ALTER COLUMN clientmergeid DROP NOT NULL;
ALTER TABLE cjams.personasset ADD addressline1 varchar(200) NULL;
ALTER TABLE cjams.personasset ADD addressline2 varchar(200) NULL;
