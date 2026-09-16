ALTER TABLE cjams.intakeservicerequestsdm ADD column if not exists confirmtrafficking varchar(10) NULL;
comment on column cjams.intakeservicerequestsdm.confirmtrafficking IS 'to store confirm trafficking value';

ALTER TABLE cjams.intakeservicerequestsdm ADD column if not exists selecttrafficking varchar(50) NULL;
comment on column cjams.intakeservicerequestsdm.selecttrafficking IS 'to store selected trafficking value';