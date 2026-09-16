ALTER TABLE cjams.progressnote ADD isintake varchar NULL;
ALTER TABLE cjams.progressnote ALTER COLUMN isintake TYPE varchar(1) USING isintake::varchar;
ALTER TABLE cjams.progressnote ADD otherpersonname varchar NULL;
ALTER TABLE cjams.progressnote ALTER COLUMN otherpersonname TYPE varchar(50) USING isintake::varchar;
ALTER TABLE cjams.progressnote ADD uploadedfile jsonb NULL;
