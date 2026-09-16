ALTER TABLE cjams.ivepersondeprivation ADD column if not exists removalid int4 NULL;
ALTER TABLE cjams.ivepersondeprivation ADD column if not exists parentid int4 NULL;
ALTER TABLE cjams.ivepersondeprivation ADD column if not exists relationship varchar NULL;