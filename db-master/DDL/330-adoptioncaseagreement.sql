-- Drop table

-- DROP TABLE cjams.adoptioncaseagreement

CREATE TABLE cjams.adoptioncaseagreement (
	adoptionagreementid uuid NOT NULL DEFAULT gen_random_uuid(),
	adoptioncaseid uuid NOT NULL,
	--adoptionplanningid uuid NOT NULL,
	isofferedsubsidy int4 NULL,
	offeraccepteddate timestamp NULL,
	startdate timestamp NULL,
	enddate timestamp NULL,
	finalizationdate timestamp NULL,
	isunderappeal int4 NULL,
	parent1signdate timestamp NULL,
	parent2signdate timestamp NULL,
	ldssdate timestamp NULL,
	issubsidypaid int4 NULL,
	effectivedate timestamp NOT NULL DEFAULT now(),
	old_id varchar(50) NULL,
	ismedassist bool NULL,
	parent1providerid int4 NULL,
	parent2providerid int4 NULL,
	parent1providername varchar(100) NULL,
	parent2providername varchar(100) NULL,
	alternateid bigint NULL,
	issingleparent int4 NULL,
	singleparentadoptioncheck int4 NULL,
	adoptiveparent1signature text NULL,
	adoptiveparent2signature text NULL,
	ldssdirectorsignature text NULL,
	agreementcomments varchar(5000) NULL,
	childplacedby varchar(15) NULL,
	childplacedfrom varchar(15) NULL,
	activeflag int4 NULL DEFAULT 1,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	CONSTRAINT adoptioncaseagreement_pk PRIMARY KEY (adoptionagreementid)
	--CONSTRAINT fk_adoptioncaseagreement_adoptionplanning FOREIGN KEY (adoptionplanningid) REFERENCES adoptionplanning(adoptionplanningid)
);
