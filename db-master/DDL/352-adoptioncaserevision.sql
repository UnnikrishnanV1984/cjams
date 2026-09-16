-- DROP TABLE cjams.adoptioncaserevision

CREATE TABLE cjams.adoptioncaserevision (
	adoptionrevisionid uuid NOT NULL DEFAULT gen_random_uuid(),
	adoptionagreementid uuid NULL,
	transactiondate timestamp NULL,
	agreementtypetypekey varchar(5) NULL,
	adoptivemotherid int4 NULL,
	adoptivefatherid int4 NULL,
	agreementstartdate timestamp NULL,
	agreementenddate timestamp NULL,
	paymentamt int4 NULL,
	"comments" varchar(5000) NULL,
	isssaapproval bool NULL,
	ssaapprovaldate timestamp NULL,
	ischildmedicallyfragile bool NULL,
	primbasissplneedstypekey varchar(5) NULL,
	approvalstatustypekey varchar(5) NULL,
	approvaldate timestamp NULL,
	isoriginal bool NULL,
	insertedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NULL,
	providerid int4 NULL,
	alternateid bigint NULL,
	CONSTRAINT pkadoptioncaserevision PRIMARY KEY (adoptionrevisionid)
);
