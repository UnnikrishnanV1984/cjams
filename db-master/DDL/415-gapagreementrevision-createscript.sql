-- Drop table
--DROP TABLE IF EXISTS cjams.gapagreementrevision;

CREATE TABLE cjams.gapagreementrevision (
	gapagreementrevisionid uuid NOT NULL DEFAULT gen_random_uuid(),
	gapagreementid uuid NULL,
	gapid uuid NULL,
	iscomprehensivehomestudy bool NULL,
	iscgawardedcustody bool NULL,
	isplacementenddate bool NULL,
	ischildreceivetca bool NULL,
	startdate timestamp NULL,
	enddate timestamp NULL,
	signaturedate timestamp NULL,
	guardianonedate timestamp NULL,
	guardiantwodate timestamp NULL,
	ldssdate timestamp NULL,
	activeflag int4 NULL DEFAULT 1,
	effectivedate timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	old_id varchar(50) NULL,
	tcaamount numeric(10) NULL,
	isfianotified int4 NULL,
	fianotifieddate timestamp NULL,
	isrcnotifiedcontact int4 NULL,
	iscsnotifiedtocustody int4 NULL,
	approvalstatustypekey varchar NULL,
	approvaldate timestamp NULL,
	CONSTRAINT gapagreementrevision_pkey PRIMARY KEY (gapagreementrevisionid)
);
