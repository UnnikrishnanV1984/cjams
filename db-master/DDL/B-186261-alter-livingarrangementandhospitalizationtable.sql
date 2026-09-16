ALTER TABLE cjams.livingarrangement  ADD COLUMN IF NOT EXISTS objectid character varying;
comment on column cjams.livingarrangement.objectid is 'To link Living Arrangement with Hospitalization';

ALTER TABLE cjams.livingarrangement ADD COLUMN IF NOT EXISTS objecttype  varchar NULL;
comment on column cjams.livingarrangement.objecttype is 'To Identify object ID relation';

ALTER TABLE cjams.placementrevision  ADD COLUMN IF NOT EXISTS objectid character varying;
comment on column cjams.placementrevision.objectid is 'To link Living Arrangement with Hospitalization';

ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS objecttype  varchar NULL;
comment on column cjams.placementrevision.objecttype is 'To Identify object ID relation';


ALTER TABLE cjams.personhospitalization  ADD COLUMN IF NOT EXISTS objectid character varying;
comment on column cjams.personhospitalization.objectid is 'To link Hospitalization with Living Arrangement';


ALTER TABLE cjams.personhospitalization  ADD COLUMN IF NOT EXISTS notificationdate timestamp NULL;
comment on column cjams.personhospitalization.notificationdate is 'Notification Date in displaying the pop-up';