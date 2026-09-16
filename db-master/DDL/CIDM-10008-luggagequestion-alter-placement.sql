ALTER TABLE cjams.placement DROP COLUMN IF EXISTS placementdisposableortrashbag; 
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS placementdisposableortrashbag boolean NULL;
comment on column cjams.placement.placementdisposableortrashbag is 'Person  Placement disposable or trashbag.Captures Yes or No values';


ALTER TABLE cjams.livingarrangement DROP COLUMN IF EXISTS  ladisposableortrashbag;
ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS  ladisposableortrashbag boolean NULL;
comment on column cjams.livingarrangement.ladisposableortrashbag is 'Person Livingarrangement disposable or trashbag.Captures Yes or No values';


ALTER TABLE cjams.placementrevision DROP COLUMN IF EXISTS  placementdisposableortrashbag;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS placementdisposableortrashbag boolean NULL;
comment on column cjams.placementrevision.placementdisposableortrashbag is 'Person placement revision disposable or trashbag.Captures Yes or No values.';

ALTER TABLE cjams.intakeservreqchildremoval DROP COLUMN IF EXISTS  childremovalluggage;
ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS  childremovalluggage boolean NULL;
comment on column cjams.intakeservreqchildremoval.childremovalluggage is 'the child have luggage before their removal was exited information.Captures Yes or No values.';

ALTER TABLE cjams.intakeservreqchildremoval DROP COLUMN IF EXISTS  luggageprovided;
ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS  luggageprovided boolean NULL;
comment on column cjams.intakeservreqchildremoval.luggageprovided is 'Was new luggage provided when their removal was exited information.Captures Yes or No values.';

ALTER TABLE cjams.intakeservreqchildremoval DROP COLUMN IF EXISTS  placementdisposableortrashbag;
ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS  placementdisposableortrashbag boolean NULL;
comment on column cjams.intakeservreqchildremoval.placementdisposableortrashbag is 'Information about Was a disposable or trash bag used to carry their belongings.Captures Yes or No values.';

ALTER TABLE cjams.intakeservreqchildremoval DROP COLUMN IF EXISTS  luggagecomments;
ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS  luggagecomments varchar NULL;
comment on column cjams.intakeservreqchildremoval.luggagecomments is 'luggage indicator  comments';


ALTER TABLE cjams.intakeservreqchildremoval_history DROP COLUMN IF EXISTS  childremovalluggage;
ALTER TABLE cjams.intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS  childremovalluggage boolean NULL;
comment on column cjams.intakeservreqchildremoval_history.childremovalluggage is 'the child have luggage before their removal was exited information.Captures Yes or No values.';

ALTER TABLE cjams.intakeservreqchildremoval_history DROP COLUMN IF EXISTS  luggageprovided;
ALTER TABLE cjams.intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS  luggageprovided boolean NULL;
comment on column cjams.intakeservreqchildremoval_history.luggageprovided is 'Was new luggage provided when their removal was exited information.Captures Yes or No values.';

ALTER TABLE cjams.intakeservreqchildremoval_history DROP COLUMN IF EXISTS  placementdisposableortrashbag;
ALTER TABLE cjams.intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS  placementdisposableortrashbag boolean NULL;
comment on column cjams.intakeservreqchildremoval_history.placementdisposableortrashbag is 'Information about Was a disposable or trash bag used to carry their belongings.Captures Yes or No values.';

ALTER TABLE cjams.intakeservreqchildremoval_history  DROP COLUMN IF EXISTS  luggagecomments;
ALTER TABLE cjams.intakeservreqchildremoval_history  ADD COLUMN IF NOT EXISTS  luggagecomments varchar NULL;
comment on column cjams.intakeservreqchildremoval_history.luggagecomments is 'luggage indicator  comments';

ALTER TABLE cjams.intakeservreqchildremoval DROP COLUMN IF EXISTS  luggageupdatedby;
ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS  luggageupdatedby varchar NULL;
comment on column cjams.intakeservreqchildremoval.luggageupdatedby is 'luggage updatedby person';

ALTER TABLE cjams.intakeservreqchildremoval DROP COLUMN IF EXISTS  luggageupdatedon;
ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS  luggageupdatedon timestamp NULL;
comment on column cjams.intakeservreqchildremoval.luggageupdatedon is 'luggage updated on time';

ALTER TABLE cjams.intakeservreqchildremoval_history DROP COLUMN IF EXISTS  luggageupdatedby;
ALTER TABLE cjams.intakeservreqchildremoval_history  ADD COLUMN IF NOT EXISTS  luggageupdatedby varchar NULL;
comment on column cjams.intakeservreqchildremoval_history.luggageupdatedby is 'luggage updatedby person';

ALTER TABLE cjams.intakeservreqchildremoval_history  DROP COLUMN IF EXISTS  luggageupdatedon;
ALTER TABLE cjams.intakeservreqchildremoval_history  ADD COLUMN IF NOT EXISTS  luggageupdatedon timestamp NULL;
comment on column cjams.intakeservreqchildremoval_history.luggageupdatedon is 'luggage updated on time';
