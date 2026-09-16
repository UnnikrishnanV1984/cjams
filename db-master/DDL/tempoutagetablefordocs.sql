CREATE TABLE IF NOT exists cjams.temp_outage_uploads (
	srno varchar(20) NULL,
	objectid uuid NULL,
	objecttype text NULL,
	isuploaded bool NULL,
    insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1
);


COMMENT ON COLUMN cjams.temp_outage_uploads.srno IS 'Service case number';
COMMENT ON COLUMN cjams.temp_outage_uploads.objectid IS 'Service case ID details';
COMMENT ON COLUMN cjams.temp_outage_uploads.objecttype IS 'To Identify service case or CPS';
COMMENT ON COLUMN cjams.temp_outage_uploads.isuploaded IS 'To check uploaded or not';