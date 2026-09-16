--CIDM-5228 store Transfer Agency and other agency information.


ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS transferagency varchar NULL;
comment on column cjams.intakeservreqchildremoval.transferagency is 'to store transfer agency information';

ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS otherpublicagency varchar NULL;
comment on column cjams.intakeservreqchildremoval.otherpublicagency is 'to store other public specific agency which can be identified';

ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS locationofadoption varchar NULL;
comment on column cjams.intakeservreqchildremoval.locationofadoption is 'to store adoption location information';

ALTER TABLE cjams.intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS transferagency varchar NULL;
comment on column cjams.intakeservreqchildremoval_history.transferagency is 'to store transfer agency information';

ALTER TABLE cjams.intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS otherpublicagency varchar NULL;
comment on column cjams.intakeservreqchildremoval_history.otherpublicagency is 'to store other public specific agency which can be identified';

ALTER TABLE cjams.intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS locationofadoption varchar NULL;
comment on column cjams.intakeservreqchildremoval_history.locationofadoption is 'to store adoption location information';
