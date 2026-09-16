ALTER TABLE cjams.pubprovapphouseholdbgchecks ALTER COLUMN household_member_id DROP NOT NULL;
alter table pubprovapphouseholdbgchecks add column if not exists personid uuid null;
alter table pubprovapphouseholdbgchecks add column if not exists objectid varchar(50) null;
alter table publicproviderhousehold add column if not exists personid uuid  NULL;


drop table if exists providerapprovetypeconfig;

CREATE TABLE cjams.providerapprovetypeconfig (
	providerapprovetypeconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	providerid varchar(50) NULL,
	referralid varchar(50) NULL,
	applicantid varchar(50) NULL,
	"comments" text NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	effectivedate timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	updatedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedon timestamp NOT NULL DEFAULT now(),
	old_id varchar(50) NULL,
	communication varchar(50) NULL,
	approval_type varchar(50) NULL,
	requested_date timestamp NULL,
	CONSTRAINT pk_providerapprovetypeconfig PRIMARY KEY (providerapprovetypeconfigid)
)
WITH (
	OIDS=FALSE
);


drop table if exists providerinfoconfig;

CREATE TABLE cjams.providerinfoconfig (
	providerinfoconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	providerid varchar(50) NOT NULL,
	"program" varchar(50) NULL,
	programtype varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	effectivedate timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	updatedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedon timestamp NOT NULL DEFAULT now(),
	old_id varchar(50) NULL,
	CONSTRAINT pk_providerinfoconfig PRIMARY KEY (providerinfoconfigid)
)
WITH (
	OIDS=FALSE
);

