ALTER TABLE cjams.personeducation add column if not exists bidadded int4 NULL;
COMMENT ON COLUMN personeducation.bidadded IS 'To store check whether new bid is added or not';

ALTER TABLE cjams.personeducation_history add column if not exists bidadded int4 NULL;
COMMENT ON COLUMN personeducation_history.bidadded IS 'To store check whether new bid is added or not';
