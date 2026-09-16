alter table sdmtraffickingaudittrail ADD column if not exists objectkey varchar(100) NULL;
alter table sdmtraffickingaudittrail ADD column if not exists ismaltreatment varchar(100) NULL;
alter table sdmtraffickingaudittrail ADD column if not exists isfclivingarrangement varchar(100) NULL;
alter table sdmtraffickingaudittrail ADD column if not exists isschool varchar(100) NULL;
alter table sdmtraffickingaudittrail ADD column if not exists islicenseddaycare varchar(100) NULL;
alter table sdmtraffickingaudittrail ADD column if not exists isprivateplacement varchar(100) NULL;
alter table sdmtraffickingaudittrail ADD column if not exists isfcplacementsetting varchar(100) NULL;
alter table sdmtraffickingaudittrail ADD column if not exists provider jsonb NULL;

COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.objectkey IS 'object key for type audit';
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.ismaltreatment IS 'to save ismaltreatment';
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.isfclivingarrangement IS 'to save isfclivingarrangement';
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.isschool IS 'to save isschool';
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.islicenseddaycare IS 'to save islicenseddaycare';
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.isprivateplacement IS 'to save isprivateplacement';
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.isfcplacementsetting IS 'to save isfcplacementsetting';
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.provider IS 'to save provider ';

ALTER TABLE cjams.administrativeoverrides ADD column if not exists contactmadewithhhmember boolean NULL;

COMMENT ON COLUMN cjams.administrativeoverrides.contactmadewithhhmember IS 'contactmade with hh member';

ALTER TABLE cjams.routing ADD column if not exists intakerecommendation varchar(225) NULL;
COMMENT ON COLUMN cjams.routing.intakerecommendation IS 'to add intake recommendationn in overrides';


ALTER TABLE cjams.routing ADD column if not exists supervisordecision varchar(225) NULL;
COMMENT ON COLUMN cjams.routing.supervisordecision IS 'to add supervisor decision after overrides';

alter table administrativeoverrides alter column referralsnapshotid  DROP NOT NULL;
alter table administrativeoverrides alter column intakeserviceid  DROP NOT NULL;

ALTER TABLE cjams.intakeservicerequest ADD column if not exists addendum text null;
COMMENT ON COLUMN cjams.intakeservicerequest.addendum IS 'to add intake addendum';

ALTER TABLE cjams.routing ADD column if not exists approveddate timestamp NULL;
COMMENT ON COLUMN cjams.routing.approveddate IS 'to add supervisor approved date';

alter table cjams.sdmtraffickingaudittrail add column if not exists providerdetails jsonb null;
COMMENT ON COLUMN cjams.sdmtraffickingaudittrail.providerdetails IS 'to add provider details';