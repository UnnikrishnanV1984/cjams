ALTER TABLE cjams.intakeservicerequestsdm ADD COLUMN IF NOT EXISTS isfclivingarrangement bool NULL DEFAULT false;
comment on column cjams.intakeservicerequestsdm.isfclivingarrangement is 'to store living arrangement in foster care';

ALTER TABLE cjams.intakeservicerequestsdm ADD COLUMN IF NOT EXISTS linkschidresid bool NULL DEFAULT false;
comment on column cjams.intakeservicerequestsdm.isfclivingarrangement is 'to store Alleged maltreatment linked to a childs residence while they were removed in Foster Care';

ALTER TABLE cjams.intakeservicerequestsdm ADD COLUMN IF NOT EXISTS selectedplacement CHARACTER VARYING;
comment on column cjams.intakeservicerequestsdm.selectedplacement  is 'to store selected placement or living arrangement';
