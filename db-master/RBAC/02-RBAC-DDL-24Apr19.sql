ALTER TABLE cjams.resource ALTER COLUMN resourcename TYPE varchar(500) USING resourcename::varchar;
ALTER TABLE cjams.resource ADD COLUMN IF NOT EXISTS description varchar(1000);
ALTER TABLE cjams.resource ADD COLUMN IF NOT EXISTS parentkey varchar(250);

ALTER TABLE cjams.resource ADD COLUMN IF NOT EXISTS modulekey varchar(250);