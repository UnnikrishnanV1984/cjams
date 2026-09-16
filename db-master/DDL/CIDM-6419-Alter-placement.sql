ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS transferagency varchar NULL;
comment on column cjams.placement.transferagency is 'to store transfer agency information';

ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS otherpublicagency varchar NULL;
comment on column cjams.placement.otherpublicagency is 'to store other public specific agency which can be identified';

ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS transferagency varchar NULL;
comment on column cjams.placementrevision.transferagency is 'to store transfer agency information';

ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS otherpublicagency varchar NULL;
comment on column cjams.placementrevision.otherpublicagency is 'to store other public specific agency which can be identified';