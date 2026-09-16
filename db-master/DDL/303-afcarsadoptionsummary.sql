-- Drop table

DROP TABLE if exists cjams.afcarsadoptionsummary;

CREATE TABLE cjams.afcarsadoptionsummary (
	summaryid bigint NOT NULL,
	reportingperiod varchar(20) NULL,
	firstsubmitteddate timestamp NULL,
	lastsubmitteddate timestamp NULL,
	insertedon timestamp NULL,
	insertedby varchar(10) NULL,
	updatedon timestamp NULL,
	updatedby varchar(10) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	old_id varchar(50) NULL
);

-- Permissions

ALTER TABLE cjams.afcarsadoptionsummary OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.afcarsadoptionsummary TO welfareadmin;
