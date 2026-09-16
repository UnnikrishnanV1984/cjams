DROP TABLE IF EXISTS cjams.personhealthpassport;

CREATE TABLE IF NOT EXISTS cjams.personhealthpassport (
	personhealthpassportid uuid NOT NULL DEFAULT gen_random_uuid(),
	personid uuid NOT NULL,
	placementid uuid NULL,
	haspassportprovidedtocaregiver bool NULL,
	effectivedate timestamp NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	CONSTRAINT pk_personhealthpassport PRIMARY KEY (personhealthpassportid)
);