-- Drop table
 drop  table if exists cjams.externalapilogs;

CREATE TABLE cjams.externalapilogs (
	externalapilogsid uuid NOT NULL DEFAULT cjams.gen_random_uuid(), -- Table primary key UUID
	objectid varchar(50) NOT NULL, -- Requested object id
	objecttype varchar(50) NOT NULL, -- Type of request. it will handle all type of request. EX: Jira Request,ECMS upload
	objectsubtype varchar(50) NULL, -- Sub type of request. it will handle all type of  sub request. EX: ECMS_request. sub type : service case.
	request text NULL, -- Request payload
	response text NULL, -- Response payload/ response messages
	responsestatus varchar NULL, -- Response status. Success or Error
	activeflag int4 NOT NULL DEFAULT 1,
	insertedon timestamp NOT NULL DEFAULT now(), -- Record created date and time
	insertedby varchar NULL, -- User who created this record
	updatedon timestamp NULL, -- Record updated date and time
	updatedby varchar NULL, -- user who last updated the record
	CONSTRAINT externalapilogs_pkey PRIMARY KEY (externalapilogsid)
);

-- Column comments

COMMENT ON COLUMN cjams.externalapilogs.externalapilogsid IS 'Table primary key UUID';
COMMENT ON COLUMN cjams.externalapilogs.objectid IS 'Requested object id';
COMMENT ON COLUMN cjams.externalapilogs.objecttype IS 'Type of request. it will handle all type of request. EX: Jira Request,ECMS upload';
COMMENT ON COLUMN cjams.externalapilogs.objectsubtype IS 'Sub type of request. it will handle all type of  sub request. EX: ECMS_request. sub type : service case.';
COMMENT ON COLUMN cjams.externalapilogs.request IS 'Request payload';
COMMENT ON COLUMN cjams.externalapilogs.response IS 'Response payload/ response messages';
COMMENT ON COLUMN cjams.externalapilogs.responsestatus IS 'Response status. Success or Error';
COMMENT ON COLUMN cjams.externalapilogs.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.externalapilogs.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.externalapilogs.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.externalapilogs.updatedby IS 'user who last updated the record';


