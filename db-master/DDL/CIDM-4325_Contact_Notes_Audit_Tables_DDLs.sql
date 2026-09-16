-- To capture daily Contact Counts
DROP TABLE if exists cjams.progressnote_audit_summary;

CREATE TABLE cjams.progressnote_audit_summary (
	auditsummaryid uuid NOT NULL DEFAULT gen_random_uuid(),
	auditdate date NULL, 
	statecountycode character varying NULL, 	
	totalcontacts integer NULL,
	countcountmatched boolean NULL, 
	lastverifiedon date NULL,
	insertedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	activeflag int4 NULL DEFAULT 1,
	CONSTRAINT pk_progressnote_audit_summary PRIMARY KEY (auditsummaryid)
);
CREATE INDEX progressnote_audit_summary_idx ON cjams.progressnote_audit_summary USING btree (auditsummaryid);
CREATE INDEX progressnote_audit_summary_search_idx ON cjams.progressnote_audit_summary USING btree (auditdate, statecountycode);

-- To capture daily Contact Details
DROP TABLE if exists cjams.progressnote_audit_detail;

CREATE TABLE cjams.progressnote_audit_detail (
	auditdetailid uuid NOT NULL DEFAULT gen_random_uuid(),
	auditdate date NULL, 
	statecountycode character varying NULL, 	
	securityusersid character varying NULL,
	conatctid bigint NULL, -- witsid 
	casetype character varying NULL,
	casenumber character varying NULL,
	contacttype text NULL,
	contactdate date NULL,
	contactinsertedon timestamp NULL, 
	conatctdescription  text NULL,
	insertedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	activeflag int4 NULL DEFAULT 1,
	CONSTRAINT pk_progressnote_audit_detail PRIMARY KEY (auditdetailid)
);
CREATE INDEX progressnote_audit_details_idx ON cjams.progressnote_audit_detail USING btree (auditdetailid);
CREATE INDEX progressnote_audit_details_search_idx ON cjams.progressnote_audit_detail USING btree (auditdate, statecountycode);

