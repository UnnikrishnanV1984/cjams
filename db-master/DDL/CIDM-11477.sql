ALTER TABLE cjams.beaconaudittrail
ADD COLUMN if not exists personid uuid NULL ;

COMMENT ON COLUMN cjams.beaconaudittrail.personid IS 'to save personid';