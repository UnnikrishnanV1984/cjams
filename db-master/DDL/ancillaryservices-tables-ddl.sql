--cjams.ancillaryservices table
DROP TABLE if exists cjams.ancillaryservices;

CREATE TABLE cjams.ancillaryservices (
	ancillaryservicesid uuid NOT NULL DEFAULT gen_random_uuid(), -- Table primary key(UUID)
	alternateid bigserial NOT NULL, -- Table alternate primary key(interger)
	paymenttype varchar(5) NULL, -- Type of payment. Ex: 26 - CfE Bed Retainer fee
	providerserviceid int4 NULL, -- Link with tb_provider_Service to know the service and provier map
	startdate date NULL, -- Start date for service
	enddate date NULL, -- End date of service
	noofbeds int4 NULL, -- Providers bed counts
	costnotexceed numeric(10,2) NULL,
	"comments" text NULL, -- Request descriptions
	finalamount numeric(10,2) NULL, -- Final approved amount by Finance team
	financecategorycode varchar(5) NULL, -- Fiscal category code
	supervisorapprovalstatuscode varchar(5) NULL, -- Case supervisor approval status. Ex: 3047
	paymentapprovalstatuscode varchar(5) NULL, -- Finance supervisor approval status. Ex: 3047
	supervisorapprovaldate timestamp NULL, -- Case supervisor approval date
	paymentapprovaldate timestamp NULL, -- Finance supervisor approval date
	updatedby varchar(50) NULL, -- Audit column- Updated by
	updatedon timestamp NULL DEFAULT now(), -- Audit column- Updated on
	insertedby varchar(50) NOT NULL, -- Audit column- Created by
	insertedon timestamp NOT NULL DEFAULT now(), -- Audit column- Created on
	activeflag int4 NOT NULL DEFAULT 1, -- Active record flag
	statecountycode varchar(5) NULL,
	CONSTRAINT pk_ancillaryservicesid PRIMARY KEY (ancillaryservicesid)
);

-- Column comments

COMMENT ON COLUMN cjams.ancillaryservices.ancillaryservicesid IS 'Table primary key(UUID)';
COMMENT ON COLUMN cjams.ancillaryservices.alternateid IS 'Table alternate primary key(interger)';
COMMENT ON COLUMN cjams.ancillaryservices.paymenttype IS 'Type of payment. Ex: 26 - CfE Bed Retainer fee';
COMMENT ON COLUMN cjams.ancillaryservices.providerserviceid IS 'Link with tb_provider_Service to know the service and provier map';
COMMENT ON COLUMN cjams.ancillaryservices.startdate IS 'Start date for service';
COMMENT ON COLUMN cjams.ancillaryservices.enddate IS 'End date of service';
COMMENT ON COLUMN cjams.ancillaryservices.noofbeds IS 'Providers bed counts';
COMMENT ON COLUMN cjams.ancillaryservices."comments" IS 'Request descriptions';
COMMENT ON COLUMN cjams.ancillaryservices.finalamount IS 'Final approved amount by Finance team';
COMMENT ON COLUMN cjams.ancillaryservices.financecategorycode IS 'Fiscal category code';
COMMENT ON COLUMN cjams.ancillaryservices.supervisorapprovalstatuscode IS 'Case supervisor approval status. Ex: 3047';
COMMENT ON COLUMN cjams.ancillaryservices.paymentapprovalstatuscode IS 'Finance supervisor approval status. Ex: 3047';
COMMENT ON COLUMN cjams.ancillaryservices.supervisorapprovaldate IS 'Case supervisor approval date';
COMMENT ON COLUMN cjams.ancillaryservices.paymentapprovaldate IS 'Finance supervisor approval date';
COMMENT ON COLUMN cjams.ancillaryservices.updatedby IS 'Audit column- Updated by';
COMMENT ON COLUMN cjams.ancillaryservices.updatedon IS 'Audit column- Updated on';
COMMENT ON COLUMN cjams.ancillaryservices.insertedby IS 'Audit column- Created by';
COMMENT ON COLUMN cjams.ancillaryservices.insertedon IS 'Audit column- Created on';
COMMENT ON COLUMN cjams.ancillaryservices.activeflag IS 'Active record flag';

-- cjams.ancillaryservicessnapshot table


DROP TABLE if exists cjams.ancillaryservicessnapshot;

CREATE TABLE cjams.ancillaryservicessnapshot (
	ancillaryservicessnapshotid uuid NOT NULL DEFAULT gen_random_uuid(),
	alternateid bigserial NOT NULL,
	ancillaryservicesid uuid NOT NULL,
	providerid int8 NULL,
	taxidno numeric(9) NULL,
	provtaxtypecd varchar(5) NULL,
	providername varchar(200) NULL,
	provideraddress varchar(500) NULL,
	providerphone varchar(150) NULL,
	ldsscd varchar(5) NULL,
	ldssdesc varchar(100) NULL,
	ldssaddress varchar(500) NULL,
	workerid uuid NULL,
	workername varchar(200) NULL,
	workerphone varchar(100) NULL,
	requestdate date NULL,
	providerserviceid int8 NULL,
	providerservicedesc varchar(100) NULL,
	justificationtx text NULL,
	fiscalcategorycd varchar(5) NULL,
	fiscalcategorydesc varchar(200) NULL,
	startdate date NULL,
	enddate date NULL,
	costno numeric(10,2) NULL,
	finalamountno numeric(10,2) NULL,
	sprvsrapprovaldate date NULL,
	sprvsrapprovalstatuscd varchar(5) NULL,
	supervisorapprovalstatus varchar(100) NULL,
	supervisorid int8 NULL,
	supervisorname varchar(200) NULL,
	paymentapprovaldate date NULL,
	paymentapprovalstatuscd varchar(5) NULL,
	paymentapprovalstatus varchar(100) NULL,
	paymentstaffid int8 NULL,
	paymentapprovername varchar(200) NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	CONSTRAINT pk_ancillaryservicessnapshotid PRIMARY KEY (ancillaryservicessnapshotid)
);
