
CREATE TABLE cjams.adoptioncasesuspensionrevision (
	adoptionsuspensionrevisionid uuid NOT NULL DEFAULT gen_random_uuid(),
	adoptionsuspensionid uuid NOT NULL,
	transactiondate timestamp NULL,
	suspensionreasontypekey varchar(15) NULL,
	suspensionbegindate timestamp NULL,
	suspensionenddate timestamp NULL,
	suspensionremarks varchar(500) NULL,
	approvalstatustypekey varchar(5) NULL,
	approvaldate timestamp NULL,
	isoriginal bpchar(1) NULL,
	insertedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	activeflag int4 NULL DEFAULT 1,
	effectivedate timestamp NULL,
	old_id varchar(50) NULL,
	suspensionreasonremarks varchar(100) NULL,
	alternateid int8 NULL,
	adoptionagreementid uuid NULL,
	adoptioncaseid uuid NULL,
	CONSTRAINT pkadoptioncasesuspensionrevision PRIMARY KEY (adoptionsuspensionrevisionid)
	)
	
WITH (
	OIDS=FALSE
);
