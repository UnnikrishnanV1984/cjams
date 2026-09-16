
ALTER TABLE cjams.adoptionsuspensionrevision add column if not exists adoptionsuspensionid uuid NULL;


-- Drop table

-- DROP TABLE cjams.adoptionsuspensionrevision;

CREATE TABLE cjams.adoptionsuspension (
	adoptionsuspensionid uuid NOT NULL DEFAULT gen_random_uuid(),
	adoptionagreementid uuid NULL,
	adoptionplanningid uuid NOT NULL,
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
	CONSTRAINT pkadoptionsuspension PRIMARY KEY (adoptionsuspensionid)
);



