-- Drop table

DROP TABLE IF EXISTS cjams.youthtransitionplan CASCADE;

CREATE TABLE cjams.youthtransitionplan (
	youthtransitionplanid uuid NOT NULL DEFAULT gen_random_uuid(),
	summary_json jsonb NULL,
	youththoughts_json jsonb NULL,
	sracc_json jsonb NULL,
	health_json jsonb NULL,
	moneymanagement_json jsonb NULL,
	housing_json jsonb NULL,
	education_json jsonb NULL,
	employment_json jsonb NULL,
	documentation_json jsonb NULL,
	clientid uuid NOT NULL,
	intakeserviceid uuid NOT NULL,
	sevicecaseid uuid NULL,
	insertedby varchar(50) NULL,
	updatedby varchar(50) NULL,
	insertedon timestamp NULL,
	updatedon timestamp NULL,
	approvaldate timestamp NULL,
	approvalstatuskey varchar(26) NULL,
	completiondate timestamp NULL,
	assessmentcompletiondate timestamp NULL,
	nextduedate timestamp NULL,
	rejectionnote varchar(2000) NULL,
	returnreason varchar(2000) NULL,
	caseworkername varchar(150) NULL,
	supervisorworkername varchar(150) NULL,
	CONSTRAINT pk_youthtransitionplan PRIMARY KEY (youthtransitionplanid)
);

-- Permissions

ALTER TABLE cjams.youthtransitionplan OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.youthtransitionplan TO welfareadmin;
