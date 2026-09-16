
CREATE TABLE if not exists cjams.senhistorynotifications (
	senhistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
	personid uuid NOT NULL,
	senstatusflag int4 NULL,
	notificationdate timestamp NULL,
	objecttypekey varchar(50) NULL,
	objectid varchar(50) NULL,
    workerdetails varchar(50) NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	nevershowagain bool NULL,
	CONSTRAINT pf_senhistorynotifications PRIMARY KEY (senhistoryid)
);


COMMENT ON COLUMN cjams.senhistorynotifications.senhistoryid IS 'System generated identity for each';
COMMENT ON COLUMN cjams.senhistorynotifications.personid IS 'Person ID details';
COMMENT ON COLUMN cjams.senhistorynotifications.senstatusflag IS 'Substance new exposed flag check';
COMMENT ON COLUMN cjams.senhistorynotifications.notificationdate IS 'Notification date';
COMMENT ON COLUMN cjams.senhistorynotifications.workerdetails IS 'For this worker notification will be hidden';
COMMENT ON COLUMN cjams.senhistorynotifications.objecttypekey IS 'Object Type ';
COMMENT ON COLUMN cjams.senhistorynotifications.objectid IS 'Object ID details';
