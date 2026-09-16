alter table tb_public_provider_applicant add column if not exists provisionstrtdate timestamp without time zone null;
alter table tb_public_provider_applicant add column if not exists provisionenddate timestamp without time zone null;
drop table if exists providerapprovalserviceconfig;
CREATE TABLE cjams.providerapprovalserviceconfig (
	providerapprovalserviceconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	serviceid varchar(50) NULL,
	approvaltypecd varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	effectivedate timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	updatedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedon timestamp NOT NULL DEFAULT now(),
	old_id varchar(50) NULL,
	CONSTRAINT pk_providerapprovalserviceconfigid PRIMARY KEY (providerapprovalserviceconfigid)
);