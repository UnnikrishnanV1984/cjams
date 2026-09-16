ALTER TABLE cjams.administrativeoverrides ALTER COLUMN entityid type character varying; 

ALTER TABLE cjams.administrativeoverrides ALTER COLUMN referralsnapshotid type character varying; 

ALTER TABLE cjams.administrativeoverrides ALTER COLUMN overridestaffid type character varying;

ALTER TABLE cjams.administrativeoverrides ALTER COLUMN overridestaffid DROP NOT NULL;

ALTER TABLE cjams.administrativeoverrides ALTER COLUMN insertedby TYPE varchar(50) USING insertedby::varchar;

ALTER TABLE cjams.administrativeoverrides ALTER COLUMN updatedby TYPE varchar(50) USING updatedby::varchar;

ALTER TABLE cjams.administrativeoverrides ALTER COLUMN administrativeoverrideid SET DEFAULT gen_random_uuid();

ALTER TABLE cjams.administrativeoverrides ADD intakeapproveddate timestamp NULL;	
