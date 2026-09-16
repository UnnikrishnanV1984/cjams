DROP TABLE if exists cjams.ancillaryservices;

CREATE TABLE if not exists cjams.ancillaryservices (
	ancillaryservicesid uuid NOT NULL DEFAULT gen_random_uuid(),
	alternateid bigserial NOT NULL,
	paymenttype varchar(5) NULL,
	providerserviceid int4 NULL,
	startdate date NULL,
	enddate date NULL,
	noofbeds int4 NULL,
	costnotexceed numeric(10,2) NULL,
	"comments" text NULL,
	finalamount numeric(10,2) NULL,
	financecategorycode varchar(5) NULL,
	supervisorapprovalstatuscode varchar(5) NULL,
	paymentapprovalstatuscode varchar(5) NULL,
	supervisorapprovaldate timestamp NULL,
	paymentapprovaldate timestamp NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	statecountycode varchar(5) null,
	paymentid character varying,
	purchasedetails json,
	CONSTRAINT pk_ancillaryservicesid PRIMARY KEY (ancillaryservicesid)
);
