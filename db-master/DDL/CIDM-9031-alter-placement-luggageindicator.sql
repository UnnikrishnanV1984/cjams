ALTER TABLE cjams.placement DROP COLUMN IF EXISTS placementluggage;
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS placementluggage boolean NULL;
comment on column cjams.placement.placementluggage is 'Person Placement luggage information. Captures Yes or No values';

ALTER TABLE cjams.placement DROP COLUMN IF EXISTS plluggagepurchased; 
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS  plluggagepurchased boolean NULL;
comment on column cjams.placement.plluggagepurchased is 'Person  Placement luggage purchased information.Captures Yes or No values';

ALTER TABLE cjams.placement DROP COLUMN IF EXISTS  plluggagecomments;
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS  plluggagecomments varchar NULL;
comment on column cjams.placement.plluggagecomments is 'Person Placement luggage comments';

ALTER TABLE cjams.livingarrangement DROP COLUMN IF EXISTS  livingarrangementluggage;
ALTER TABLE cjams.livingarrangement  ADD COLUMN IF NOT EXISTS livingarrangementluggage boolean NULL;
comment on column cjams.livingarrangement.livingarrangementluggage is 'Person living arrangement luggage information.Captures Yes or No values';

ALTER TABLE cjams.livingarrangement DROP COLUMN IF EXISTS  laluggagepurchased;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS  laluggagepurchased boolean NULL;
comment on column cjams.livingarrangement.laluggagepurchased is 'Person Livingarrangement luggage purchased information.Captures Yes or No values';

ALTER TABLE cjams.livingarrangement DROP COLUMN IF EXISTS  laluggagecomments;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS  laluggagecomments varchar NULL;
comment on column cjams.livingarrangement.laluggagecomments is 'Person Livingarrangement luggage comments';

ALTER TABLE cjams.placementrevision DROP COLUMN IF EXISTS  placementluggage;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS placementluggage boolean NULL;
comment on column cjams.placementrevision.placementluggage is 'Person placement revision luggage information.Captures Yes or No values.';

ALTER TABLE cjams.placementrevision DROP COLUMN IF EXISTS  plluggagepurchased;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS  plluggagepurchased boolean NULL;
comment on column cjams.placementrevision.plluggagepurchased is 'Person placement revision luggage purchased information.Captures Yes or No values.';

ALTER TABLE cjams.placementrevision DROP COLUMN IF EXISTS  plluggagecomments;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS  plluggagecomments varchar NULL;
comment on column cjams.placementrevision.plluggagecomments is 'Person placement revision luggage comments';








