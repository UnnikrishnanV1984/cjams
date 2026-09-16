ALTER TABLE cjams.adoptionagreement add column if not exists  adoptiveparent1signature text NULL;
ALTER TABLE cjams.adoptionagreement add column if not exists  adoptiveparent2signature text NULL;
ALTER TABLE cjams.adoptionagreement add column if not exists  ldssdirectorsignature text NULL;
ALTER TABLE cjams.adoptionagreement add column if not exists  agreementcomments varchar(5000) NULL;