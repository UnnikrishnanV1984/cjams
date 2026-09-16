alter table sdmtraffickingaudittrail ADD column if not exists fatalitypersons jsonb;
alter table sdmtraffickingaudittrail ADD column if not exists ischildfatality character varying(5);


COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.fatalitypersons IS 'to save child fatality details';
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.ischildfatality IS 'To find child fatality audit captured or not';