ALTER TABLE cjams.intakeservicerequest ALTER COLUMN requestercounty TYPE varchar(50) USING requestercounty::varchar;

ALTER TABLE cjams.intakeservicerequest ALTER COLUMN requestercity TYPE varchar(100) USING requestercity::varchar;