-- Drop table

-- DROP TABLE cjams.adoptionapplicabilityinfo

CREATE TABLE cjams.adoptionapplicabilityinfo (
	adoptionapplicabilityid uuid NOT NULL DEFAULT gen_random_uuid(),
	removalid int8 NOT NULL,
	clientid int8 NOT NULL,
	childexpectedadoptiondate timestamp NULL,
	hasthechildbeenincare60monthsormore text NULL,
	canchildreturntohome varchar(10) NULL,
	descriptionofreturnhome varchar(500) NULL,
	fosterparentemotionalbonding varchar(10) NULL,
	activeflag int4 NULL DEFAULT 1,
	insertedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	CONSTRAINT pk_adoptionapplicabilityinfo PRIMARY KEY (adoptionapplicabilityid)
);

-- Permissions

ALTER TABLE cjams.adoptionapplicabilityinfo OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.adoptionapplicabilityinfo TO welfareadmin;
