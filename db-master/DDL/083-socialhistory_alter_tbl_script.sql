ALTER TABLE cjams.socialhistory ALTER COLUMN placement TYPE varchar(5000) USING placement::varchar;
ALTER TABLE cjams.socialhistory ALTER COLUMN familyhistory TYPE varchar(5000) USING familyhistory::varchar;
ALTER TABLE cjams.socialhistory ALTER COLUMN childdesc TYPE varchar(5000) USING childdesc::varchar;
 
ALTER TABLE cjams.socialhistory ALTER COLUMN socialhistoryid SET DEFAULT gen_random_uuid();
 