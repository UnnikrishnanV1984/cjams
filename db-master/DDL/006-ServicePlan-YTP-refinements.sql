ALTER TABLE cjams.youthtransitionplan ADD caseworkername varchar(150) NULL;
ALTER TABLE cjams.youthtransitionplan ADD supervisorworkername varchar(150) NULL;
ALTER TABLE cjams.serviceplan ADD caseworkername varchar(150) NULL;
ALTER TABLE cjams.serviceplan ADD supervisorworkername varchar(150) NULL;
ALTER TABLE cjams.serviceplanoutcome ADD actualserviceplanoutcomename varchar(500) NULL; 
ALTER TABLE cjams.serviceplanoutcome ALTER COLUMN serviceplanoutcomename TYPE varchar(500) USING serviceplanoutcomename::varchar;
ALTER TABLE cjams.youthtransitionplan ADD approvalstatustypekey varchar(150) NULL;
ALTER TABLE cjams.serviceplanfocus ADD approvalstatustypekey varchar(150) NULL;
ALTER TABLE cjams.serviceplanaction ADD approvalstatustypekey varchar(150) NULL;