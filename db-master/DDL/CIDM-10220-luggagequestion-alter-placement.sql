ALTER TABLE cjams.placement DROP COLUMN IF EXISTS exitluggage;
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS exitluggage boolean NULL;
comment on column cjams.placement.exitluggage is 'Person  luggage information at the time of exit. Captures Yes or No values';

ALTER TABLE cjams.placement DROP COLUMN IF EXISTS exitluggageprovided; 
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS  exitluggageprovided boolean NULL;
comment on column cjams.placement.exitluggageprovided is 'Person luggage purchased information at the time of exit.Captures Yes or No values';

ALTER TABLE cjams.placement DROP COLUMN IF EXISTS  exitluggagecomments;
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS  exitluggagecomments varchar NULL;
comment on column cjams.placement.exitluggagecomments is 'Person luggage comments at the time of exit';

ALTER TABLE cjams.placement DROP COLUMN IF EXISTS  exitdisposableortrashbag;
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS exitdisposableortrashbag boolean NULL;
comment on column cjams.placement.exitdisposableortrashbag is 'Information about Was a disposable or trash bag used to carry their belongings at the time of exit.Captures Yes or No values.';

ALTER TABLE cjams.placementrevision DROP COLUMN IF EXISTS exitluggage;
ALTER TABLE cjams.placementrevision  ADD COLUMN IF NOT EXISTS exitluggage boolean NULL;
comment on column cjams.placementrevision .exitluggage is 'Person  luggage information at the time of exit. Captures Yes or No values';

ALTER TABLE cjams.placementrevision  DROP COLUMN IF EXISTS exitluggageprovided; 
ALTER TABLE cjams.placementrevision  ADD COLUMN IF NOT EXISTS  exitluggageprovided boolean NULL;
comment on column cjams.placementrevision .exitluggageprovided is 'Person luggage purchased information at the time of exit.Captures Yes or No values';

ALTER TABLE cjams.placementrevision  DROP COLUMN IF EXISTS  exitluggagecomments;
ALTER TABLE cjams.placementrevision  ADD COLUMN IF NOT EXISTS  exitluggagecomments varchar NULL;
comment on column cjams.placementrevision .exitluggagecomments is 'Person luggage comments at the time of exit';

ALTER TABLE cjams.placementrevision  DROP COLUMN IF EXISTS  exitdisposableortrashbag;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS exitdisposableortrashbag boolean NULL;
comment on column cjams.placementrevision .exitdisposableortrashbag is 'Information about Was a disposable or trash bag used to carry their belongings at the time of exit.Captures Yes or No values.';



















