-- Drop table

DROP TABLE IF EXISTS cjams.tb_audit_fostercareevent;

CREATE TABLE cjams.tb_audit_fostercareevent (
	fostercareeventid uuid NOT NULL,
	auditperiodid bigserial NOT NULL,
	eventreason varchar(50) NULL,
	islivingarrangementsameasplacement varchar(50) NULL,
	havetherebeenanylapsesinplacementandcareresponsibilitytoiveagen varchar(50) NULL,
	eventstatus varchar(50) NULL,
	typeoflapses varchar(50) NULL,
	eventstage varchar(50) NULL,
	eventenddate timestamp NULL,
	eventstartdate timestamp NULL,
	isthereanyreasonableeffortsfindingduringreviewperiod varchar(50) NULL,
	fostercareredeterminationeligibilitystatuswitheventchange varchar(50) NULL,
	CONSTRAINT pk_audit_fostercareevent PRIMARY KEY (fostercareeventid),
	CONSTRAINT fk_audit_periods FOREIGN KEY (auditperiodid) REFERENCES cjams.tb_ive_fostercare_audit(auditperiodid)
);
