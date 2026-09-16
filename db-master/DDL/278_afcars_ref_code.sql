-- Drop table

-- DROP TABLE cjams.afcars_ref_code

CREATE TABLE cjams.afcars_ref_code (
	reference_id int4 NOT NULL,
	afcars_ref_cd varchar NULL,
	afcars_ref_type varchar NULL,
	cjams_cd varchar NULL,
	description varchar(255) NULL,
	activeflag int4 NULL,
	CONSTRAINT "AFCARS_REF_CODE_pkey" PRIMARY KEY (reference_id)
);

-- Permissions

ALTER TABLE cjams.afcars_ref_code OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.afcars_ref_code TO welfareadmin;
