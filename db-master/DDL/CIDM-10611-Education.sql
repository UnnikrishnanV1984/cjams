ALTER TABLE cjams.personeducation ADD COLUMN IF NOT EXISTS schooladdress1 varchar;
COMMENT ON COLUMN cjams.personeducation.schooladdress1 IS 'First line of the school address associated with the education record';

ALTER TABLE cjams.personeducation ADD COLUMN IF NOT EXISTS schooladdress2 varchar;
COMMENT ON COLUMN cjams.personeducation.schooladdress2 IS 'Second line of the school address associated with the education record';

ALTER TABLE cjams.personeducation ADD COLUMN IF NOT EXISTS schoolzipcode varchar(50);
COMMENT ON COLUMN cjams.personeducation.schoolzipcode IS 'Zip code of the school address associated with the education record';





ALTER TABLE cjams.personeducation_history ADD COLUMN IF NOT EXISTS schooladdress1 varchar;
COMMENT ON COLUMN cjams.personeducation_history.schooladdress1 IS 'First line of the school address associated with the education record';

ALTER TABLE cjams.personeducation_history ADD COLUMN IF NOT EXISTS schooladdress2 varchar;
COMMENT ON COLUMN cjams.personeducation_history.schooladdress2 IS 'Second line of the school address associated with the education record';

ALTER TABLE cjams.personeducation_history ADD COLUMN IF NOT EXISTS schoolzipcode varchar(50);
COMMENT ON COLUMN cjams.personeducation_history.schoolzipcode IS 'Zip code of the school address associated with the education record';