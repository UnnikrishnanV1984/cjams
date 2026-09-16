-- Drop table

-- DROP TABLE cjams.personimmunizationconfig

CREATE TABLE cjams.personimmunizationconfig (
	personimmunizationconfigid uuid NOT NULL DEFAULT gen_random_uuid(),
	value_text varchar(100) NULL,
	description varchar(100) NULL,
	uiconfig jsonb NULL,
	agetype varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	effectivedate timestamp NOT NULL DEFAULT now(),
	expirationdate timestamp NULL,
	old_id varchar(20) NULL
);

-- Permissions

ALTER TABLE cjams.personimmunizationconfig OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.personimmunizationconfig TO welfareadmin;
