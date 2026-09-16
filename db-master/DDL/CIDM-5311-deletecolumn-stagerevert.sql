ALTER TABLE cjams.intakeservicerequestsdm DROP COLUMN IF  EXISTS isfclivingarrangement bool NULL DEFAULT false;
comment on column cjams.intakeservicerequestsdm.isfclivingarrangement  is 'remove from stage';

ALTER TABLE cjams.intakeservicerequestsdm DROP COLUMN IF EXISTS linkschidresid bool NULL DEFAULT false;
comment on column cjams.intakeservicerequestsdm.linkschidresid  is 'remove from stage';

ALTER TABLE cjams.intakeservicerequestsdm DROP COLUMN IF  EXISTS selectedplacement CHARACTER VARYING;
comment on column cjams.intakeservicerequestsdm.selectedplacement  is 'remove from stage';