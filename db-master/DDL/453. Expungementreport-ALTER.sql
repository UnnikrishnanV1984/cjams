ALTER TABLE cjams.expungementreport  ALTER COLUMN  expungereportid   SET DEFAULT  uuid_in(md5(random()::text || now()::text)::cstring) ;
ALTER TABLE cjams.expungementreport  ALTER COLUMN  maltreaterid   SET DEFAULT  0;
ALTER TABLE cjams.expungementreport  ALTER COLUMN  maltreatercisid   SET DEFAULT   'N/A' ;
ALTER TABLE cjams.expungementreport  ALTER COLUMN  workerid   SET DEFAULT  'N/A';
ALTER TABLE cjams.expungementreport  ALTER COLUMN  victimid   SET DEFAULT   0;
ALTER TABLE cjams.expungementreport  ALTER COLUMN  victincisid SET DEFAULT   'N/A' ;
ALTER TABLE cjams.expungementreport  ALTER COLUMN  cisclientid SET DEFAULT  'N/A' ;
ALTER TABLE cjams.expungementreport  ALTER COLUMN  suid SET DEFAULT  0;
ALTER TABLE cjams.expungementreport  ALTER COLUMN  requestuserid SET DEFAULT  'N/A' ;