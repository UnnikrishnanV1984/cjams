-- Drop table

-- DROP TABLE cjams.adoptioncaseagreementrate

CREATE TABLE cjams.adoptioncaseagreementrate (
	adoptionagreementrateid uuid NOT NULL DEFAULT gen_random_uuid(),
	adoptionagreementid uuid NULL,
	startdate timestamp NULL,
	enddate timestamp NULL,
	provider_id int8 NULL,
	paymentamout numeric NULL,
	isapproval int4 NULL,
	approvaldate timestamp NULL,
	isspeacialneeds int4 NULL,
	parent1actorid uuid NULL,
	parent2actorid uuid NULL,
	childrelationship varchar(50) NULL,
	notes text NULL,
	activeflag int4 NULL DEFAULT 1,
	effectivedate timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	old_id varchar(50) NULL,
	specialneedtypekey varchar(15) NULL,
	specialneedremarks varchar(200) NULL,
	transactiondate timestamp NULL,
	rateoverwrittensw bpchar(1) NULL,
	CONSTRAINT adoptioncaseagreementrate_pk PRIMARY KEY (adoptionagreementrateid),
	CONSTRAINT fk_adoptioncaseagreementrate_adoptioncaseagreement FOREIGN KEY (adoptionagreementid) REFERENCES adoptioncaseagreement(adoptionagreementid)
);
